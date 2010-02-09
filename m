From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/misc: rotary-encoder: Set gpio direction
Date: Mon, 8 Feb 2010 16:18:23 -0800
Message-ID: <201002081618.23605.dmitry.torokhov@gmail.com>
References: <20100208210350.36f51cbf@digital-domain.net> <20100208221206.GP9007@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f172.google.com ([209.85.222.172]:57450 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab0BIAS3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 19:18:29 -0500
Received: by pzk2 with SMTP id 2so57522pzk.21
        for <linux-input@vger.kernel.org>; Mon, 08 Feb 2010 16:18:29 -0800 (PST)
In-Reply-To: <20100208221206.GP9007@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Andrew Clayton <andrew@digital-domain.net>, linux-input@vger.kernel.org, Mark Somerville <mark@scottishclimbs.com>

On Monday 08 February 2010 02:12:06 pm Daniel Mack wrote:
> On Mon, Feb 08, 2010 at 09:03:50PM +0000, Andrew Clayton wrote:
> > While trying to get a rotary encoder working under a beagle board using
> > the drivers/input/misc/rotary-encoder.c driver, we found that even with
> > the right pin mux settings configured through
> > /sys/kernel/debug/omap_mux/*, i.e INPUT_PULLUP and MODE4, the
> > gpio_get_value() functions only ever returned 1.
> >
> > By explicitly calling gpio_direction_input() after each requested gpio,
> > the driver started working and started returning correct input events.
> >
> > The following is the patch that works for us. What do you think?
> 
> Yep, that looks good to me, thanks!
> 
> Acked-by: Daniel Mack <daniel@caiaq.de>

.33 material or hold off till .34?

-- 
Dmitry
