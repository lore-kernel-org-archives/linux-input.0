From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/5] mfd: qcom-rpm: Add support for pm8018
 RPM Regulator
Date: Tue, 28 Jun 2016 16:09:46 +0100
Message-ID: <20160628150946.GO24982@dell>
References: <1466759887-25394-1-git-send-email-narmstrong@baylibre.com>
 <1466759887-25394-5-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <rtc-linux+bncBDA7X7F2WUEBBB5GZK5QKGQEJSXTQUA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1466759887-25394-5-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 24 Jun 2016, Neil Armstrong wrote:

> In order to support the Qualcomm MDM9615 SoC, add support for the
> RPM regulator entries in the qcom-rpm driver.
>=20
> Acked-by: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom-rpm.txt |  1 +
>  drivers/mfd/qcom_rpm.c                             | 51 ++++++++++++++++=
++++++
>  include/dt-bindings/mfd/qcom-rpm.h                 | 22 ++++++++++
>  3 files changed, 74 insertions(+)

For my own reference:
  Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
 =20
> diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documen=
tation/devicetree/bindings/mfd/qcom-rpm.txt
> index b98b291..72d68d4 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> +++ b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> @@ -13,6 +13,7 @@ frequencies.
>  		    "qcom,rpm-msm8660"
>  		    "qcom,rpm-msm8960"
>  		    "qcom,rpm-ipq8064"
> +		    "qcom,rpm-mdm9615"
> =20
>  - reg:
>  	Usage: required
> diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
> index 880d469..c309ebe 100644
> --- a/drivers/mfd/qcom_rpm.c
> +++ b/drivers/mfd/qcom_rpm.c
> @@ -390,11 +390,62 @@ static const struct qcom_rpm_data ipq806x_template =
=3D {
>  	.ack_sel_size =3D 7,
>  };
> =20
> +static const struct qcom_rpm_resource mdm9615_rpm_resource_table[] =3D {
> +	[QCOM_RPM_CXO_CLK] =3D			{ 25, 9, 5, 1 },
> +	[QCOM_RPM_SYS_FABRIC_CLK] =3D		{ 26, 10, 9, 1 },
> +	[QCOM_RPM_DAYTONA_FABRIC_CLK] =3D		{ 27, 11, 11, 1 },
> +	[QCOM_RPM_SFPB_CLK] =3D			{ 28, 12, 12, 1 },
> +	[QCOM_RPM_CFPB_CLK] =3D			{ 29, 13, 13, 1 },
> +	[QCOM_RPM_EBI1_CLK] =3D			{ 30, 14, 16, 1 },
> +	[QCOM_RPM_APPS_FABRIC_HALT] =3D		{ 31, 15, 22, 2 },
> +	[QCOM_RPM_APPS_FABRIC_MODE] =3D		{ 33, 16, 23, 3 },
> +	[QCOM_RPM_APPS_FABRIC_IOCTL] =3D		{ 36, 17, 24, 1 },
> +	[QCOM_RPM_APPS_FABRIC_ARB] =3D		{ 37, 18, 25, 27 },
> +	[QCOM_RPM_PM8018_SMPS1] =3D		{ 64, 19, 30, 2 },
> +	[QCOM_RPM_PM8018_SMPS2] =3D		{ 66, 21, 31, 2 },
> +	[QCOM_RPM_PM8018_SMPS3] =3D		{ 68, 23, 32, 2 },
> +	[QCOM_RPM_PM8018_SMPS4] =3D		{ 70, 25, 33, 2 },
> +	[QCOM_RPM_PM8018_SMPS5] =3D		{ 72, 27, 34, 2 },
> +	[QCOM_RPM_PM8018_LDO1] =3D		{ 74, 29, 35, 2 },
> +	[QCOM_RPM_PM8018_LDO2] =3D		{ 76, 31, 36, 2 },
> +	[QCOM_RPM_PM8018_LDO3] =3D		{ 78, 33, 37, 2 },
> +	[QCOM_RPM_PM8018_LDO4] =3D		{ 80, 35, 38, 2 },
> +	[QCOM_RPM_PM8018_LDO5] =3D		{ 82, 37, 39, 2 },
> +	[QCOM_RPM_PM8018_LDO6] =3D		{ 84, 39, 40, 2 },
> +	[QCOM_RPM_PM8018_LDO7] =3D		{ 86, 41, 41, 2 },
> +	[QCOM_RPM_PM8018_LDO8] =3D		{ 88, 43, 42, 2 },
> +	[QCOM_RPM_PM8018_LDO9] =3D		{ 90, 45, 43, 2 },
> +	[QCOM_RPM_PM8018_LDO10] =3D		{ 92, 47, 44, 2 },
> +	[QCOM_RPM_PM8018_LDO11] =3D		{ 94, 49, 45, 2 },
> +	[QCOM_RPM_PM8018_LDO12] =3D		{ 96, 51, 46, 2 },
> +	[QCOM_RPM_PM8018_LDO13] =3D		{ 98, 53, 47, 2 },
> +	[QCOM_RPM_PM8018_LDO14] =3D		{ 100, 55, 48, 2 },
> +	[QCOM_RPM_PM8018_LVS1] =3D		{ 102, 57, 49, 1 },
> +	[QCOM_RPM_PM8018_NCP] =3D			{ 103, 58, 80, 2 },
> +	[QCOM_RPM_CXO_BUFFERS] =3D		{ 105, 60, 81, 1 },
> +	[QCOM_RPM_USB_OTG_SWITCH] =3D		{ 106, 61, 82, 1 },
> +	[QCOM_RPM_HDMI_SWITCH] =3D		{ 107, 62, 83, 1 },
> +	[QCOM_RPM_VOLTAGE_CORNER] =3D		{ 109, 64, 87, 1 },
> +};
> +
> +static const struct qcom_rpm_data mdm9615_template =3D {
> +	.version =3D 3,
> +	.resource_table =3D mdm9615_rpm_resource_table,
> +	.n_resources =3D ARRAY_SIZE(mdm9615_rpm_resource_table),
> +	.req_ctx_off =3D 3,
> +	.req_sel_off =3D 11,
> +	.ack_ctx_off =3D 15,
> +	.ack_sel_off =3D 23,
> +	.req_sel_size =3D 4,
> +	.ack_sel_size =3D 7,
> +};
> +
>  static const struct of_device_id qcom_rpm_of_match[] =3D {
>  	{ .compatible =3D "qcom,rpm-apq8064", .data =3D &apq8064_template },
>  	{ .compatible =3D "qcom,rpm-msm8660", .data =3D &msm8660_template },
>  	{ .compatible =3D "qcom,rpm-msm8960", .data =3D &msm8960_template },
>  	{ .compatible =3D "qcom,rpm-ipq8064", .data =3D &ipq806x_template },
> +	{ .compatible =3D "qcom,rpm-mdm9615", .data =3D &mdm9615_template },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, qcom_rpm_of_match);
> diff --git a/include/dt-bindings/mfd/qcom-rpm.h b/include/dt-bindings/mfd=
/qcom-rpm.h
> index 13a9d4b..54aef5e 100644
> --- a/include/dt-bindings/mfd/qcom-rpm.h
> +++ b/include/dt-bindings/mfd/qcom-rpm.h
> @@ -147,6 +147,28 @@
>  #define QCOM_RPM_SMB208_S1b			137
>  #define QCOM_RPM_SMB208_S2a			138
>  #define QCOM_RPM_SMB208_S2b			139
> +#define QCOM_RPM_PM8018_SMPS1			140
> +#define QCOM_RPM_PM8018_SMPS2			141
> +#define QCOM_RPM_PM8018_SMPS3			142
> +#define QCOM_RPM_PM8018_SMPS4			143
> +#define QCOM_RPM_PM8018_SMPS5			144
> +#define QCOM_RPM_PM8018_LDO1			145
> +#define QCOM_RPM_PM8018_LDO2			146
> +#define QCOM_RPM_PM8018_LDO3			147
> +#define QCOM_RPM_PM8018_LDO4			148
> +#define QCOM_RPM_PM8018_LDO5			149
> +#define QCOM_RPM_PM8018_LDO6			150
> +#define QCOM_RPM_PM8018_LDO7			151
> +#define QCOM_RPM_PM8018_LDO8			152
> +#define QCOM_RPM_PM8018_LDO9			153
> +#define QCOM_RPM_PM8018_LDO10			154
> +#define QCOM_RPM_PM8018_LDO11			155
> +#define QCOM_RPM_PM8018_LDO12			156
> +#define QCOM_RPM_PM8018_LDO13			157
> +#define QCOM_RPM_PM8018_LDO14			158
> +#define QCOM_RPM_PM8018_LVS1			159
> +#define QCOM_RPM_PM8018_NCP			160
> +#define QCOM_RPM_VOLTAGE_CORNER			161
> =20
>  /*
>   * Constants used to select force mode for regulators.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
