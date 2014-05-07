From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] input: rotary encoder: implement quarter period mode
Date: Wed, 7 May 2014 15:45:43 +0100
Message-ID: <20140507144543.GE27177@e106331-lin.cambridge.arm.com>
References: <1387377798-22344-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:43426 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751310AbaEGOqM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 7 May 2014 10:46:12 -0400
Content-Disposition: inline
In-Reply-To: <1387377798-22344-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <daniel@zonque.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi,

On Wed, Dec 18, 2013 at 02:43:18PM +0000, Sascha Hauer wrote:
> Some rotary encoders have a stable state in all output state
> combinations. Add support for this type of encoder.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: linux-input@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/input/rotary-encoder.txt   |  1 +
>  Documentation/input/rotary-encoder.txt             |  9 +++++--
>  drivers/input/misc/rotary_encoder.c                | 30 ++++++++++++++++++++--
>  include/linux/rotary_encoder.h                     |  1 +
>  4 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> index 3315495..cbdb29b 100644
> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> @@ -15,6 +15,7 @@ Optional properties:
>  - rotary-encoder,rollover: Automatic rollove when the rotary value becomes
>    greater than the specified steps or smaller than 0. For absolute axis only.
>  - rotary-encoder,half-period: Makes the driver work on half-period mode.
> +- rotary-encoder,quarter-period: Makes the driver work on quarter-period mode.

The new property looks as sane to me as the half-period property, so for
the binding addition:

Acked-by: Mark Rutland <mark.rutland@arm.com>

As a general nitpick it would be nicer if the binding didn't refer to
the driver and had a description of {half,quarter} period modes inline,
but that might be a bit tricky and shouldn't block this.

Cheers,
Mark.
