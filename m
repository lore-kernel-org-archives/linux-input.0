From: Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: [PATCH] linux-input: TSC-10 DM USB touchscreen driver assume
 2-byte response from controller
Date: Tue, 11 Nov 2008 23:54:01 +0100
Message-ID: <491A0D09.8040803@gmx.ch>
References: <c4f20e170811060725v2ae331f9t7b1ba48059f93170@mail.gmail.com> <20081111164953.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:60103 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752304AbYKKWyF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2008 17:54:05 -0500
In-Reply-To: <20081111164953.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nuno Lucas <ntlucas@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On 11.11.2008 22:52, Dmitry Torokhov wrote:
> On Thu, Nov 06, 2008 at 03:25:40PM +0000, Nuno Lucas wrote:
>> The usbtouchscreen module implements a driver for the TSC-10 DM USB
>> touchscreen controllers, but assumes a 2-byte response for the
>> CMD_RESET and CMD_RATE commands, when they can be only a single byte
>> when no EEPROM is connected.
>>
>> The driver worked with an earlier controller revision, but new
>> revisions of the controller fail.
>>
>> It seems the problem is that the early controller had the
>> SEL4/EEPROM-CS pin high, but the new controller has it down, making
>> the response different.
>>
>> Without the fix, the controller would answer the single byte 0x06
>> (ACK), making the init fail with -ENODEV because buf[1] is 0xFF (as
>> initialized before).
>>
>> As the single byte is the only thing we need to check it was ok, there
>> is no need to verify the second byte.
>>
>> The [0x15 0x01] case is the NAK [0x15] response for when there is no
>> data in the EEPROM [bit-0 of second byte set], so I let that be, as I
>> don't have any controller with an EEPROM.
>>
>> With this patch, both the earlier and latest controller work the same.
>>
>> Note: This was previously submited as BUG #11961 [1] on the bugzilla
>> tracker, but rebased to version 2.6.27.4 and with unnecessary comments
>> and printk's removed.
>>
>>
>> Signed-off-by: Nuno Lucas <ntlucas@gmail.com>
>>
>>
>> [1] http://bugzilla.kernel.org/show_bug.cgi?id=11961
> 
>> diff -urNp linux-2.6.27.4/drivers/input/touchscreen/usbtouchscreen.c linux-2.6.27.4-patched/drivers/input/touchscreen/usbtouchscreen.c
>> --- linux-2.6.27.4/drivers/input/touchscreen/usbtouchscreen.c	2008-10-25 23:05:07.000000000 +0100
>> +++ linux-2.6.27.4-patched/drivers/input/touchscreen/usbtouchscreen.c	2008-11-06 15:07:49.000000000 +0000
>> @@ -424,7 +424,7 @@ static int dmc_tsc10_init(struct usbtouc
>>  	                      0, 0, buf, 2, USB_CTRL_SET_TIMEOUT);
>>  	if (ret < 0)
>>  		goto err_out;
>> -	if (buf[0] != 0x06 || buf[1] != 0x00) {
>> +	if (buf[0] != 0x06) {
>>  		ret = -ENODEV;
>>  		goto err_out;
>>  	}
>> @@ -437,8 +437,7 @@ static int dmc_tsc10_init(struct usbtouc
>>  	                      TSC10_RATE_150, 0, buf, 2, USB_CTRL_SET_TIMEOUT);
>>  	if (ret < 0)
>>  		goto err_out;
>> -	if ((buf[0] != 0x06 || buf[1] != 0x00) &&
>> -	    (buf[0] != 0x15 || buf[1] != 0x01)) {
>> +	if ((buf[0] != 0x06) && (buf[0] != 0x15 || buf[1] != 0x01)) {
>>  		ret = -ENODEV;
>>  		goto err_out;
>>  	}
> 
> Daniel, have you seen this?
> 

Seems to make sense. 0x06 is always the normal response, the error responses
start with 0x15 and only there the second byte matters...
Besides the serial version of the controller use just one byte for the normal
response...so i guess the protocols got aligned...
  http://www.dmccoltd.com/files/controler/tsc10_rsa_e.pdf

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

