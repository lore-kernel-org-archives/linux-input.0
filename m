Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5848594F;
	Fri, 11 Sep 2026 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132745; cv=none; b=hKkw6njbdz1vJH7elFI54QbyVC8kYxNSlOe8IVLdNrURbyn9LgYKtAXJ9uV1oNHkE+TG7VPdid+hRhBf9sjm88nivNEPMg8pXQOKR3cRos5VWlScZPomcMJaQf2bHprPwm41ZbVznuGhaiRwpCxCajFWr2xGmRQMdto1N4mt9+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132745; c=relaxed/simple;
	bh=+bhIA77KYFWRfVFlTa5amrjaQulxwqBwbI1DM0cGG2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZsPSoFOt28mF5d3pEBg8R0RKRV3MOrJHB8dE4q1fhBYYZirnmqrI4Oi+KqJuuXWZgOVftyjP5ueSqE0eebR3SQMSlE8YC9k9UVSVgZ1FdS3TvFey8Hf14UB0yD/lZfw7g+kIF7J0/Kw2mckxq323fBrR4wyTDtIfI5Jxgx8EPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f21Dqhm6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f21Dqhm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A3D1F00893;
	Fri, 11 Sep 2026 13:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132741;
	bh=j4qGgA1+x4CXcGra8l6DIcfg/zDcSnt7hUt3Dr3NX4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=f21Dqhm6nQByFX+22ouZFkMwhqVWOyL2DAIo86CtY67gyIZFBSh2SFf96kgq6FmBF
	 rZCfMN6gDYJyVSL9/jBy+RZ4Wr39lbiWtBTQsXRId8RQOhypxFJr16IiJpKogQgn+M
	 Wjyb96ygJCulVDQEPh+cYpwtKBzLJ+4oyVYhgcIjOvU0exlu+Xz/ri1+25Lz3tlAeY
	 hHF2T4ZRViV3b/8wLnDXZP0tFHwKBt/WleVKkHw/NSM45UCIA3Py5Wio+swNKLw871
	 KcrZBkGuFLqTuwhw0rsZdz30rpWNVHgCge6cvhFevww0oEAa9zc+BwJBV7WyQB/wMd
	 /TKMIAEnqL18A==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 11 Sep 2026 15:18:27 +0200
Subject: [PATCH 1/3] dt-bindings: input: syna,rmi4: Allow 'panel' property
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-topic-rmi4_panel_follower-v1-1-c1b2cf1cdb62@oss.qualcomm.com>
References: <20260911-topic-rmi4_panel_follower-v1-0-c1b2cf1cdb62@oss.qualcomm.com>
In-Reply-To: <20260911-topic-rmi4_panel_follower-v1-0-c1b2cf1cdb62@oss.qualcomm.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789132733; l=1036;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=DMr933I86ycsqwefwLQOVs5OCpIDPLbN6vCfwk4a2hU=;
 b=W3MPAoryWvz7pHNie3np2bkuWTVj5x4BhwAUOFjBpaz1X3g74lFlQYOCCliDsrVZbL+eBmwID
 3A1NJTc4uKfBp8ezYSSnyvN0sNJ2RgzkDlU2XfTgCNcj8apgXEnaGdY
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Many RMI4 implementations are present in in-cell panels where the
precise power seqeuencing is paramount to both the display and the
touch parts to function properly.

Allow binding to a panel node, which is expected to handle that.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/input/syna,rmi4.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
index fb4804ac3544..08a1786d3c8a 100644
--- a/Documentation/devicetree/bindings/input/syna,rmi4.yaml
+++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
@@ -57,6 +57,10 @@ properties:
   vdd-supply: true
   vio-supply: true
 
+  panel:
+    description: Reference to the panel this touchscreen follows for power sequencing.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
   rmi4-f01@1:
     type: object
     additionalProperties: false

-- 
2.55.0

