Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793307761;
	b=3Ktt9ldab3F5tUsMTBHqonA4lii/9YFIOruY6/XuITAG1/rJnSrvzHeFtkvCCklikIIG
	 UDhoEBv8PzLO5DwzTno4l3qCuPRPRh0qn50vKG9OyDWp8YLji65rDHgLvXHEjdkPXZoSC
	 Yj3dP61fKNskQi7h56lsDMseAojyjQrHiM4os1gFn2jUdiZv9ujYG6V6w5dOYIMsB0R/u
	 8Ne+kvpoSxg2beIwquNJlUWnlK2SNUfPh5Xyt7K21IEBuJhCCdiFrIgLNPLoBb2bVJKsb
	 xtbExgLS0wcbpeUqTyJhTvXGHoRxinrpLqxLf6TWd1u9RXoci7vuVctsN6EsQTMASXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307761;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GChhJSELgzTv5vQCl/oyU87c2jYGiNk/WOEVK+6uib8=;
	b=VB2ZZS3LHjWrqe4gH+BKHLLlRgTnpWEO/4rWhw+xE7divaQlBDgwo0vw/IHNYn7wVE12
	 oCztF1N73TXRoYi2BCUmX/INWpoAhAwQIVqkb6yKTtDVifCK3TqIm8Cej9svEYfmODaPF
	 Xk064REL3PwNzuMhgiVJ7+/mQ93JUxV2vq2wALmqJpJbbRBNOnGKEqV92iNkv7dWCS/MB
	 wfS2aP6v8TOM2c1F+n7BQaIOTjtVNTn4oXWPZFEPtu3iLWwSkHiyqnNgYgU+DHc4AvjdY
	 nvXj+HkQzpwA0UYtSDRsdh3NiFffQg95PYkxpSpZuTD4zpudXURTlfVEAFNYI14HKqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a/caIvUp";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB33A60A2610;
	Thu, 29 Oct 2026 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/caIvUp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793307760;
	b=WdOri68F9d3rMytJIzMxR5MrG7HU3cGUX7k8q58SkHT1doHuvVlL04CERk2EbngZvAC8
	 fNkrWNoc0liOzYaPSB3J+FcMC1UFKvv477k/QUo8nZxzY6+5BaHLfIenmGPy21mXshFwl
	 84qiwi+jUO1bHdlVdi2NmdtIWMDBCaFwK2UoVqZnjJoThl1/TsObCwR4GF0JgXGqI+wl7
	 m39ZmQmc903FQcmQgx0jTxkW51XwYjUY0n3mkcvbHhV7Rh8aia0b5bChwUBG1ZXXxNCux
	 DAcgcAczokXYb229HQNRS0xD/EZMEy+YDtZcHFBHqearIiNOW5fl3V37djaxtomq66A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793307760;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GChhJSELgzTv5vQCl/oyU87c2jYGiNk/WOEVK+6uib8=;
	b=IJI6b/IKWzTYZhDfrThPps1hZePR5FqbzbfXid3gS+bIRwjGjoOJdXZaodvdIbsu3t1G
	 LykaOzacSveek4ZtxjDtTaQcpILHT3Q50En9gzMz41ui8u+28qqjJ3HDTbW9YSopg3uvH
	 wU6tK+xB2C/BnEzyRtZccMsyxtvXSJ1uAgcwAPgDsW11+LbQNjKhj7oa2t20zFbDzS63C
	 Za39tplHf191gDfJJo7ljIpHRcfznRzrML3On0UgDWe6jCfZjMEPmzjdSltce72AyHJx4
	 VMRmeoHU31FB5YHJestIIirewrVtqbXjSgJE5QcE5kgakNvBBYa31rvaIad6w8m8LTg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 68FF31F031E0;
	Thu, 29 Oct 2026 21:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307760;
	bh=GChhJSELgzTv5vQCl/oyU87c2jYGiNk/WOEVK+6uib8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=a/caIvUpp5fKEhGcM+XowXJoyfLmM/f2iPygVOsCArzMxorojPREDxTBXFTGuQ2TK
	 aHT/PtGpygxJKEdd5HQT1JbdjIJGgKAPa9YL3hWhwgP5LcGmz7a3Z05nm1WcfNHZL7
	 4Nl2GBTUyK+PEIQBO6fFq4FnCk7w//NANCawrYcOUTkSzeD1nEVGgP8ZrcvkGyOZjy
	 0BD+bgRGckcQv+ARO9w0UBbSdUTp8jR8/fZWH/OS0DJXxuW5k3O8p1hj76Xc7EpnrV
	 kkN11v/uGbMF3bhe4bikHlIjXmielPlo89uJIG4o1swu1x2Y2PPqlJwOxOExyqUhUS
	 qq/qYN5XZEhvA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DAF0C459CA;
	Thu, 29 Oct 2026 21:02:37 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Fri, 30 Oct 2026 00:02:36 +0300
Subject: [PATCH v7 05/11] dt-bindings: mailbox: qcom: Add MSM8952 APCS
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
Message-Id: <20261030-msm8952-initial-support-v7-5-ad748ace375d@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793307755; l=1010;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=4SRoaEV+jb2+MQXKbteEPlFA0htY5fjMkh7Yu9tlUFU=;
 b=GSlrnEDH/HdsblcuMId71T0U/Vhsgqi0l3X1hKYyZ5jApBULVq1Goc3llScKOLYFV1L7qz0C+
 IVF/W4FdEBSDpB4w2PrshJMXRe+x44GYx/griiF5TCWjdYp+cDd5Bdy
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the APCS mailbox compatible for the MSM8952.

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
2.55.0


