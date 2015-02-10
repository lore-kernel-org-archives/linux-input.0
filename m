From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] HID: sony: Enable Gasia third-party PS3 controllers
Date: Tue, 10 Feb 2015 09:14:36 +0100
Message-ID: <1423556076.19839.3.camel@linux-0dmf.site>
References: <20150207154859.89a7e4e3.cand@gmx.com>
	 <1423476481.10695.2.camel@linux-0dmf.site>
	 <20150209204414.a4d205be.cand@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48238 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583AbbBJIO5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Feb 2015 03:14:57 -0500
In-Reply-To: <20150209204414.a4d205be.cand@gmx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lauri Kasanen <cand@gmx.com>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ao2@ao2.it, AndrewD207@aol.com

On Mon, 2015-02-09 at 20:44 +0200, Lauri Kasanen wrote:
> On Mon, 09 Feb 2015 11:08:01 +0100
> Oliver Neukum <oneukum@suse.de> wrote:
> 
> > > +	ret = usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x02),
> > > +				buf2, sizeof(buf2),
> > > +				&transfered, USB_CTRL_SET_TIMEOUT);
> > 
> > You cannot do this. Even for a single byte DMA on the stack is
> > wrong. Not on all architectures it works at all and you violate
> > the DMA constrainsts. You must use kmalloc().
> 
> Hi Oliver,
> 
> Does this still apply when using hid_hw_output_report?

Yes. For USB devices hid_hw_output_report() goes to
usbhid_output_report(). That goes to usb_interrupt_msg(),
which passes the buffer pointer. It will then be mapped
for DMA. You must not do that on the stack.

	HTH
		Oliver


