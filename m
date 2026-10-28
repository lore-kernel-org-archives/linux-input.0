Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793186357;
	b=4qzxqShE3qmCdTuu9uv5t8Ec8X2yayI4GoUdW5lkwURfpWDjhe415xwEV9Nt5AJ1MmTA
	 ZJl+bFHipirLfSNKimZr+hAkV1CSJUgFUt8xUkOSgDeMji8WIPWYA3wgc9Zg0khJd9cF1
	 Z66JXTONwqA+95OLwXdPFGp/W+I5/XbpWFVxUr0zUr0T1V0vkw0Nu0/EVf31O3Owj5oAL
	 hSAygzT3PFwJjbAp+SyFo9fY17GvTT6gktkrlkLsThosO5Gw7y7c0ptBRsdpmPJZRY3zb
	 +zEjuusYXu+miUESBjRpkOhuxTE2k6WKJ97D+VVjUuA0lLfbAx5E9NJl2BRL6y6PReg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186357;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=w41sq28x/ASq4lXyo8/BhZ5wcP8Nly9VwoK1OLW/Pp8=;
	b=ld/iz65uIN8LqjKhxw6gkcF3QLRHuX2KKUjXPIm2UlS5nfsyRaDal2f/BjV2eKqgblO5
	 ejhRJ7Em18mHXqIV7Vx56k9QqPa5ecZXOxUUtx1TTaK1NuxGuQwYXaYmSDpPyYclDOBlN
	 Pj4lYqUlaHoda0GeR11sbAKwe6d6VTtcxQ1nV22H8q7DxLhfR6PVyu+kZArpyo3PGZMRz
	 eSVKi7bMtjyTH6EnxA17ib+P4StbswJ+ZSPVrOBG4EkB2lvPN4hHW8Yh4vtIC7u0RHNsx
	 6SIrqBraoZgLhKrNXl5Vorp0nXK7/y7hayKtyEOZfjHmDRp6mFxiEunWI4atPN70ozA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2qzZ8cu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE060A2621;
	Wed, 28 Oct 2026 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2qzZ8cu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793186356;
	b=H/OLYwJi+D1RgtG4l79kTwvAvQOGGegwh0YXvGlj/U+d8Koj5iDcwZXhBcDS9ezdKcu8
	 UVbwoor0I/H8wd2yc1bSMVcMaoMh2fNyY+8lnXJSPl5DmLIhSD92RrSJv3LQZXg+Pc+Gt
	 L1uAJip1lg1MHkxOxI/DVGkOlUZQTYE8jq3vfmIg5W0lQt7jHoYsNBI1KJv+wpBUXQEHE
	 w9VTctwQmz6pOfbWUKSuoBvOaFocTs/hB5ob1yL6EsrLYo1mQYBAUKL++IqGRhyqSHL2Y
	 GzTW4xb4iewEQd8t5F4CsV/MS4c7VDFC8elS6OsHAHMup2HOTQjzmxxoXyKQgd0hViQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793186356;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=w41sq28x/ASq4lXyo8/BhZ5wcP8Nly9VwoK1OLW/Pp8=;
	b=3LUT88M7uNSef3Y/dbnEqFsbgVAcziNEDCLlfwjSkpMUxz0jKTYa+zS4eSdAa62pyz3f
	 RSRRhhKEQZYetwcdvz/uuNxr29XGbZ3cAfQoyZN0kvc1McBPlnPRSeHdIB3wh3lf0GZyx
	 CpyzfRLKV5g2pUPDSLJRCXyzaxSxMAzu80NcuRWTa4XV0EDbuKr190K6qMMydtLgxRgC2
	 QntCOln4efdOY6V53vSBw4F4oKVaBabTmG0d1tymXE01KJ0haBtfrEbna/oqnAD0TJMqP
	 BeD0etbm11Hs+NWuHDSkfXl4iYWLIqm0fGltfvnxtDDi/OUfklsZgqhzmEReQZ2lw8Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1C2FE1F01340;
	Wed, 28 Oct 2026 11:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793186356;
	bh=w41sq28x/ASq4lXyo8/BhZ5wcP8Nly9VwoK1OLW/Pp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=b2qzZ8cu4aVJvtP4q5wNdcchc/woej4B7IVRs46PjGeArSY6aVnjvK+e9mY5sxrG3
	 GnPWHEd2O+2M5oLxbhOIlGtz8lVQD9Mm4h/u/oGcPMqVurpudyM5oYfkJWZtyr82Ac
	 wvO1Yazvwp4SJI18O4yxLQyry0GFwexFhLQAU66gLaDBhRqOQNDqygHYojnnEfyXMo
	 RC//XSYD40rkUAnJ+8oN74JjRbEEXNWVHAw5Sg+3jp4y5DEEwO/6lVRx6po23Zpwdx
	 4IycHcU+lKCamwGlD/Cc1UDdClgGyDg31Y8E0Os04Bn3AxOy/NNcdfQToaTXRIAdxq
	 lPdlCmVayCumw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1C58445437;
	Wed, 28 Oct 2026 11:19:13 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 28 Oct 2026 14:17:29 +0300
Subject: [PATCH v6 10/11] dt-bindings: input: touchscreen: goodix: Add
 binding for GT970
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
Message-Id: <20261028-msm8952-initial-support-v6-10-e07ddd8bcf4c@mainlining.org>
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
 Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793186351; l=1656;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=WcI6NF2jH7/1jsgO/qq/6GfopHH27DV/LBlXLYlg2yo=;
 b=bH46ezpINOJGaqTGuv8ax4EGvA3DWxV2Yq930+Quu+D70OJ6ZNJtsQ+ibnaxx8zH6mpZtRUen
 U3OY+akPQPeCF3YGHWmBgTadJbP4fCH5vhc+r4fJpFndxqMGKAc6x9n
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

GT970 works with GT911 driver, document it to be
used with GT911 compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 .../bindings/input/touchscreen/goodix.yaml         | 35 ++++++++++++----------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
index a26a54d63a1c..4be2c137abd7 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
@@ -14,21 +14,26 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - goodix,gt1151
-      - goodix,gt1158
-      - goodix,gt5663
-      - goodix,gt5688
-      - goodix,gt911
-      - goodix,gt9110
-      - goodix,gt912
-      - goodix,gt9147
-      - goodix,gt917s
-      - goodix,gt927
-      - goodix,gt9271
-      - goodix,gt928
-      - goodix,gt9286
-      - goodix,gt967
+    oneOf:
+      - enum:
+          - goodix,gt1151
+          - goodix,gt1158
+          - goodix,gt5663
+          - goodix,gt5688
+          - goodix,gt911
+          - goodix,gt9110
+          - goodix,gt912
+          - goodix,gt9147
+          - goodix,gt917s
+          - goodix,gt927
+          - goodix,gt9271
+          - goodix,gt928
+          - goodix,gt9286
+          - goodix,gt967
+      - items:
+          - enum:
+              - goodix,gt970
+          - const: goodix,gt911
 
   reg:
     enum: [ 0x5d, 0x14 ]

-- 
2.55.0


