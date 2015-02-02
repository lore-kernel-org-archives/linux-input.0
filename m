From: Roman Volkov <v1ron@mail.ru>
Subject: Re: [PATCH 1/5] i8042: intel-8042 DT documentation
Date: Tue, 3 Feb 2015 01:10:51 +0300
Message-ID: <20150203011051.11999a16@v1ron-s7>
References: <1422913730-12663-1-git-send-email-v1ron@v1ros.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.181.128]:54078 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933531AbbBBWNn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Feb 2015 17:13:43 -0500
In-Reply-To: <1422913730-12663-1-git-send-email-v1ron@v1ros.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roman Volkov <v1ron@v1ros.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>

=D0=92 Tue,  3 Feb 2015 00:48:46 +0300
Roman Volkov <v1ron@v1ros.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> Documentation for 'intel,8042' DT compatible node.
>=20
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> Signed-off-by: Roman Volkov <v1ron@v1ros.org>
> ---
>  .../devicetree/bindings/input/intel-8042.txt       | 29
> ++++++++++++++++++++++ 1 file changed, 29 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/input/intel-8042.txt
>=20
> diff --git a/Documentation/devicetree/bindings/input/intel-8042.txt
> b/Documentation/devicetree/bindings/input/intel-8042.txt new file
> mode 100644 index 0000000..2aea7ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/intel-8042.txt
> @@ -0,0 +1,29 @@
> +* Intel 8042 Keyboard Controller
> +
> +Required properties:
> +- compatible: should be "intel,8042"
> +- regs: memory for keyboard controller
> +- interrupts: two interrupts should be specified (keyboard and aux)
> +- command-reg: offset in memory for command register
> +- status-reg: offset in memory for status register
> +- data-reg: offset in memory for data register
> +
> +Optional properties:
> +- init-reset: Controller should be reset on init and cleanup
> +
> +Optional Linux-specific properties:
> +- linux,kbd_phys_desc: defaults to i8042/serio0
> +- linux,aux_phys_desc: defaults to i8042/serio1
> +- linux,mux_phys_desc: defaults to i8042/serio%d
> +
> +
> +Example:
> +	keyboard@d8008800 {
> +		compatible =3D "intel,8042";
> +		reg =3D <0xd8008800 0x100>;
> +		interrupts =3D <23 4>;
> +		command-reg =3D <0x04>;
> +		status-reg =3D <0x04>;
> +		data-reg =3D <0x00>;
> +		mux-ports =3D <2>;
> +	};

Hi,

This patch set is to enable the Open Firmware Device Tree support for
the i8042 controller. Yes, some ARM SoC boards are still using i8042. A=
s
an example, it is the vt8500 architecture.

I've tested this on my wm8505 machine in both configurations: as a
module and built-in. Also a modification of this driver is available
at https://github.com/linux-wmt/linux-vtwm. This should not affect x86
and similar architectures without the DT enabled in the config.

Regards,
Roman.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
