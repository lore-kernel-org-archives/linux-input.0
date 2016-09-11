From: Brad Baker <bbaker6212@gmail.com>
Subject: Re: Goodix touchscreen works intermittently, fails reading config info.
Date: Sun, 11 Sep 2016 16:28:08 -0300
Message-ID: <CAG=1usZc8FY4=xn9eGq17X+a0NtjR+47kKs_eYHXrpNERpFtow@mail.gmail.com>
References: <CAG=1usatOHQ3sq5NTanbRQZ088gD53Xu3APVxe4p6Lf4mf5ahQ@mail.gmail.com>
 <1F3AC3675D538145B1661F571FE1805F2F32C5C6@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33424 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756227AbcIKT2K (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 11 Sep 2016 15:28:10 -0400
Received: by mail-qt0-f172.google.com with SMTP id 11so63897225qtc.0
        for <linux-input@vger.kernel.org>; Sun, 11 Sep 2016 12:28:10 -0700 (PDT)
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F32C5C6@irsmsx105.ger.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: bastien nocera <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Irina,
  I don't have the tablet. The user's last reply yesterday was this:
"here is a log of the, TS working with your latest edits
http://pastebin.com/mhMpa3Zj . it might be a couple days before i can
do much more testing on it.  "
So I'm still waiting to find out if my changing the default
trigger_type=0 had any effect when read_config fails.
That log of the working case shows things as expected.

[   12.356637] goodix_backport: loading out-of-tree module taints kernel.
[   12.356739] goodix_backport: module verification failed: signature
and/or required key missing - tainting kernel
[   12.364644] intel_sst_acpi 808622A8:00: No matching machine driver found
[   12.365892] Goodix-TS i2c-GDIX1001:00: ID 9111, version: 1060
[   12.373813] Goodix-TS i2c-GDIX1001:00: dev_info: cfg_len: 186,
x_max: 2160, y_max: 2160, touch_num: 10, trigger_type: 0
[   12.373822] Goodix-TS i2c-GDIX1001:00: dev_info: cfg_len: 186,
x_max: 2160, y_max: 2160, touch_num: 10, trigger_type: 0
[   12.373998] input: Goodix Capacitive TouchScreen as
/devices/pci0000:00/808622C1:05/i2c-13/i2c-GDIX1001:00/input/input6

<====== Note: =====>
Please note my change of email address I will be moving to soon:
bradleybaker@protonmail.com
<================>


On Sun, Sep 11, 2016 at 3:54 PM, Tirdea, Irina <irina.tirdea@intel.com> wrote:
>
>
>> -----Original Message-----
>> From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Brad Baker
>> Sent: 11 September, 2016 0:21
>> To: bastien nocera
>> Cc: linux-input@vger.kernel.org
>> Subject: Goodix touchscreen works intermittently, fails reading config info.
>>
>> Summary: Goodix touchscreen works intermittently, fails reading config info.
>>  https://bugzilla.kernel.org/show_bug.cgi?id=156511
>>
>> Description:  Chuwi Hi12 tablet with Intel cherry-trail Atom Z8300,
>> the touchscreen does work after bootup most of the time, but sometimes
>> it does not work without running modprobe.  When it fails the dmesg
>> log shows the error "Invalid config, using defaults" and when it works
>> this error is not present.
>>
>> Module: goodix, goodix_backport
>> Linux version 4.8.0-040800rc5-generic (kernel@tangerine) (gcc version
>> 6.2.0 20160830 (Ubuntu 6.2.0-2ubuntu11) ) #201609041832 SMP Sun Sep 4
>> 22:34:01 UTC 2016
>>
>> dmesg log when it's failing:
>> [ 10.012314] Goodix-TS i2c-GDIX1001:00: ID 9111, version: 1060
>> [ 10.017711] Goodix-TS i2c-GDIX1001:00: Invalid config, using defaults
>> [ 10.018021] input: Goodix Capacitive TouchScreen as
>> /devices/pci0000:00/808622C1:05/i2c-13/i2c-GDIX1001:00/input/input6
>>
>> details given in bugzilla #156511
>
> Hi Brad,
>
> I had similar problems with some Goodix devices until I enabled the
> reset sequence [1].
>
> Although the touch screen was initialized and I could read/write to/from
> the device, I read only 0s from the configuration registers. The datasheet
> recommends using the reset procedure at power on, so I could not find any
> information on how to make the device work reliably without it. Resetting the
> device at boot fixed the problem for me. For backwards compatibility, the
> reset sequence is only available if the interrupt and reset gpio pins are
> connected and configured through _DSD properties in the ACPI table or DT
> properties.
>
> One reason for the touchscreen not working in this case is that the interrupts
> are not properly configured. I noticed in the Bugzilla details that you already
> tried changing the default value for trigger_type to the one read from the device.
> Did that work?
>
> Regards,
> Irina
>
> [1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ec6e1b4082d9f5b0858ce33169a1c22a27a982f6
