From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] Input: pwm-beeper: support customized freq for SND_BELL
Date: Fri, 10 Feb 2017 09:48:33 -0600
Message-ID: <20170210154833.lefb7m4gnxnvvcxo@rob-hp-laptop>
References: <1486444894-18321-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33929 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752285AbdBJQ6F (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Feb 2017 11:58:05 -0500
Content-Disposition: inline
In-Reply-To: <1486444894-18321-1-git-send-email-hs@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko Schocher <hs@denx.de>
Cc: linux-input@vger.kernel.org, Guan Ben <ben.guan@cn.bosch.com>, Mark Jonas <mark.jonas@de.bosch.com>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Manfred Schlaegl <manfred.schlaegl@gmx.at>, Mark Rutland <mark.rutland@arm.com>

On Tue, Feb 07, 2017 at 06:21:34AM +0100, Heiko Schocher wrote:
> From: Guan Ben <ben.guan@cn.bosch.com>
> 
> extend the pwm-beeper driver to support customized frequency
> for SND_BELL from device tree.
> 
> Signed-off-by: Guan Ben <ben.guan@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> [hs@denx.de: adapted to 4.10-rc7]
> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
> ---
> 
>  .../devicetree/bindings/input/pwm-beeper.txt       |  3 ++
>  drivers/input/misc/pwm-beeper.c                    | 36 ++++++++++++++++------
>  2 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> index be332ae..438c6e0 100644
> --- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> @@ -5,3 +5,6 @@ Registers a PWM device as beeper.
>  Required properties:
>  - compatible: should be "pwm-beeper"
>  - pwms: phandle to the physical PWM device
> +
> +optional properties:
> +- bell-frequency:  bell frequency in Hz

Needs a unit suffix:
bell-frequency-hz or just bell-hz as hz implies frequency.

Or maybe beeper-hz would be more consistant.

Rob
