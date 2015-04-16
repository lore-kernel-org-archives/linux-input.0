From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v1] HID: bug fixes in hid-cp2112 driver
Date: Thu, 16 Apr 2015 01:32:40 -0700
Message-ID: <552F73A8.5060605@cumulusnetworks.com>
References: <1429143746-16967-1-git-send-email-ellen@cumulusnetworks.com> <20150416074158.GA913@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150416074158.GA913@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

[Sorry.  Thunderbird did some weird stuff to my message.  Here it is again.]

Thanks for the quick reply.

On 04/16/2015 12:41 AM, Wolfram Sang wrote:
> On Wed, Apr 15, 2015 at 05:22:26PM -0700, Ellen Wang wrote:
>> 1. cp2112_xfer() byte swaps smbus words incorrectly:
>>
>> While i2c is by and large big endian, smbus transactions are
>> little endian.  This only affects word operands.  Essentially,
>> all occurences of be16 in cp2112_xfer() are now le16.
>>
>> 2. I2C_SMBUS_BYTE write in cp2112_xfer() should pass "command"
>> as the single data byte, not "data->byte":
>>
>> When tickled the right way, this actually segfaults the kernel
>> because "data" is NULL.
>>
>> 3. cp2112_i2c_xfer() only supports a single i2c_msg and only
>> reads up to 61 bytes:
>>
>> This is a serious limitation.  For example, the at24 eeprom driver
>> generates paired write and read messages (for eeprom address and data).
>> And the reads can be quite large.  The fix consists of a loop
>
> Well, at24 detects how many bytes it got and continues from there.

That's true, but instead of returning short, the old
cp2112_i2c_xfer() fails out (with EIO) when the first USB operation
doesn't return all the bytes.  Look for "short read: %d < %d" in
the original version.  That's just broken.

Also, even if we fix that by returning the correct byte count,
the semantics are still wrong.  The request that initiated
the operation has the desired byte count.  So the controller
may have already read all the bytes from the device.  We
should return all of them.  Every operation at the driver level
should correspond to exactly the same operation on the i2c bus.


>...
>> This is a funny driver that is a bridge from usb hid to i2c.
>> So while it officially belongs to hid, most of the functionality
>> is about i2c.  So I'm sending this patch to both linux-input
>> and linux-i2c.  David Barksdale <dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org> is
>> the original author/owner in the .c file.
>
> Probably, this would be best an MFD driver with the i2c and gpio
> functionality sourced out to the relevant subsystems. Dunno how well
> this works with hid drivers, though.

I agree.  This is probably something that should be taken up with
the maintainer.


>> While this patch contains three bug fixes, the first two are
>> quite trivial.  I'm hoping it's OK to glom them into one.
>
> Then, it should be easy to factor them out? Really, the "one patch per
> issue" rule is extremly helpful when fixing regressions.

I'll do that.


>>...
>> +static int cp2112_i2c_write_read_req(void *buf, u8 slave_address,
>> +                     u8 *addr, int addr_length,
>> +                     int read_length)
>> +{
>> +    struct cp2112_write_read_req_report *report = buf;
>> +
>> +    if (read_length < 1 || read_length > 512 ||
>> +        addr_length > sizeof(report->target_address))
>> +        return -EINVAL;
>
> This shows the drawback of having I2C master drivers not in the
> i2c-directory: It easily misses updates to the i2c-core.
> We now have the i2c-quirk infrastructure (2187f03a9576c4) which this
> driver should make use of. It can describe this...
>
>> +    for (m = msgs; m < msgs + num; m++) {
>> +        /*
>> +         * If the top two messages are a write followed by a read,
>> +         * then we do them together as CP2112_DATA_WRITE_READ_REQUEST.
>> +         * Otherwise, process one message.
>> +         */
>> +
>
> and this and the core will check the messages for you. It should
> simplify your code, too.

I didn't know about that.  Cumulus Linux is based on 3.2.something
(debian wheezy) and i2c-quirk came in after that.

I can update the driver to use the quirk mechanism, but I would
prefer to do that as a separate checkin, so Cumulus can use
a version of hid-cp2112.c that exists somewhere in mainline
even if it's not the latest.
