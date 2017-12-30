From: Sebastian Schmidt <yath@yath.de>
Subject: Re: PROBLEM: Changing speed on ThinkPad X1 Carbon 5th trackpoint
 causes "failed to enable mouse"
Date: Sat, 30 Dec 2017 15:11:38 +0100
Message-ID: <20171230141138.GA23284@marax.lan.yath.de>
References: <20171228091125.GA743@marax.lan.yath.de>
 <c6427787-112c-d6f7-4f77-ae44c6aebb2f@canonical.com>
 <20171228142855.GA2007@marax.lan.yath.de>
 <f1fb1612-2d16-25a4-b57e-c56a01b729c2@canonical.com>
 <20171229190529.GA2108@marax.lan.yath.de>
 <f8795209-1b95-81a5-5fbe-f3e3fdc0d18f@canonical.com>
 <20171230095705.GA1861@marax.lan.yath.de>
 <4ca11d3d-4e7c-5bef-1811-9bc95b6e901a@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from karr.yath.de ([144.76.4.50]:47434 "EHLO karr.yath.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbdL3OLq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 30 Dec 2017 09:11:46 -0500
Content-Disposition: inline
In-Reply-To: <4ca11d3d-4e7c-5bef-1811-9bc95b6e901a@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>, gregkh@linuxfoundation.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Sat, Dec 30, 2017 at 09:54:39PM +0800, Aaron Ma wrote:
> I believe it should be a firmware issue on trackpoint.

I’ve just checked yesterday and updated the Windows Synaptics drivers to
the newest version, but the reported firmware version (4) stays
unchanged. Did you actually verify your change on firmware version 4 or
only 2 and 3, as the commit message and the comment indicate?

> There are several ways to set the speed & sensitivity:
> 1, udev hwdb/rules;
> 2, xorg conf;
> 3, GUI;
> 
> It seems users are rarely to use sysfs directly, so the bug is still there.

Sorry. Are you saying “Oops, thanks for the report, I’ll fix it”
or “I’ve just given you three ways to tell libinput my preferred
acceleration, so sysfs is going to stay broken for firmware version
0x04”? I doubt that sysfs is “rarely” used and, mind you, not everyone
is using GNOME and Wayland.

Adding Greg KH since he’s asked for objections in
<20170828080530.607134002@linuxfoundation.org>.
