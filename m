From: Lauri Kasanen <cand@gmx.com>
Subject: Re: [PATCH] HID: sony: Enable Gasia third-party PS3 controllers
Date: Mon, 9 Feb 2015 20:44:14 +0200
Message-ID: <20150209204414.a4d205be.cand@gmx.com>
References: <20150207154859.89a7e4e3.cand@gmx.com>
	<1423476481.10695.2.camel@linux-0dmf.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423476481.10695.2.camel@linux-0dmf.site>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ao2@ao2.it, AndrewD207@aol.com
List-Id: linux-input@vger.kernel.org

On Mon, 09 Feb 2015 11:08:01 +0100
Oliver Neukum <oneukum@suse.de> wrote:

> > +	ret = usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x02),
> > +				buf2, sizeof(buf2),
> > +				&transfered, USB_CTRL_SET_TIMEOUT);
> 
> You cannot do this. Even for a single byte DMA on the stack is
> wrong. Not on all architectures it works at all and you violate
> the DMA constrainsts. You must use kmalloc().

Hi Oliver,

Does this still apply when using hid_hw_output_report?

- Lauri
