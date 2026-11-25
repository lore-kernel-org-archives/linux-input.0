Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795576038;
	b=KpYoBcR4M5kD7iCFrX0jWn2e896iHRery5aSD7muV51kstAdTRt/8cICQ9JedIZsUBKH
	 YrPHnzAxzwi+JHPNQ3I1crNtEHUJ1kSJ2b+TmABOiLp+63tDrRbtD+yxGnVT5CqISbO0C
	 D8WwToXpFpyGPqU8xHKw6awc8XhINJdDFZA57+yyy5qm3dELeIQszvDwcVzOMRYXa5iEz
	 lUYM0O1SfbTu5ta85x+pR0YSSqNTj2yTiv8iy99rEeUyI8nlXsf7yk+nO//ZhESS8111u
	 GlFjupGC8KfUkV9qlON/OcX3ZWetHPBKQPG8dx++oWpUJJf9TEs4BfWjFAvnmwGga2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795576038;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3dIGFjM+Dqj9Ck3ijqsVlQquI5LsysNcLBZ6l2ixSOs=;
	b=mT2ht+1NjGqcCcJOnQIzz+JvKHlMoLoyG/ZleW2nEgcUmTrg3PrFPQO8ovEAFwAswhVi
	 dVQFcyyvdlqFcsnz06iKqsXfIyU5aSZuOs3zB+KP5mdcBGt6HCRfRfHOB3P4MeowAo1+H
	 bjfcy97/U6Eg0tTCWDuFFIAYDO4RD1qkV6DNYEjsDkoXpYBsxwtymKDA7pAjVun/7tAUh
	 NPcnxuj1uqC8fvw36GaeISKyXQwkOQscII48b5YtY3BC5wlmRvYT25c8zHfdD6rLhQ0Cy
	 5l4KgRxWckj3gVPLcWxKP0Nw/1Jr2oaj2twPthRrgqqQknRuuI3bje4B/R1Xdp7yJjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H27LTma7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F654606A32D;
	Wed, 25 Nov 2026 03:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H27LTma7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF9D1F000D1;
	Wed, 25 Nov 2026 03:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795576038;
	bh=3dIGFjM+Dqj9Ck3ijqsVlQquI5LsysNcLBZ6l2ixSOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H27LTma7b4nHUVEyDuOvzU8sXLgI/e/DiWKfJEoGhO4FF8Gv47XfJ8bV+PFEGKzi3
	 4cWEGSAGLZiKqenduVg7HkaROKIhH7qlzzt1hLTWqkFShvOjtuCa5ruw4KO92Rsqx8
	 wrdMxYn2dTfdT5+6E12XMVzeTIKq1H4j9+kkEYKRBcNMKGE8InrIg+KcxtaXgrVKiw
	 SFv4zI/CDXi0p5BTMWlYo0NkiT7fCmPDGfQGGZiqIP8+GEn5WF/iIk4fNu+Ecw6GMR
	 2PyXdPV6Vpt5EeK0PRZHsKEc89JMgFoJpPq30EkHUpRpzylmcl+yyN+uIPdixmqfzo
	 xjVmikCnJi0Jw==
Message-ID: <sashiko-outbox-232447@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] drm/panel: add VIEWE JD9365TX 7 inch DSI panel
Reply-To: sashiko-reviews@lists.linux.dev
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_C2127E2B5045C6293E54AC20BE5908B79F09@qq.com>
References: <20261125025638.1171-1-3066883572@qq.com>
 <tencent_C2127E2B5045C6293E54AC20BE5908B79F09@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 03:07:17 +0000
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
- [High] drm/panel: build failure in jd9365tx_probe() from removed
  orientation API
- [Low] drm/panel: jd9365tx_send_cmds() duplicates
  mipi_dsi_dcs_write_seq_multi()
--

commit 42ee7a955bd94a5de5a014d27ef8d93f0daadee3
Author: Hefei <3066883572@qq.com>

drm/panel: add VIEWE JD9365TX 7 inch DSI panel

This commit adds a DRM panel driver for the VIEWE 7KF82 720x1280 Jadard
JD9365TX 2-lane MIPI-DSI module.

> diff --git a/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c b/drivers/gpu/d=
rm/panel/panel-viewe-jd9365tx.c
> new file mode 100644
> index 0000000000000..7455dff834c4d
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c
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
This isn't a bug, but could jd9365tx_prepare() use
mipi_dsi_dcs_write_seq_multi() and mipi_dsi_msleep() directly on dsi_ctx
instead of defining struct jd9365tx_cmd, JD_CMD*(), and
jd9365tx_send_cmds()?  That would avoid duplicating the DCS sequence
helper and padding every command entry to 64 bytes.

[ ... ]

> +static int jd9365tx_probe(struct mipi_dsi_device *dsi)
> +{
[ ... ]
> +	ret =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get orientation\n");

[Severity: High]
Does this fail to build when CONFIG_DRM_PANEL_VIEWE_JD9365TX is enabled?
Commit b5a8b1f2a973 ("drm/panel: Use drm_of_get_panel_orientation()")
removed of_drm_get_panel_orientation() in favor of
drm_of_get_panel_orientation() in <drm/drm_of.h>.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_381F4A5669D=
F8884104F17BF29A893E3A408@qq.com?part=3D4
