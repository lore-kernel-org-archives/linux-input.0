From: Chris Diamand <chris@diamand.org>
Subject: Re: [PATCH] psmouse: added BYD touchpad driver
Date: Wed, 3 Feb 2016 20:28:03 +0000
Message-ID: <20160203202803.GA18677@smaug>
References: <CAHc7Qt33N4LZNm1kjeFKKtqCHt8o8e-ZGu7BBuc0oGJZeB_JyA@mail.gmail.com>
 <20160203004153.GA15147@smaug>
 <CAHc7Qt3cMu4+qXvruXtY7-GxL=skaUda1c4bfA5DDdNMfOfKGg@mail.gmail.com>
 <20160203085816.GA3307@smaug>
 <56B23203.3080509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35067 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308AbcBCU2H (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Feb 2016 15:28:07 -0500
Received: by mail-wm0-f43.google.com with SMTP id r129so182664924wmr.0
        for <linux-input@vger.kernel.org>; Wed, 03 Feb 2016 12:28:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56B23203.3080509@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Pospesel <pospeselr@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> The Windows driver provides a visualization of the regions for the hardware
> edge scrolling capability. When entering that screen, a particular command
> pair is sent, and the touchpad starts sending interleaved REL and ABS
> packets.  When leaving that screen, another particular command pair is sent,
> and the touchpad resumes the normal REL only stream.

Good find! That's very crafty.

I've managed to apply your patch, and can confirm that it works - my initial
impressions (using it for 15 mins...) are that even 256x256 resolution absolute
mode + synaptics is much better than the touchpad's built-in gesture detection.

Let's work your patch into something which applies on top of the existing
driver, and get it merged.

Cheers!
Chris
