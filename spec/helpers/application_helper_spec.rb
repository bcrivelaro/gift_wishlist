RSpec.describe ApplicationHelper do
  describe '#flash_class' do
    context 'when success' do
      subject { flash_class('success') }

      it { is_expected.to eq('alert-success') }
    end

    context 'when notice' do
      subject { flash_class('notice') }

      it { is_expected.to eq('alert-success') }
    end

    context 'when error' do
      subject { flash_class('error') }

      it { is_expected.to eq('alert-danger') }
    end

    context 'when alert' do
      subject { flash_class('alert') }

      it { is_expected.to eq('alert-danger') }
    end

    context 'when anything' do
      subject { flash_class('anything') }

      it { is_expected.to eq('anything') }
    end
  end
end
