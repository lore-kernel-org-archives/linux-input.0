From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID bus
Date: Mon, 21 Apr 2008 11:25:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804211124060.19002@twin.jikos.cz>
References: <Pine.LNX.4.64.0804181333180.12972@jikos.suse.cz>
 <1208644696-29129-1-git-send-email-jirislaby@gmail.com> <480B6C16.40806@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:42955 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755930AbYDUJZv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 05:25:51 -0400
In-Reply-To: <480B6C16.40806@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, mit-devel@lists.printk.net, linux-kernel@vger.kernel.org

On Sun, 20 Apr 2008, Anssi Hannula wrote:

> Why not just do something like
> 
> #define HID_DEVICE(vend, dev) \
> 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE | \
> 		       USB_DEVICE_ID_MATCH_INT_CLASS, \
> 	.idVendor = (vend), \
> 	.idProduct = (prod), \
> 	.bInterfaceClass = USB_INTERFACE_CLASS_HID
> (see linux/usb.h)
> 
> and use USB hotplugging?
> Or do we plan to match against something else as well, such as hid
> reports or something?

No, we plan to do matching based solely on VID/PID. The report-specific 
stuff is then handled between the specific driver and HID generic code.

Thanks,

-- 
Jiri Kosina
SUSE Labs

