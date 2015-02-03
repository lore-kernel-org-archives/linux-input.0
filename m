From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/5] i8042: intel-8042 DT documentation
Date: Tue, 3 Feb 2015 11:38:16 +0000
Message-ID: <20150203113816.GA30866@leverpostej>
References: <1422913730-12663-1-git-send-email-v1ron@v1ros.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:40811 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933912AbbBCLiv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Feb 2015 06:38:51 -0500
Content-Disposition: inline
In-Reply-To: <1422913730-12663-1-git-send-email-v1ron@v1ros.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roman Volkov <v1ron@v1ros.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Roman Volkov <v1ron@mail.ru>, Tony Prisk <linux@prisktech.co.nz>

On Mon, Feb 02, 2015 at 09:48:46PM +0000, Roman Volkov wrote:
> Documentation for 'intel,8042' DT compatible node.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> Signed-off-by: Roman Volkov <v1ron@v1ros.org>
> ---
>  .../devicetree/bindings/input/intel-8042.txt       | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/intel-8042.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/intel-8042.txt b/Documentation/devicetree/bindings/input/intel-8042.txt
> new file mode 100644
> index 0000000..2aea7ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/intel-8042.txt
> @@ -0,0 +1,29 @@
> +* Intel 8042 Keyboard Controller
> +
> +Required properties:
> +- compatible: should be "intel,8042"
> +- regs: memory for keyboard controller
> +- interrupts: two interrupts should be specified (keyboard and aux)

Is it possible only one of these is wired up?

It might be worth using interrupt-names.

> +- command-reg: offset in memory for command register
> +- status-reg: offset in memory for status register
> +- data-reg: offset in memory for data register
> +
> +Optional properties:
> +- init-reset: Controller should be reset on init and cleanup

Why is this necessary? Can't we just always reset it?

> +
> +Optional Linux-specific properties:
> +- linux,kbd_phys_desc: defaults to i8042/serio0
> +- linux,aux_phys_desc: defaults to i8042/serio1
> +- linux,mux_phys_desc: defaults to i8042/serio%d

As a general note, s/_/-/ in property names please.

That said, I don't follow why we should have these at all. I don't
understand what the description is intended to mean.

In general we want to avoid Linux-specific properties. If a DTB needs to
know about the inernals of an OS it's likely to be fragile and broken
over time.

> +
> +
> +Example:
> +	keyboard@d8008800 {
> +		compatible = "intel,8042";
> +		reg = <0xd8008800 0x100>;
> +		interrupts = <23 4>;

If this is intended to be two interrupts, please bracket them
individually, e.g.

	interrupts = <23>, <4>;

> +		command-reg = <0x04>;
> +		status-reg = <0x04>;

Same address?

> +		data-reg = <0x00>;
> +		mux-ports = <2>;

This wasn't documented above.

Thanks,
Mark.

> +	};
> -- 
> 2.2.2
> 
> 
