import { LinearGradient } from 'expo-linear-gradient';
import { Pressable, Text, View } from 'react-native';
import { styled } from 'nativewind';

const StyledLinearGradient = styled(LinearGradient);

type Props = {
  title: string;
  from: string;
  to: string;
  onPress?: () => void;
  testID?: string;
};

export function GradientButton({ title, from, to, onPress, testID }: Props) {
  return (
    <Pressable testID={testID} onPress={onPress} className="w-full">
      <StyledLinearGradient
        colors={[from, to]}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 1 }}
        className="w-full rounded-2xl"
      >
        <View className="h-14 w-full items-center justify-center px-5">
          <Text className="text-base font-semibold text-white">{title}</Text>
        </View>
      </StyledLinearGradient>
    </Pressable>
  );
}

