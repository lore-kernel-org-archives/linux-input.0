From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] input: Add LED support to Synaptics device
Date: Thu, 15 Apr 2010 21:12:18 +0200
Message-ID: <20100415191217.GA1495@ucw.cz>
References: <1271257823-23566-1-git-send-email-tiwai@suse.de> <1271257823-23566-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:42284 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752254Ab0DPFWu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Apr 2010 01:22:50 -0400
Content-Disposition: inline
In-Reply-To: <1271257823-23566-3-git-send-email-tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> The new Synaptics devices have an LED on the top-left corner.
> This is controlled via the command 0x0a with parameters 0x88 or 0x10.
> 
> The detection of the LED isn't clear yet.  It should have been the new
> capability bits that indicate the presence, but on real machines, it
> doesn't fit.  So, for the time being, the driver checks the product id
> in the ext capability bits and assumes that LED exists on the known
> devices.
> 
> The support of LED is controlled via a normal input event with EV_LED
> bit mask.  It supports LED_MUTE bit.  X driver can detect the LED
> support by checking these bits.

Could we use generic LED API for this? It is not really 'mute' led
after all...
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
