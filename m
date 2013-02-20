From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: atmel_mxt_ts and mxt224e
Date: Wed, 20 Feb 2013 11:50:03 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1302201129400.3667@pmeerw.net>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net> <CAPDwgkPBmH3wTDs=t5uaj6jpK6hYD0mxJJ3-5d=Fv2W9aZ3dPQ@mail.gmail.com> <CAPDwgkPjhTMjS=V33u_JLx5H4sFEOUif_xgu-fz9BHYmPdO11g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:57560 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933883Ab3BTKuF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Feb 2013 05:50:05 -0500
In-Reply-To: <CAPDwgkPjhTMjS=V33u_JLx5H4sFEOUif_xgu-fz9BHYmPdO11g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yufeng Shen <miletus@google.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, y0922.shim@samsung.com, Benson Leung <bleung@chromium.org>

Hello,

> > The Chromium team has been recently working on the atmel_mxt_ts driver extensively
> > (see patches history here
> > http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel.git;a=history;f=drivers/input/touchscreen/atmel_mxt_ts.c;h=5e40f6d75e7f7e24370e3a7d266c6ebcc06b46a6;hb=refs/heads/chromeos-3.4)

thank you for the pointer; I was aware of Chromiumos working on this but 
not the official place to look :)

> > As you pointed out, the chip configuration process and mxt_handle_pdata() is very fragile regarding
> > different chip sets with different object layouts. So we have taken the approach to move to file based
> > configuration (see patch
> > http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel.git;a=commit;h=95a1d96b785af4e16138e6cc7b4d01fed5b9dccb)

I think that's a good idea to support robust configuration loading

> > So the platform data are moved to a config file with predefined format. Userspace can interact with the driver
> > through sysfs to initiate loading a particular config file for the device. When configuration happens, config file chip ID & chip info
> > block CRC are compared against the device chip ID & device chip info block to make sure the consistence between
> > the config and the chip set. Then the configuration is written to the device dynamically which does not require the device reboot.

but what to do with the initial configuration at _probe() time?

mxt_handle_pdata() is still there
I'm pretty sure setting of the threshold, burst length, orientation do not 
work as intended; voltage setting is still broken for mxt224e

is the plan to remove pdata support altogether? this then requires 
userspace interaction to get the device working

> > We have been using and testing this approach for a long time and now 
> > in the process of upstreaming our patch set, so to avoid duplicate 
> > effort, it would be great if you can give some thoughts (or try out the 
> > patch set if you are interested and we would give you all the help as
> > we can) on our patch set and let us iterate on it.

I have no need for flexible post-probe device configuration

my patches 1,3,4,5,7 are mostly complementary to your patch series

can the proposed file format replace the pdata config data? 
mxt_apply_pdata_config() would need to be adapted then...

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
