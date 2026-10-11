Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E5435B653;
	Sun, 11 Oct 2026 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737533; cv=none; b=WRQ4O/K/oFwYmANQCrgCu21qyKH8WPCQ/exqRt2KWIVEQvh9ceNGQ2nIzbdjNl+ax+kcTyMPaKBruI0wNvh7q3onae5ZwHlw2yLbbBcTUzi9uzHKK6depCriPYmfdmRbTayOTGIkRudLmt/gmH0AqyIc1v+gH3qXZBLiWNXNQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737533; c=relaxed/simple;
	bh=1VAUGUtsIzrRS3NpZWYQU6qxN7QwSxApdg6TWS5po8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IzMp+yoMl2awmLKdcLrC96UOifV0KLCET7PlHv+cG3o3ywHuEzWoKAmhruFeGopF7QXw0jRC5zYSnRHzKlGrUd1Bsm25J84ooAWXXXHcL6+l23PK5K1wdJ5jW9LG0mBhPCpJMbR7FjY9cEa18MgmRFGGd6gm4RKPYyOIWi+I2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2T3avxO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2T3avxO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E4FEC4AF65;
	Sun, 11 Oct 2026 16:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791737532;
	bh=1VAUGUtsIzrRS3NpZWYQU6qxN7QwSxApdg6TWS5po8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T2T3avxOi200/WoJuWZ96a7KrKKwM2R2WNC7Fr/J3/3Sy1Hk3h/tWWqDKXC83JQam
	 5bsGIIJiPzToj5l5+52c4TISxO+5wimOC3cdp6wKpw5gjLOahVRK29aM//9T0t3sw/
	 HV+CMcJ5amC2AV7/iRfxAPud0yZkJsndcaprtWwRdfpAnib099Ll6KGVtzsM7jzUcA
	 ktnsqbBS1J8N+XI1sggOENQVvfs4dh3zy1hSVQIaya2fvq/GjDsur0XJZKNfqXA4b8
	 OV1R9MBtf200rk44WwNDQaTCmHQKXmjFIRBE6ZiZJPJeWXLYpTNLG/ENgcPmgduCqb
	 MBqG7vT/iGfaw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6319FCA9ED1;
	Sun, 11 Oct 2026 16:52:12 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Sun, 11 Oct 2026 19:51:26 +0300
Subject: [PATCH v5 4/7] thermal: qcom: tsens: Add support for MSM8952 tsens
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-msm8952-initial-support-v5-4-1857074992ec@mainlining.org>
References: <20261011-msm8952-initial-support-v5-0-1857074992ec@mainlining.org>
In-Reply-To: <20261011-msm8952-initial-support-v5-0-1857074992ec@mainlining.org>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org, 
 Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791737529; l=3695;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=3h8bz/deABOTAvqHXeSaJkIEOawr/vek4uhwmg7uHiw=;
 b=O53CIdJr3BqCGpBzC2c1J5nZ9cVQ/IJS62Tjt5wfh5KWXVquYVK2mrBRYeVmslLSUL72hA4vk
 A6cZsCAfkIRAqhdtytx4g+GVd56Uo4yapWT8a8DoHGBTqVpW8KY5qc5
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Add support for tsens v1 block that exists on MSM8952 with
11 tsens sensors. Sensor Offsets are taken from downstream.

Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/thermal/qcom/tsens-v1.c | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c    |  3 +++
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index faa5d00788ca..7bda8e6087c4 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -145,6 +145,34 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
 	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
 };
 
+static int __init init_8952(struct tsens_priv *priv)
+{
+	priv->sensor[0].p1_calib_offset = 2;
+	priv->sensor[0].p2_calib_offset = -1;
+	priv->sensor[1].p1_calib_offset = -4;
+	priv->sensor[1].p2_calib_offset = -4;
+	priv->sensor[2].p1_calib_offset = 4;
+	priv->sensor[2].p2_calib_offset = 5;
+	priv->sensor[3].p1_calib_offset = 1;
+	priv->sensor[3].p2_calib_offset = 1;
+	priv->sensor[4].p1_calib_offset = 2;
+	priv->sensor[4].p2_calib_offset = 3;
+	priv->sensor[5].p1_calib_offset = -1;
+	priv->sensor[5].p2_calib_offset = -1;
+	priv->sensor[6].p1_calib_offset = 0;
+	priv->sensor[6].p2_calib_offset = -1;
+	priv->sensor[7].p1_calib_offset = 3;
+	priv->sensor[7].p2_calib_offset = 4;
+	priv->sensor[8].p1_calib_offset = 2;
+	priv->sensor[8].p2_calib_offset = 4;
+	priv->sensor[9].p1_calib_offset = 0;
+	priv->sensor[9].p2_calib_offset = 0;
+	priv->sensor[10].p1_calib_offset = -3;
+	priv->sensor[10].p2_calib_offset = -2;
+
+	return init_common(priv);
+}
+
 static int __init init_8956(struct tsens_priv *priv) {
 	priv->sensor[0].slope = 3313;
 	priv->sensor[1].slope = 3275;
@@ -223,6 +251,19 @@ struct tsens_plat_data data_8937 = {
 	.fields		= tsens_v1_regfields,
 };
 
+static const struct tsens_ops ops_8952 = {
+	.init		= init_8952,
+	.calibrate	= tsens_calibrate_common,
+	.get_temp	= get_temp_tsens_valid,
+};
+
+struct tsens_plat_data data_8952 = {
+	.num_sensors	= 11,
+	.ops		= &ops_8952,
+	.feat		= &tsens_v1_feat,
+	.fields		= tsens_v1_regfields,
+};
+
 static const struct tsens_ops ops_8956 = {
 	.init		= init_8956,
 	.calibrate	= tsens_calibrate_common,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b5ec70201e2f..4d7013fc79d6 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1191,6 +1191,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8939-tsens",
 		.data = &data_8939,
+	}, {
+		.compatible = "qcom,msm8952-tsens",
+		.data = &data_8952,
 	}, {
 		.compatible = "qcom,msm8956-tsens",
 		.data = &data_8956,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index e8376accdff3..a35b15312961 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -669,7 +669,7 @@ extern struct tsens_plat_data data_8960;
 extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8974, data_9607;
 
 /* TSENS v1 targets */
-extern struct tsens_plat_data data_tsens_v1, data_8937, data_8976, data_8956;
+extern struct tsens_plat_data data_tsens_v1, data_8937, data_8952, data_8976, data_8956;
 
 /* TSENS v1 with no RPM targets */
 extern const struct tsens_plat_data data_ipq5018;

-- 
2.55.0


