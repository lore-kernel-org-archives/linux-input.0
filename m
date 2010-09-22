From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 1/2] input: add support for Nomadik SKE keypad
 controller
Date: Wed, 22 Sep 2010 08:29:38 -0700
Message-ID: <20100922152938.GA32097@core.coreip.homeip.net>
References: <1285156355-24555-1-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48362 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205Ab0IVP3o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Sep 2010 11:29:44 -0400
Received: by pvg2 with SMTP id 2so161663pvg.19
        for <linux-input@vger.kernel.org>; Wed, 22 Sep 2010 08:29:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285156355-24555-1-git-send-email-sundar.iyer@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: linux-input@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>

On Wed, Sep 22, 2010 at 05:22:35PM +0530, Sundar Iyer wrote:
> Add support for the keypad controller in the Scroll Key Encoder (SKE)
> module on the Nomadik family and the DB8500 SoC.
> 
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> >-----Original Message-----
> >From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> >Sent: Wednesday, September 22, 2010 2:02 PM
> 
> [..]
> 
> >below). If this does not work then I guess we'll have to rever to your original
> >approach with threaded IRQ (just drop the attached patch on top).
> 
> Dmitry,
> 
> I finally reverted back to your suggested patch for using the threaded irqs
> and its working again.
> 

Sundar,

Out of curiosity, did you try the patch that did not do polling? What
was the breakage?

I was also hoping you'd use it as a base for applying the threaded patch
- I did a few fixups and changed the probe routine a bit.

Thanks.

-- 
Dmitry
