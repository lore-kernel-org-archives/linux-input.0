From: Sylvain Rochet <sylvain.rochet@finsecur.com>
Subject: Re: [PATCH v3 1/2] DT: Documentation: input: rotary encoder: Add
 wakeup-source property
Date: Tue, 16 Jun 2015 19:28:32 +0200
Message-ID: <20150616172832.GA15598@gradator.net>
References: <1423755638-9294-1-git-send-email-sylvain.rochet@finsecur.com>
 <1423755638-9294-2-git-send-email-sylvain.rochet@finsecur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-guillaumet.finsecur.com ([91.217.234.131]:42561 "EHLO
	guillaumet.finsecur.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbbFPSKl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2015 14:10:41 -0400
Content-Disposition: inline
In-Reply-To: <1423755638-9294-2-git-send-email-sylvain.rochet@finsecur.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Johan Hovold <jhovold@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hello,

On Thu, Feb 12, 2015 at 04:40:37PM +0100, Sylvain Rochet wrote:
> This patch adds property wakeup-source to GPIO rotary encoders.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> ---
>  Documentation/devicetree/bindings/input/rotary-encoder.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> index 3315495..2c643a3 100644
> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> @@ -15,6 +15,7 @@ Optional properties:
>  - rotary-encoder,rollover: Automatic rollove when the rotary value becomes
>    greater than the specified steps or smaller than 0. For absolute axis only.
>  - rotary-encoder,half-period: Makes the driver work on half-period mode.
> +- wakeup-source: Boolean, rotary encoder can wake-up the system.
>  
>  See Documentation/input/rotary-encoder.txt for more information.

Hello DT guys, it's been a while, may I ping you about this property ?

We wonder if this should be "rotary-encoder,wakeup", "linux,wakeup" or 
"wakeup-source".

Thank you :)

Sylvain
