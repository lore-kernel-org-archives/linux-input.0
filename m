From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/5] ARM: multi_v7_defconfig: add st-keyscan driver
Date: Mon, 10 Mar 2014 10:34:14 +0000
Message-ID: <20140310103414.GH14976@lee--X1>
References: <1393990772-9567-1-git-send-email-gabriel.fernandez@st.com>
 <1393990772-9567-6-git-send-email-gabriel.fernandez@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393990772-9567-6-git-send-email-gabriel.fernandez@st.com>
Sender: linux-doc-owner@vger.kernel.org
To: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, kernel@stlinux.com
List-Id: linux-input@vger.kernel.org

> This patch adds KEYBOARD_ST_KEYSCAN config
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

You should capitalise ST Keyscan in the $SUBJECT line, but other than t=
hat:
  Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/m=
ulti_v7_defconfig
> index ee69829..5e926981 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -131,6 +131,7 @@ CONFIG_INPUT_EVDEV=3Dy
>  CONFIG_KEYBOARD_GPIO=3Dy
>  CONFIG_KEYBOARD_TEGRA=3Dy
>  CONFIG_KEYBOARD_SPEAR=3Dy
> +CONFIG_KEYBOARD_ST_KEYSCAN=3Dy
>  CONFIG_KEYBOARD_CROS_EC=3Dy
>  CONFIG_MOUSE_PS2_ELANTECH=3Dy
>  CONFIG_INPUT_MISC=3Dy

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
