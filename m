Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793186360;
	b=tSQMX/uvRzAXTIv0Ml2aEyheLo4Htbd6l7omjjiLoS0ukM4K1MxqJ8QR0i+lnq92trB3
	 FSqveOBUZfM+8WYnxr7j5U9ZY852JXqPQ2hVVKHcjgrOZeMOy+I2bb2sfQMxK5eGnuIxQ
	 v8gLWiiT1bNOacsmiM4yc/OiqpSHVlUmOkGwSj91ksBHDYJJhvjZwmYSZ59WChSQtQKGP
	 9uuqggALoUpkmneuD8fnSdK8uJe44FjbUhhbEIAUELsc7w7M+nLzwk9/EB5iNZyHlIOaI
	 afq91C89SbD3/m5rdkbTVJ2N054LYG4aJkxw3K60UaDvZbtqc4I6puyTSX7PFvEubzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186360;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fLxcuXmvvWbcMDhadAHY0ieF3XzHcf5W7cJn0XjKsvk=;
	b=p2B4u4OqMMTfFjQLcO5uJhDqPzZ7DJc4+t4eywQxRDVJuji1+SEEuRsDEzv/xXmlPtCT
	 EUZHTuZmUVH00Fr2bWheetcSVUjTlMjbfJ5aqYk/8FgBmjFD5rkUWZUeVzTe4rHQvqcEH
	 n15Q4tZl2r0xgFJqQmfi0zXqSU9yT7jrq87i1YBJrGKdqgkxCvlDdgfqhE/r2rfKcctAH
	 Nbj0u5MQeJGUCiyVm9UjjznRvwPzB3J94tMMyJCZkHY03j4574HCa6sCNAf25YPvSvouO
	 13kZ/fDRP6yOlGqr09IzgtCEkJCCBNp1HVXueD8o6mXcpPb5nUZVzptjDLor4Y2TEug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FGONao/g";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A0606A31A;
	Wed, 28 Oct 2026 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGONao/g
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793186354;
	b=anz4XldHoeB51+tOfy5fluDuSJOWdTplG0Zl0HsDpSto5gB9FfOQiSS/qQkUhaVjoG6X
	 KfuqiFCYJ96p5wOs2lX3r37+6YfOx1oJbEgXEo35TJWPMRmksqN9K4Tcgt7cSrQjRLwzA
	 P7ackGVsReNq4HPrDHq7pKBtP/8ufBkCgR/5+1MpwoiaA9tEGDZKIC99N3nwfxk3OQSk1
	 T8EkaZIcsCgIzGunxq5l5m5X150tdh9qbjaobLgkgnn1fY9LTEpeocKwiGwtrIWVjpecJ
	 eHgx+jtsxqKwOKA4nnPzFSn2SW++kBgdjW1a/kfOrRLQD3eR9TqTDsbtZ0d/euNVHeA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793186354;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fLxcuXmvvWbcMDhadAHY0ieF3XzHcf5W7cJn0XjKsvk=;
	b=V0tc0mKh6lKLqpjXNOI8uRN7yy2wIRJokY/Vo9HdtzFYMySCsb8Cn2NpTz1O5/UohUub
	 MKUQOOGzE9AVERKhFTHtmC/aQa254OLQWKF8ucHx7MwP30NPL+SeNQ33zQAknaIp2f8WR
	 p9aAn5ZfM7xnO6cIxBajShSx5DkTjr5H0o/AgWRk49IfLp2k0LMkUMyK8MWRSqxLpJtIr
	 5Q175GPrwup+ppMQcG/TcAwBULsJNKw+wlE4YI+4AE7bl8QYH29nso2DZFmdr3glc8ENL
	 CaNw64rWPA6kPMxCB7nGJ/jG+PrOycyyKs/TT+oJXXuDAguqV6cMMvtL/QRF+zNunhA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3D4AE1F031E5;
	Wed, 28 Oct 2026 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793186354;
	bh=fLxcuXmvvWbcMDhadAHY0ieF3XzHcf5W7cJn0XjKsvk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FGONao/g0p5nzye2j6WJZMCtB8JgFMzcVHtayJcNUJPMV92iF0Usxg8JPmZYeOkRC
	 Te1PgPiYISAri44X+U76PvqfP2Z2pltj/EkaMvNX8wzfWQ0ulm/WLnbflMOqQSpS5h
	 XO9B4h45rb4JTFBoB7eCGkaTPy8gdJIuns152Y9XOMK60NluV3bnFJLqkDds03jHlR
	 Hju9hm+d84ZlEhJFBg8fZw8T+tP7/sG25MiHe3P4Q87w679CiQITMhSRcvAWT1BI8k
	 xWl1SEc7azZr280RPDKnuV1a4f1pvub/caZNwp0+jDpIm94a0T/Jpx6S+1BealjVnh
	 t/ehYBbvKHyBw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BA8EF4541B;
	Wed, 28 Oct 2026 11:19:12 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 28 Oct 2026 14:17:22 +0300
Subject: [PATCH v6 03/11] dt-bindings: watchdog: qcom-wdt: Document MSM8952
 watchdog
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
Message-Id: <20261028-msm8952-initial-support-v6-3-e07ddd8bcf4c@mainlining.org>
References: <20261028-msm8952-initial-support-v6-0-e07ddd8bcf4c@mainlining.org>
In-Reply-To: <20261028-msm8952-initial-support-v6-0-e07ddd8bcf4c@mainlining.org>
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
 Muzaffer Kadir <muzafferkadir@mainlining.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793186351; l=832;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=6oZOV+Mf0e2Xnm4F17qb2OJyHhIjSjwRgWv2fbhA1PA=;
 b=/LAAnAOrVpwOOgRezY78N0yMI7KJQY//B7hj3n1Cd4TXoQKy6YnY36h5aDZ+hTD7vhw9Aowwf
 UXs4hdvKYtcB4EweLSUH3Ktyc4lTRj8YFkDa3lK3/R7Vyxu0jKQ4sps
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the watchdog found on MSM8952.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 4ff61102e407..38f86ccd1ffd 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -29,6 +29,7 @@ properties:
               - qcom,apss-wdt-kaanapali
               - qcom,apss-wdt-maili
               - qcom,apss-wdt-msm8226
+              - qcom,apss-wdt-msm8952
               - qcom,apss-wdt-msm8974
               - qcom,apss-wdt-msm8994
               - qcom,apss-wdt-nord

-- 
2.55.0


