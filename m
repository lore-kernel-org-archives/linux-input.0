Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793307760;
	b=Dvh6zo0hG0JRhHGsIyaItwhh80kT7XLvJWuGujW9CXc4kpOW1UeWKKb5miIw5tNtMXUy
	 Wd3SZw8jWbOj7hiroUrLxP+77AOXN7u36AyxsMO+jU7XLLYLPIxmkA+KeK68qUNqsJtlw
	 EdDlTSRdhE2/qyRmODVq9Tklf7L/jN+1Ma4Cymadh44EedNXqPxf/jbUQbyuSRbLO83el
	 SuYifYbu3A6S0CduARONsoAa8MPe75rdMY82HiWyWTt0J11HWxsb0Wpn4EXFaVkRNdUgx
	 eogDv+cMj7y3GGgJ+RYA5xSdicJorDZeMYZ41Qcw2NxeARTQd82kb0ytxKMBbsXcT9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307760;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jzwLpiOCSTfk/iNQchEnSGtk9C1iLhHaOh/60qqYFLM=;
	b=UsL+VIgIWWErnbA6wAIJsAP32O1bxxC4G/AEE2AXTQyuGaehBYMWR6rMrbw0f1OYzx7d
	 3FnIdyEp4aeSBAoqZ+X42/YIbJvYr7iCPAs/vNI90A8vJhycfTAQ3N1p7nPzOHs4caJIE
	 tnbxpAANGnWfj9bsbN+apCuJXnbaYT8l3rcRvGRbP2yc5UIz8QUZWWrzpO0zUKIR2W0VO
	 Pa76Rf4bNq9PZVDyV+Rjx6pkreDokskyfzPbS3RqvvEVYJtE8pSLgFHPa5xgwqqEHk6OO
	 dJWTSGamCqbu0kY/2/oEq3UpQBtePsELr6QJyU84/AeXWAfj/ZTh5hYwfUqaElv/QTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ub+T1fIn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1264606A31E;
	Thu, 29 Oct 2026 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ub+T1fIn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793307759;
	b=WzeH/57JEaVVhhLdEWmKsHM/l3b5ASaCyICJMT8CdNpXCplltcvHX3BfWKrx3cydyNzl
	 U/vdjl99myo4mrutu2uplLilWSdGwlbZrIdDrscr96YxMPUQaCamZlQ9oGZQnG8lNkghL
	 +dE73Wt18P6yLoE2KsJRrwmgozX8DmLubXzwRWArnQ3TSwR3qEFF0JAOvgkpHgRH/twmY
	 sq/pV8GMTpL6NC14bgMhES0V7arl6HDSPyLZ6sZw/AGkZhzCiDw0Xe5RMsPKO3aB6EJEX
	 8x47mNr6G0kYlHu2nRqv+dtB4al9vI6c/Cuqc3BV9EzpuMr5VwQY8ZCYvzQiz4V3Sdw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793307759;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jzwLpiOCSTfk/iNQchEnSGtk9C1iLhHaOh/60qqYFLM=;
	b=rJNvV19XUXn3RDUsSV82ZaJ2u80Z/WPW8fmgpp/2WkL+UEtk1qcGwRxUo5jwMLSN/DNY
	 XQ0KpyPkFR+91PjKWAjuyiLa6pNJXeu9gi4zPMwB8iufVmZD+tu0RLVCBA34eh71i39PZ
	 8dlRAhLRUR3mo0Byx93H0TEEsJkPgr7ij/yI4rmr0UasYrTrzlrqDJniVmGtNJ8kFfEv5
	 zCM/1yL0g10VnhsLM4sLiMeIt/wZqG2X26//BqXx3sKSqQNmKooFR2jfajLWH6SzwlxZy
	 UuqKYHGvKvRc6qqCzo/BI3qV8XQoz2XR+jTTjSOCSRfdyxRaCejkU+PUgvaEoEo3g+w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4FD9C1F01829;
	Thu, 29 Oct 2026 21:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307759;
	bh=jzwLpiOCSTfk/iNQchEnSGtk9C1iLhHaOh/60qqYFLM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ub+T1fIn8jKwlYJ8nGqyWTVm0NxrYuEmL1bV3OcxpREc8g9oZTRSEEsZL0PDjnxjd
	 YaowRbpxR1hdkbh6WQpF9ziDENRvTvGY+Dh4ViwnP1kxkC0iHUYsaF0L/pqSL9KtzE
	 yHQEZdS0w5dveMBW5bLxoSIUsBVg9ATX6wvbAKY1AXv+eBML7ADaETwWlgtQGjGOUG
	 fqfWbGjssf5+GMSNF/Eeahp4O58o5NvzNAvC3E6d/ITfYIOJg4P31JTxqHaDUnWNce
	 wwUpbuH0T8wulAsr5XVFdCtmAhd+3pYnl+oJcElZZInEwbcjyBWT2kEqFuYoc+HWVd
	 +i8SUqlO+/ZBA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C9E08459C6;
	Thu, 29 Oct 2026 21:02:37 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Fri, 30 Oct 2026 00:02:35 +0300
Subject: [PATCH v7 04/11] dt-bindings: sram: qcom,imem: Document MSM8952
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
Message-Id: <20261030-msm8952-initial-support-v7-4-ad748ace375d@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793307755; l=753;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=fWLPHUaLL+KMkAH1bez9zdhhruTHKbOtePm+HR+NFJk=;
 b=xw+TT+7+zOCTDns2G2gQaPITXt73Zz3pBMnredH7gp1XwC5vHI/r6ucIf7gY8eFIFyrHn0Q0W
 7ovZXsfTkc3CmEZrh2vRCNNDsEtT1cvxv8dKhB793iT5cRiZBqTizZS
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


