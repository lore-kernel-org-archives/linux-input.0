From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH V2] input:ad7879-i2c use swapped varient of i2c_smbus_read_word_data
Date: Fri, 21 Oct 2011 17:14:45 +0100
Message-ID: <4EA19A75.6010907@cam.ac.uk>
References: <544AC56F16B56944AEC3BD4E3D59177146E75C18DC@LIMKCMBX1.ad.analog.com> <1319198236-2085-1-git-send-email-jic23@cam.ac.uk> <20111021160923.GA19153@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:47398 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849Ab1JUQOj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Oct 2011 12:14:39 -0400
In-Reply-To: <20111021160923.GA19153@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Michael.Hennerich@analog.com, Linux I2C <linux-i2c@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>

On 10/21/11 17:09, Dmitry Torokhov wrote:
> On Fri, Oct 21, 2011 at 12:57:16PM +0100, Jonathan Cameron wrote:
>> This varient was introduced in
>> i2c: boilerplate function for byte swapped smbus_write/read_word_data
>>
>> This also has the side effect of ensuring any errors from the i2c
>> read and no longer mangled.
>>
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>> V2: include the write function as pointed out by Michael Hennerich.
>>
>> The patch introducing this swapped function is working its way through the i2c
>> tree.
>>
>>  drivers/input/touchscreen/ad7879-i2c.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
>> index 4e4e58c..cc51392 100644
>> --- a/drivers/input/touchscreen/ad7879-i2c.c
>> +++ b/drivers/input/touchscreen/ad7879-i2c.c
>> @@ -47,7 +47,7 @@ static int ad7879_i2c_read(struct device *dev, u8 reg)
>>  {
>>  	struct i2c_client *client = to_i2c_client(dev);
>>  
>> -	return swab16(i2c_smbus_read_word_data(client, reg));
>> +	return i2c_smbus_read_word_swapped(client, reg);
> 
> This is still not endian-safe. I wonder if introducing
> i2c_smbus_read_word_swapped() just makes the metter worse by hiding
> this...
> 
> I'd prefer if we had i2c_smbus_read_be16() instead.
smbus spec says that all transfers must be little endian.
Hence it is type safe because the smbus controllers are guaranteed to have made
that assumption and converted to cpu endianess.  If not they are buggy.
Hence, this is endian safe.

Unfortunately numerous devices do the exact opposite (for successive approximation
ADCs it would be silly to do otherwise.) Hence they use the smbus protocol, but
then have to flip the bytes.

