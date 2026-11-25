Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575228;
	b=GrvhavoBD04GC5nz656EYX2LbE+0dxu97aaWuEmTmSXYnX2/iz+uqcsrj2S4vqsJysIu
	 hQas0qllgB77TEnMJ0csKucVagmabRNxB727rmF1Lse3vnOxfq268OZqItZQVp9VH0e94
	 KyfducdfeXBYPDbcQpmxk3ZYXlhFvuSaz8wUdnvGto1b6GD9vR8DCDG4DQSBaBl58SpHk
	 /4Bg3yo5Iw+furOlG2GuXI9zjMVFbSJqFDc/Ha3Ch9AsJfkYLsuDTY5M4t5ecbziXDdgT
	 SlfAeRjfcZQJ6O31AM1j/issyUzlINje0Au5hNqutW+l9tGR9YtwLKNyLITC6ekJk9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575228;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uA+u8gLrQBscfkz97StZsV/2v00EcO4O845ZNF383AY=;
	b=Qdo/4+PXHCx5/EL+VEUTTBBcAjVXrzps3y3rqCRBL7uQvGcTkKeJt5dOxv/vZU939BOG
	 E8hZyncQ+Jb9FZViORLa3ut57+Eb7YAbenMPNkeI9TfsFf7SUWItKBBEBoLROhE1Ari/r
	 SfHGwNFKjHYsdfOJBQtxqPy8twrxH/4QQ4mxh+9uLwP9YCO95KB2Wj2nXpSd39/H8oiTm
	 RIuxhzhkh3JZwD8YUlACDzUeG/6OjtuoX6gaif562paJ1stpv1K567JXwzKS9BZWbM4vI
	 XTLJCAv12Cq+L4G0J+UtplobZ3Ma+SYq6e5B4Z1KY3x9LUukUGWrqx8IFUvSzkwtmqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3Bpl4KX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7F4606A31E;
	Wed, 25 Nov 2026 02:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3Bpl4KX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8D31F000C0;
	Wed, 25 Nov 2026 02:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795575227;
	bh=uA+u8gLrQBscfkz97StZsV/2v00EcO4O845ZNF383AY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J3Bpl4KXMxsq2cNqCclyLpelSFiokb+5C5dLxVKcbsHh90l2wsWszD34AR3x1jf33
	 aXCMvQPqYnP4zpJhmtyu6RMOM5GDy2cZSG3IsU6pq1kUdQXGIdqgcm5d8bDNzI8bUy
	 52q2Xy+CsB1AM+/9IPCbQawsvyZOXPT9znKrxuMOsB+PB7CUlGcs6jYDkYCB2T/nSf
	 LHFV0WPgJDwCV3Jjq4EeCdO6hzWUlQ47c0DWSi2IJms+WM9ghRmHDsyCpKsoJdn8uv
	 Gg3/BHZYTn9N0grQ+h1e84KKzY9ALLO5KHEDFIHe11QbnfAGs5VxKolc+hzBnHPvr7
	 tBkEvsVtSosfg==
Message-ID: <sashiko-outbox-232426@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] drm/panel: add VIEWE JD9365TX 7 inch DSI panel
Reply-To: sashiko-reviews@lists.linux.dev
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_C80F7DF059E17C7313CE3E35FF62A1A28D0A@qq.com>
References: <20261125024226.1293-1-3066883572@qq.com>
 <tencent_C80F7DF059E17C7313CE3E35FF62A1A28D0A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:53:46 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/panel: jd9365tx_probe() calls removed
  of_drm_get_panel_orientation()
- [Low] drm/panel: jd9365tx_send_cmds() duplicates
  mipi_dsi_dcs_write_seq_multi()
--

commit ca140a7fa3afff2f94a32e601392829d717fcccf
Author: Hefei <3066883572@qq.com>

drm/panel: add VIEWE JD9365TX 7 inch DSI panel

This commit adds a DRM panel driver for the VIEWE 7KF82 720x1280 Jadard
JD9365TX 2-lane MIPI-DSI panel module.

> diff --git a/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c b/drivers/gpu/d=
rm/panel/panel-viewe-jd9365tx.c
> new file mode 100644
> index 0000000000000..7455dff834c4d
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c
> @@ -0,0 +1,340 @@

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
mipi_dsi_msleep() with the dsi_ctx that jd9365tx_prepare() already sets
up?  That avoids calling the deprecated mipi_dsi_dcs_write_buffer()
helper, removes the custom jd9365tx_send_cmds() loop, and drops the fixed
64-byte data[] padding per entry in struct jd9365tx_cmd.

[ ... ]

> +static int jd9365tx_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev =3D &dsi->dev;
> +	struct jd9365tx_panel *ctx;
> +	int ret;

[ ... ]

> +	ret =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get orientation\n");

[Severity: High]
Does this fail to build when CONFIG_DRM_PANEL_VIEWE_JD9365TX is enabled?
Commit b5a8b1f2a973 ("drm/panel: Use drm_of_get_panel_orientation()")
removed of_drm_get_panel_orientation() in favor of
drm_of_get_panel_orientation() declared in <drm/drm_of.h>, which also
needs to be included here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_7B5CDF8F847=
44FFBBFCFA89FE3651F675608@qq.com?part=3D4
