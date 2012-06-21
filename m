From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: gpio_keys: added setup call for extending
 functionality of driver
Date: Thu, 21 Jun 2012 01:50:45 -0700
Message-ID: <20120621085045.GD2193@core.coreip.homeip.net>
References: <1340208597-31865-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36617 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758907Ab2FUIuu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jun 2012 04:50:50 -0400
Received: by dady13 with SMTP id y13so579984dad.19
        for <linux-input@vger.kernel.org>; Thu, 21 Jun 2012 01:50:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340208597-31865-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>

Hi Alexander,

On Wed, Jun 20, 2012 at 08:09:57PM +0400, Alexander Shiyan wrote:
> This additional call can be used for extending functionality of
> driver. For example we can add EV_SND, EV_LED, etc. handlers.
> 

I am not sure that gpio_keys is quite ready to handle events besides
EV_KEY and EV_SW, additional changes are needed; and if you make those
additional changes then I think current platform data should be
sufficient to specify all supported even types.

Also, given the general push towards DT-ased setups platform-supplied
board setup code might not be the best approach.

Thanks.

-- 
Dmitry
