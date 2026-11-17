Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920661;
	b=1Wm7Ic66+MSJwfDX0ogrWPU0h8YTBma3arJwOJ4Yb4o3DNW5Tyx1E5ZswBzFlRaOuN6u
	 nn9MfBQjiLMcDmdubYO1qQmgnVM+jCZRR3a14ncUxI6YcXC2WkKq0WLUOHE3Xg1oc1MIN
	 3oNnt6gjpfci9E5mgV7ofolEXYGlW2ym4ijE7m9cBhBVlbGlN6CpIl0jyo4gsUqq8Ftn4
	 05Wu7MIApxTn+JtEIsbSy4soT2wS+GCKQyC+T0eo1JK/s8NKCALSmZw5i6paLnFf/pxCD
	 fHbJC3u047DGvBhQ6pl8QfPNufBFGfrH0Lq8z4/q3y4IcrcjGY2jkucjh+wwGwzXS7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920661;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nI2cgsAmA/JuxQGnB2pVceabASOqqzEJlK87ic5E+LQ=;
	b=Rq+1xJyLqvBkPpkV7rLm6f8hS/B8CMeN+rAt9vShNpVEB8iQZw8ffzSCac+2GfJ125No
	 H+KfZ2W30ym0Hl/yeRSmAsYLZ8jkzUvGyPXg5NdDyrsdUfAVCqlb+LFS02vtX0iUDfYRq
	 Be2kXs0pR133EDT4iaoXi2BaVHE19m7wKN742Ej9ysl8Isi8qFNccjSG1Mm0SJO+N48Hu
	 CaqViMX62CBRIMqSQfLiPbTfYu9wgTbj8Dvw55LgVoDj/quce/XWi5Zkn4dMm+LR3SVXW
	 dea621FMBXv376C/ehKm/zgIciB3VqYbkTcJiyKyUCLXHuwNyxtsN7xu69YLQgM6dCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bE5J5D0S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255DD606A331;
	Tue, 17 Nov 2026 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bE5J5D0S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B07B1F000C4;
	Tue, 17 Nov 2026 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920660;
	bh=nI2cgsAmA/JuxQGnB2pVceabASOqqzEJlK87ic5E+LQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bE5J5D0SENvHxZUjar42icMfJylTWccN+96DT2vYPDxWEG9NlR8qjClXJFACvmnGi
	 fgjGACxXJVBqsx/AxBYf/LwcE8xZTGbrX7NrUnL5aJ7n3b27Gnop9sQ7ehOkjWmrbb
	 ZzxnQPoleqkW0MddXPVrfBkwFCYhkEKk7HUk59iNK4zmbe042+MaarV/Ja6t3hwzV3
	 1YbG8nzBrG0hVwuCBM7ImUiMYz1pE2HD1SUK2UGLPh2NeCISjiV6HNUzKWSQJ9v8DS
	 C0OUB9RvT6TxBbT8CoMi2kHPi4/+MdowfkTVOz7AyeEBvkdDAPQIFZlWNMxy+xt5SC
	 0TnCoG6aHhSDg==
Message-ID: <sashiko-outbox-218833@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/11] drm/panel: add LG SW43103 panel driver
Reply-To: sashiko-reviews@lists.linux.dev
To: rofikkerneldev <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117123946.668557-6-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
 <20261117123946.668557-6-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:04:19 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/panel: username handle used instead of real name in DCO and
  authorship
- [Medium] drm/panel: sw43103_remove() calls sw43103_unprepare()
  unconditionally
- [Medium] drm/panel: sw43103: unsynchronized DSI transfers in
  sw43103_backlight_update_status()
- [Low] drm/panel: sw43103_enable() hardcodes full brightness before
  backlight_enable()
--

commit c8fd387b550027d7b2fde8a05702145f363e56ba
Author: rofikkerneldev <rofikcoga@gmail.com>

> drm/panel: add LG SW43103 panel driver
>
> Add support for the 1080x2460 SW43103 AMOLED panel. Handle power and
> reset sequencing, DCS backlight control, and the DSC configuration
> required by the panel.
>
> Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>

[Severity: High]
Under Documentation/process/submitting-patches.rst and the Developer
Certificate of Origin, patches must use a real human name rather than a
username handle (rofikkerneldev) in the commit author, Signed-off-by tag,
maintainer entry, and module author macro.

