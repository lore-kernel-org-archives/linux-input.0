From: Yong Wang <yong.y.wang@linux.intel.com>
Subject: Re: [PATCH] eeepc-wmi: new driver for WMI based hotkeys on Eee PC
	laptops
Date: Sat, 20 Mar 2010 20:24:16 +0800
Message-ID: <20100320122416.GA10558@ywang-moblin2.bj.intel.com>
References: <20100319133924.GA30427@ywang-moblin2.bj.intel.com> <20100319135929.GA29027@srcf.ucam.org> <20100319151054.GA30664@ywang-moblin2.bj.intel.com> <20100319152323.GA30456@srcf.ucam.org> <20100320005553.GB32163@ywang-moblin2.bj.intel.com> <20100320122049.GA1478@holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:7014 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751824Ab0CTMdO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 08:33:14 -0400
Content-Disposition: inline
In-Reply-To: <20100320122049.GA1478@holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: cascardo@holoscopio.com
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Corentin Chary <corentincj@iksaif.net>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org

On Sat, Mar 20, 2010 at 09:20:50AM -0300, cascardo@holoscopio.com wrote:
> On Sat, Mar 20, 2010 at 08:55:53AM +0800, Yong Wang wrote:
> > 
> > One question just popped off the top my head. What if there is a power
> > applet that wants to display a slider field at the bottom of the screen
> > showing the current brightness real time whenever users press brightness
> > hotkeys? Shouldn't it listen to the standard input events translated by
> > X into standard XF86 keysyms? Or shall it listen to the ACPI backlight
> > events? If so, it is the ACPI LCD event when using acpi backlight
> > driver. But what if those vendor specific backlight drivers are used?
> > 
> > Thanks
> > -Yong
> > --
> 
> You may select/poll for the sysfs file actual_brightness. It will return
> POLLPRI. Basically, backlight devices end up calling sysfs_notify that
> will allow sysfs_poll to work. Read the comments about sysfs_poll at
> fs/sysfs/file.c.
> 
> You should either use backlight_force_update in your driver or let the
> user update it writing to the brightness file. In your case, I'd say you
> should use backlight_force_update and give BACKLIGHT_UPDATE_HOTKEY as
> the reason.
> 

Oh, I see. Thank for clarifying, Cascardo.

-Yong

