From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] input,serio: support for GRLIB APBPS2 PS/2
 Keyboard/Mouse
Date: Thu, 21 Feb 2013 10:03:57 -0800
Message-ID: <20130221180357.GA18737@core.coreip.homeip.net>
References: <1361371293-14059-1-git-send-email-daniel@gaisler.com>
 <20130220184318.GD15152@core.coreip.homeip.net>
 <5125EDB5.3070909@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:35366 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783Ab3BUSD7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Feb 2013 13:03:59 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so3602913pbc.39
        for <linux-input@vger.kernel.org>; Thu, 21 Feb 2013 10:03:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5125EDB5.3070909@gaisler.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Hellstrom <daniel@gaisler.com>
Cc: linux-input@vger.kernel.org, software@gaisler.com

On Thu, Feb 21, 2013 at 10:49:41AM +0100, Daniel Hellstrom wrote:
> On 02/20/2013 07:43 PM, Dmitry Torokhov wrote:
> >Hi Daniel,
> >
> >On Wed, Feb 20, 2013 at 03:41:33PM +0100, Daniel Hellstrom wrote:
> >>+static void apbps2_close(struct serio *io)
> >>+{
> >>+	struct apbps2_priv *priv = io->port_data;
> >>+
> >>+	/* stop interrupts at PS/2 HW level */
> >>+	APBPS2_WRITE(&priv->regs->ctrl, 0);
> >>+
> >>+	/* unregister PS/2 interrupt handler */
> >>+	devm_free_irq(&io->dev, priv->irq, priv);
> >What is the benefit (except for wasting memory) of using
> >devm_request_irq()/devm_free_irq() in this fashion?
> None.
> 
> >
> >By the way, I would prefer if request IRQ was done in probe and freeing
> >in remove. I know that many existing serio drivers do it in open/close,
> >but this is not correct. We shoudl make sure all resources are available
> >beforehand.

> This has been done to avoid spending time in the APBPS2 ISR when the
> PS/2 interface is not used, and the interrupt is shared with another
> hardware.

Thankfully your device seems to be able shut off interrupts at the
controller level, so this should not be an issue.

-- 
Dmitry
