Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876105;
	b=nvqLKPJ8ZojcSkrgfYlvbvPT+P5lEfRaW+m2V3dN1M4DrUB/tRNHD2f3urg7SOVPJOB3
	 JSMtOAbJNJDro6g6EUmkX2yVy/bXc8A9bjWKlJbPqW6WEQjN6eXjLOSnxxa+0yyo9bs/7
	 Mnqqr3g+T6e7f5guxgqH2oa2bQuyBODS8kjSVAjPbWzkJstI71W8UUshWHGm3VdeQxPtn
	 jutDKOiiwMKi2T5DGF+aGI62Q8ONcfO/57qCYsuJ1Ncmi7nffex8T6L2v3umPhb+c3WTS
	 KiCNyyzsIX1kworpp3E1yf7cFSymOq6DbtrWoEgE3zk4wr111069INv5TgPOgcRuYzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876105;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vrbFmRHg0Vwaa7wvCtJ83s9ZBgrN+iwSbrevpGKdNvE=;
	b=eArZhpftv9sZzUFPBMG4oBX0Dy+7xwoJdQAenRlhp3ukHGujxIb9eWmLD5lTYYTSbYXk
	 1WTHl8fMmYSKs5i2nnA3k9iHvKI5lKj5kGfXtmEbIInIUE8GLtlQ48XFU4bwlynJEbs9J
	 vm7ZVoXo0puXRYHhg9gEPGoCO0wz28GrFGeAV2jW9sh7YyVcBSTdA3HNme7VoTdEt3/gb
	 U5hDVhBqjbJqFyIofltfYisTcfcHRtqPaC3BiU4PdZiprBjsNDXrCtIEcErZN5tUZPJy0
	 aIonF5B8SQmCHdknef09CwbugxJ/PFzpvsC6+IZNjqxP8OMGKUvhLah+JCzlKATiC+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbXuMzoe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933B1606A329;
	Thu,  5 Nov 2026 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbXuMzoe
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793876104;
	b=gu9rYsh6ltFvfJ9kIOQaXz5TfHoAokbA7Z3+j8j1+anAj0LkmKzBW64jTKkpWzuFXeIH
	 alRR0prrODdBAmGi56FORllVYmac6EunxH8hiuoDTrSH43hSypI0RyN3tGAmlnfakx0+C
	 Weu8owrJgFVt/pJ6vfQ/UocnQyJqTrTkUiWDUBzqdyb3PNAXhE1IA4RH7JAJz4hlomRy7
	 TJ5x6JWlUVhyxup5s2tN3Io14lhubAtAE1MGGakVQeiBrOWE6FBl3MmMa2bHbchfiWZkf
	 38lm8S5RhZT1HXbycntsxrgLf3Pn3UrssdfFmZP/jqm/mqwXjvyDxjceUqFFirffHrA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793876104;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vrbFmRHg0Vwaa7wvCtJ83s9ZBgrN+iwSbrevpGKdNvE=;
	b=Gk7N+ifED987xcgbZALAXQcc5YCeSH5j9S/+/GTAr/+0HVoQdr9iE3Z2SBSjNDxl/7NS
	 sTdqR5qmsRmit3snDhFiHSfDlS/wV4uCUYUGvhr31AGaboLsm7x4mFINC/pHZA0PeFLJG
	 G4qJB9lPsLtmvxr1sGsLbuwFBlNm/I6IbJtDMOj2de/bxDecaQFCNNK32Cak2PM98HGv+
	 +W4aaQcuKS9X4pL/usM7s08e3C4w13BWOJmAtwG3Qs0jnNOjLnqBN9Ru2nq4vGMhQnyBR
	 cbEsNF00qF90hAPEFXaG7XscLgb3HsX/CPAuUbz2+heHkGWbFo/ApGy321JZpEzsw8g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 820111F00A18;
	Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876104;
	bh=vrbFmRHg0Vwaa7wvCtJ83s9ZBgrN+iwSbrevpGKdNvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CbXuMzoe5qU+uDFNip+1wLfiN8y70+UZhIAbf4BG2nkWV3I+9szWEz0mtsLevKdkG
	 FyclFAcx7YjmAbaGaznHYS9d0NI8NHm9PvqA7A7wItZ/iOLpy5VMreSbqBDtPjR/zA
	 3mm2X6TNug8j2K/DwsAvhKAgmEatuEf1Of4B+61k0GYxt6FAHN6VwX6BWpOY0H92dq
	 7BCuwGnV+G4lHmsLD8kdZyrw5ijAaVB1lzNZedw7UfnUwQsuOh8ZWX3P/8yu9JbRv9
	 eL4lnHTxoAyCehkIUpDrpVh05w1ALx3bOeXIzaTkErJCtcONuRO1SJCiWCqohmioZf
	 ykVVLIpTzXGMQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0EB22471DE;
	Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Thu, 05 Nov 2026 13:54:06 +0300
Subject: [PATCH v8 02/11] dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU
 to SMMUv2 compatibles
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
Message-Id: <20261105-msm8952-initial-support-v8-2-311ae8e8f14b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793876100; l=969;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=kpqMYq4BzsuyLclvUfDPu/lZin8icjEat8+zs0C5qZw=;
 b=9WSZMwhPlP7hXbdYUrdG/vxs8AJkxR/4Y4m+tW62ZnC+XgNTxbi3GIJZbQk1BhG/fe7KSFTLw
 l+RMCYRa2YmAT8BGxEcSw8QXMEyotCg21ySNJU5Y3cqphbNMnGQWJMH
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Add MSM8952 compatible string with "qcom,msm-iommu-v2" as fallback
for the MSM8952 IOMMU which is compatible with Qualcomm's secure
fw "SMMU v2" implementation.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index 93a489025317..9952b9da9a6a 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -27,6 +27,7 @@ properties:
           - const: qcom,msm-iommu-v1
       - items:
           - enum:
+              - qcom,msm8952-iommu
               - qcom,msm8953-iommu
               - qcom,msm8976-iommu
           - const: qcom,msm-iommu-v2

-- 
2.56.0


