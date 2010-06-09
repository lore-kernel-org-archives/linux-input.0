From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [0000/0003]full power management for usb touchscreens
Date: Wed, 9 Jun 2010 15:40:04 +0200
Message-ID: <201006091540.06003.linux@rainbow-software.org>
References: <201006071513.29478.oneukum@suse.de> <20100607161920.GA7706@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1-out1.atlantis.sk ([80.94.52.55]:52455 "EHLO
	mail.atlantis.sk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753992Ab0FINkJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jun 2010 09:40:09 -0400
In-Reply-To: <20100607161920.GA7706@core.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Daniel Ritz <daniel.ritz@gmx.ch>, Oliver Neukum <oneukum@suse.de>

On Monday 07 June 2010, Dmitry Torokhov wrote:
> On Mon, Jun 07, 2010 at 03:13:29PM +0200, Oliver Neukum wrote:
> > Hi,
> >
> > this patch series implements:
> >
> > - full support for suspend/resume/reset_resume
> > - runtime power management
> >
> > It does so by adding normal methods for suspend/resume,
> > splitting device intialization into a part that needs to be repeated
> > after reset_resume() and a part that does not.
> > Runtime power management is possible while the device is
> > active if the device supports remote wakeup, otherwise a fallback
> > to a method based on open/close is implemented.
> >
> > I lack the hardware. Therefore I need testers.
>
> Ondrej,
>
> You are the latest person I know who users usbtouchscreen driver, any
> chance you could lend a hand to Oliver here, please?

Looking at the patches from archive:

If I understand it correctly, usbtouch_resume submits the irq URB only if
the input device is open. That will fail with Nexio as it has an internal
watchdog which needs URBs or the device will reconnect - see irq_always
(Zytronic seems to need it too).


>From patch 3/3:
> @@ -1449,14 +1483,23 @@ static int usbtouch_probe(struct usb_interface
> *intf, usbtouch->irq->transfer_dma = usbtouch->data_dma;
>         usbtouch->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
>
> -       /* device specific init */
> +       /* device specific allocations */
>         if (type->init) {

Looks like a copy&paste bug, should be "if (type->alloc) {".

> -               err = type->init(usbtouch);
> +               err = type->alloc(usbtouch);
>                 if (err) {
> -                       dbg("%s - type->init() failed, err: %d", __func__,
> err); +                       dbg("%s - type->alloc() failed, err: %d",
> __func__, err); goto out_free_urb;
>                 }
>         }
> +
> +       /* device specific init*/
> +       if (type->init) {
> +               err = type->alloc(usbtouch);
> +               if (err) {
> +                       dbg("%s - type->init() failed, err: %d", __func__,
> err); +                       goto out_do_exit;
> +               }
> +       }
>
>         err = input_register_device(usbtouch->input);
>         if (err) {


-- 
Ondrej Zary
