Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573798;
	b=oxGeJ93QOXFeJn8oJUDFznn8OQ8dk0tQYUimXClOXnXKisYNp9PDnqiCe6GtDuE1XO9T
	 iHtmnfePyjfkX1MfEI4rjU3afgcuOdEdg5J/ivNW8rIHuLemrTbZB6pkDON2Cxel+WapR
	 0fL6ZShdRZr+y0e9xaitXC1ZoBV4thEoj5+oH00TrRUDmeotstkgO0SbU1OKdc2AwdCG+
	 yGvvgwWDBaDCARqaL7PBz/YjQAIBXJox5UVRJm6fuQRuUtj27G6tmUQgkbWOE/L2GIwQz
	 SwUqXYqKicMb+1t4OBnkCWG0jtVw1w65+zdXsAk/WDNerpvbIgPWsnfBnTdBOo5Me3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573798;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tx7LN3obOMR3uffTtadIWMs7fWe+tevA3KnqPR/IHw0=;
	b=ZKVwyCeLG85oKFFpmAD1+lnt2I44rDnAwL+/T1CQ0XwEipZtYf3LEdB3LIGU2XHrlB0F
	 inRkYroboQkAEizCR7wqMXOVLmjm4x62IHSIl+jdTErkrnthnwpTNgXG4QNHcouUX2CfV
	 kvWKaYzUnF2Hu3o4+c81qEmgaLxZJNFoxr+bYAjr3jdx8JTyQsXM5SRRdA2sCIwbHGUY1
	 woYemSyVp5Q2BqzTjKjApOudNbBVaxtOuRir9lqmqnHSqVtAxIdsE1JxdESh05OgIMweO
	 BUbhJzobGn5nYP3lUYbtPuMSREm2dY8rPEBTNCoyCo+DphYiXEQbU9cET5rU01OrfOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBLeVr7s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1739606A321;
	Wed, 25 Nov 2026 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBLeVr7s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083CA1F000CF;
	Wed, 25 Nov 2026 02:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795573798;
	bh=tx7LN3obOMR3uffTtadIWMs7fWe+tevA3KnqPR/IHw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eBLeVr7sNtTvV0C6sT9VYRZRMRicuuV/NHus7BS2/DbKAuKw/r8olnmUc/USxG5nC
	 xAMkUJUaDaFkb/byVnqj0hRzmz4xAzpf50YoIdko5pSLcMfSJBesXmRyNor6BnCSIJ
	 s+Y3T0oXlV1rSi7Eneiujrb4plRrKLAkfCNIBzXlUzTaOe7uQ0Pi5FT5iCB49j4NrI
	 aWIP3mv+R+q85GjwIGjFd9lRvaCIuyaOANMPD5QjyGK9yklpcw9PPeWsvL24lUnOhD
	 C3XUT8odeRjuN+Wmw3KPvAJ4rbzyLJ3Rg83J8sXtQHVHeDlgJtDasPevXiDhwhLTzq
	 J5ekwnAAaPOOA==
Message-ID: <sashiko-outbox-232411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] drm/panel: add VIEWE JD9365TX 7 inch DSI panel
Reply-To: sashiko-reviews@lists.linux.dev
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_66628D1B7EAC58017C1F10DA3CFDFC1EA30A@qq.com>
References: <20261125020944.137-1-3066883572@qq.com>
 <tencent_66628D1B7EAC58017C1F10DA3CFDFC1EA30A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:29:57 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] drm/panel: jd9365tx_probe() calls static drm_panel_init() with
  devm_kzalloc()
- [High] drm/panel: jd9365tx_probe() calls removed
  of_drm_get_panel_orientation()
- [Low] drm/panel: jd9365tx_get_modes() misuses
  drm_connector_set_panel_orientation()
- [Low] drm/panel: jd9365tx_send_cmds() duplicates
  mipi_dsi_dcs_write_seq_multi()
- [Low] drm/panel: undocumented jadard,jd9365tx-7kf82 compatible and
  unsorted Kconfig
--

commit 3ecc9eb3ae7d4c1cce585568afbec867631fedbb
Author: Hefei <3066883572@qq.com>

