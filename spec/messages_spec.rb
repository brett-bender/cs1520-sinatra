require './portfolio'

# You can call this with a few options to get valid or invalid Message objects:
#
# build_message :without_email => true
# build_message :without_message => true

# Total Failure: #
# build_message :without_email => true, :without_message => true
#
def build_message(options = {})
  params = {}

  params[:name] = "Mister PBH"

  unless options[:without_email]
    params[:email] = 'onlygoodmemories@example.com'
  end

  params[:subject] = "ooooooh wheee rick"

  unless options[:without_message]
    params[:message] = "whatever youuuuu sayyy"
  end

  Message.new(params)
end

# just takin some validations for a spin...
describe Message do
  describe 'without an email' do
    before :each do
      @message = build_message :without_email => true

      # perform validations so errors are populated
      @message.valid?
    end

    it 'should not validate' do
      expect(@message.valid?).to be false
    end

    it 'should have one error' do
      expect(@message.errors.size).to eq 1
    end

    it 'should return an error for the name' do
      expect(@message.errors.key?(:email)).to be true
    end

    it 'should return the name error can\'t be blank' do
      expect(@message.errors[:email].first).to eq "can't be blank"
    end
  end

  describe 'without a message' do
    before :each do
      @message = build_message :without_message => true
      @message.valid?
    end

    it 'should error on the message attribute' do
      expect(@message.errors.key? :message).to be true
    end

    it 'should error with the cant be blank message' do
      expect(@message.errors[:message].first).to eq 'can\'t be blank'
    end
  end

  describe 'with no useful attributes' do
    before :each do
      @message = build_message :without_email => true, :without_message => true
      @message.valid?
    end

    it 'should return two errors' do
      expect(@message.errors.size).to eq 2
    end

    it 'should have errors for both message and email attributes' do
      expect(@message.errors.keys).to eq [:email, :message]
    end
  end
end
