Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D879B4FDE67;
	Fri, 25 Sep 2026 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790375281; cv=none; b=Gr1nB15eXCGvGN08vnMT4Q10tZMtlPkTfgf5okuESt32/yzKcjrmCaWe/KefcrgLimtmMAHMv+9R+W0xnACj0otgsvXbuT2cpNWxc0IxKv5b/c+sDcrX6HxCc4na54va95/a4vajoITD7ROQRztg+ddZU9Vlkbhy6uPqFeevlts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790375281; c=relaxed/simple;
	bh=F3JyrnU1T/7MY1F59ID3BIeap1ZmUL/wyu5htRqpiQ0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=h4psPyf2nCExd67tgXPYPmh4YOEKI2ZKvjl7c31ftRSFf4Tg+x+wiRWRox9Q9B69zZ+V4jVkhR988t7SUTmxoCadjOXz8hkjiklB6LfRdFjRgYI/1vJtN9PSJTTxU8M6Otm1YkJnb3tLHwl8obprtSZT+6NQrVvJsen1oGcvUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=JVAyHatN; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=pR6lN4bC; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="JVAyHatN";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="pR6lN4bC"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790375262; bh=A+iKWh5sj5YoOcrwdCL0h8j
	CSUwRstI5vEoHvPHIJoI=; b=JVAyHatNWNvnhAg0tCBcDElFuGPkRnfUol+s4hJLPX6tYGI3ed
	bwr2Md+LCni/ho6GyJEzErsWgGaW+i02dH2b+dBMDqRCI9/HjXdtEI2tZQIqD2d1WwCjrP25KUk
	612HcmgaMnWNOeLNaav8CwtMJsR+XT5i/U8DM1WdqFERDrMa6GsgL/h7vjZGv0Jt4tf4L7u/2hP
	/unEl8L3b2Lj2aoUa1FtE4W4UhRGPqSl9p5HK5fF7dCFGF3gs9uyGtBKZEvJvZVX/sWoo4quqKc
	r6i7pfb43QS9S0SfFFkWQ8nu/zY6PHCEbfAfuGBx5Zlk11axbcfC8jrNLAm/hgS+Vcg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790375262; bh=A+iKWh5sj5YoOcrwdCL0h8j
	CSUwRstI5vEoHvPHIJoI=; b=pR6lN4bCmjgTzxfTIKniik2AjkDBGP0oObQcwcSbYh2PEdDTtB
	U35u9OCJJr1lrCan0f/Llqwo95kPH+DgUpCg==;
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Sep 2026 00:27:42 +0200
From: =?UTF-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=
 <barnabas.czeman@mainlining.org>
To: =?UTF-8?Q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI?= <kavakliyigitcan@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, Abhinav
 Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC 04/10] drm/panel: novatek-nt36672a: add Tianma FHD+
 video mode panel
