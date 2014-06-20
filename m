From: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 10/10] mfd: cros_ec: move EC interrupt to cros_ec_keyb
Date: Thu, 19 Jun 2014 21:45:07 -0600
Message-ID: <CAPnjgZ1=J+4GC6r1piVcmEbHJUJnM-N0jZmnhOQS5fNTGUySaA@mail.gmail.com>
References: <1403115247-8853-1-git-send-email-dianders@chromium.org>
	<1403115247-8853-11-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:40150 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932859AbaFTDpI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jun 2014 23:45:08 -0400
Received: by mail-qc0-f170.google.com with SMTP id l6so3104761qcy.1
        for <linux-input@vger.kernel.org>; Thu, 19 Jun 2014 20:45:07 -0700 (PDT)
In-Reply-To: <1403115247-8853-11-git-send-email-dianders@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>, Andrew Bresticker <abrestic@chromium.org>, Stephen Warren <swarren@wwwdotorg.org>, Olof Johansson <olof@lixom.net>, Sonny Rao <sonnyrao@chromium.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Bill Richardson <wfrichar@chromium.org>, Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lk <linux-kernel@vger.kernel.org>

On 18 June 2014 12:14, Doug Anderson <dianders@chromium.org> wrote:
> From: Andrew Bresticker <abrestic@chromium.org>
>
> If we receive EC interrupts after the cros_ec driver has probed, but
> before the cros_ec_keyb driver has probed, the cros_ec IRQ handler
> will not run the cros_ec_keyb notifier and the EC will leave the IRQ
> line asserted.  The cros_ec IRQ handler then returns IRQ_HANDLED and
> the resulting flood of interrupts causes the machine to hang.
>
> Since the EC interrupt is currently only used for the keyboard, move
> the setup and handling of the EC interrupt to the cros_ec_keyb driver.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Reviewed-by: Simon Glass <sjg@chromium.org>

We never needed an EC-level interrupt, and have shipped at least three
products now that use this code, so I think it is safe enough to
declare that we won't need it.

Regards,
Simon
