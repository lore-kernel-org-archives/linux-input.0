From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: Re: [PATCH] hid: cp2112: support i2c_transfer() when num > 1
Date: Sun, 15 Mar 2015 21:23:24 +0800
Message-ID: <CAAj6DX0cXWHGV-=x0WfoSrXLVTEiNf+Vfj0HDOf4x4NC6Ny=tg@mail.gmail.com>
References: <1426419798-25360-1-git-send-email-borneo.antonio@gmail.com>
	<20150315121020.GA14594@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34536 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbbCONXZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Mar 2015 09:23:25 -0400
In-Reply-To: <20150315121020.GA14594@katana>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org

On Sun, Mar 15, 2015 at 8:10 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Sun, Mar 15, 2015 at 07:43:18PM +0800, Antonio Borneo wrote:
>> The device cp2112 does not support i2c combined transactions,
>> since unable to suppress the stop bit between adjacent i2c
>> transactions.
>
> Let's keep the precise terminology: a 'transfer' is anything between the
> start and stop bit. It can consist of multiple 'messages' which are
> combined with repeated start within one transfer.

Hi Wolfram,

thanks for your review and the clarification.

>
>> For this reason, in commit b9029345ed6483fcadadc4834b44a5656dd56d70
>> ("HID: cp2112: add I2C mode") I have omitted the support for
>> num > 1 in i2c_transfer().
>
> Good. You should make use of the quirk framework soon in linux-next or
> here: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/quirks

Nice improvement. Informing the upper driver about max R/W length is
really welcome.

>> 1) in few kernel drivers i2c_transfer() has been used to
>> simplify the code by replacing a sequence of i2c_master_send()
>> and i2c_master_recv(), e.g. in i2c-hid.c and iio subsystem.
>> Those drivers will fail if used with current cp2112 driver.
>
> I see two options for those:
>
> 1) revert the simplifications and sacrifice a bit of performance
>    to support the widest number of adapters
> 2) use the quirk infrastructure from above to query the
>    quirks of the adapter to chose between fast or compatible

Could this be an extension of your quirks?
I mean, moving in i2c-core the switch between fast or compatible?
The caller should only state if combined transfer is strictly required
by the device on I2C bus.

> Keep in mind that some devices do *require* that messages are combined
> with repeated start because they will reset their state machine after
> stop.

Agree!

>> 2) in drivers/i2c/busses/ there are already drivers that
>> implement i2c_transfer() as a sequence of elementary (not
>> combined) i2c transactions, e.g. i2c-bcm2835.c, i2c-puv3.c,
>> i2c-qup.c, i2c-robotfuzz-osif.c, i2c-viperboard.c, i2c-xlr.c.
>
> You misread that, most probably. They are iterating over the messages,
> yes, but they are expected to connect them via repeated start. If there
> is a driver sending stop after every message and accepting more than one
> message per transfer, this is a bug.

I have check most of the I2C adapter drivers. At least for the 6
drivers above, reading the code I don't see anything that implements
the repeated start. But I do not have the HW to run a test.
It's definitively possible I misread them.

>> To fix 1) and considering 2), rewrite i2c_transfer() in case
>> of num > 1 as a loop of non-combined i2c transactions.
>
> For the above reasons, NAK.

Ok, agree to drop this patch.

>> In [1] we had a talk about implementing i2c_transfer() as a
>> sequence of elementary (not combined) i2c transactions.
>> After Jonathan's reply in [2], I went to check better the
>> existing I2C drivers and I changed opinion.
>
> And why is this driver in hid? This is clearly an I2C master driver?

Actually it should be a MFD, since it implements I2C/SMB master and GPIO.
It uses HID over USB, that is probably the reason it is here.

Best Regards,
Antonio
