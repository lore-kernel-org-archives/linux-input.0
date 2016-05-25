From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH v4] input: tablet: add Pegasus Notetaker tablet driver
Date: Wed, 25 May 2016 10:46:12 +0200
Message-ID: <1464165972.2132.5.camel@suse.com>
References: <1464162274-18424-1-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464162274-18424-1-git-send-email-martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Kepplinger <martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 2016-05-25 at 09:44 +0200, Martin Kepplinger wrote:
> This adds a driver for the Pegasus Notetaker Pen. When connected,
> this uses the Pen as an input tablet.
> 
> This device was sold in various different brandings, for example
> 	"Pegasus Mobile Notetaker M210",
> 	"Genie e-note The Notetaker",
> 	"Staedtler Digital ballpoint pen 990 01",
> 	"IRISnotes Express" or
> 	"NEWLink Digital Note Taker".
> 
> Here's an example, so that you know what we are talking about:
> http://www.staedtler.com/en/products/ink-writing-instruments/ballpoint-pens/digital-pen-990-01-digital-ballpoint-pen
> 
> http://pegatech.blogspot.com/ seems to be a remaining official resource.
> 
> This device can also transfer saved (offline recorded handwritten) data and
> there are userspace programs that do this, see https://launchpad.net/m210
> (Well, alternatively there are really fast scanners out there :)
> 
> It's *really* fun to use as an input tablet though! So let's support this
> for everybody.
> 
> There's no way to disable the device. When the pen is out of range, we just
> don't get any URBs and don't do anything.
> Like all other mouses or input tablets, we don't use runtime PM.
> 
> Signed-off-by: Martin Kepplinger <martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
> ---
> 
> Thanks for having a look. Any more suggestions on this?
> 
> revision history
> ================
> v4 use normal work queue instead of a kernel thread (thanks to Oliver Neukum)
> v3 fix reporting low pen battery and add USB list to CC
> v2 minor cleanup (remove unnecessary variables)
> v1 initial release
> 

Hi,

almost there.

	Regards
		Oliver

> +static void pegasus_close(struct input_dev *dev)
> +{
> +	struct pegasus *pegasus = input_get_drvdata(dev);
> +
> +	cancel_work_sync(&pegasus->init);
> +
> +	usb_kill_urb(pegasus->irq);
> +}

This is a race condition. The URB can trigger the work.
Therefore the URB needs to die first.
