Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876105;
	b=NknYKDf6+5AOEk8nfqGiZPk1xWEdvdQ4mqFp4Zz88oP0h0sgD9U2Mi1pwSf7zGg3YBIH
	 ivxCOTWGE2Vw4HHsfRpgbyAM2gudws8xMCZbvK4JEREKFDOdeIBc6Ecl9iomVUMNaXK2+
	 PQOe7FdvI4AyLZNh/ISxqz0HAXt6jW4wTKHdc8EYHF86snudRRiec/JKbVq/jd5zIYv32
	 o+i2oJ88BGyl0DI4QyN2QHw8C9Pyr6fTk8PiUcEIG3ejV/AtRYg/ouxIc9ZVcnJlKx/WK
	 V9R0PMHNLjUqmGHCi7gqTWjBCUgEXiK2k871PrDtrwr0Zb1JwVhE+fy9AQsvzyRG5Zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876105;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0Eo/flAh5ZGhOeGiv+neAc3dXiHz3sx2uOGMjplfqp4=;
	b=NJ4EOZsZP2Zy1K1qE504JS6afgf1tLstneNvRr3kBbLONM69P+uvajU3h5aSBr7H+RSk
	 tgQR3Z7LMps9ftNEHUFkRhLsvjuoCeNMlnqN9VNcI8ri0yRkEEzGcRlJ2bgq37T4OYesa
	 WZ2GtdNM74twx4llSj5dy5eUSetURtcOl+ffQgx8dCYsvzgR/tHtrRiMnWocb6bMpAzio
	 HO/2UhurxjzzjnskPgTjDls1pQgDGfOLQplj2MWrVlpVVH6lMi953YVsu2CnXDa9XpJxl
	 5xZuevi4UUl8FEt+Ia97ReHrH/qp5mZQ5WHG506GQRvpAp1w/Iux9MHqXIhc1FEJSaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jOx3uC/b";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3387F606A32F;
	Thu,  5 Nov 2026 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOx3uC/b
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793876104;
	b=uxB+ThI5RbP6SqHUUPNYZ8J6TZIjzL7nR99YnIpUptij0b+RbPvgC+5vUnZJQk0dPkpw
	 A/0UO7+f2VNsfimUlLq33Ytgu6rHNpZdYQaZGH5DfhpSiBP+tARZYmVkVxC1+alLRrEqI
	 9snOqbzwbmndaq70ev6EdVd2rrleOdJJkJwmCNtE5Ilom/4Uolp9srIQe56AVmMPN81Bg
	 S04LhDQszrl9l62ABypYza2bRr0Pofc3Ru+VgI1m7lQc7O0RjtI0mS9DJEbR3zIeqCgxp
	 4ib1eb8J9VOM0AYjGItgThGj09XAqmSR/Dwbsul7f2C8tFeQA/6YJUju2/fftL8KMwQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793876104;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0Eo/flAh5ZGhOeGiv+neAc3dXiHz3sx2uOGMjplfqp4=;
	b=q9Fc5FEIlLvH9W/Zcdmaob9odKEGWScNKlry5caMQkl7i4Zuyay/ygmQHep2os9Zm21L
	 FnfpVuseuE6og/6i5+sog9VGvprvtJ96440+nvy+4YjVL36+8lm+jOT+sSnHov8HQpk2b
	 7ca8MA5CM7CwT7KoircdhsddtlnRUHEP/vcDvvOQ9GrXNBi7nE+RCkNrU3Z7ZXnY2IHvO
	 tXt3jNcuUF0V5pAo1E3CEESRCvbs9V1CeahFRf7Qg3rnXzwc0BnmU2MNiq97bBLg1INCj
	 o4oj/7QwKPEFS8K52EHpkoLBUJ24JCIVtmM91wuRViEGrX1Oep5GH3EPeyPHhAH8Cmg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9F0061F00A1B;
	Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876104;
	bh=0Eo/flAh5ZGhOeGiv+neAc3dXiHz3sx2uOGMjplfqp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jOx3uC/blgpeK0cwDpak+L0fqzNPwZUDCnTIaEHh4FdmoE9lnwLNQfLWqVQJqbJQw
	 cs2SDKR9Y9OUTEuxMIoOutzIWeK77NBvYOFvXeYpFK7mNMcIl4dndeuGsBnLy/duIm
	 t17ZJ/+/iXAxOmKTJnDb7lng+oZnl0GCvnEiCgG3s+vLY3l/vdCaFCvIjQpUoZVuyS
	 OoDcQ6CWXLo6YyxJ+KAPAKHdfEbzgo19M0hiBnc9WfIhM+uQid5TFD/c6q7NhSXrbT
	 ThoIbGzhYkBf2KlQDmehSHl1FnacAMNPoYPIWt7sStV22bwD5hlzbAMfLpeZSGutlN
	 Ek5WiViiXbSqg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2CB51471E5;
	Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Thu, 05 Nov 2026 13:54:08 +0300
Subject: [PATCH v8 04/11] dt-bindings: sram: qcom,imem: Document MSM8952
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
Message-Id: <20261105-msm8952-initial-support-v8-4-311ae8e8f14b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793876100; l=823;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=zJBupVape6ZlIyOXe+U5V6odCjgZTNQlYKK8oIpndf4=;
 b=pylaM1buz9GHKjkj+t38gaqW0b/RagcSeY/h2pJ0qZqu07PCgfSW4HgP6imZTPGcMdJNPilTP
 V+qNZ7rKygKASWTIrmGQbXEMEgcQpX1GAc+QTkW28dm879HMX+16Zu8
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the IMEM block found on the MSM8952.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
2.56.0


