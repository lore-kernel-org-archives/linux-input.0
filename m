From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: Add LED support to Synaptics device
Date: Thu, 15 Apr 2010 22:29:44 -0700
Message-ID: <20100416052944.GB1078@core.coreip.homeip.net>
References: <1271257823-23566-1-git-send-email-tiwai@suse.de>
 <1271257823-23566-3-git-send-email-tiwai@suse.de>
 <20100415191217.GA1495@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50946 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab0DPF3u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Apr 2010 01:29:50 -0400
Content-Disposition: inline
In-Reply-To: <20100415191217.GA1495@ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Apr 15, 2010 at 09:12:18PM +0200, Pavel Machek wrote:
> Hi!
> 
> > The new Synaptics devices have an LED on the top-left corner.
> > This is controlled via the command 0x0a with parameters 0x88 or 0x10.
> > 
> > The detection of the LED isn't clear yet.  It should have been the new
> > capability bits that indicate the presence, but on real machines, it
> > doesn't fit.  So, for the time being, the driver checks the product id
> > in the ext capability bits and assumes that LED exists on the known
> > devices.
> > 
> > The support of LED is controlled via a normal input event with EV_LED
> > bit mask.  It supports LED_MUTE bit.  X driver can detect the LED
> > support by checking these bits.
> 
> Could we use generic LED API for this? It is not really 'mute' led
> after all...

Yep, LED_MUTE is not for "muting" touchpads.

-- 
Dmitry
