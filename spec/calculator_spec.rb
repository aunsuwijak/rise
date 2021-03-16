require_relative '../src/cart'
require_relative '../src/calculator'

describe 'Calculator' do
  describe '#total' do
    context 'when customer order red and green set' do
      let(:cart) { Cart.new }

      before { cart.items = { red: 1, green: 1 } }

      it { expect(Calculator.caculate_total(cart)).to eq(90) }
    end

    context 'when customer order 2 orange set' do
      let(:cart) { Cart.new }

      before { cart.items = { orange: 2 } }

      it { expect(Calculator.caculate_total(cart)).to eq(228) }
    end

    context 'when customer order 2 orange set and has membership card' do
      let(:cart) { Cart.new }

      before do 
        cart.items = { orange: 2 }
        cart.membership = true
      end

      it { expect(Calculator.caculate_total(cart)).to eq(204) }
    end
  end
end