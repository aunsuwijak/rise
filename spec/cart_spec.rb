require_relative '../src/cart'

describe 'Cart' do
  describe '#initialize' do
    context 'when created' do
      subject { Cart.new }

      it { is_expected.to have_attributes(:items => Hash) }
    end
  end

  describe '#add' do
    context 'when item is not in cart' do
      let(:cart) { Cart.new }

      before { cart.add(:red, 2) }

      it { expect(cart.items).not_to be_empty }
      it { expect(cart.items[:red]).to eq(2) }
    end


    context 'when item is already in cart' do
      let(:cart) { Cart.new }

      before do
        cart.items = { red: 2 }
        cart.add(:red, 2)
      end

      it { expect(cart.items[:red]).to eq(4) }
    end
  end


  describe '#remove' do
    context 'when quantity is more than quantity in cart' do
      let(:cart) { Cart.new }

      before do
        cart.items = { red: 1 }
        cart.remove(:red, 2)
      end

      it { expect(cart.items[:red]).to eq(0) }
    end

    context 'when quantity is not cart' do
      let(:cart) { Cart.new }

      before { cart.remove(:red, 2) }

      it { expect(cart.items[:red]).to eq(0) }
    end

    context 'when quantity is less than quantity in cart' do
      let(:cart) { Cart.new }

      before do
        cart.items = { red: 3 }
        cart.remove(:red, 2)
      end

      it { expect(cart.items[:red]).to eq(1) }
    end
  end

  describe '#discount' do
    describe 'when cart has green, pink or orange with quantity more than 2' do
      context 'when > 2 green' do
        let(:cart) { Cart.new }

        before { cart.items = { green: 3 } }

        it { expect(cart.discount).to eq(5) }
      end

      context 'when 2 green, 2 pink' do
        let(:cart) { Cart.new }

        before { cart.items = { green: 2, pink: 2 } }

        it { expect(cart.discount).to eq(5) }
      end
    end

    context 'when has membership' do
      let(:cart) { Cart.new }

      before { cart.membership = true }

      it { expect(cart.discount).to eq(10) }
    end


    context 'when has membership and has more than 2 orange' do
      let(:cart) { Cart.new }

      before do
        cart.membership = true
        cart.items = { orange: 2 }
      end

      it { expect(cart.discount).to eq(15) }
    end

    context 'when has no membership and not selected more than 2 green, pink or orange' do
      let(:cart) { Cart.new }

      before { cart.items = { red: 2 } }

      it { expect(cart.discount).to eq(0) }
    end
  end
end