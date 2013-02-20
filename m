From: Yufeng Shen <miletus@google.com>
Subject: Re: atmel_mxt_ts and mxt224e
Date: Wed, 20 Feb 2013 13:18:44 -0500
Message-ID: <CAPDwgkMgTLp4cqytUzmy2KXNUQz4Lfdk03bSPahhvWKQ38QZbg@mail.gmail.com>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
	<CAPDwgkPBmH3wTDs=t5uaj6jpK6hYD0mxJJ3-5d=Fv2W9aZ3dPQ@mail.gmail.com>
	<CAPDwgkPjhTMjS=V33u_JLx5H4sFEOUif_xgu-fz9BHYmPdO11g@mail.gmail.com>
	<alpine.DEB.2.01.1302201129400.3667@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f52.google.com ([209.85.212.52]:53528 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933406Ab3BTSS6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Feb 2013 13:18:58 -0500
Received: by mail-vb0-f52.google.com with SMTP id fa15so5098521vbb.39
        for <linux-input@vger.kernel.org>; Wed, 20 Feb 2013 10:18:57 -0800 (PST)
In-Reply-To: <alpine.DEB.2.01.1302201129400.3667@pmeerw.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, y0922.shim@samsung.com, Benson Leung <bleung@chromium.org>

On Wed, Feb 20, 2013 at 5:50 AM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
> Hello,
>
>> > The Chromium team has been recently working on the atmel_mxt_ts driver extensively
>> > (see patches history here
>> > http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel.git;a=history;f=drivers/input/touchscreen/atmel_mxt_ts.c;h=5e40f6d75e7f7e24370e3a7d266c6ebcc06b46a6;hb=refs/heads/chromeos-3.4)
>
> thank you for the pointer; I was aware of Chromiumos working on this but
> not the official place to look :)
>
>> > As you pointed out, the chip configuration process and mxt_handle_pdata() is very fragile regarding
>> > different chip sets with different object layouts. So we have taken the approach to move to file based
>> > configuration (see patch
>> > http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel.git;a=commit;h=95a1d96b785af4e16138e6cc7b4d01fed5b9dccb)
>
> I think that's a good idea to support robust configuration loading
>
>> > So the platform data are moved to a config file with predefined format. Userspace can interact with the driver
>> > through sysfs to initiate loading a particular config file for the device. When configuration happens, config file chip ID & chip info
>> > block CRC are compared against the device chip ID & device chip info block to make sure the consistence between
>> > the config and the chip set. Then the configuration is written to the device dynamically which does not require the device reboot.
>
> but what to do with the initial configuration at _probe() time?
>

In order to not break the existing code path, we keep the
mxt_handle_pdata() there
but add the support that if pdata is NULL, then we skip applying the
configuration from
pdata, see
http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel.git;a=commit;h=5650201eb029de18517c40610d8b4122aff7369f

As noted in the commit message, most of the time the device only need
to be configured once and later on it
can just use backed up config from NVRAM. When using pdata to config
device, the config is written to device
memory every time the device boots (or probed), which adds latency to
boot time. While in our dev process, we
pre-flash the device with a workable config, set pdata to NULL, and
most of the time the device just comes up
with the right config without need of re-configuration. And if a
different config is needed later, we do the reconfig
by loading the new config from file and back it up in NVRAM.

> mxt_handle_pdata() is still there
> I'm pretty sure setting of the threshold, burst length, orientation do not
> work as intended; voltage setting is still broken for mxt224e
>

Right. If you have to take the path of mxt_handle_pdata(), you will
have to branch on different device models.
Your patch 3 does the quick hack, but as more device models need to be
supported, adapting mxt_handle_pdata()
does not scale well, while loading a corresponding config file for a
specific chipset is more preferable.

> is the plan to remove pdata support altogether? this then requires
> userspace interaction to get the device working
>

see notes above.

>> > We have been using and testing this approach for a long time and now
>> > in the process of upstreaming our patch set, so to avoid duplicate
>> > effort, it would be great if you can give some thoughts (or try out the
>> > patch set if you are interested and we would give you all the help as
>> > we can) on our patch set and let us iterate on it.
>
> I have no need for flexible post-probe device configuration
>
> my patches 1,3,4,5,7 are mostly complementary to your patch series
>

> can the proposed file format replace the pdata config data?
> mxt_apply_pdata_config() would need to be adapted then...
>
see the above comments.

> regards, p.
>
> --
>
> Peter Meerwald
> +43-664-2444418 (mobile)
