From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Fri, 16 May 2014 10:40:53 -0600
Message-ID: <53763F95.6000609@wwwdotorg.org>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org> <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com> <536963A0.4060506@wwwdotorg.org> <536BAA5A.1010809@itdev.co.uk> <536BB3C9.8070908@wwwdotorg.org> <536BDFFD.4080009@itdev.co.uk> <537128D0.3060005@wwwdotorg.org> <53763B06.7020100@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:57311 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756380AbaEPQk5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 May 2014 12:40:57 -0400
In-Reply-To: <53763B06.7020100@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

On 05/16/2014 10:21 AM, Nick Dyer wrote:
> Stephen Warren wrote:
>> On 05/08/2014 01:50 PM, Nick Dyer wrote:
>>> The patches I posted at the end of March are the first 22 out of this tag:
>>>
>>> https://github.com/ndyer/linux/tree/for-next-20140316-v8
>>
>> I took those 22 patches, applied them on top of next-20150507 (which is
>> just what I happened to be developing on top of right now), and rebased
>> my patches which add DT support. You can find the result here if you want:
>>
>> git://github.com/swarren/linux-tegra.git tegra_dev
> 
> Thanks for this. Would you be happy for me to pick these changes up and
> include them along with the other work I am sending to Dmitry? I am just
> beginning to do various updates to the whole series, one of the things I
> need to sort out is the device tree support.

That would be fine. I assume you'd only take the 2 Atmel driver patches.
I'll send the Tegra patches separately once the driver is merged.

One thing I wasn't really sure about: With your latest patches, it seems
like the bootloader address is auto-calculated from the application
address. As such, do I still need separate struct i2c_device for the
application and bootloader I2C addresses? If not, we should remove the
atmel,mxt-tp-bootloader from those patches. If so, I need to add the
second DT node back into the Tegra DT. Either way, it might be
preferable if we only had 1 node in DT, and the driver automatically
handled the two separate I2C addresses.

> I will need to add device tree parameters for the touchscreen as well as
> the touchpad, of course.
> 
> By the way, the driver should work without any firmware file and just use
> the firmware and configuration from NVRAM - request_firmware() returns a
> failure and it continues through mxt_initialize().

Hmmm. I couldn't get that to work after applying the patches you posted.
However, it did with what's already in linux-next plus the patches I sent.

> In a later patch in my long series, I make the MXT_CFG_NAME configurable
> from platform data (because you may have multiple devices needing different
> configs), and leaving it null means the call to request_firmware() is skipped.

It'd be preferable to automatically derive the firmware name from the
device type (touchscreen/touchpad) or some other parameter that can be
calculated at run-time, or queried from HW (e.g. version # from
bootloader?). I'm not sure that putting firmware filenames in DT is a
good idea, but perhaps that would work. Deriving firmware filename from
the DT compatible value would work best. If different HW needs different
firmware, it should probably have a different compatible value in DT.

I don't want to build firmware filenames into the kernel at
compile-time, since I want to be able to take a single kernel and run it
on any ARM board, each of which might use different firmware, but all
the same, use the same root filesystem (on an SD card) on all boards,
without having to rename firmware.
