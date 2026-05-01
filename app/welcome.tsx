import { GradientButton } from '@/components/gradient-button';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Text, View } from 'react-native';

export default function WelcomeScreen() {
  return (
    <SafeAreaView className="flex-1 bg-white">
      <View className="flex-1 px-6 pt-10">
        <View className="mb-10">
          <Text className="text-[28px] font-bold tracking-tight text-slate-900">
            Welcome to the app
          </Text>
          <Text className="mt-3 text-base leading-6 text-slate-600">
            Choose what you’d like to manage today.
          </Text>
        </View>

        <View className="gap-4">
          <GradientButton
            title="Property Management"
            from="#1D4ED8"
            to="#38BDF8"
            testID="welcome-property-management"
          />
          <GradientButton
            title="Property Maintenance"
            from="#7C3AED"
            to="#EC4899"
            testID="welcome-property-maintenance"
          />
        </View>
      </View>
    </SafeAreaView>
  );
}

