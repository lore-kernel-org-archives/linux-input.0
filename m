From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Revert "Input: trackpoint - add new trackpoint firmware
 ID"
Date: Mon, 1 Jan 2018 23:08:11 -0800
Message-ID: <20180102070811.p7gfaq3vr55sdbd3@dtor-ws>
References: <20171230152213.GA2099@marax.lan.yath.de>
 <dcfb84c8-4ad8-8276-5451-ee91fc84f742@canonical.com>
 <20171231082646.GC25965@kroah.com>
 <901a0a66-eb83-9dcd-658c-5b09eabcab88@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:40794 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbeABHIP (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 2 Jan 2018 02:08:15 -0500
Received: by mail-it0-f53.google.com with SMTP id f190so38470105ita.5
        for <linux-input@vger.kernel.org>; Mon, 01 Jan 2018 23:08:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <901a0a66-eb83-9dcd-658c-5b09eabcab88@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Schmidt <yath@yath.de>, linux-input@vger.kernel.org

Hi Aaron,

On Sun, Dec 31, 2017 at 04:51:09PM +0800, Aaron Ma wrote:
> 1, Commit ec667683c53 addes support of the new trackpoint.
> The trackpoint can be identified as "TPPS/2 IBM TrackPoint" and set
> properties OK. Trackpoint enabled some enhanced features.
> Without this commit there will be no scroll mode when xf86-input-evdev
> is used.
> 
> 2, trackpoint.c export a speed of sysfs,
> the speed sys file can't be set right value on X1 Carbon 5th. This issue
> is caused by trackpoint firmware.

No, I do not believe that this is an issue with the firmware. Rather, it
seems that Lenovo is multi-sourcing trackpoint for their devices, and
not all of them implement the IBM trackpoint protocol. We will need to
contact Elan to figure out what capabilities their trackpoints have.

> Workaround is to use xinput/xorg/udev/GUI to set trackpoint speed.

I'd rather we did not force users to do that.

> 
> 3, Windowds tool Trackpointdetect.exe shows it is ELAN (ID:03) in error log.
> After debugging psmouse driver on it, the IDs and FW/hardware version is
> not ELAN. Forcing to load ELAN driver will not make it work.

We do not have a special driver for Elan trackpoints and if they do not
fully implement IBM trackpoint protocol, then standard PS/2 mode should
be used, at least until someone creates a proper Elan trackpoint driver.

The original "magic ID" for the IBM trcakpoints was 0x1. This value was
described in the original trackpoint spec and has not changed since late
90th. Now we have 0x2 and 0x3. Could they indicate ALPS and Elan
trackpoints respectively? What ID does your Yoga report? Does it support
all features exported by the trackpoint driver (speed, sensitivity,
inertia, etc)?

Thanks.

-- 
Dmitry
