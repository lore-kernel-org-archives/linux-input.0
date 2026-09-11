Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE746983E;
	Fri, 11 Sep 2026 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116675; cv=none; b=EuK/NnEXb0LYRw+v/CD/6asovc6dXoK6Zv7VKR0Ta1kdYzOWZUj4TQP8Lb+r9btZjsUkcgpYDNrjSlYVHeIFMR4Lf5jjOnUJKXDlrEAqg4xR+plno/7GFnKd6qRBxJW7RWJMvSOo7wZi73m4R4Up7AWSlApe6bXrStlXquOnA3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116675; c=relaxed/simple;
	bh=Ir2kLA2MThBgdITjF1uXNT5vEPUPjCB6BDKYUWJlkVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mmELsGvLSUbuZXJK0uy8ZSycTNuq8X4SoufD6IdpM67VnB69R5I2iZR8Zm1C+G6ftgw92rv/JHfEHG0nzIHIsJBFhARtEjMwDsYjBSZcHiixOpFL0dZNUWxR4l7/Jw54Gwltd8nFeONpsXJ+H5XGbA6kcKiHC5+pozli4NxokKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYSSY0U3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYSSY0U3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05C54C32786;
	Fri, 11 Sep 2026 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789116675;
	bh=Ir2kLA2MThBgdITjF1uXNT5vEPUPjCB6BDKYUWJlkVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RYSSY0U3ZTgE0EmFs+R/EejwrlYRI+/TrMNhbNEX4oXfFnrGdk9pbOm4Je+CbXGef
	 kWfdnuvbUiyLH/ntBecjS+nC4mRYGaVu+cZ15jcX+x99Mzs4IrvSeHYFdZyExXvSBw
	 C4SP5mvaXwH+WI87t9FWeCD/0EDboQxyTJfW0rr5UADaTpeWVPu+AQ4qgvkOK8kAuh
	 KAgqHzRl+ZgRJJIxc0RkR9upmWVjHtLIu8hpdMC9lH14aX5kb3begGcV2LVxb+Wia1
	 jseVCk+3S3+K9rdH+7XVG6xwDjCdnYhQ+agpg/JKcxCz8ejk1gYa7QgGmlxOheWrP9
	 vUu9WzQpEinwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16AAC88E50;
	Fri, 11 Sep 2026 08:51:14 +0000 (UTC)
From: =?utf-8?q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI_via_B4_Relay?= <devnull+kavakliyigitcan.gmail.com@kernel.org>
Date: Fri, 11 Sep 2026 11:51:04 +0300
Subject: [PATCH RFC 07/10] drm/msm/dpu: describe SM6125 programmable-fetch
 delayed-start quirk
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-ginkgo-submission-final-v1-7-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
In-Reply-To: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 =?utf-8?q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI?= <kavakliyigitcan@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789116671; l=4060;
 i=kavakliyigitcan@gmail.com; s=20260911; h=from:subject:message-id;
 bh=dCreEw0ry0ghroTxWJf7tgoAXBd+986oDcr+3tTl2VM=;
 b=KYl/lRrMDLhvHmU1okl6IBNSYl8H3UZgdc2FxvgWCppoBUwtEFIZVK5FOVUPt7/MCw61kGQkv
 KJLS3g1uVXIC9D2IU3cjGrSuCaC0umPhHpUeGM0zuoT1TWfIB4deo3w
X-Developer-Key: i=kavakliyigitcan@gmail.com; a=ed25519;
 pk=W2GaxVotULs2vAjRMMLheaDtMMYs4037zO1LVVfFtPI=
X-Endpoint-Received: by B4 Relay for kavakliyigitcan@gmail.com/20260911
 with auth_id=1024
X-Original-From: =?utf-8?q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI?= <kavakliyigitcan@gmail.com>
Reply-To: kavakliyigitcan@gmail.com

From: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>

On Qualcomm SM6125 (Snapdragon 665 / Trinket DPU 5.4.0), calculating the
programmable prefetch start counter strictly as:

    (vert_total - vfp_fetch_lines) * horiz_total + 1

causes the fetch trigger to evaluate on the active-video to vertical
front porch line boundary. In hardware, this triggers an internal line
buffer FIFO conflict within the INTF timing generator, resulting in
immediate DSI FIFO overflow and timeout errors (status=5) and complete
loss of pixel output.

Qualcomm downstream display drivers mitigate this erratum via
delay_prg_fetch_start = true, delaying the fetch start by one scanline
(+ horiz_total) into vertical front porch line 1.

Introduce 'has_prg_fetch_delay' in struct dpu_caps, enable it for SM6125
in its catalog entry, and throttle fetch start in programmable_fetch_config()
when the capability is set.

Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   | 11 +++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h         |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h
index 64be51e301591b7f17918475a957623c6fea23d4..ec0315284e0663f57a41a1fdf515d948c3d40d68 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h
@@ -13,6 +13,7 @@ static const struct dpu_caps sm6125_dpu_caps = {
 	.max_mixer_blendstages = 0x6,
 	.has_dim_layer = true,
 	.has_idle_pc = true,
+	.has_prg_fetch_delay = true,
 	.max_linewidth = 2160,
 	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
 	.max_hdeci_exp = MAX_HORZ_DECIMATION,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index ba810f26ea3099106aac1783f7f6bf5e014e41a0..15445eaf9f3baf4661e22bee133cc2059a3cd2b1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -237,10 +237,21 @@ static void programmable_fetch_config(struct dpu_encoder_phys *phys_enc,
 
 	vfp_fetch_lines = programmable_fetch_get_num_lines(phys_enc, timing);
 	if (vfp_fetch_lines) {
+		const struct dpu_mdss_cfg *catalog = phys_enc->dpu_kms->catalog;
+
 		vert_total = get_vertical_total(timing);
 		horiz_total = get_horizontal_total(timing);
 		vfp_fetch_start_vsync_counter =
 		    (vert_total - vfp_fetch_lines) * horiz_total + 1;
+
+		/*
+		 * SM6125 (DPU 5.4 / Trinket) quirk matching downstream
+		 * delay_prg_fetch_start = true. Throttle fetch start
+		 * to the second line after active video (VFP line 1).
+		 */
+		if (catalog && catalog->caps && catalog->caps->has_prg_fetch_delay)
+			vfp_fetch_start_vsync_counter += horiz_total;
+
 		f.enable = 1;
 		f.fetch_start = vfp_fetch_start_vsync_counter;
 	}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index f45faf87333e89bbd463504ae3219609ef6209bd..db3cbf9fa04a13baf3ac40390757ed24120ccccd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -273,6 +273,7 @@ struct dpu_rotation_cfg {
  * @has_dim_layer      dim layer feature status
  * @has_idle_pc        indicate if idle power collapse feature is supported
  * @has_3d_merge       indicate if 3D merge is supported
+ * @has_prg_fetch_delay indicate if programmable fetch start requires a 1-line delay
  * @max_linewidth      max linewidth for sspp
  * @pixel_ram_size     size of latency hiding and de-tiling buffer in bytes
  * @max_hdeci_exp      max horizontal decimation supported (max is 2^value)
@@ -285,6 +286,7 @@ struct dpu_caps {
 	bool has_dim_layer;
 	bool has_idle_pc;
 	bool has_3d_merge;
+	bool has_prg_fetch_delay;
 	/* SSPP limits */
 	u32 max_linewidth;
 	u32 pixel_ram_size;

-- 
2.47.3


