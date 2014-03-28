From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 00/10] mfd: AXP20x: Add support for AXP202 and AXP209
Date: Fri, 28 Mar 2014 08:01:37 +0000
Message-ID: <20140328080137.GE17779@lee--X1>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:62982 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbaC1IBm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Mar 2014 04:01:42 -0400
Received: by mail-wi0-f175.google.com with SMTP id cc10so450151wib.2
        for <linux-input@vger.kernel.org>; Fri, 28 Mar 2014 01:01:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1395955764-18103-1-git-send-email-carlo@caione.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com, maxime.ripard@free-electrons.com, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org

> AXP209 and AXP202 are the PMUs (Power Management Unit) used by A10, A=
13
> and A20 SoCs and developed by X-Powers, a sister company of Allwinner=
=2E
> AXP20x comprises an adaptive USB-Compatible PWM charger, 2 BUCK DC-DC
> converters, 5 LDOs, multiple 12-bit ADCs of voltage, current and temp=
erature
> as well as 4 configurable GPIOs.=20

[...]

> Carlo Caione (10):
>   mfd: AXP20x: Add mfd driver for AXP20x PMIC
>   dt-bindings: add vendor-prefix for X-Powers
>   mfd: AXP20x: Add bindings documentation
>   input: misc: Add driver for AXP20x Power Enable Key
>   input: misc: Add ABI docs for AXP20x PEK
>   regulator: AXP20x: Add support for regulators subsystem
>   ARM: sunxi: dt: Add x-powers-axp209.dtsi file
>   ARM: sun7i/sun4i: dt: Add AXP209 support to various boards
>   ARM: sunxi: Add AXP20x support in defconfig
>   ARM: sunxi: Add AXP20x support multi_v7_defconfig

I'm only CC'ed on two of these patches. In order to gain a full
appreciation what what the set is trying to achieve, can you CC me on
the entire set please?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
