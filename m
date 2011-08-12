From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2] input: add EETI eGalax I2C capacitive multi touch
 driver.
Date: Fri, 12 Aug 2011 22:30:03 +0200
Message-ID: <20110812203003.GA8995@polaris.bitmath.org>
References: <20110801063409.GB32118@core.coreip.homeip.net>
 <1312370963-24965-1-git-send-email-jiejing.zhang@freescale.com>
 <20110811203449.GA6162@polaris.bitmath.org>
 <CACrgxGCodzp+2TqOCHQPRFTN4oT+DuqsZ8qKCahQ5bcXS+9dkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:42679 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab1HLU3B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Aug 2011 16:29:01 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id 519EBC69B
	for <linux-input@vger.kernel.org>; Fri, 12 Aug 2011 22:28:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CACrgxGCodzp+2TqOCHQPRFTN4oT+DuqsZ8qKCahQ5bcXS+9dkA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Jiejing.Zhang " <kzjeef@gmail.com>
Cc: Zhang Jiejing <jiejing.zhang@freescale.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, dima@android.com

> > The device seems to send finger changes sequentually, resulting in one
> > packet (terminated with input sync) for each finger change. Is this
> > the intention/necessary? Some egalax firmware (hid version) seems to
> > work this way.
> 
> When I make v2 patch, I've a look the Protocol B's driver in upstream,
> but there were two type of multi-point report fashion,
> One type is report all the finger status in one input sync(), and
> separate each mt point with mt_input_slot(), like wocom driver.
> 
> But there was some driver (like egalax hid version), send each mt
> point with one input_sync(), but I'm worry about if main stream user
> space frameworks(xorg mtouch etc,) support this behavior well.

Sequential reporting works reasonably well, although there are
potential problems (applying methods for smooth motion, for
instance). Wakeups and cpu intensity also increases.

> What's your point of view about this ?

If possible, I think batched reporting is preferred, i.e., using the
same method as all hid drivers _but_ the egalax one.

> > The usage of REPORT_MODE_* is unclear to me too.
> 
> In the programming manual this mode 's name is "single touch mouse
> mode", may be it will be a better name for this mode ?

Ok, sounds like the equivalent of the hid generic mouse, which could
either be ignored or assigned its own input device node. Nothing out
of the ordinary, in other words, and the patch looks good in this
respect. Thanks for clarifying.

Henrik
