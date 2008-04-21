From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: HID bus
Date: Mon, 21 Apr 2008 09:36:21 -0400
Message-ID: <20080421133621.GA27646@anvil.corenet.prv>
References: <Pine.LNX.4.64.0804181333180.12972@jikos.suse.cz> <1208644696-29129-1-git-send-email-jirislaby@gmail.com> <480B6C16.40806@gmail.com> <Pine.LNX.4.64.0804211124060.19002@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.187]:62792 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762379AbYDUNg0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:36:26 -0400
Received: by rn-out-0910.google.com with SMTP id e11so311557rng.17
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:36:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0804211124060.19002@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Anssi Hannula <anssi.hannula@gmail.com>, Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, mit-devel@lists.printk.net, linux-kernel@vger.kernel.org

On Mon, Apr 21, 2008 at 11:25:43AM +0200, Jiri Kosina wrote:
> On Sun, 20 Apr 2008, Anssi Hannula wrote:
> 
> > Why not just do something like
> > 
> > #define HID_DEVICE(vend, dev) \
> > 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE | \
> > 		       USB_DEVICE_ID_MATCH_INT_CLASS, \
> > 	.idVendor = (vend), \
> > 	.idProduct = (prod), \
> > 	.bInterfaceClass = USB_INTERFACE_CLASS_HID
> > (see linux/usb.h)
> > 
> > and use USB hotplugging?
> > Or do we plan to match against something else as well, such as hid
> > reports or something?
> 
> No, we plan to do matching based solely on VID/PID. The report-specific 
> stuff is then handled between the specific driver and HID generic code.
> 

Hmm, [ab]using USB modalias makes me a bit uneasy. What about bluetooth
HID devices?

-- 
Dmitry
