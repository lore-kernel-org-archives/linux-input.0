From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Tue, 20 May 2014 17:19:19 +0100
Message-ID: <537B8087.1040306@itdev.co.uk>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org> <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com> <536963A0.4060506@wwwdotorg.org> <536BAA5A.1010809@itdev.co.uk> <536BB3C9.8070908@wwwdotorg.org> <536BDFFD.4080009@itdev.co.uk> <537128D0.3060005@wwwdotorg.org> <53763B06.7020100@itdev.co.uk> <53763F95.6000609@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:22049 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753819AbaETQTX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 May 2014 12:19:23 -0400
In-Reply-To: <53763F95.6000609@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

Stephen Warren wrote:
> On 05/16/2014 10:21 AM, Nick Dyer wrote:
>> Thanks for this. Would you be happy for me to pick these changes up and
>> include them along with the other work I am sending to Dmitry? I am just
>> beginning to do various updates to the whole series, one of the things I
>> need to sort out is the device tree support.
> 
> That would be fine. I assume you'd only take the 2 Atmel driver patches.
> I'll send the Tegra patches separately once the driver is merged.

Great! Dmitry has merged some of the patches I sent now, so I'm just
working on updating to take account of that and adding the device tree
changes, and taking account of a couple of other review comments.

> One thing I wasn't really sure about: With your latest patches, it seems
> like the bootloader address is auto-calculated from the application
> address. As such, do I still need separate struct i2c_device for the
> application and bootloader I2C addresses? If not, we should remove the
> atmel,mxt-tp-bootloader from those patches. If so, I need to add the
> second DT node back into the Tegra DT. Either way, it might be
> preferable if we only had 1 node in DT, and the driver automatically
> handled the two separate I2C addresses.

Currently you shouldn't need the extra node for the bootloader, it should
figure it out itself. I think in the future, the driver should register the
bootloader address with i2c_new_dummy() to prevent it being bound to a
different driver.

>> I will need to add device tree parameters for the touchscreen as well as
>> the touchpad, of course.
>>
>> By the way, the driver should work without any firmware file and just use
>> the firmware and configuration from NVRAM - request_firmware() returns a
>> failure and it continues through mxt_initialize().
> 
> Hmmm. I couldn't get that to work after applying the patches you posted.
> However, it did with what's already in linux-next plus the patches I sent.

I will test this on my setup and see if I can figure out what is causing
the problem.

>> In a later patch in my long series, I make the MXT_CFG_NAME configurable
>> from platform data (because you may have multiple devices needing different
>> configs), and leaving it null means the call to request_firmware() is skipped.
> 
> It'd be preferable to automatically derive the firmware name from the
> device type (touchscreen/touchpad) or some other parameter that can be
> calculated at run-time, or queried from HW (e.g. version # from
> bootloader?). I'm not sure that putting firmware filenames in DT is a
> good idea, but perhaps that would work. Deriving firmware filename from
> the DT compatible value would work best.

Yes, I was planning to allow the firmware filename to be specified in DT. I
think that coming up with a scheme to automatically derive it would fall
down in various corner cases (as an example, you might have two devices
which have the same family/variant IDs but require different firmwares), so
it gives maximum flexibility to not dictate the naming policy.

> If different HW needs different
> firmware, it should probably have a different compatible value in DT.

There are literally hundreds of different combinations of hardware/firmware
supported by this driver. Trying to generate a comprehensive list would be
a never-ending task to support. I don't think this is a good idea.