In-Reply-To: <20260911-ginkgo-submission-final-v1-4-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-4-0e68e63a18d4@gmail.com>
Message-ID: <8396770e7f5c85d4e8ac111b83bf8ad0@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2026-09-11 10:51, YİĞİTCAN KAVAKLI wrote:
> Add support for the 1080x2340 Tianma video mode panel with Novatek
> NT36672A driver IC found in the Xiaomi Redmi Note 8 (ginkgo / SM6125).
> 
> Changes:
> - Add 1080x2340 display mode timings (183.025 MHz pixel clock)
> - Add verified DCS initialization sequences for pages 0x25, 0x20, 0x24,
>   0x26, and user command page 0x10
> - Add standard DRM panel .enable and .disable callbacks to coordinate
>   display on/off commands with active DSI video stream
> - Set prepare_prev_first = true for host controller synchronization
> - Optimize power-on reset sequence to nominal 10ms timings
> 
> Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 141 
> ++++++++++++++++++++-----
>  1 file changed, 117 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c 
> b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> index 
> 464d9ce47d87dc857c3a565a63156ac79ddeb30c..b69213790441f204016895a391b58f676762b1aa 
> 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> @@ -34,7 +34,7 @@ static const char * const nt36672a_regulator_names[] 
> = {
>  	"vddneg",
>  };
> 
> -static unsigned long const nt36672a_regulator_enable_loads[] = {
> +static const unsigned long nt36672a_regulator_enable_loads[] = {
>  	62000,
>  	100000,
>  	100000
> @@ -92,18 +92,12 @@ static int nt36672a_panel_unprepare(struct 
> drm_panel *panel)
>  	if (pinfo->desc->send_deinit_cmds)
>  		pinfo->desc->send_deinit_cmds(&dsi_ctx);
> 
> -	/* Reset error to continue with display off even if send_cmds failed 
> */
> +	/* Reset error to continue power-down even if send_cmds failed */
>  	dsi_ctx.accum_err = 0;
> -	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> -	/* Reset error to continue power-down even if display off failed */
> -	dsi_ctx.accum_err = 0;
> -
> -	/* 120ms delay required here as per DCS spec */
> -	msleep(120);
> 
>  	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> 
> -	/* 0x3C = 60ms delay */
> +	/* 60ms delay as per DCS spec */
>  	msleep(60);
> 
>  	nt36672a_panel_power_off(panel);
> @@ -120,15 +114,14 @@ static int nt36672a_panel_power_on(struct 
> nt36672a_panel *pinfo)
>  		return ret;
> 
>  	/*
> -	 * As per downstream kernel, Reset sequence of Tianma FHD panel 
> requires the panel to
> -	 * be out of reset for 10ms, followed by being held in reset for 
> 10ms. But for Android
> -	 * AOSP, we needed to bump it upto 200ms otherwise we get white 
> screen sometimes.
> -	 * FIXME: Try to reduce this 200ms to a lesser value.
> +	 * Reset sequence: 10ms out of reset, 10ms held in reset, 10ms out of 
> reset.
>  	 */
> -	gpiod_set_value(pinfo->reset_gpio, 1);
> -	msleep(200);
> -	gpiod_set_value(pinfo->reset_gpio, 0);
> -	msleep(200);
> +	gpiod_set_value_cansleep(pinfo->reset_gpio, 0);
> +	usleep_range(10000, 11000);
> +	gpiod_set_value_cansleep(pinfo->reset_gpio, 1);
> +	usleep_range(10000, 11000);
> +	gpiod_set_value_cansleep(pinfo->reset_gpio, 0);
> +	usleep_range(10000, 11000);
> 
>  	return 0;
>  }
> @@ -146,19 +139,41 @@ static int nt36672a_panel_prepare(struct 
> drm_panel *panel)
> 
>  	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> 
> -	/* 0x46 = 70 ms delay */
> -	mipi_dsi_msleep(&dsi_ctx, 70);
> -
> -	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	/* 80 ms delay as per DCS spec / downstream timing */
> +	msleep(80);
> 
>  	/* Send rest of the init cmds */
>  	if (pinfo->desc->send_init_cmds_2)
>  		pinfo->desc->send_init_cmds_2(&dsi_ctx);
> 
> -	mipi_dsi_msleep(&dsi_ctx, 120);
> -
>  	if (dsi_ctx.accum_err < 0)
> -		gpiod_set_value(pinfo->reset_gpio, 0);
> +		gpiod_set_value_cansleep(pinfo->reset_gpio, 0);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int nt36672a_panel_enable(struct drm_panel *panel)
> +{
> +	struct nt36672a_panel *pinfo = to_nt36672a_panel(panel);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = pinfo->link };
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +
> +	/* Frame settling delay */
> +	msleep(20);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int nt36672a_panel_disable(struct drm_panel *panel)
> +{
> +	struct nt36672a_panel *pinfo = to_nt36672a_panel(panel);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = pinfo->link };
> +
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +
> +	/* 120ms delay as per DCS spec */
> +	msleep(120);
> 
>  	return dsi_ctx.accum_err;
>  }
> @@ -189,6 +204,8 @@ static int nt36672a_panel_get_modes(struct 
> drm_panel *panel,
>  static const struct drm_panel_funcs panel_funcs = {
>  	.unprepare = nt36672a_panel_unprepare,
>  	.prepare = nt36672a_panel_prepare,
> +	.enable = nt36672a_panel_enable,
> +	.disable = nt36672a_panel_disable,
As far as I know adding .enable and .disable callbacks for on/off 
commands is a workaround for -110 time outs
and not a proper fix, as a workaround .disable is enough.
Here is an another attempt with the same workaround and it was declined:
https://lore.kernel.org/all/20240509-jdi-use-disable-v1-1-5c175b2ea1ee@gmail.com/
We have this commit for this issue at downstream 
https://github.com/msm8953-mainline/linux/commit/c1adb576d7b49833d0d48c5ffae18372c9db668e
but in my understanding it also should not considered a proper fix.
>  	.get_modes = nt36672a_panel_get_modes,
>  };
> 
> @@ -404,6 +421,79 @@ static const struct nt36672a_panel_desc 
> tianma_fhd_video_panel_desc = {
>  	.send_deinit_cmds = tianma_fhd_video_send_deinit_cmds,
>  };
> 
> +static void tianma_ginkgo_send_init_cmds(struct mipi_dsi_multi_context 
> *dsi_ctx)
> +{
> +	/* Page 0x25 init */
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x25);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x18, 0x96);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x05, 0x04);
> +
> +	/* Page 0x20 init */
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x20);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x78, 0x01);
> +
> +	/* Page 0x24 init */
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x24);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x82, 0x13);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x84, 0x31);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x88, 0x13);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x8a, 0x31);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x8e, 0xe4);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x8f, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x90, 0x80);
> +
> +	/* Page 0x26 init */
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x26);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xa9, 0x12);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xaa, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xae, 0x8a);
> +
> +	/* Page 0x10 (User command page) */
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x10);
> +}
> +
> +static void tianma_ginkgo_send_post_on_cmds(struct 
> mipi_dsi_multi_context *dsi_ctx)
> +{
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x35, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x68, 0x04, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x51, 0xb8);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x2c);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x55, 0x00);
> +}
> +
> +static const struct drm_display_mode tianma_ginkgo_fhd_video_mode = {
> +	.clock		= 183025,
> +
> +	.hdisplay	= 1080,
> +	.hsync_start	= 1080 + 90,
> +	.hsync_end	= 1080 + 90 + 2,
> +	.htotal		= 1080 + 90 + 2 + 120,
> +
> +	.vdisplay	= 2340,
> +	.vsync_start	= 2340 + 10,
> +	.vsync_end	= 2340 + 10 + 3,
> +	.vtotal		= 2340 + 10 + 3 + 8,
> +
> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static const struct nt36672a_panel_desc 
> tianma_ginkgo_fhd_video_panel_desc = {
> +	.display_mode = &tianma_ginkgo_fhd_video_mode,
> +	.panel_name = "tianma-ginkgo-fhd-video",
> +	.width_mm = 67,
> +	.height_mm = 145,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.lanes = 4,
> +	.send_init_cmds_1 = tianma_ginkgo_send_init_cmds,
> +	.send_init_cmds_2 = tianma_ginkgo_send_post_on_cmds,
> +};
> +
>  static int nt36672a_panel_add(struct nt36672a_panel *pinfo)
>  {
>  	struct device *dev = &pinfo->link->dev;
> @@ -428,6 +518,8 @@ static int nt36672a_panel_add(struct nt36672a_panel 
> *pinfo)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to get backlight\n");
> 
> +	pinfo->base.prepare_prev_first = true;
> +
>  	drm_panel_add(&pinfo->base);
> 
>  	return 0;
> @@ -481,6 +573,7 @@ static void nt36672a_panel_remove(struct 
> mipi_dsi_device *dsi)
> 
>  static const struct of_device_id tianma_fhd_video_of_match[] = {
>  	{ .compatible = "tianma,fhd-video", .data = 
> &tianma_fhd_video_panel_desc },
> +	{ .compatible = "tianma,fhd-video-ginkgo", .data = 
> &tianma_ginkgo_fhd_video_panel_desc },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, tianma_fhd_video_of_match);
