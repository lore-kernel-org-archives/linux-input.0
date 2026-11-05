Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876107;
	b=0I3UJlmv/g86QJxpBMtuJoH5vQh902J6EvjVeVhAhdL1xJrvaSx/32OzNVJBd7ENDmyF
	 gNM6sRhfNbYM3Wov3cdzYhuT8Q0GJ/Ahr81Kp3zzsecoJzK+5wv3W+dsWNSAMQLa96FGh
	 OAaGxEs3kQba9CuA4j9VJgSLDZFrScjqGO5F0Wxtb8ttrno/Qcc8tlCZfGUNMyNiQ0jS9
	 By+9QHr7QCJHnWI49dUR4JA79+SgzUhCdcj7yNlmYOTWV7s++F1yx87dVuXkjim518q6z
	 RE/0/hmLl0rtQT4BDgelc5CpxoyM2eroOOUAelqe36mkJ5iGe+GcAGoCbJKRCrPuj3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876107;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lWMe1RAYR94lI6AVLaNRykGgNbx1qk1GymPgorV116g=;
	b=vv6H1LY5k82+0cr4d6QHdL61/kEuDlsE8sJTs9HY5Xikf7/Kx1/SVMP0gQ6SgAIQd2Hq
	 kwnKQw3CDHvq7VDoAhnh9LwJBPzCbcsM+hV7Ca44HXJmVYRJUrH51MLWJvnOYTFH/pSr4
	 2w7a8Z5V5FtYGdIIxyVkt6rDSu/ON5nJm1QiGsZUJ8ZdoPgTnV9ex5/LP2XJHbiPjyghf
	 FBEt4NCmGgGEI15klhsn0EFs8QXJ5Ox6DYG8mgN63we1cxGKIsZc/ZWd6nxnymWsz78v/
	 PVrF15hbaCqH97agi/1RqC4UT35PKXGCKHr3jIkCNMVymgwmeZNdLvf5SN5IDT0IYZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZDORVLc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E926B606D82D;
	Thu,  5 Nov 2026 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZDORVLc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793876106;
	b=DwfEv9u0PjXswRrepu9muw2Ice8YYykODlGNugODhQlJQ90ijJqTNd9jGnopQkhjn4DO
	 8PHgBjsxUlg5+VdryEZHlqX5jka+XJK236CFd0nqKoFz/DKiTmUcWPVuBWbAo/nz9m9c7
	 S0G3tLqgCojl5Pp5NzWMc7ZWRaptFOXu+ho6Zi9M/+1JXPcheVcDf9VW5xLWpF0BzFA/Q
	 zEFjOBG/jEN9BelZqkiMr9AXbKtFIUNRenihPdtDc6627YTYJcSW7GQm7diDSmGucd75B
	 nOGa+js6T1P68ZYRUdEh0vlhQHNlMItM83ZI6IJ1K2wbbsJJ1aJTPCAStvptxLE3fHg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793876106;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lWMe1RAYR94lI6AVLaNRykGgNbx1qk1GymPgorV116g=;
	b=j/6FVC2ocZPwujy4UjUIRNB89fp3I9SaJUFVDTvdNjmknoTqVpyi/6Chw7njVCNvIa/6
	 Uevd+OaQc18LOc/BL/gkJNKNxQnBoCsEYBp4ViijzvuQpoLSH2aX06qTXiv8sFe+KniFB
	 AvAakleTlPlf3roYpqbYe8nY74dBeu9xmNsPdx01clVUhlw654wP+tY7AN7gcWMOmD6Dh
	 jVtvi6QipSwCD4eBzuu095G0coOwRfZZHu1nwdTjBQPq/QtUFnIkAZ6wMMgyv86W1iUQ7
	 M7Nfa7MBZnsndJaUuS9PZsvDWVBieEbyAKbIWulyWDdmJXNet9RrlTaT7fSVT7StGDw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B41851F00A1C;
	Thu,  5 Nov 2026 10:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876106;
	bh=lWMe1RAYR94lI6AVLaNRykGgNbx1qk1GymPgorV116g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CZDORVLccv3GkYb+FlKUmt+7UwQQ5Xug1ZBlNr5tfvAKllxSaaAc0Ls3fMbeZ7dz/
	 3ufpzB6LPNMUgkWo5joJglJcBxIYAO635M+bxT2YNugNQ3A6aaQipjnxcBwqjvsuK3
	 cRPyQy9K1OWBOtpPijr9hvg0tLVqO531HvEUiA0ZdZRJ8HgPfi+VJIMsey1ltYc+zL
	 8Bs7jBmi4vDdOf/wQVrVm421oKc+vAY+wC0CSvlBzK2lGdyWFxc/0Yf+99aDZiPQlD
	 XmuKd2QKXdzVSEhMbFOX9FiOnJnH+CsDPC0uvh03Lr2IO7YsVbQvICkmRrxCZT/Gw/
	 7gREOZ18cpyWQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3C5CF471EA;
	Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Thu, 05 Nov 2026 13:54:09 +0300
Subject: [PATCH v8 05/11] dt-bindings: mailbox: qcom: Add MSM8952 APCS
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
Message-Id: <20261105-msm8952-initial-support-v8-5-311ae8e8f14b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793876100; l=1080;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=bfllieSk1x0Zo8xBxn5AQLJBSUyzj9oz9UVJP9mqh0g=;
 b=BkAVYp5XLBwZyWHx1KKefdibqr2AbuR9S3KS8apAEHWwlOLenggE8vmJHX2nGHvRnNLBR5lCl
 uCnCOobkwloB6ROYUhv64xsxDwEmJfzg85+kFQwmZLR8knu2LKWkR7z
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the APCS mailbox compatible for the MSM8952.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 5110363a0717..c2b0d7394f36 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -31,6 +31,11 @@ properties:
               - qcom,qcs404-apcs-apps-global
           - const: qcom,msm8916-apcs-kpss-global
           - const: syscon
+      - items:
+          - enum:
+              - qcom,msm8952-apcs-kpss-global
+          - const: qcom,msm8939-apcs-kpss-global
+          - const: syscon
       - items:
           - enum:
               - qcom,msm8974-apcs-kpss-global

-- 
2.56.0


