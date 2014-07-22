From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: document INPUT_PROP_TOPBUTTONPAD
Date: Mon, 21 Jul 2014 17:58:14 -0700
Message-ID: <20140722005814.GA37237@core.coreip.homeip.net>
References: <20140722000018.GA10920@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:46661 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbaGVA6S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jul 2014 20:58:18 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so10738065pad.25
        for <linux-input@vger.kernel.org>; Mon, 21 Jul 2014 17:58:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140722000018.GA10920@jelly.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On Tue, Jul 22, 2014 at 10:00:18AM +1000, Peter Hutterer wrote:
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>

Applied, thank you.

> ---
>  Documentation/input/event-codes.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/input/event-codes.txt b/Documentation/input/event-codes.txt
> index f82ba9c..7ff7bf4 100644
> --- a/Documentation/input/event-codes.txt
> +++ b/Documentation/input/event-codes.txt
> @@ -281,6 +281,19 @@ gestures can normally be extracted from it.
>  If INPUT_PROP_SEMI_MT is not set, the device is assumed to be a true MT
>  device.
>  
> +INPUT_PROP_TOPBUTTONPAD:
> +-----------------------
> +Some laptops, most notably the Lenovo *40 series provide a trackstick
> +device but do not have physical buttons associated with the trackstick
> +device. Instead, the top area of the touchpad is marked to show
> +visual/haptic areas for left, middle, right buttons intended to be used
> +with the trackstick.
> +
> +If INPUT_PROP_TOPBUTTONPAD is set, userspace should emulate buttons
> +accordingly. This property does not affect kernel behavior.
> +The kernel does not provide button emulation for such devices but treats
> +them as any other INPUT_PROP_BUTTONPAD device.
> +
>  Guidelines:
>  ==========
>  The guidelines below ensure proper single-touch and multi-finger functionality.
> -- 
> 1.9.3
> 
