Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793186357;
	b=gRcoJ3JCKA6dMWcsk/+mSJdRLYO4k+xFCeLLdIXOIHpJsJ2M35jFU9fI+mFeHfJO9aNL
	 Pr4X75xidbRgrvVKPebHfU0nxBMFpMpV1uFL6qChG52hLlGCPzAZOYOdfN278DIPUOGxh
	 TACbMfXJ/eI58Kc+eP9PgWyZkK9qL3Yl3U07hwm4KytNDApW0iKLmhRWpMw87u56RZoIM
	 upe4oIkqN07gV8ZWWQ2giHDaYxnXZnrTRASDYQpLMYyQHoSr0BwQ7xjny9eO2Ayr7YqKc
	 HPt5z6Qzr1poaYJmb9zjEGHQjmTr0N+/rvGAflA/lcSUZyaN881BQGxRUd9fI+cRLEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186357;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XSe6fJJOO/EdiEiWR2XftDrTqeJx/Yi+0YnCBjUlCZE=;
	b=QjR5TWX1uXgSGXRUThmkz1MUo48syqBXg9h+WzRbQA6aqIk4NlQpUcSDVHdTkPhlaTg4
	 40VMDUfNjeTz5j5pHC+3KUXlJLww+3FrKV1YjIq/bn0TG7qj1S1DWeIPLn8zwxNNY82iB
	 VdGa51fam08UG2JxFtX51DGo2PPV277R+OV0TInkAKNvGTZroquZOiw/X5wEHizJ5+7xR
	 zrglD72xXQKNGiLszOUxPZRJ3tCameolQs0plFAwDSP6n9R0e6IG1UQQzRrxqS49Hptvy
	 Xc+3Hvag8qoPYD7e1uMv0QuUSMAVNzj8/fSnuRCB9QoGFF5fHdaoD8DrgrLW78tM61Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l15RFh6W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D848760A260D;
	Wed, 28 Oct 2026 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l15RFh6W
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793186356;
	b=HECSlxp4Z4Q86kCQhxbaQHh3gXMsw9iBsbdTpgNfw1ld3A1IlGv3TRmegP4OGMGk4LwD
	 mnBx351iSh/vAN86MfzcSniTbZO8VwaoGuxp6ex+HlF5798KENXNJzep9qyI26KWh5g7i
	 Ts/k6hSoSPx2cexjXhPZjEv3w4X1p1pfM1EO+doV1AG8fP8OldpeSjGsjI8FBgXvY8rWZ
	 74sHUZz5Ar3AyCojdPT5gYd4arNyfC6KDWmXtk2nfJ3Rag2hMM8mJFFC7FfJN5wzGkSHz
	 Y5XjEZfdzS/n7/ECW07Em9gN2BdivGX1Py+y3X8jDuzGK8C393zO/cPvoCdDrh1vy9Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793186356;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XSe6fJJOO/EdiEiWR2XftDrTqeJx/Yi+0YnCBjUlCZE=;
	b=cBwNu3hSAF7htKjGIG1TSuYDdyKNKjWiIMg1zVBdQgMM8IXN/MxXwNnOAF0NHo8CfMph
	 gXm/0nw30nV14hh+b4zQh5JhGmkk7hjhLNDuLgowzgd1J6IN9Gu7HUApRNR3SiKHp1ccu
	 qWdf/QghQbmkxo8gpMrHdmJLjIuGMsNmHfaMdO2zLalwzp5e2kx7JGMojxz9l++VLkauH
	 PXRCK+Hk23V0fpbO7TqsbsawL+g4Mrr0oTX3GjqdVyECXCRCN7Vqd/xqKRD3ohAZdQbqC
	 XH3cKXvJSpJ4J/rtjXW+0OPzwbBx+7TaK9k881sc5+HG3onjdxBaT5WTRhlAvO4vFOw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F3C0E1F01344;
	Wed, 28 Oct 2026 11:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793186356;
	bh=XSe6fJJOO/EdiEiWR2XftDrTqeJx/Yi+0YnCBjUlCZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=l15RFh6WpaF33kIoYhQwjnWB0ukPmffdsWzSUPZHAFM7NKgK2K3sSaHstV8nzuNEj
	 44QfWalej+qSvmUNpU756hj2r96pP5Wv9ApJFQhDtoCqEplu++Gx0bPHtZpSv6lWF+
	 uHyd49wRbk1KLIlRxS9EJGz/vF8g/+OllXoXyOUfN495Wk80HFgYvGie6Wj+YPSmPP
	 JBmeKWYj77eT7I6oxXrr9dekegHdsPsB/c3vFxSAKaTcH8aV3ms1M3uBi9CPVzZBXE
	 1v4ZUL3lQadKj5q6q80/rNq/J544r0XWoBFYldTcZ7RgZS7hIxAoiSSn8+T64w2zbR
	 jEKo7heGaMDEA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EC5E34542B;
	Wed, 28 Oct 2026 11:19:12 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 28 Oct 2026 14:17:26 +0300
Subject: [PATCH v6 07/11] dt-bindings: display: msm: dsi-controller-main:
 Add MSM8952 compatible
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
Message-Id: <20261028-msm8952-initial-support-v6-7-e07ddd8bcf4c@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793186351; l=1157;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=o++ptew9Ow2rBuPiY/JBHdw7xKutwMrQt/b2OznM4Wc=;
 b=CTGeG+waE0KO7HeBwqT+k8dOvFZWDCXcToGok50l9QNy850X9NHJW4F2Dcp9mGHVLhE+fHoaR
 GDGbbdLHevUD/coNX3luD9m1v39JDQDBxaKV+VY+971fvL7R7GqmSaf
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the DSI Controller found on the MSM8952.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index e4fd1cbbd4e0..8b352380827f 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -19,6 +19,7 @@ properties:
               - qcom,milos-dsi-ctrl
               - qcom,msm8226-dsi-ctrl
               - qcom,msm8916-dsi-ctrl
+              - qcom,msm8952-dsi-ctrl
               - qcom,msm8953-dsi-ctrl
               - qcom,msm8974-dsi-ctrl
               - qcom,msm8976-dsi-ctrl
@@ -271,6 +272,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8916-dsi-ctrl
+              - qcom,msm8952-dsi-ctrl
               - qcom,msm8953-dsi-ctrl
               - qcom,msm8976-dsi-ctrl
     then:

-- 
2.55.0


