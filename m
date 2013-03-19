From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 2/4] Input: cyapa - Firmware update via request firmware
Date: Mon, 18 Mar 2013 17:37:01 -0700
Message-ID: <CANLzEku6s-831vfrP56eS2ZCGT==8i8JqjGNs++ujAvr8enxQg@mail.gmail.com>
References: <1363218651-22457-1-git-send-email-bleung@chromium.org>
	<1363218651-22457-3-git-send-email-bleung@chromium.org>
	<20130316200047.GA6155@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:56902 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378Ab3CSAhC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Mar 2013 20:37:02 -0400
Received: by mail-oa0-f46.google.com with SMTP id k1so6315965oag.5
        for <linux-input@vger.kernel.org>; Mon, 18 Mar 2013 17:37:02 -0700 (PDT)
In-Reply-To: <20130316200047.GA6155@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Olof Johansson <olofj@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, Dudley Du <dudl@cypress.com>

On Sat, Mar 16, 2013 at 1:00 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
>> Userspace can initiate the firmware update procedure by copying cyapa.bin
>> to /lib/firmware, and then writing anything to the device sysfs attribute:
>>   /sys/bus/i2c/devices/7-0067/update_fw
>
> Why do you need to trigger this from userland via sysfs?
>

It's a confluence of factors that drives the decision trigger from userland.
- As a part of the cold-boot probe steps, the trackpad's bootloader
will load an operational firmware from its flash memory. In the
average case, the trackpad driver does not need to update the firmware
because it's current. (the non-average cases are cases where on device
firmware is corrupted or out of date)
- The cypress firmware payloads we are working with here do not
contain an indication of firmware version in the payload itself, so
the driver can't tell at probe time whether what it would get if it
request_firmware is newer, older, or the same version as what's
already loaded on the trackpad.
- On a 400kHz i2c bus, it takes 13 seconds to send the 31K payload to
the device and to wait for it to jump into the operational mode
firmware. This is too long to block probe every time.
- Because it takes so long to do a firmware update, our user space
would like to put up a warning message anyhow to tell the user that
the touchpad is being updated, and not to disturb the system.

>> +     if (sysfs_create_group(&client->dev.kobj, &cyapa_sysfs_group))
>> +             dev_warn(dev, "error creating sysfs entries.\n");
>> +
>
> Would it not be neat to invoke the firmware update automatically instead?

The one situation where I could see an automatic firmware update being
useful would be cases where the driver, during probe, discovered that
the trackpad is in Bootloader mode because no valid firmware was found
(a case of corruption of some kind due to the system powering down
during a previous fw update, or example). In that case, the driver can
request firmware and update it without user space having to trigger it
later.

Another driver in input does it the same way. atmel_mxt_ts.c, which
our team is actively working on as well, also has an update_fw sysfs
for a lot of the same reasons.

Thanks,

--
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
