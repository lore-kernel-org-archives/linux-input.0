Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876105;
	b=DStRcDWY8CNhb32jiQkprrl1xKADWSmiubZF1fhsEqtzzjSmUYlmEszxBzU6+XjAx1Tk
	 f7mFHrAGbSAtF/2a8sSGdJK1YsW2oHQ+N8Q2X9rHMDa9TUpTRRSkIU8lTFCUcAz3JGUSR
	 4dMMMn/s96Hub8IbRLYRKb570f0v2/GG4jZS5kSs9kjTk9GstJDVA86056rzkTbSg3vx+
	 Oo6xAZF6SvxggJ794+iR+S1AlmDMsN9cUnIs85ArE3IjzYwn2lJmtCXU0KjAVIAPzncj6
	 5E3/DsQkqbsqUuXPdB7bF416plCH+6H2q6516vpJeuqL4jTyA0Fgv0szihMUXCzjNZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876105;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=H3WRmxg92eNyeZbuIxB9Tvu0SSWoaGEzh+UrG7Xwc+Y=;
	b=B3XVoE65rhD1y3V/0NQaKaBKqRPpx0EgEoHMJmh206exClgbGzyiCN8WSjSXccT6Q/sH
	 wzvyNdN2VYqK4eOtP8Y7SAoYx6o5mYBORcsDg5phSvbajrFtb0O2ybCv36+CocyQzoJwe
	 RpAdlATSzzNqMWML+tBx0/OkQO6n7k7qdawwSABlEr7GaKXjbPXh7hdNrOusODYK0vj9/
	 njhyXF7rqTPB6M6gdiQNxAgAqZ1QjksAf14/XYhMD9UlAEmDyM/b53a7h3It3syd6GWCq
	 m4iB/RglhMRaoxuv71YNH2LV/q3CD5HzD4twcLfoaJ6dbXhkRtj4PEH64bt/wl9gwxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lc8whcbE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACA7606A328;
	Thu,  5 Nov 2026 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lc8whcbE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793876104;
	b=E4W1E0r3t+vqGGjS8xl6qIUsxOi66OYH1TVwxFsVOY3aFamnQUzLZUlZ7bNX2mcG1pRT
	 N7aBYF3uG1HrhFDRe5Sb3joyXZ/4ypBrEyZYF2LXs+0s6H67zIg4vdYNVI2pkXJNznR6b
	 eFHHzrINxyvjfy8azFrOsf7nCSRgJMrf+Vzc3+/rn2C3qVA33Ufd0LWlmXH18Mgk4kR/I
	 Hn6xFZGX0GGjzERAWVqlUa1PiR/Kr8EBtzZVXoHgR46/eR2/HYcDkVJ6S5AszeUFQWHi/
	 i309D0BMLjKnM5z0ROaofJQJLrZb47ipR8HwQb0mE8Cr5jyh+Rxa2jlQ5lH3jFXu8eg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793876104;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=H3WRmxg92eNyeZbuIxB9Tvu0SSWoaGEzh+UrG7Xwc+Y=;
	b=msNUVs0ADCVamsYpa6CuoOYI1HipU3ougyfPuaCmuyl+IqnX4VzeHWlj6dd5Iu1suqXB
	 M/ziCvFJ9rJURlv8Wx5x/nzI7503z272DpxHsP/7NEcbbzAdDLkuPWvWwnxyL/f/jiEDL
	 jhBGZUhH3Osy4otwmFrwJm0pqGcgwEcjqEI2AmocBh5yXzBYzxu7uXvIfnavWgCa7+gvZ
	 ljDesUJHwujinbinYnx+nHYDZV07nDgKxWG7PtSPm1jIfdWrDxDEqcxlkU7M46VedcGxf
	 IPCvzU8tGZ0RVxjbhH/Ukm+NU5TA40CwioIIFlti4nAlNLIJOxyZbmGrDyLWSPyLePg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 811681F00A16;
	Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876104;
	bh=H3WRmxg92eNyeZbuIxB9Tvu0SSWoaGEzh+UrG7Xwc+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Lc8whcbEaVvHlPX5uV+s7TDCgVT3ce9/buWo1jd2jlZaTZlG2cPz3Qf4De1Jd3sd5
	 /z54OYWVfyYVSIm5trFarxI+0DYQoPNpYoTaB/OEo1rQC56n0YjzAvbDcY9kJCGBGZ
	 5V8YjQXij6v9Brmegi5Awvh0UXAlKqWzWnXbEtr1gxDDeH4yH5JJyHeqAd2oS4qGm+
	 gj9U7K8cfBwsHJC1/V9sb+X6GBkOeNBjaxb/nDI9zalXV2fvaLM1+00SmNi4YHsqcR
	 vgNeChGMYE7H+qe2LgLhO6eo+sOSRLvaF0YILj/FMRER9s1cMXLKk2CZd21gpQlkQx
	 pSLPTgLCZmMIQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 00EF2471B9;
	Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Thu, 05 Nov 2026 13:54:05 +0300
Subject: [PATCH v8 01/11] dt-bindings: nvmem: Add compatible for MSM8952
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-msm8952-initial-support-v8-1-311ae8e8f14b@mainlining.org>
References: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
In-Reply-To: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org, 
 Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793876100; l=867;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=qM3CNGW9XVhnq0JnblgwuEQx6NNHy6/EPHp/pHMUtRM=;
 b=R4aPPjpYbjg49f2JEZjk0oKVlZv5pGjHlQVwVn9/Qe9EzSgPwMKNrkwvTcBIzkzCUmXS3FJnK
 gUM7dZxY9W9CJudpJ4HMxxcngr3t48gq0hEMizQaycOTEcaWDw5nw5T
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the QFPROM block found on MSM8952.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 566304ed4c78..646f2e8dcf4d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -37,6 +37,7 @@ properties:
           - qcom,msm8916-qfprom
           - qcom,msm8917-qfprom
           - qcom,msm8937-qfprom
+          - qcom,msm8952-qfprom
           - qcom,msm8960-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom

-- 
2.56.0


