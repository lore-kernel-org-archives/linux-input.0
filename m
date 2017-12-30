From: Sebastian Schmidt <yath@yath.de>
Subject: Re: PROBLEM: Changing speed on ThinkPad X1 Carbon 5th trackpoint
 causes "failed to enable mouse"
Date: Sat, 30 Dec 2017 10:57:05 +0100
Message-ID: <20171230095705.GA1861@marax.lan.yath.de>
References: <20171228091125.GA743@marax.lan.yath.de>
 <c6427787-112c-d6f7-4f77-ae44c6aebb2f@canonical.com>
 <20171228142855.GA2007@marax.lan.yath.de>
 <f1fb1612-2d16-25a4-b57e-c56a01b729c2@canonical.com>
 <20171229190529.GA2108@marax.lan.yath.de>
 <f8795209-1b95-81a5-5fbe-f3e3fdc0d18f@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from karr.yath.de ([144.76.4.50]:46258 "EHLO karr.yath.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750879AbdL3J5N (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 30 Dec 2017 04:57:13 -0500
Content-Disposition: inline
In-Reply-To: <f8795209-1b95-81a5-5fbe-f3e3fdc0d18f@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Sat, Dec 30, 2017 at 02:43:16PM +0800, Aaron Ma wrote:
> Please try:
> $ xinput set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" -1
> 
> The last value of speed can be -1 to 1.

Ah. That indeed changes the speed, thanks!

However, please let me ask again: Isn’t the sysfs interface supposed to
work, too? I’ve got my problem resolved for Xorg now, but about every
article on the internet refers to the sysfs interface for changing the
speed, cf. <https://www.google.com/search?q=trackpoint+speed>.

I’m also fine with the assertion that Lenovo shipped a broken firmware,
but I’d expect some warning in dmesg then and a reasonable fallback (to
a regular PS/2 mouse?) then. Can we at least agree that there is a
driver bug that ought to be fixed or a firmware bug that ought to be
worked around?

Thanks,
Sebastian
