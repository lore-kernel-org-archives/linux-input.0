From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v1 10/12] input: keypad_matrix: use usleep_range() for
 scan delay
Date: Fri, 21 Jun 2013 16:00:19 -0600
Message-ID: <51C4CCF3.20603@wwwdotorg.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de> <1371838198-7327-11-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:41200 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946161Ab3FUWAX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jun 2013 18:00:23 -0400
In-Reply-To: <1371838198-7327-11-git-send-email-gsi@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gerhard Sittig <gsi@denx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
> querying keyboards isn't a time critical task and does not depend on
> exact timing in the microseconds order -- the timeouts and delays are
> arbitrary choices or educated guesses at best anyway

> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt

> @@ -93,7 +93,10 @@ Optional Properties:
>  			a column line and reading back its row status,
>  			such that pin levels can settle after
>  			propagating through the matrix and its
> -			associated hardware components
> +			associated hardware components, can be specified
> +			with either one value giving the exact delay, or
> +			with two values giving a delay range (allowing
> +			for reduced timer management overhead)
>  - col-switch-delay-ms:	columns switch interval in milliseconds instead
>  			of using interrupts to detect key press changes,
>  			enables polling mode when specified
> @@ -146,7 +149,7 @@ Examples:
>  	matrix_keypad {
>  		compatible = "gpio-matrix-keypad";
>  		debounce-delay-ms = <5>;
> -		col-scan-delay-us = <1>;
> +		col-scan-delay-us = <2 10>;

Is it really useful to change the binding this way?

The values in DT presumably represent the minimum delays that the HW
will tolerate or that are useful. SW is always free to scan more slowly
than that. As such, if you're simply modifying the driver to allow more
flexibility in timing, then I don't think you have to modify the DT
binding to allow for this?
