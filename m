Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793307767;
	b=qZEodYPV+2wODxz6v6K7vKHaJ2GrTzq2ZhN/ajWLSCwHJzxafnEYiHje+xRyfreM/Zz/
	 o2JlmiI/ADiorZApC2MbdAdVCd0RSCo60eVZl8eucJqujj84jQgTONwnd4FFTXVL6m05q
	 h9OCMoSDWBqSQQwYgIXSRiU43tCbrxtT/0QB7cmIqI3eFOXYraytKeZIdVtMKHHR+Ytzj
	 /pkq5qaFcSex4Ko9krIGxM60rIg6rvt0inGSYKjRv+7oAvdeq2pjQJdPMQwup9cDxtQ5Y
	 hP+WNXThVSjuhsyhS3K7UQphrnhusMeZTfq5uN1TjJD2ppKQGjPrY4/ko80x14Xvyvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307767;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=siDHJNCTopPCSRKzCL5cJLzJZg1AuYQ0QITbIwpTbio=;
	b=Rrmz6pCCQocTX/R8ugiEVyzmwQya4q7yEn1ygBSJiZz8DNX9syxAcUrmzPmOnkXA+CEX
	 jnazmlCksVzA94PyD3W180HpdQHOKFCQW/Uf6FI3kw+gjgzOe/3EOimF4KdyoQUqChV+c
	 7h/9VeGMrhf3nq0295KbtmaxL3RDmiPK3aeoXm8zTgR6fjdzkdGApyueGgEy/JR7Nyhxt
	 KP7otqSMdBI6YI4KeQXw0lt8FXTXaX7MkIYiyr81xEN1PWVPUUd8ipx/gMduvuIeT5oxi
	 yCXVVHVhnmDDm6NwtDGDomFhYvzD2ObwAEXL+x5uJaONXVzXYTAd9hGBXT+sfz+p3ow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FtPzAXRn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EA0606A33B;
	Thu, 29 Oct 2026 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FtPzAXRn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793307761;
	b=1L0GNRo2qD2X5YsmsSzGADWZYDGtYHRIv012fcT/823zaMSQYD+u++9Gsps0DzX9mu4n
	 qXSMJUmvdbWIu01rswtcXF6GuU0QZkE0YCq6Yo1tUmq4R4XL9ZTeaRBPKgqNglegYw/Vd
	 4EYFWTtxNkqMn10axBzPZ068tyzdN0wTiDpwWhWs2Iya3ZuYC4KQ/7PabDaUigIEqcJoq
	 Tf1zWBxWB/AYm3tEJ7h2VmVDHW0rtBXPjolweVmbixczPxmOnJkKe2Tta6X1iA1CLUnXf
	 6wyy0smL6SRwdG6EadS0yWNBBMBP6ZjskaoXw8B4v1W0LSXSRy+NsVMbo7c9xGch6OQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793307761;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=siDHJNCTopPCSRKzCL5cJLzJZg1AuYQ0QITbIwpTbio=;
	b=n6gTNi6p8XYPThgC09rqwh6dM+Z+BRJo1GjeCQ3AvoZLHfbhX/2S2qEoBLYeSgYcWnAK
	 0qZXnHAqF1LKQe+qUXBmjYE1//kiNUHgssore98I9TZdjeX4M4c5INbnF6H7J+wj22mU3
	 dsLn4/D6alun/zWyUfMFk4unR4dIl6muLX9eWKycL1PDW7GTkG1u1YKiHajfsyZyBevmQ
	 I0qqm5/9Lb79hTkVS2i947UDpQHPmSIT4nUMr/ArJ0qpbDL4DGKNE9VGk3O/2GL+Iaos/
	 lgikNTFag4nHYtrqViBZD/f0PgjKr9Za5z2nZexlW7CxIYG+IRSk+0YiOII3AyVMqSg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6FFFC1F031E6;
	Thu, 29 Oct 2026 21:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307761;
	bh=siDHJNCTopPCSRKzCL5cJLzJZg1AuYQ0QITbIwpTbio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FtPzAXRnBUY4Z3d0NhAKbo5jpiiAIqatdoykZKeDj55ihbyT9l0ES9E8Px+llaVBX
	 zaU+sy239CGpB0JX+q3RIqTHOMvjU0612ItjT8K9eOEosYMvMiTk4AaAhjBvWFNW9d
	 uduCEh8z+ntmVigORAk6qcgw3x/3Wen9Sj9Va1zjR8KByuoH1QgclBWz5ySxJSx/wh
	 ehvxxaYhpgYcn/8xco3fKTCqjU4NlZydlu93VLCQW9hku36IU1xKcpy+j7J/HwfbdT
	 ld3g7lOJI5tuGXghuIka11rqWEgwfVwkmLPgJdii1ZeNeUs5KCOBFSudtaF2bhrgkO
	 zh3Flny8Ad9sw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E9185459CE;
	Thu, 29 Oct 2026 21:02:37 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Fri, 30 Oct 2026 00:02:37 +0300
Subject: [PATCH v7 06/11] dt-bindings: clock: qcom,a53pll: Add MSM8952
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
Message-Id: <20261030-msm8952-initial-support-v7-6-ad748ace375d@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793307755; l=1385;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=BrzMm8QIgqROsRwWhO5mUK+pBiKnEr9sw/uWcqoVjmc=;
 b=1mAfH2nBwjwf7aeVI3GXqV/oYDC0YmaZcLrSIbIredaTXJK8uFq6qs6FlBm/WyNBz6u/h9zws
 G3I7eE8HuyfBBZF5e9kRnmt0Owa8gG7DYTg3G8JRf/ZNN4hIyzViCCJ
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the a53pll found on MSM8952.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 .../devicetree/bindings/clock/qcom,a53pll.yaml     | 25 +++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
index 1eec77e75a0a..4abfaa24bc71 100644
--- a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
@@ -15,16 +15,21 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,ipq5018-a53pll
-      - qcom,ipq5210-a53pll
-      - qcom,ipq5332-a53pll
-      - qcom,ipq6018-a53pll
-      - qcom,ipq8074-a53pll
-      - qcom,ipq9574-a73pll
-      - qcom,msm8226-a7pll
-      - qcom,msm8916-a53pll
-      - qcom,msm8939-a53pll
+    oneOf:
+      - enum:
+          - qcom,ipq5018-a53pll
+          - qcom,ipq5210-a53pll
+          - qcom,ipq5332-a53pll
+          - qcom,ipq6018-a53pll
+          - qcom,ipq8074-a53pll
+          - qcom,ipq9574-a73pll
+          - qcom,msm8226-a7pll
+          - qcom,msm8916-a53pll
+          - qcom,msm8939-a53pll
+      - items:
+          - enum:
+              - qcom,msm8952-a53pll
+          - const: qcom,msm8939-a53pll
 
   reg:
     maxItems: 1

-- 
2.55.0


