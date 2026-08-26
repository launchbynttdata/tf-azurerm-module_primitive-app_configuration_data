package testimpl

import (
	"context"
	"os"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azcore"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/arm"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/cloud"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/appconfiguration/armappconfiguration/v2"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestAppConfigurationData(t *testing.T, ctx types.TestContext) {
	testAppConfigurationData(t, ctx)
}

func TestComposableAppConfigurationData(t *testing.T, ctx types.TestContext) {
	testAppConfigurationData(t, ctx)
}

func testAppConfigurationData(t *testing.T, ctx types.TestContext) {

	subscriptionId := os.Getenv("ARM_SUBSCRIPTION_ID")

	if len(subscriptionId) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID environment variable is not set")
	}

	cred, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Unable to get credentials: %v\n", err)
	}

	options := arm.ClientOptions{
		ClientOptions: azcore.ClientOptions{
			Cloud: cloud.AzurePublic,
		},
	}

	clientFactory, err := armappconfiguration.NewClientFactory(subscriptionId, cred, &options)
	if err != nil {
		t.Fatalf("failed to create client: %v", err)
	}

	t.Run("TestAppConfigurationKeys", func(t *testing.T) {
		appconfigName := terraform.OutputContext(t, context.Background(), ctx.TerratestTerraformOptions(), "app_configuration_name")
		resourceGroupName := terraform.OutputContext(t, context.Background(), ctx.TerratestTerraformOptions(), "resource_group_name")

		keyValue, err := clientFactory.NewKeyValuesClient().Get(context.Background(), resourceGroupName, appconfigName, "test-config-key", nil)
		if err != nil {
			t.Fatalf("failed to finish the request: %v", err)
		}
		require.NotNil(t, keyValue.Properties)
		require.NotNil(t, keyValue.Properties.Value)
		assert.Equal(t, "Hello, World!", *keyValue.Properties.Value)
	})
}
