Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793186360;
	b=t4l0Hqfx6wBFQbHZKIJq83pMkId90uuha86cq7OXzCR0rMugi6+WOgAb0NDegjAQtO7A
	 2MroF0Q9Yc2wJaWvyXubJd4EguPvB3eOwja+777apCMSF89E1grjUdGz7SFH+PrD/KrxA
	 0ORlRO/+JovVahpd5DF71GKhdBuOQGwxzPycvyYSY4tmfHldJPgIaqJEMgsi9iCxS7Kss
	 /1HjvLLkhHJbOxgulqU5VQ2A2hw22lSv/n+wMZ8rI1RzMnbl+cjw2EFyY6aR9QOVPFUG+
	 I+1okxxhvsIkr0hgFwcHv56TevYBCmtZrhFRSXeKWsjXOcPZW8u4ZGlIHOoPULLAhpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186360;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jzwLpiOCSTfk/iNQchEnSGtk9C1iLhHaOh/60qqYFLM=;
	b=SFYMCQwf4rmjVzBU64d+QSyacaRVE0Z11SsxZG+OGfpMcJwr7nxFAt8PNK2YNwR+WArY
	 JvkGEtXp+fHYMRfytwpmktzoGVL1BmrDJsV5WdE5OTMa176r0ZfIWTzs0UiyzDRyRUagY
	 K5FKk1E0kJ7F99nr8ihfZ8FClJxUJS8cg9VTkLwZbACi5FCGnO0AZuMW+DeZlGIoj9bc1
	 uvf3nWqMlK29NW2wuTKrXUWifrB1vlZjg/JE4HeBIMIa23p1rUk1xPAgskHGvIBsVM27g
	 KM28yN0p8p/PebPepzDgLvRqxs+8p3kYdJAoVDsniXgm8LTYz9V3hF/Yb4Tj20RHKjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpOkDhEV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52760A262E;
	Wed, 28 Oct 2026 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpOkDhEV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793186354;
	b=K9PVNlOfGqcUvyoe9zqNLBC7QggG06+jMtDsBPr+1bF/nUXssbiBYtSE2SoKhuyEQd4k
	 Rp1CCwh+vGLd8nT71KOR8O+sm8SBd7j+f2b5Rk9NGzUvaerEq1WNrVbS9yTQwk7BDeoNp
	 5HjmQG/PXTR2FPPfvSsctGMf/hSjPVP24YJDqbavjz4VD3ITbafmDxli100CthddIvKWF
	 g2y8cQlnUpavTNSukkclejJLq4e0kQyk3iq0J9HhIGyU2UCHRzIb9RffVmkujsuPPIOJH
	 AZszSQUQRI7qovRydKvPV99F3q0eA1CNXzwaAQRCBV96BfZUSrUOLDjBTdud18ESF/g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793186354;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jzwLpiOCSTfk/iNQchEnSGtk9C1iLhHaOh/60qqYFLM=;
	b=Pj9Jxy+m1i3r1r76IC010AHKMSynOesj+BsmJFcYsMjXqSZ8B0R3WsFk5EHguOAQyRVc
	 pi+v4AwFjbdwUv2qzb5GMKTUthhtKmO2lehZwoYxz3zRsFZCdemEYrmuUonPbQ39ziVAb
	 NpvqJFtagyUtdfbv0j1R+KSa2v4xuv2TyoQkOgUWaBwjI2hQidwxdwwRRuciqvogxifrb
	 RWJNJHyVb4fZhZkdtbVDtolaOJLTCMcb9tg7p43rJj7opvnPIrGAWuA432yXBb5m7NAcS
	 JJdVeq6Mvu/xqAB4sHkrm3PWEEMpyDgqcyPG+AWaPWRX95CYvRxhn22cJaD7Tc+merA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4944B1F031E0;
	Wed, 28 Oct 2026 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793186354;
	bh=jzwLpiOCSTfk/iNQchEnSGtk9C1iLhHaOh/60qqYFLM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kpOkDhEVHT6b3GUb4zjmi3EKNN+ip1054zBHfbT/f3XIlEYX/oppFIHmZrhf+xt2k
	 H0Jdv93vc7Lmwq0p/jPSP98IGaFAr9YxIMSF2BM63ormMYnVmS+RilIVhNB2DNx6O2
	 6YQQbujy6S9u9e77NkiEQrBetHIiZYyaTgWlrk4smGxyzbwcpvburB8i/aAvhGNq5c
	 oKPbFLbohk7C11S9XiaQrZ02MQ5wbqlt0ADa43gdqCCqlUVpJWoDcRMoXixygl2ZlC
	 3MJgZC4pw8WmOmhnKtpBNlzGb4qXs1euJUTYWTT/IYq820fojTaHs+xULjRUL6XL0d
	 eEivzdheop3xw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C65944541F;
	Wed, 28 Oct 2026 11:19:12 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 28 Oct 2026 14:17:23 +0300
Subject: [PATCH v6 04/11] dt-bindings: sram: qcom,imem: Document MSM8952
 compatible
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
Message-Id: <20261028-msm8952-initial-support-v6-4-e07ddd8bcf4c@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793186351; l=753;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=fWLPHUaLL+KMkAH1bez9zdhhruTHKbOtePm+HR+NFJk=;
 b=sLRVmeO+li6//eZZgDcrq8uO+fGvIoyj5+Aat+OqLWcWhq2MTixQ/RDKF5Xjb2lVfi8x5CTu7
 TDxOeHVHr0sBewRmK4fak6BCzVBDK8ijamWnqH018AfRLrwQSeiF6ET
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the IMEM block found on the MSM8952.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
index 2f120376a8f4..5d7b226cc587 100644
--- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
+++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - qcom,apq8064-imem
           - qcom,msm8226-imem
+          - qcom,msm8952-imem
           - qcom,msm8974-imem
           - qcom,msm8976-imem
           - qcom,qcs404-imem

-- 
2.55.0