drm/panel: add VIEWE JD9365TX 7 inch DSI panel

This commit adds a DRM panel driver for the VIEWE 7" 720x1280 Jadard
JD9365TX (7KF82) 2-lane MIPI-DSI panel.

> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 26ffa2378f55c..9a3038bf60987 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -427,6 +427,17 @@ config DRM_PANEL_INNOLUX_P079ZCA
>  	  24 bit RGB per pixel. It provides a MIPI DSI interface to
>  	  the host and has a built-in LED backlight.
> =20
> +config DRM_PANEL_VIEWE_JD9365TX
> +	tristate "VIEWE 7\" JD9365TX DSI panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y here to enable the VIEWE 7" 720x1280 Jadard JD9365TX
> +	  MIPI-DSI panel.
> +
> +	  If unsure, say N.
> +
>  config DRM_PANEL_JADARD_JD9365DA_H3
>  	tristate "Jadard JD9365DA-H3 WXGA DSI panel"
>  	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makef=
ile
> index 365f2e73f6b45..84ed0891a40d1 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) +=3D panel-ilit=
ek-ili9881c.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9882T) +=3D panel-ilitek-ili9882t.o
>  obj-$(CONFIG_DRM_PANEL_INNOLUX_EJ030NA) +=3D panel-innolux-ej030na.o
>  obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) +=3D panel-innolux-p079zca.o
> +obj-$(CONFIG_DRM_PANEL_VIEWE_JD9365TX) +=3D panel-viewe-jd9365tx.o
>  obj-$(CONFIG_DRM_PANEL_JADARD_JD9365DA_H3) +=3D panel-jadard-jd9365da-h3=
.o
>  obj-$(CONFIG_DRM_PANEL_JDI_LT070ME05000) +=3D panel-jdi-lt070me05000.o
>  obj-$(CONFIG_DRM_PANEL_JDI_LPM102A188A) +=3D panel-jdi-lpm102a188a.o
> diff --git a/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c b/drivers/gpu/d=
rm/panel/panel-viewe-jd9365tx.c
> new file mode 100644
> index 0000000000000..b511dd6bfed96
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c
> @@ -0,0 +1,353 @@

[ ... ]

> +struct jd9365tx_cmd {
> +	u8 len;
> +	u8 data[64];
> +	u16 delay_ms;
> +};
> +
> +#define JD_CMD(...) {					\
> +	.len =3D sizeof((u8[]){ __VA_ARGS__ }),		\
> +	.data =3D { __VA_ARGS__ },			\
> +	.delay_ms =3D 0,					\
> +}
> +
> +#define JD_CMD_DELAY(ms, ...) {				\
> +	.len =3D sizeof((u8[]){ __VA_ARGS__ }),		\
> +	.data =3D { __VA_ARGS__ },			\
> +	.delay_ms =3D (ms),				\
> +}

[ ... ]

> +static int jd9365tx_send_cmds(struct mipi_dsi_device *dsi,
> +			      const struct jd9365tx_cmd *cmds,
> +			      unsigned int count)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	for (i =3D 0; i < count; i++) {
> +		const struct jd9365tx_cmd *cmd =3D &cmds[i];
> +
> +		if (cmd->len) {
> +			ret =3D mipi_dsi_dcs_write_buffer(dsi, cmd->data, cmd->len);
> +			if (ret < 0) {
> +				dev_err(&dsi->dev,
> +					"DCS write 0x%02x failed: %d\n",
> +					cmd->data[0], ret);
> +				return ret;
> +			}
> +		}
> +		if (cmd->delay_ms)
> +			msleep(cmd->delay_ms);
> +	}
> +	return 0;
> +}

[Severity: Low]
Can the init sequence use mipi_dsi_dcs_write_seq_multi() and
mipi_dsi_msleep() instead of a custom struct jd9365tx_cmd table and
jd9365tx_send_cmds() loop?  jd9365tx_prepare() already sets up a struct
mipi_dsi_multi_context, and using the standard _multi() helpers avoids
duplicating mipi_dsi_dcs_write_buffer_multi() and allocating a fixed
64-byte buffer per command entry.

