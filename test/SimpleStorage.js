const SimpleStorage = artifacts.require('SimpleStorage.sol');
const PaymentTest = artifacts.require('PaymentTest.sol');

contract('SimpleStorage', () => {
  it('Should update data', async () => {
    const storage = await SimpleStorage.new();
    await storage.updateData(10);
    const data = await storage.readData();
    assert(data.toString() === '10');
  });
});

contract('PaymentTest', () => {
  it('should transfer ether', async () => {
    const paymentTest = await PaymentTest.new();
     await paymentTest.sendEther('0x8d24b5fCdb321F8F634DC8858059f70691118018', 0) 
    const result = await paymentTest.message()
    console.log('result = ', result)
    assert(result === "True");
  });
});
