From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ALPS touchpad no longer recognizing 'taps' as mouseclick in
 3.3-rc3
Date: Sun, 12 Feb 2012 12:12:36 -0800
Message-ID: <20120212201236.GA9389@core.coreip.homeip.net>
References: <20120212164728.GA19629@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42053 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab2BLUMm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Feb 2012 15:12:42 -0500
Content-Disposition: inline
In-Reply-To: <20120212164728.GA19629@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Greg,

On Sun, Feb 12, 2012 at 08:47:28AM -0800, Greg KH wrote:
> Hi,
> 
> This problem has been since 3.3-rc1, but I only now am getting around to
> reporting it, sorry about that.
> 
> In 3.3-rc3, my alps touchpad isn't recognizing a tap on the touchpad as
> a mouse click.  Is there a new Kconfig option that I need to enable?
> 
> My /proc/bus/input/devices entry for this thing is:
> I: Bus=0011 Vendor=0002 Product=0008 Version=7326
> N: Name="AlpsPS/2 ALPS DualPoint TouchPad"
> P: Phys=isa0060/serio1/input0
> S: Sysfs=/devices/platform/i8042/serio1/input/input6
> U: Uniq=
> H: Handlers=mouse1 event6 
> B: PROP=8
> B: EV=b
> B: KEY=e420 70000 0 0 0 0
> B: ABS=260800001000003
> 
> Is there anything else you need me to report to help track this down?
> 

Please make sure you have xorg-x11-drv-synaptics installed and then
check if tap to click is enabled in your DE. I think Gnome for some
reason has it off my default.

Thanks.

-- 
Dmitry