[ ... ]

> +static int jd9365tx_get_modes(struct drm_panel *panel,
> +			      struct drm_connector *connector)
> +{
> +	struct jd9365tx_panel *ctx =3D to_jd9365tx(panel);
> +	struct drm_display_mode *mode;
> +
> +	mode =3D drm_mode_duplicate(connector->dev, &jd9365tx_7kf82_mode);
> +	if (!mode)
> +		return -ENOMEM;
> +
> +	drm_mode_set_name(mode);
> +	mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	drm_mode_probed_add(connector, mode);
> +
> +	connector->display_info.width_mm =3D mode->width_mm;
> +	connector->display_info.height_mm =3D mode->height_mm;
> +	drm_connector_set_panel_orientation(connector, ctx->orientation);
> +	return 1;
> +}
> +
> +static enum drm_panel_orientation
> +jd9365tx_get_orientation(struct drm_panel *panel)
> +{
> +	struct jd9365tx_panel *ctx =3D to_jd9365tx(panel);
> +
> +	return ctx->orientation;
> +}
> +
> +static const struct drm_panel_funcs jd9365tx_funcs =3D {
> +	.prepare =3D jd9365tx_prepare,
> +	.disable =3D jd9365tx_disable,
> +	.unprepare =3D jd9365tx_unprepare,
> +	.get_modes =3D jd9365tx_get_modes,
> +	.get_orientation =3D jd9365tx_get_orientation,
> +};

[Severity: Low]
Should jd9365tx_get_modes() delegate to
drm_connector_helper_get_modes_fixed(connector, &jd9365tx_7kf82_mode) and
drop the drm_connector_set_panel_orientation() call?

jd9365tx_funcs already provides .get_orientation, so panel-bridge helpers
configure the panel orientation property before drm_dev_register().  Calling
drm_connector_set_panel_orientation() inside .get_modes runs after
drm_dev_register(), which can trigger a WARN_ON in
drm_object_attach_property() if orientation has not already been attached.

> +
> +static int jd9365tx_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev =3D &dsi->dev;
> +	struct jd9365tx_panel *ctx;
> +	int ret;
> +
> +	ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;

[ ... ]

> +	ret =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
> +	if (ret)
> +		return ret;

[Severity: High]
Does calling of_drm_get_panel_orientation() break the build?

Commit b5a8b1f2a973 ("drm/panel: Use drm_of_get_panel_orientation()")
removed of_drm_get_panel_orientation() in favor of
drm_of_get_panel_orientation() from <drm/drm_of.h>, which is also not
included here.

> +
> +	drm_panel_init(&ctx->panel, dev, &jd9365tx_funcs, DRM_MODE_CONNECTOR_DS=
I);

[Severity: High]
Does calling drm_panel_init() after devm_kzalloc() break the build and leave
ctx->panel.bridge uninitialized?

Commit fe417df954a9 ("drm/panel: Make drm_panel_init() static") made
drm_panel_init() private to drivers/gpu/drm/drm_panel.c.  Panel drivers
must allocate and initialize their container struct with
devm_drm_panel_alloc(), which also initializes the embedded struct
drm_bridge required by drm_panel_add().

[ ... ]

> +static const struct of_device_id jd9365tx_of_match[] =3D {
> +	{ .compatible =3D "viewe,7kf82" },
> +	{ .compatible =3D "jadard,jd9365tx-7kf82" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, jd9365tx_of_match);

[Severity: Low]
Is "jadard,jd9365tx-7kf82" documented in the DT binding schema?
Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml in
commit "dt-bindings: display: add VIEWE JD9365TX panel binding" only lists
"viewe,7kf82".

Also, DRM_PANEL_VIEWE_JD9365TX and panel-viewe-jd9365tx.o are inserted
between INNOLUX and JADARD in drivers/gpu/drm/panel/Kconfig and
drivers/gpu/drm/panel/Makefile rather than in alphabetical order, and the
commit message has an empty body.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_EE81D0ED29E=
97716D56BDCF1A3C5AAE35B05@qq.com?part=3D4
