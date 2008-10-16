From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: mmotm 2008-10-16-00-52 uploaded (HID)
Date: Fri, 17 Oct 2008 01:15:30 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0810170113570.28536@jikos.suse.cz>
References: <200810160758.m9G7wZmt018529@imap1.linux-foundation.org> <Pine.LNX.4.64.0810161558341.14604@shark.he.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:60607 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755146AbYJPXPc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Oct 2008 19:15:32 -0400
In-Reply-To: <Pine.LNX.4.64.0810161558341.14604@shark.he.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, 16 Oct 2008, Randy.Dunlap wrote:

> > The mm-of-the-moment snapshot 2008-10-16-00-52 has been uploaded to
> >    http://userweb.kernel.org/~akpm/mmotm/
> > It contains the following patches against 2.6.27:
> mmotm has several various build failures when
> HID=y and USB=n
> or
> HID=y and USB_HID=m.
> These are (mostly) caused by drivers/hid/Kconfig doing lots of "select"s
> when EMBEDDED=n, such as
> config HID
> 	tristate "Generic HID support"
> 	depends on INPUT
> 	default y
>         select HID_A4TECH if !EMBEDDED
[ ... ]
> Build failure examples:
> 9168:
> HID=y, USB=n
> hid-bright.c:(.text+0x1013f0): undefined reference to `usbhid_set_leds'
> hid-dell.c:(.text+0x1019bc): undefined reference to `usbhid_set_leds'
> hid-lg.c:(.text+0x102310): undefined reference to `usbhid_set_leds'
> hid-lgff.c:(.text+0x102509): undefined reference to `usbhid_submit_report'
> hid-lgff.c:(.text+0x102566): undefined reference to `usbhid_submit_report'
> hid-pl.c:(.text+0x102bbb): undefined reference to `usbhid_submit_report'
> hid-pl.c:(.text+0x102ddf): undefined reference to `usbhid_submit_report'
> hid-sony.c:(.text+0x103339): undefined reference to `usb_control_msg'

Hi Randy,

yes, that's my bug, and it is already fixed in Linus' tree (commit 
b36299bcc0f).

Thanks,

-- 
Jiri Kosina
SUSE Labs
