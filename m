Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E66F43B4BB;
	Fri, 11 Sep 2026 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116675; cv=none; b=JnBP8XSg3UBXhPaDayRyclAM4cxr8Fo4ew/6sCSPIIrk2R2L4y7alPRtsEP2a2/x5vHmkKLKAZY7IHIEMrH3XdBU68GhgeXeySiWDvbuL1l8wNxV0TzAr0vAB5T0lsMfXc97xzJqowxlwDwhQgK8Ya3n1LFY1csOf4MXP6HpW38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116675; c=relaxed/simple;
	bh=8RziPjmr86j58LZqVuPJpDkvRLhBLUgcBlPpa46vgoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZxnjjWCFCldFP6OQtGnetuAJpAloDk/qfS4VGo2lPbRcDvMe/wqE59LnfR20T601DKq0Dz0LjlA1Y+ndKxdphDAb3jnN8ZCAexCy+/iExxC6HkuDmLZ5vtR+O6Xlz3cnjVhA0l24A8cbV2Pa/7x3lAJvGuGlqKFz24zP49uMw10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQHYx2Q7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQHYx2Q7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABBE6C2BD04;
	Fri, 11 Sep 2026 08:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789116674;
	bh=8RziPjmr86j58LZqVuPJpDkvRLhBLUgcBlPpa46vgoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dQHYx2Q7FEXSskE3N+4PECi8e3dFPWmZtOf/+86Ag1CFzYqmXGYk0cJZdkLQP51LP
	 V/AnF0OitSqeniNgmleIMm1QouUkLJXvrZzhgjymmLK9jlLZAYa61OM7BA3JrVAUOh
	 /UQebmdKNvqcdybm9Wyf8W9wKl3K+heYYgNF1zPQv7CROkvTjomi3i17yYORRluZ6E
	 vW5n/Hc7uPg9yolV8yZuVrrQdp1VhAagcFmLFk1MBGoxc6F5YOWfOh+FikUJJhlPDk
	 Y47tXQ1cmb5WBFEZ936kE9NCK+VBjgi4JjOBgFBAhEZutYoq3vCe3rAUIc6RgpcO2g
	 jJfYOyzMc+Qog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903E7C88E53;
	Fri, 11 Sep 2026 08:51:14 +0000 (UTC)
From: =?utf-8?q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI_via_B4_Relay?= <devnull+kavakliyigitcan.gmail.com@kernel.org>
Date: Fri, 11 Sep 2026 11:51:00 +0300
Subject: [PATCH RFC 03/10] dt-bindings: display: panel: novatek,nt36672a:
 add Tianma FHD+ video mode variant
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-ginkgo-submission-final-v1-3-0e68e63a18d4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789116671; l=1337;
 i=kavakliyigitcan@gmail.com; s=20260911; h=from:subject:message-id;
 bh=AtK+lXLPgtCAd0x0Q8ZmqlE6229e2DioZldnqFvwW6k=;
 b=CuC7FXTtyIRRqdqKvBCGyMqURAjP2DqWfwpfHd4zVYPkbELnIFOwMkil8+A9jXa9BtQxWIuzD
 9CC7I9h8FMhBVz5GdwJnIyMxg1Hb2F2jwFbu1IbAx7X3jeL/90Hw5pO
X-Developer-Key: i=kavakliyigitcan@gmail.com; a=ed25519;
 pk=W2GaxVotULs2vAjRMMLheaDtMMYs4037zO1LVVfFtPI=
X-Endpoint-Received: by B4 Relay for kavakliyigitcan@gmail.com/20260911
 with auth_id=1024
X-Original-From: =?utf-8?q?Y=C4=B0=C4=9E=C4=B0TCAN_KAVAKLI?= <kavakliyigitcan@gmail.com>
Reply-To: kavakliyigitcan@gmail.com

From: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>

Add compatible string "tianma,fhd-video-ginkgo" for the 1080x2340 Tianma
video mode panel found on the Xiaomi Redmi Note 8 (ginkgo / SM6125).

The downstream vendor DT identifies the panel as "nt36672a video mode
dsi tianma panel" without documenting a glass model number. Following
the established convention of "tianma,fhd-video" for Poco F1, this
variant is added under the existing NT36672A binding schema.

Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
---
 Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
index 5d16d85117254ce479cfe9b9b33df8eeafeed1e1..9f42b1ef07669a3b0e6d2285a39a961e2e04cec7 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
@@ -23,6 +23,7 @@ properties:
     items:
       - enum:
           - tianma,fhd-video
+          - tianma,fhd-video-ginkgo
       - const: novatek,nt36672a
     description: This indicates the panel manufacturer of the panel that is
       in turn using the NT36672A panel driver. This compatible string

-- 
2.47.3


