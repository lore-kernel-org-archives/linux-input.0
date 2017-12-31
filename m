From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH] Revert "Input: trackpoint - add new trackpoint firmware
 ID"
Date: Sun, 31 Dec 2017 16:51:09 +0800
Message-ID: <901a0a66-eb83-9dcd-658c-5b09eabcab88@canonical.com>
References: <20171230152213.GA2099@marax.lan.yath.de>
 <dcfb84c8-4ad8-8276-5451-ee91fc84f742@canonical.com>
 <20171231082646.GC25965@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49769 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdLaIvQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 31 Dec 2017 03:51:16 -0500
In-Reply-To: <20171231082646.GC25965@kroah.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sebastian Schmidt <yath@yath.de>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

1, Commit ec667683c53 addes support of the new trackpoint.
The trackpoint can be identified as "TPPS/2 IBM TrackPoint" and set
properties OK. Trackpoint enabled some enhanced features.
Without this commit there will be no scroll mode when xf86-input-evdev
is used.

2, trackpoint.c export a speed of sysfs,
the speed sys file can't be set right value on X1 Carbon 5th. This issue
is caused by trackpoint firmware.
Workaround is to use xinput/xorg/udev/GUI to set trackpoint speed.

3, Windowds tool Trackpointdetect.exe shows it is ELAN (ID:03) in error log.
After debugging psmouse driver on it, the IDs and FW/hardware version is
not ELAN. Forcing to load ELAN driver will not make it work.
