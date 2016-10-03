From: Brad Baker <bbaker6212@gmail.com>
Subject: Re: Goodix touchscreen works intermittently, fails reading config info.
Date: Sun, 2 Oct 2016 21:53:47 -0300
Message-ID: <CAG=1usb-+fWC8ULCWyA2qnRy96+_FDyppd6FV6S13B2mrQRTaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35784 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbcJCAxt (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 2 Oct 2016 20:53:49 -0400
Received: by mail-qk0-f175.google.com with SMTP id t7so151187658qkh.2
        for <linux-input@vger.kernel.org>; Sun, 02 Oct 2016 17:53:49 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: bastien nocera <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Sep 14, 2016 at 6:29 AM, Tirdea, Irina <irina.tirdea@intel.com> wrote:
>
>
>> -----Original Message-----
>> From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Brad Baker
>> Sent: 13 September, 2016 6:05
>> To: Tirdea, Irina
>> Cc: bastien nocera; linux-input@vger.kernel.org
>> Subject: Re: Goodix touchscreen works intermittently, fails reading config info.
>>
>> Irina, a little more info on the symptoms. The user reports the
>> touchscreen works when restarting but fails when powering on.  He says
>> pretty much 100% of the time.  The log is the same...
>>
>
> Hi Brad,
>
> Thanks for all the information you provided. I have already replied on the
> Bugzilla thread with some patches that enable reset for the device.
>
> Regards,
> Irina
>
>

Hi Irina, please see my updates to your Bugzilla comments.
In the directions for generating the firmware file I did not understand this:
"set Config_Fresh to 1 and generate the binary config firmware image"
Where is Config_Fresh set?  Do I set it to 1 at the top of the shell script?...
https://github.com/blocksonic/gt9xx/blob/device-tree/goodix-generate-fw.sh

Also, your comment was not clear to me...
"You might need to revert the patch that enables reset for the Chuwi tablet [3]"
Under what conditions do I need to move these changes?

The user is reporting the following dmesg output with your latest code...

[    8.635097] goodix_backport: loading out-of-tree module taints kernel.
[    8.635878] goodix_backport: module verification failed: signature
and/or required key missing - tainting kernel
[    8.644537] Goodix-TS i2c-GDIX1001:00: I2C Address: 0x14
[    8.644549] Goodix-TS i2c-GDIX1001:00: Applying gpios quirk
[    8.679120] EFI Variables Facility v0.08 2004-May-17
[    8.690345] pstore: using zlib compression
[    8.690382] pstore: Registered efi as persistent store backend
[    8.741171] Goodix-TS i2c-GDIX1001:00: i2c test failed attempt 1: -121
[    8.772461] Goodix-TS i2c-GDIX1001:00: i2c test failed attempt 2: -121
[    8.797575] Goodix-TS i2c-GDIX1001:00: I2C communication failure: -121
[    8.819003] SSE version of gcm_enc/dec engaged.
[    8.821731] Goodix-TS: probe of i2c-GDIX1001:00 failed with error -121

Please see my latest posts on Bugzilla.  Thanks, -Brad-
