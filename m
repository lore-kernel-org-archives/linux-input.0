From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 2/2] input: clps711x-keypad: dts: Add bindings
 documentation
Date: Fri, 28 Mar 2014 09:43:24 -0700
Message-ID: <20140328164324.GC7582@core.coreip.homeip.net>
References: <1395165888-17434-1-git-send-email-shc_work@mail.ru>
 <1395165888-17434-2-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:62715 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbaC1Qn2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Mar 2014 12:43:28 -0400
Content-Disposition: inline
In-Reply-To: <1395165888-17434-2-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>

On Tue, Mar 18, 2014 at 10:04:48PM +0400, Alexander Shiyan wrote:
> This patch adds the devicetree documentation for the Cirrus Logic
> CLPS711X keypad.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

I picked this one up and folded into the driver patch.

> ---
>  .../devicetree/bindings/input/clps711x-keypad.txt  | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/clps711x-keypad.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/clps711x-keypad.txt b/Documentation/devicetree/bindings/input/clps711x-keypad.txt
> new file mode 100644
> index 0000000..93fa2c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/clps711x-keypad.txt
> @@ -0,0 +1,27 @@
> +* Cirrus Logic CLPS711X matrix keypad device tree bindings
> +
> +Required Properties:
> +- compatible:    Shall contain "cirrus,clps711x-keypad".
> +- row-gpios:     List of GPIOs used as row lines.
> +- poll-interval: Poll interval time in milliseconds.
> +- linux,keymap:  The definition can be found at
> +                 bindings/input/matrix-keymap.txt.
> +
> +Optional Properties:
> +- autorepeat:    Enable autorepeat feature.
> +
> +Example:
> +	keypad {
> +		compatible = "cirrus,ep7312-keypad", "cirrus,clps711x-keypad";
> +		autorepeat;
> +		poll-interval = <120>;
> +		row-gpios = <&porta 0 0>,
> +			    <&porta 1 0>;
> +
> +		linux,keymap = <
> +			MATRIX_KEY(0, 0, KEY_UP)
> +			MATRIX_KEY(0, 1, KEY_DOWN)
> +			MATRIX_KEY(1, 0, KEY_LEFT)
> +			MATRIX_KEY(1, 1, KEY_RIGHT)
> +		>;
> +	};
> -- 
> 1.8.3.2
> 

-- 
Dmitry
