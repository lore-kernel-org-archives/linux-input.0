Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793307760;
	b=WYmMZDfKaZMhKR5uIQ0tMEY5Ny7yH/BxBbGQN8e22FeU+Ohg9mB/8AR5KPr8gHRPRF+K
	 Tb07osPUfRAJR8+Zq2gR3D8NFWWN3pDdGswOE1tkRJRcK7/Vve4CNBBy/zI5JdAY/J76i
	 /2mf9zmCAx19uyNQfeItR10ju2U7myN7qx8bsbP6/9XZ6iz0MnqPWlFAkJr/immc+U9f2
	 QsPPJbSJm//dpoXLVeSdzD1MocgFDivuppMxtkkP8ZOq8vrzdf62RxbpjgorNa13AAvYs
	 q/ntkyvFPlp8LdaAwwDcV7CWfd5A6NCzH8Bj6DYcGgUFG+yv+r33KzyY649Mdex97nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307760;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fLxcuXmvvWbcMDhadAHY0ieF3XzHcf5W7cJn0XjKsvk=;
	b=jJAO1DGSwxoSx9J0SDMQLBXv4wVDWH14Fxv1j4MTP1Mzf71HIgngF/5M3SFRyVbFApH3
	 vmVluZy5komCZGw7gIobfYXef2Vc9XeuLg8F3S8b1RKHryQUEJzWUQe0UvdCNnvxlztf9
	 aDkqYcELBntqMQ9qNm+rqZ7eGbvc8Xnl2eIEemFnaffFcKnvSGjS35FB0tAief3yJmdOt
	 CoJPd3hTnu6K90oKt7A3AI8HkrZrA09CRqEqF096drFQGzYonf+OWRurf/e7aP2BUfAR8
	 Nxv4fRmDJVB3l9LUttkkNGb4YDF6d94n2S30pbzT3QLjJDsNnAR18qkp6wmO84stmrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjlju18q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C70606A31C;
	Thu, 29 Oct 2026 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjlju18q
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793307759;
	b=hASBgIInuQM6YooXOJlBl7dT/zkAL0iTs4yz+czTndoO0rB4OC/0qdoFZRxb/CZ00vHs
	 OgeX9btFg2GIZplj7Td8q3kMCYtLtsQDtFvznfAkVTZ4hNs038mbqmYJ7drIsxm/29Ehg
	 4bP8lNYKwdurt8uY3EaF6D1Ov4ZAzbueiDRiCPqMam2ZNjwFIMkOf/lq5ZL2s4Pn2uIi8
	 /YSZnSIt9bQoxVjXZatLRPRITjZ2YHfjSMNhtU/kjtKEFakmhosiOD9/HQd9NLbAQhVOp
	 0/HUNl3Xs9WeDHYrNcW5Fe2VClMPzjPn5hiQS1VsLy0wvzeEpyHHSuFC5kBR4Tdjyug==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793307759;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fLxcuXmvvWbcMDhadAHY0ieF3XzHcf5W7cJn0XjKsvk=;
	b=Ac29jV1/TZJAZfsKpdW94E/hlcup3ebDz30BZXNlasoKUgoXzqRtquGPC8ML2cpXsXs0
	 /Bi7kVFMiYfOm1Bs7lZ9Z0C95FU2RSXR97HwtvD6xRKf7t7WinkTsoxGK73ib9/HjiRGJ
	 PK60Js9YSuH/APINoWf1nUEvCHeLwByFGBTB+kmRuxPrENuc3JGyH0EwqY6jrGCws+RE/
	 VWmLhDYDPISES5t8vXoRvwJyX76r9rmIXKCT28SqyuIWml2/HBZS1Dpw4Z3e5GktnJyFX
	 ITzl3rU1y2R+TsXPsEQRTF4trBamunfwbn0kNyDy9XNzXdgqnUKPObMJb9Zk5DGOiaA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3AFA81F01828;
	Thu, 29 Oct 2026 21:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307759;
	bh=fLxcuXmvvWbcMDhadAHY0ieF3XzHcf5W7cJn0XjKsvk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mjlju18qpKWd2lqnAu07CmtqoPBCQ+/F/EEm8wjbFukHw0G1nosnnT10yUJLIjFVf
	 4CIHhiuY/Ut7kSTKPxP7J+s1bcRemgKJ2YJeWqjk5GCXlQ1LL9Z+PWu6bVisroRCAx
	 DyIV3PQa/uOmlJsXmobbaEw3cG/ruMotXfdNq5iKnBQq0OrNVeivq8cz4Qy015+IeN
	 uNRtubtfJ4iCp4ylDdlrx2bXFr211ltfoUdRcHnr7u39JXIbGYet6Ocs5Rg4lXZhQB
	 tQ4ss0Yul7VxoPDj75+T8Qss/eLCC37sqBl/6Qx6yG7FxJhy2Lqm1/F9NjNjjTq7Ji
	 Ckg92yttWoUuw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B9956459C2;
	Thu, 29 Oct 2026 21:02:37 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Date: Fri, 30 Oct 2026 00:02:34 +0300
Subject: [PATCH v7 03/11] dt-bindings: watchdog: qcom-wdt: Document MSM8952
 watchdog
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
Message-Id: <20261030-msm8952-initial-support-v7-3-ad748ace375d@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793307755; l=832;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=6oZOV+Mf0e2Xnm4F17qb2OJyHhIjSjwRgWv2fbhA1PA=;
 b=KuBHI6HUk4j9F5IWlHJCGnRDPyZqMkHNXhEm+21/P9kib1tjoSezmTXLRE6gje86e6WtkzEK3
 UtX5Sho3g8nDy6gCXuluYoHXS9F4mk3LEV68/NUCKb09hPnEMDVCWc5
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org
Content-Transfer-Encoding: 7bit

From: Muzaffer Kadir <muzafferkadir@mainlining.org>

Document the watchdog found on MSM8952.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 4ff61102e407..38f86ccd1ffd 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -29,6 +29,7 @@ properties:
               - qcom,apss-wdt-kaanapali
               - qcom,apss-wdt-maili
               - qcom,apss-wdt-msm8226
+              - qcom,apss-wdt-msm8952
               - qcom,apss-wdt-msm8974
               - qcom,apss-wdt-msm8994
               - qcom,apss-wdt-nord

-- 
2.55.0


