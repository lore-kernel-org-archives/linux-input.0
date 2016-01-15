From: Chris Diamand <chris@diamand.org>
Subject: Re: [PATCH] Input: byd - add BYD PS/2 touchpad driver
Date: Fri, 15 Jan 2016 08:11:10 +0000
Message-ID: <20160115081110.GA10700@smaug>
References: <1451272536-22065-1-git-send-email-chris@diamand.org>
 <20160103050230.GD23680@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32829 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755711AbcAOILN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 03:11:13 -0500
Received: by mail-wm0-f67.google.com with SMTP id u188so1576110wmu.0
        for <linux-input@vger.kernel.org>; Fri, 15 Jan 2016 00:11:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160103050230.GD23680@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

Thanks for the review! Apologies - I meant to send this extra info with v2 of
the patch, but my Mutt settings failed me.

> Could you please tell me what boxes use this touchpad?

The touchpad is found in the 2015 PC Specialist `Lafite' laptops:

    http://www.pcspecialist.co.uk/

There's an Ubuntu bug for the lack of driver here:

    https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1424293

And the manufacturer's datasheet is here:

    http://bydit.com/doce/products/microelectronics/2474.html

> Hmm, so the touchpad can't report absolute coordinates for us? That's
> unfortunate.

Yep, that's correct, even for the Windows driver.

I've updated the patch based on your feedback - I'll post it again shortly.

Cheers,
Chris