> diff --git a/drivers/gpu/drm/panel/panel-lg-sw43103.c b/drivers/gpu/drm/p=
anel/panel-lg-sw43103.c
> new file mode 100644
> index 0000000000000..caab54e0d1153
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-lg-sw43103.c
[ ... ]
> +static int sw43103_enable(struct drm_panel *panel)
> +{
> +	struct sw43103_panel *sw43103 =3D to_panel_info(panel);
> +	struct mipi_dsi_multi_context ctx =3D { .dsi =3D sw43103->link };
> +
> +	/* Display On */
> +	mipi_dsi_dcs_set_display_on_multi(&ctx);
> +	mipi_dsi_msleep(&ctx, 20);
> +
> +	/* Enable display backlight control and full brightness */
> +	mipi_dsi_dcs_write_seq_multi(&ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x2c=
);
> +	mipi_dsi_dcs_write_seq_multi(&ctx, MIPI_DCS_SET_DISPLAY_BRIGHTNESS, 0x0=
7, 0xff);
> +
> +	return ctx.accum_err;
> +}

[Severity: Low]
Should sw43103_enable() leave brightness programming to the backlight
device?

drm_panel_enable() calls backlight_enable(panel->backlight) right after
panel->funcs->enable(panel), which invokes sw43103_backlight_update_status()
to write the control display register and the configured brightness
(defaulting to 1024).  Hardcoding 0x07ff (2047) here duplicates those
transfers and briefly flashes the panel at maximum brightness whenever the
display is enabled at a lower brightness level.

[ ... ]

> +static int sw43103_backlight_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi =3D bl_get_data(bl);
> +	u16 brightness =3D backlight_get_brightness(bl);
> +	u8 ctrl =3D 0x2c;
> +	int ret;
> +
> +	dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +
> +	ret =3D mipi_dsi_dcs_write(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, &ctrl, =
sizeof(ctrl));
> +	if (ret < 0)
> +		goto out;
> +
> +	ret =3D mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
> +
> +out:
> +	dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +
> +	return ret < 0 ? ret : 0;
> +}

[Severity: Medium]
Can a sysfs brightness write race with panel preparation or issue transfers
while the panel is powered off?

sw43103_backlight_init() registers the backlight device during probe, and
backlight_device_set_brightness() calls sw43103_backlight_update_status()
under only bd->ops_lock and bd->update_lock.  If userspace writes to sysfs
while the panel is unprepared, mipi_dsi_dcs_write() runs while the panel is
in reset or powered down.  If it writes during sw43103_prepare(), it also
races on dsi->mode_flags:

CPU0                              CPU1
sw43103_prepare()
  sw43103_program()
    sw43103_init_sequence()
                                  backlight_device_set_brightness()
                                    sw43103_backlight_update_status()
                                      dsi->mode_flags &=3D ~...
    mipi_dsi_dcs_write_seq_multi()
      /* sent in high-speed mode instead of low-power mode */

Conversely, restoring the low-power mode flag at the end of
sw43103_backlight_update_status() while sw43103_program() is sending the
picture parameter set forces mipi_dsi_picture_parameter_set_multi() into
low-power mode.

[ ... ]

> +static void sw43103_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct sw43103_panel *ctx =3D mipi_dsi_get_drvdata(dsi);
> +	int ret;
> +
> +	ret =3D sw43103_unprepare(&ctx->base);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "failed to unprepare panel: %d\n", ret);
> +
> +	ret =3D mipi_dsi_detach(dsi);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
> +
> +	drm_panel_remove(&ctx->base);
> +}

[Severity: Medium]
Does calling sw43103_unprepare() directly in sw43103_remove() underflow the
regulator enable counts?

sw43103_unprepare() unconditionally calls regulator_bulk_disable() without
checking or updating ctx->base.prepared.  If the panel is not prepared when
the driver is unbound, regulator_bulk_disable() triggers an unbalanced
regulator disable warning and returns -EIO; if the panel is prepared,
powering it off before mipi_dsi_detach() and drm_panel_remove() leaves
ctx->base.prepared set, causing modeset teardown to access an unpowered
panel and disable the supplies a second time.  Removing the manual
sw43103_unprepare() call lets the modeset driver tear the panel down
cleanly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117123946.6685=
57-1-rofikcoga@gmail.com?part=3D5
