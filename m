Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793186356;
	b=q5/VM+HYPN1t/7S7wjm8GsZCXO43jb7kCYAm80wPHm4mNKdyFZPJ2u9aL+k/NaCqA9h+
	 kdn/B2ZARgLQzdjbtWjAB7GxnGVEJuFTj2WK3gI5HK2uATel4uv6jn3JKCFzUc8QaESTn
	 hASlE4aCdhhEMlW5TQ42/fVuLelzi/QW08nqJ3R58KCrRQFIIaNRCUAC9frV1b/XBGN7u
	 cNXbuD0W4g8FVlruzGS6lIEKLwVL6v4BlLuZA3CUi62eOnNMyPLSX+yfk7SXGX+dO5F5b
	 bZ/W8/0k+hk+9GLVjG5Ijy7pPlCCqvnVBU77DyGThv+GDRGRqoAA64b1LHk4GyQA9Xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186356;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GChhJSELgzTv5vQCl/oyU87c2jYGiNk/WOEVK+6uib8=;
	b=fcRw4x5101eYfXqAnBsXMwQYp6vOiM6bEm5q9xEwjZ5pomJv1akZ8kURqWkRzeVmUKK+
	 yQ6MvOQAfwlGLdkCcmuh618T4XQgElYbfHnbMdMh5dBWl5prDPyxsLpC4pxW4/Ltra/yy
	 bNIuU+AH8ER4pPEJGY1CYduUo2411O565IwKRBHvYMjTsuACJP2269GbSitAB1J5vsPq8
	 DURWT6woeUyKGPst+eBJUkMhBs/PUwT9YBv4VF8tSKcP5L9LJ4bGwmI249kVfbStar208
	 UyROpMvejhmLVpEKNZn8OdIHDfDVsq93b2dTSaNu3nf8TMvS++Eh9a31bt3IUUFKxNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILvFO5U2;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F5F606A33B;
	Wed, 28 Oct 2026 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILvFO5U2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793186356;
	b=xFWQ4UWC4DtZXQ4itYSiRiGzX1y/SHCQuPnc2u4Q/dQDujM3UDARVBZefsiQrm1bmx/m
	 mWoHDGzM3Uu2MIkMY2P7y3Ey7nrl/0t92SLpmaQJPAYVn7spBrj0NxwKaj/+eTg/Q6NKk
	 XvBIy2POm+vWpupCwJazNBpTVyg107PmOV/NIC3uRT4W510m7fxlzZPNC0rJNJ1OZaPhP
	 +gQkI0S780iWgkSYC3/1VwdSlrZgNcrgoxLXdg3wWw5UsJMN1R6Xdsk1YGVI+eKy7Wsle
	 /5Hlg3wD5RRzuAiEMYyi4JUevPCf2lRhTJLs2HHCDis8fUglC/AUIDdfU4AeUx/+zAg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793186356;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GChhJSELgzTv5vQCl/oyU87c2jYGiNk/WOEVK+6uib8=;
	b=KY+XUSHei33uLOY6KwzDGdRDGVEny4X7w5ejyhNn75AgmnDub2EfvwyaNPdE0QJarASE
	 p/nsuZciVURdTCMEgKw16SwwBe3DVKzVi46bbh/KSzuh873C9feam5lJHtFRtHYJC4VMe
	 oG/yXJaWk95m8K++g4PDqwLeVotZQHnqtOvLHAkrL7a5gMq9JDwRukPCmlJM/uEkQwnGm
	 aqutt9EY8m93GVyDrPNvHpb7jNoS9Krj54RlqPQFptVxT3pHeMHEUYUpKsxLZwlMbBXP9
	 cgXX/giGSonapPw9Ow4es/Zf/ZbYZ7Imj66H6sx30So+gyQbG7xHGK4CFHNjKzEBVqQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6457A1F031E2;
	Wed, 28 Oct 2026 11:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793186356;
	bh=GChhJSELgzTv5vQCl/oyU87c2jYGiNk/WOEVK+6uib8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ILvFO5U2wDXD7idnvirlf+fgR6zoVwrf2H81aKZlXJ45i7BZD6e1O450K5hRPaQAE
	 EqD7IdlfVzY0vOs8OdiOnM7JgKYQ0JQ9Pjg++1x6t8noDgQfgghVc+Fs5gqnEjvBbj
	 kHRDG7R1qdPVfniK6oGvIQ1MwhDLkdeIOe9coXQOvAsgf7iosrNAfasOhzVMes51k1
	 lfoxkqExClP1KdPdLU3pnIgq46Wr6MlkY6eDASUheFzV/R1D/GpIBJUpZqCaHWMdxo
	 xkASkmG64sG0tT61netjRWwn/Fb9zjgana85ik677O+03h9tHglMsNtYSLjmN6+MUP
	 1tTbaJ2FXvIpw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D396145423;
	Wed, 28 Oct 2026 11:19:12 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Wed, 28 Oct 2026 14:17:24 +0300
Subject: [PATCH v6 05/11] dt-bindings: mailbox: qcom: Add MSM8952 APCS
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
Message-Id: <20261028-msm8952-initial-support-v6-5-e07ddd8bcf4c@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793186351; l=1010;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=4SRoaEV+jb2+MQXKbteEPlFA0htY5fjMkh7Yu9tlUFU=;
 b=3AHMQWA0DgEunwCg6ewTCeBMBBNzoqUS16lMOy7XGkSEtXStcKWyXRX2eMQHaOZfyUm/P6G/1
 wI4GyEa2zcSCzfrxKkLhrJsCG8o/ipCLhpQv6SWC1L5Py1TS52/c4RJ
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


