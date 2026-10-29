Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793307761;
	b=nXGTXmOKZHEfV+5eXKp23gn2xOvNzPsw0sYFNgHi5aquVK0zPFv61b5h90C2GkA9B7k9
	 DaTF753+hjYBz+9uDyzpR6p+1hHJjqkLlJtSl7D61WEJ7IE+tpESL5kKkB0LRzJUv+cUi
	 yln8WJ15JgZdh0Te9+wF8NR3ur5ZenK+Yyb+0dFx2+1wunGInxwV1NL7eg/tfbAFXak5h
	 LocB0V1Xxu36yPfIwqS8XVh1ocW4AqTdDkG3UIxCERopLXURYBkd9pHomYKStV09XxIv3
	 CVLJHb/ERd31pag8pDQnhtYyhilqo3tWo+4KGCGpd6ktCF34Y2MUSP/RVH5Y9gP8Otw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307761;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YtLuFwYMxWJ7OAJXryg93wJ6lZuv0XaX28dxD1Odvmw=;
	b=mTcIOdfTifxp79Af9j0vw2bwMQ29WsHhfc6DJGkRAYWABee7WWadMQRcP5r6Gi6oBY4D
	 b7vUabX5BbhgBztH2V8KU7Pj/FZrWJVZg5985floyj461+5LuYjmUkskZlTcm6C7wpMRA
	 loXF/iz96UcXSZE7Xp+o3PGxTBvmaN2/LG2IT5ovxHbzJ8kSM7c2PBNaTjYKq0f5T/GW9
	 ZIJ/E1/gfGBc0LXlZgu+Y5ogcTuXfl7jSAiH+KNlOY4eP4lm/ws4DjZyg0/dctFFnsdGy
	 1zONfqTG0xPgZXXCFIeq5mt51ZdnXvGy8RvCQx1bNEKWwgbaBdU4wR/JuB4jNXojfZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0eI2BTB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C74860A2622;
	Thu, 29 Oct 2026 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0eI2BTB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793307760;
	b=PhO+PgshsM8VWuwqWEplwnCrF6uoBHJJ2eaBqC1MP7EqDxKHdrC0CZDRo6TZHVpIHhAk
	 b98jZ4TFXx6VxxLwPg7JDflJNLIw5K63A/kw5/jRQj8vdk/3by0qu4BJMI6ZTQyUFWaqK
	 +9VUf9FdPUjno0E4rhcA3mWEkUJfO1LzrVKs0o3oyT572TOsVzz0J67l3yIPNa8/0lVDC
	 /Moqzs7wCNFEck+On5XmZRQqDDGRzGndHbPYUMNtqjiDvHxxKaydPDgznxssU7WdjAO4T
	 ryfKZVHOWBSZlTzrhbWOZFdO8bn1jdbu6himocBYON6fYv8ghx4MtT4r3mulmYbIumQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793307760;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YtLuFwYMxWJ7OAJXryg93wJ6lZuv0XaX28dxD1Odvmw=;
	b=gILWTBFgDtB0j0LhfKIL2MvA9hMQGakPzIUDW3uWz3tn+D2DHq1L6sA7eJH1H2b3VZOS
	 Zt1l2QxprJBjdiDxXl1AYaNvgMM8AlYjr6m2ZFVJua0zfmn+wAoahpjpk5CMa5WRuwTKM
	 EprwkAO80gpFwuuo01j2p/qsDGaa2EqrQWedOeoH16YD3MZ1QvD73MCTry2Q8DwgUGn9D
	 r7LSXZ1L7vGK6/iq4JERzp16sHJNeF1WeZ6BqIhySxf8VSCRuFLppCp1oWmsMBGv1ysDS
	 mr7HoDj/eMSRz3IzyHUZUGZ9SKI1islBNW+HajIe0m9PlQ+xjFmSVUaVHgvVdJEIZog==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CC9B41F031E4;
	Thu, 29 Oct 2026 21:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307760;
	bh=YtLuFwYMxWJ7OAJXryg93wJ6lZuv0XaX28dxD1Odvmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Z0eI2BTBVjSYJe8B7CEcjJTwa1W5rHFT8hMqWEmz4kKtwMcwYgZXoOfkU6xYOQ7bO
	 OVraHgZ4cRvLD7T3dqZWPW5DRb1PlnJEHl5rO0tYHBWvCSmw8DX+lWDV6qmA5rYNWh
	 wPSja3CLTGkrPk3U0KmbRlv6EblIuHeSHSkIICowdpdHHJNXlH6CdNezUYTXa4J9OW
	 4SH1SPrdUgRfhcWaMz/MfJcUsYR8ZwgLich90N0dBQxRrBreC6qvHbWtyGRZ/SfUvw
	 iR//MaLHsZdS+6a8PE27wuro/8FaAAY6Jv4FAwbpmcF5J1sOi5ilgc6zf1xHSTbiu/
	 jRwQFQQlPK0cg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 15F8D459D6;
	Thu, 29 Oct 2026 21:02:38 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Fri, 30 Oct 2026 00:02:39 +0300
Subject: [PATCH v7 08/11] dt-bindings: remoteproc: qcom: adsp: Add MSM8952
 ADSP compatible
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
Message-Id: <20261030-msm8952-initial-support-v7-8-ad748ace375d@mainlining.org>
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
In-Reply-To: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793307755; l=1646;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=zeeDd1bkkmg05ycXckrFpXocFkJ+mpflUejuSXRUXv0=;
 b=Xz/zaHwySF8MZHcLdtjCnwGPCOGlk5Va/CyP7NnKC+cPUAOh4vWj3bZYDBIt1BukXLjfLylf9
 cTIgP6PihNPAkVyzqRXtY1nosHzviH4zf451VRW+QiqlqlTHgEgw8xl
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the ADSP remoteproc found on the MSM8952.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  | 31 +++++++++++++---------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 7e8ecae8e6cb..1e4650aafa82 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -15,19 +15,24 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,msm8226-adsp-pil
-      - qcom,msm8953-adsp-pil
-      - qcom,msm8974-adsp-pil
-      - qcom,msm8996-adsp-pil
-      - qcom,msm8996-slpi-pil
-      - qcom,msm8998-adsp-pas
-      - qcom,msm8998-slpi-pas
-      - qcom,sdm660-adsp-pas
-      - qcom,sdm660-cdsp-pas
-      - qcom,sdm845-adsp-pas
-      - qcom,sdm845-cdsp-pas
-      - qcom,sdm845-slpi-pas
+    oneOf:
+      - enum:
+          - qcom,msm8226-adsp-pil
+          - qcom,msm8953-adsp-pil
+          - qcom,msm8974-adsp-pil
+          - qcom,msm8996-adsp-pil
+          - qcom,msm8996-slpi-pil
+          - qcom,msm8998-adsp-pas
+          - qcom,msm8998-slpi-pas
+          - qcom,sdm660-adsp-pas
+          - qcom,sdm660-cdsp-pas
+          - qcom,sdm845-adsp-pas
+          - qcom,sdm845-cdsp-pas
+          - qcom,sdm845-slpi-pas
+      - items:
+          - enum:
+              - qcom,msm8952-adsp-pil
+          - const: qcom,msm8996-adsp-pil
 
   reg:
     maxItems: 1

-- 
2.55.0


