Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795324435;
	b=ecIN53RghCDqtSADnumah2WRd6aGpQwgHbri7cQx/tuaSSM58+kKrd4M1t3K4sJxOw0H
	 3wGgDY0wzvbH02ip1Xgq427PjID5Dagwz7SbT6FKNndRR9ZG68js10OSrCrG5luvR4uxD
	 9otk4rtlNW8bh1uJ90oNndpinQgzoeJm0Qjm09Qmky02V6JrQhmh05C8wERNfhQB1pqJ1
	 GAA0kPVkuE+Wxxbo/YmHzqH7wexUod5hFlwN5ZDXpcwb06IzQQJtu6lSTHuy3YcGQDhfH
	 ALKXtzNfOhPjHvDdDRj8GyQ9u3cnIJZOe4ldEuWktO3wIqP6vSl1exVdwvSvFt/kVlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795324435;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=x7fAWI0SeuRciQJeEO5O1AtHlb4bQ7PjYiV8HGkcy0k=;
	b=t0dytN8Wy7tmhzAzRIRRIny1nJ7ezu4t5GXqY37ug3S+x3edZJQw6GljTMTfz/JAzFE+
	 JlKPPYvFaFNHHWTd41Oc9E2DmgqQwIYoQILK3oo+z0s00snD3IKsH1inVY8VebXK/Wb14
	 aMVLTEaWx49CI4OmGXzWBcglURI2kOWPZYayaWS3iemDsmJSfWz3lPDQXBo60Iyvp+8bR
	 P1fCp/80seRbnOvvANFBJBnIKYRuga4VspXl25lQRJeRjsVPkEtRMuojqokjGg/r2Uk/P
	 l75lM7XiYhi4Iqfc0GiGI5Vh633YOTFhs7FG845cAP+WINL0t3PgKXpLo6cmuRPNcVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2ozEWXk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A81606A32C;
	Sun, 22 Nov 2026 05:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2ozEWXk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795324435;
	b=D0QKwwfvqqKfD9SQUanhTkJ1VqYb5jg1JZK0R627yBMZAZFl7Z3vtvdleyj3IYlGmdDA
	 hzyFj9++hrTtMRJLCUan/L4Fng3IVWhgVO1c8h6OnG/uiY5ixwoZJvJUfqOG5JmVVfLwH
	 X8emjQmcg3s6Vt6xvPuqsfQU7W2xDkID9UPKbCXSn6xpp84JJZ3WUlWJ7iC2RblGHqvgk
	 BLf6ujoLF80Md+ryT6+Dp9d4NCwI4Jrn2w4W+oTX53r6G9/PTfftjLM/1+mHH4/gk/ddT
	 eviQQ4+yISusQt7Jcr479kAfSlae/7CeT4VEEFV4DjlWvhIWBtMxKE7BrXkcJeKH7mQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795324435;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=x7fAWI0SeuRciQJeEO5O1AtHlb4bQ7PjYiV8HGkcy0k=;
	b=ql0V+EsPYx+XWkzjIn0xMMZFEni+BsSe/AKa1pu3rx8FNi2lSmnp3/858zrtwK4sOPdB
	 IOJoHsdJdnk7v9gXuGg0LP/euZepFDw7sjXhF2uav32rk8KBvhNstCm7fyEWMOh95I07R
	 4QL/QCpSDfZuFWVZFY9T/ZW5U9V7jyuL0nyfpMNzc5IUflzZPUrdeUgKqJk2n0z28xUNL
	 e9RkNoK/GZ1nquhwKt9dYyKWGXjTzxMAMIMdmDZUbousmaMVY34qB6YjrQAV0BOk/K0UL
	 aDkm9eutUlnPyR6KykEMvlGNbgGosHXdFQRxMtx9PHV3K3ZL5MAUAnRG/LZPfGoe5Nw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6B40E1F000CF;
	Sun, 22 Nov 2026 05:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795324435;
	bh=x7fAWI0SeuRciQJeEO5O1AtHlb4bQ7PjYiV8HGkcy0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=D2ozEWXkZdDC8JL6ZBpgZ1Ldx4saOF75fswPb/HXYGzU8LgXGA2QJpGWJNEAI5Ct6
	 py8/JJVRtMx/uOYXp3Yazh31g8lnvqTM0RPv+m5CJ6DtNmh8GQakZQKjGlvA9tCicz
	 CJVf9eCxvjBm6gL2MUkLfwBCaynITbXU8FkTuRznIGFHVGTpDNSRyZcaudkC/u0L/k
	 z+aNDlQPka1672lAL2o/n1+tSz1UYdr08rSTHy4hZv6v5u4NNXflJ7eABiJ7wEzCIW
	 Xmp6WzW8N4zxO1bHJcIC0Gp+FZew4rfZr7OcdVddOtpp0v6QQXWEg+SCalbH0DsHg0
	 2LUPt3Odx2mSQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F04114BF55;
	Sun, 22 Nov 2026 05:13:53 +0000 (UTC)
