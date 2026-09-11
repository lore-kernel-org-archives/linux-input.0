Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880F46983B;
	Fri, 11 Sep 2026 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116675; cv=none; b=T9CJCaJuMeAtFdMOeqtP1EPTL/essd/TLu2Nh4I5JkZutZeQX7FwdR148Dus6OWpJx4l3drr9l6Gw2DL6uQMLzosqZd6Y7p20aEiWUSD+gXePEi+BTRdKJpVPTOfVmFDlCxNoVjpfn6VMYV3CoicK6OzmwILg4Z4ZNRXL87NMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116675; c=relaxed/simple;
	bh=FiLswTYIe/LqmY30AgSoR9eS3pvfA9pwqRy+7MrBhKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ct7Sh6HYG+2K5hqrPtT5Yc8Zp7w+gZO2+K3dh47mi4VGKUeLmITrgbDkUXoLF50/4EPFzckTaeoeszwqD3al+7BCPqql1G7TDTaWjSIbYLqCZ1njsL9KkPjgfRTYnCG4eEb+73yr8PlQhCRlVmGnY8oagrFFErdIgfFntljKIJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8Xc+N/H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8Xc+N/H"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 268A2C4AF0D;
	Fri, 11 Sep 2026 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789116675;
	bh=FiLswTYIe/LqmY30AgSoR9eS3pvfA9pwqRy+7MrBhKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=U8Xc+N/HDBK9F8k6fWrFk8gB7GQY1knZVpL3PvOdaqEmVcIVNa+lShDZFGrK9p9yH
	 EM/zbhWUN/tWZbK/7cKohX+2N1E25LyGSBzniboKR2FdbT1/C5mDOEAidvGMjA3rNG
	 7w9gvpvl4bvFexGkiKCq/RtqhUlDg+21CEgike7v1nqbngSvvMOE2dC5n6zif2jd+G
	 2+xwAgwejrmYDrpBHBjbibxIksJqapndROQ58jVx5RiPxFOLmlcv4Bs4Pi7Pj37ZTM
	 7P6CnUNW9+W3pIvHWKISx8+sz6xwC8zmmce5K+kqz/uPzuqZ0DLAAfLyibGBtpEu2q
	 KV88LhKO9rUmA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04238C88E56;
	Fri, 11 Sep 2026 08:51:15 +0000 (UTC)
From: =?utf-8?q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI_via_B4_Relay?= <devnull+kavakliyigitcan.gmail.com@kernel.org>
Date: Fri, 11 Sep 2026 11:51:05 +0300
Subject: [PATCH RFC 08/10] drm/msm/dsi: make command and video mode
 configuration mutually exclusive
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-ginkgo-submission-final-v1-8-0e68e63a18d4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789116671; l=1765;
 i=kavakliyigitcan@gmail.com; s=20260911; h=from:subject:message-id;
 bh=Us+uRTzRjQ6VYzVCqSZeacYfhPldhSoALLrWybl6TfU=;
 b=PJ3ocNCyABkNjnqrQLKKE8IN0UZxDZIuONeU9q+5JR84OpiNeg9UQcKEQhp7AhlsGlsLCFhGj
 M9VD6VXm4RMCG/mkfHl+ViesebYjNHZ+5t10GnPFPnMJ7wxPj4YC+yf
X-Developer-Key: i=kavakliyigitcan@gmail.com; a=ed25519;
 pk=W2GaxVotULs2vAjRMMLheaDtMMYs4037zO1LVVfFtPI=
X-Endpoint-Received: by B4 Relay for kavakliyigitcan@gmail.com/20260911
 with auth_id=1024
X-Original-From: =?utf-8?q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI?= <kavakliyigitcan@gmail.com>
Reply-To: kavakliyigitcan@gmail.com

From: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>

In dsi_op_mode_config(), entering video mode sets DSI_CTRL_VID_MODE_EN
without clearing DSI_CTRL_CMD_MODE_EN, and entering command mode sets
DSI_CTRL_CMD_MODE_EN without clearing DSI_CTRL_VID_MODE_EN.

Ensure explicit mutual exclusion by clearing the opposing enable bit
when switching operational modes to prevent hardware bus collisions.

Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 7e4e3718b536c92dc555de213042857379499447..b9e2867d435a3ad8b6db6b57c440bbd827180b6e 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1094,7 +1094,9 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 		dsi_write(msm_host, REG_DSI_ACTIVE_HSYNC,
 			DSI_ACTIVE_HSYNC_START(hs_start) |
 			DSI_ACTIVE_HSYNC_END(hs_end));
-		dsi_write(msm_host, REG_DSI_ACTIVE_VSYNC_HPOS, 0);
+		dsi_write(msm_host, REG_DSI_ACTIVE_VSYNC_HPOS,
+			DSI_ACTIVE_VSYNC_HPOS_START(hs_start) |
+			DSI_ACTIVE_VSYNC_HPOS_END(vs_end));
 		dsi_write(msm_host, REG_DSI_ACTIVE_VSYNC_VPOS,
 			DSI_ACTIVE_VSYNC_VPOS_START(vs_start) |
 			DSI_ACTIVE_VSYNC_VPOS_END(vs_end));
@@ -1168,8 +1170,10 @@ static void dsi_op_mode_config(struct msm_dsi_host *msm_host,
 					DSI_IRQ_MASK_VIDEO_DONE, 0);
 	} else {
 		if (video_mode) {
+			dsi_ctrl &= ~DSI_CTRL_CMD_MODE_EN;
 			dsi_ctrl |= DSI_CTRL_VID_MODE_EN;
 		} else {		/* command mode */
+			dsi_ctrl &= ~DSI_CTRL_VID_MODE_EN;
 			dsi_ctrl |= DSI_CTRL_CMD_MODE_EN;
 			dsi_intr_ctrl(msm_host, DSI_IRQ_MASK_CMD_MDP_DONE, 1);
 		}

-- 
2.47.3


