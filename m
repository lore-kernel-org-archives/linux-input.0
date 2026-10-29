Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793307767;
	b=LvmxhgcYVnSDuhHvtaJulYDNCBTeqMlA62s9i1v8CVVKq0cGukG2pBtpKC8B5e4TEQBs
	 EfXCRC9ytuxGJz53wc92oFXI7StX8eE03Yss8yFvDs68aoiObsKZkeFhrsNAN3R4Zwxzh
	 SGaM2t4p7JgV3Sk4FDEgG/x5CbF6CfaNZ/JReFccFwc+ngR7xzfySWeL7OuDZtIweJ2ma
	 vaWR5kH/TLeFDZL0y3zWJv8OPBxTF08zaCnUiDYGr6S63C8bvmv2OL8y+ovIEkXyKVPFL
	 cHcoUx6DQ1f3Jnb8aOUJzbWMbE5Tjg5QJZ1s0wf2kilHJKc3fMvYqCZPku11HonIrNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307767;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=w41sq28x/ASq4lXyo8/BhZ5wcP8Nly9VwoK1OLW/Pp8=;
	b=5ZSKgxWJsnkI7jhGQnihxDquCX52XWGTjLz7v3Fw+2uvQLYixYylRnvvPvJnqiwUhJfK
	 ZMQ7fG/bHv8JabsAJtFN1Z/x+2AmIO+7zt7p5Kxj/DetJ3coIl/tvLA3sshnjB5HUnbWJ
	 CqAY6oN/T37klTnAyTGPzviX/aDgSqIrjhjveP1Sm1YN+gHPlbm7gwWWodc4XZDXI2hob
	 Ys4MjGiV3/LTQc37k4PZORephgeDJBeqV4DUxuP6vIt/+xbnF/4nx2paFos2fRDKGqAoT
	 7GpMKSVAJ65e+K5aYct7OgQ2wREz06MUvzMDqeJBIBG830oN1r8wLtzsMVMFwlx+Vgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Orrk8FxC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50D60A260B;
	Thu, 29 Oct 2026 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Orrk8FxC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793307762;
	b=CrEiYe9583yQZ6g8kWuM6h4hLnWw6W6h7FKk+UrKR24EiuHTM+tIAwMoTfHFK9ZkfhQz
	 xhV6PJvNOkb73MDxoORr/EowHvBAKoHmsZpDGbPYsLxu8hH9F8ZHflnoefMqu+kjblcB4
	 ICRaq+LQH0fmMlpnaXnlYMJz5j9xZjSIccErlVY9/yzJgs1MaUk0jbw1IBN9ojXwYychx
	 pJ+6h3AkJcypR3U/+KCRtSygUX5IGxlIqe9icEEVoXVgST3ft5dAKstJdx63u+mjiPluJ
	 02R9ik8LVs1qkGz33VVZKEsuV3EnuAgAVRV1yO8FC9YgWnJVf5TX+ftEPUnKzGL0b+g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793307762;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=w41sq28x/ASq4lXyo8/BhZ5wcP8Nly9VwoK1OLW/Pp8=;
	b=uK+gEhU37dZ3t9Q6XSA/Xzw8ZBVYF0P++6rb6iLBBKlDNuwCn2vikPgzLxD7ev/BoS63
	 WHxjVDpolGeb9mG4+xYkMHAOQ3eRh+cI82EIZQ414AT5k5RguU66JSsgu/bT6H1+0JAqe
	 R7SNYjyz2f1VHHIk2TI4w/iyk8DVKUd/Hwzfn2njNfTB+T8a04z9TnwKWLkarRCnAhfQl
	 fLY/vULIv9AMXOFdHFJK+7YPrjXXyEsDQoUVGT7MmMHa7CvQiiD+5EFdglaG1Wp3YZjGV
	 DiRpRAEESulv9JPku3iLovynnZGyCmGeapys0hHvECOYLeusvTuduS9qYSO+F6xfA5g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2C06A1F031E2;
	Thu, 29 Oct 2026 21:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307762;
	bh=w41sq28x/ASq4lXyo8/BhZ5wcP8Nly9VwoK1OLW/Pp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Orrk8FxCJocyKLi8FRsai06fgyaLKlitCXzV0JGryyWT6TuXkz5dgoa5dhKvX8BRG
	 b7EDSaqIbSfYIcKQuj28bEknENtOwdhZ9iMTyDMYa2M7TK8ACosB129NwY2mJQG5Gj
	 YGxKKPGWn2r4xWuDJgj539wHN/cJBpnWx5Kb3HcwSIXKisQh79FMKsRoDluwoNLYPg
	 RlA3jNgMgnFcLUEXeTdbeHHQ3/6zmY+QmC9yqMJpu87QgfmNoovw1g8RMAKBeuWfXz
	 l+zv8gpUmwH4y8C3Zn1YsleWoRnF55QauqQGUKPkIQ/q7gbfiYNVSwa0I1ln6MQK1L
	 S052DhEksGIWw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3836E459DE;
	Thu, 29 Oct 2026 21:02:38 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Fri, 30 Oct 2026 00:02:41 +0300
Subject: [PATCH v7 10/11] dt-bindings: input: touchscreen: goodix: Add
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
Message-Id: <20261030-msm8952-initial-support-v7-10-ad748ace375d@mainlining.org>
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
 Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793307755; l=1656;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=WcI6NF2jH7/1jsgO/qq/6GfopHH27DV/LBlXLYlg2yo=;
 b=KaVq6JMZuo3i7wkTjbLJsHd9Jmfne5+q+ucL4Yn9K7uwr8fdG/0pQ6H8NdBv0fDg2nySA2G7s
 XCRYwH3A72GAEr18ksMnVvsYSFPJtptrjY7nrZRMU5r8xHer6DbMIDY
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