From: EMCP333 via B4 Relay <devnull+emcp.enser.io@kernel.org>
Date: Sun, 22 Nov 2026 05:13:50 +0000
Subject: [PATCH 1/3] dt-bindings: input: syna,rmi4: Document wakeup-source
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
Message-Id: <20261122-b4-rmi4-wakeup-v1-1-1b662be4a9d6@enser.io>
References: <20261122-b4-rmi4-wakeup-v1-0-1b662be4a9d6@enser.io>
In-Reply-To: <20261122-b4-rmi4-wakeup-v1-0-1b662be4a9d6@enser.io>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Abel Vesa <abelvesa@kernel.org>, Casey Connolly <casey.connolly@linaro.org>, 
 linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 EMCP333 <emcp@enser.io>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795324430; l=1368;
 i=emcp@enser.io; s=ultron; h=from:subject:message-id;
 bh=ibrZrS/G/KWUW6WvA1g5ly3Yt1Di9/yHqulMV+RT/tA=;
 b=OjgsAqKLRdguBshmfdwAa6AQdxl/df/CLVH/lThmy9HBz9+19CZ4x5uUYtVXcCeVCkZVGbGU+
 z6sCwm9aNXMBWXJr34lcMsZcKtPDf3CzHXQbrwhr/Qurpm/ktoNkxdM
X-Developer-Key: i=emcp@enser.io; a=ed25519;
 pk=5sG48Lul+Vn7OzXu3VZrCWk5uvEFPYMXYnAV0TZR/tY=
X-Endpoint-Received: by B4 Relay for emcp@enser.io/ultron with auth_id=1598
X-Original-From: EMCP333 <emcp@enser.io>
Reply-To: emcp@enser.io
Content-Transfer-Encoding: 7bit

From: EMCP333 <emcp@enser.io>

The I2C core already turns a "wakeup-source" property into a
wakeup-capable device: of_i2c_get_board_info() sets I2C_CLIENT_WAKE and
i2c_device_probe() then calls device_init_wakeup() and
dev_pm_set_wake_irq(). rmi_driver additionally arms the attention IRQ
with enable_irq_wake() in rmi_disable_irq() when device_may_wakeup() is
true.

The binding does not list the property, so a board that sets it fails
dtbs_check:

  sdm845-oneplus-fajita.dtb: synaptics-rmi4-i2c@20 (syna,rmi4-s3706b):
    Unevaluated properties are not allowed ('wakeup-source' was unexpected)

Allow it.

The code and this changelog were prepared with the help of an AI coding
assistant. The submitter has reviewed both and takes responsibility for
them.

Signed-off-by: EMCP333 <emcp@enser.io>
---
 Documentation/devicetree/bindings/input/syna,rmi4.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
index fb4804ac35..34bcc25135 100644
--- a/Documentation/devicetree/bindings/input/syna,rmi4.yaml
+++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
@@ -57,6 +57,8 @@ properties:
   vdd-supply: true
   vio-supply: true
 
+  wakeup-source: true
+
   rmi4-f01@1:
     type: object
     additionalProperties: false

-- 
2.47.3


