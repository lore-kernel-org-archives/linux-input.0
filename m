Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CD5C4338F
	for <linux-input@archiver.kernel.org>; Sun, 25 Jul 2021 19:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4CCF60BD3
	for <linux-input@archiver.kernel.org>; Sun, 25 Jul 2021 19:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhGYTAd (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 25 Jul 2021 15:00:33 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:34464 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230116AbhGYTAc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 25 Jul 2021 15:00:32 -0400
Received: by mail.z3ntu.xyz (Postfix, from userid 182)
        id C0121C9334; Sun, 25 Jul 2021 19:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1627242060; bh=u1AvTW+JumWnj5z3TPOMBolUFzKDAp5hib1V0QDAuFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=n3TxW67ZK4hOgD5VK73Xxo3jHiFHZ886UQ/rXxXsCdpoMRRVWsTNsX+CPfki1VJ7b
         g3fw5+rpbK+0AxsJdtazVFY+EyCxqsr7spvFey8i7G0vT3xvKDF2YUmTRYvs1ZI/33
         ezFgPy5mQjufAhYxRZp1M0Bwi2vKI9LqZIuKLKpY=
Received: from g550jk.localnet (ip-213-127-63-121.ip.prioritytelecom.net [213.127.63.121])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 464D7C92A2;
        Sun, 25 Jul 2021 19:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1627242034; bh=u1AvTW+JumWnj5z3TPOMBolUFzKDAp5hib1V0QDAuFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ykkVYAzIvTEM7WbCRiI3nznm9SNWYcKVAwYQm2M++Oe0z8aIk39kWg6qdE5z1xtuO
         kNq0PC20ANLB+LOb1ycqAfvT4CV9AB0JplE7Qg9+k/CD7eu+fGPmFXxbqM5U3MKx5u
         KckAv6TLC7wgE6Wjmh2q8Y3YoiRzs4filBJ/kKi8=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/2] Input: pm8941-pwrkey - Respect reboot_mode for warm reset
Date:   Sun, 25 Jul 2021 21:34:12 +0200
Message-ID: <3904041.pqeu4ir2bD@g550jk>
In-Reply-To: <20210714095850.27185-3-shawn.guo@linaro.org>
References: <20210714095850.27185-1-shawn.guo@linaro.org> <20210714095850.27185-3-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Shawn,

On Mittwoch, 14. Juli 2021 11:58:49 CEST Shawn Guo wrote:
> On some devices, e.g. Sony Xperia M4 Aqua, warm reset is used to reboot
> device into bootloader and recovery mode.  Instead of always doing hard
> reset, add a check on reboot_mode for possible warm reset.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Tested-by: Luca Weiss <luca@z3ntu.xyz>

Rebooting into bootloader works on fairphone-fp2 with these commands now:

$ echo warm > /sys/kernel/reboot/mode
$ reboot-mode bootloader

reboot-mode is this small utility:
https://gitlab.com/postmarketOS/reboot-mode/-/blob/master/reboot-mode.c

Regards
Luca

> ---
>  drivers/input/misc/pm8941-pwrkey.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/pm8941-pwrkey.c
> b/drivers/input/misc/pm8941-pwrkey.c index cf8104454e74..9b14d6eb1918
> 100644
> --- a/drivers/input/misc/pm8941-pwrkey.c
> +++ b/drivers/input/misc/pm8941-pwrkey.c
> @@ -27,6 +27,7 @@
>  #define PON_PS_HOLD_RST_CTL2		0x5b
>  #define  PON_PS_HOLD_ENABLE		BIT(7)
>  #define  PON_PS_HOLD_TYPE_MASK		0x0f
> +#define  PON_PS_HOLD_TYPE_WARM_RESET	1
>  #define  PON_PS_HOLD_TYPE_SHUTDOWN	4
>  #define  PON_PS_HOLD_TYPE_HARD_RESET	7
> 
> @@ -93,7 +94,10 @@ static int pm8941_reboot_notify(struct notifier_block
> *nb, break;
>  	case SYS_RESTART:
>  	default:
> -		reset_type = PON_PS_HOLD_TYPE_HARD_RESET;
> +		if (reboot_mode == REBOOT_WARM)
> +			reset_type = PON_PS_HOLD_TYPE_WARM_RESET;
> +		else
> +			reset_type = PON_PS_HOLD_TYPE_HARD_RESET;
>  		break;
>  	}




