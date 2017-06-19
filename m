From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] input: goodix: Poll the 'buffer status' bit before
 reading data
Date: Tue, 20 Jun 2017 00:41:42 +0200
Message-ID: <1497912102.2559.7.camel@hadess.net>
References: <20170330133349.19931-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58010 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbdFSWlr (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2017 18:41:47 -0400
In-Reply-To: <20170330133349.19931-1-paul@crapouillou.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Hey,

Sorry I took this long to look into this.

On Thu, 2017-03-30 at 15:33 +0200, Paul Cercueil wrote:
> The Goodix panel triggers an interrupt on touch events. However, its
> registers will contain the valid values a short time after the
> interrupt, and not when it's raised. At that moment, the 'buffer
> status'
> bit is set.
> 
> Previously, if the 'buffer status' bit was not set when the registers
> were read, the data was discarded and no input event was emitted,
> causing "finger down" or "finger up" events to be missed sometimes.
> 
> This went unnoticed until v4.9, as the DesignWare I2C driver commonly
> used with this driver had enough latency for that bug to never
> trigger.
> 
> Now, in the IRQ handler we will poll (with a timeout)

I don't like the fact that the timeout isn't actually a timeout, but a
loop counter...

>  the 'buffer status'
> bit and process the data of the panel as soon as this bit gets set.

OK.

> Note that the Goodix panel will send a few spurious interrupts after
> the
> 'finger up' event, in which the 'buffer status' bit will never be
> set.

Can you please re-send the patch with diff option that makes it easier
to comment on whole patch? There's various block levels being mixed
because they have a linefeed in common...

I'm also CC:ing Hans to test it out as my Goodix tablet is still out of
commission.

Cheers
