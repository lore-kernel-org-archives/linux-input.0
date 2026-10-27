Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138504;
	b=c1gxDPTI67nG1xipvvjma8kJ1Tn0LBVRn59wEGnhbTI3Nx55lGzph8MqwQIO6MFQoO2X
	 N3STRsjElq255NnhCdAFzzqz4RTjrodJyIkzK+XOeCcze8mCNNQiM4iuut4XsA3Ux3yPr
	 cUbu8OHug5GhLK7543k3EXROPBcBEZXzHhrmVZjt0PERNqP2m6PWlyn2T7RAjhtnpZ/rA
	 iEj+6bMmKpe9mnxZb4ehxCg45vJqSasOKCGDdyiEpziJj8GCgM52Za2uKubDUPvhlhs1Z
	 /Bvp5TRTBU2SNnlkQILrc+NvYC/BsGhz/ADi1mr6G0ZHbs8Ej15KrNhv5FIe+zU9evg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138504;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mime-Autoconverted;
	bh=Ktjma6HcQWv7GiJJjj8PL5RwgoM4aJvF0tpv2up6UU8=;
	b=2CET29gf1XrF8f0DtJz2ne3Nz7j6mWQfAz7XYx9ADVHlVxBzmo+s8YgJOb5NTxThsu69
	 PoMJoiEY41BJO1Ee6CGnDP/fVOXEJMR6AJjIrtx8TMvWi0TopViizCmCyTUcvvTNwmRzb
	 1myT/U4YzRqhoeQN+9FoxSuAD2V5cJhUXpbCYPlvAJUwwaZ5QDZT4FUPOwJ079VH0Wply
	 FRU7RWP2dJaar8RqVrClqj/MpvNE9P32xUJJgSTD/+odTjXORo3Mrm42xwJw6OQLXRCO6
	 HRqGi4h7rJiYEtoxWzZGCwV1PmZ6gf5in5X7OLq3EWU+QldfOFZ6PAQh8pNpkUpv5lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=irl.hu;
	spf=pass smtp.mailfrom=irl.hu;
	arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8BF27606A322;
	Tue, 27 Oct 2026 22:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BF27606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68114.dsl.pool.telekom.hu [::ffff:81.182.129.20])
  (AUTH: PLAIN soyer@irl.hu, SSL: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by irl.hu with ESMTPSA
  id 0000000000080879.000000006AE11F3E.0002F671; Tue, 27 Oct 2026 23:01:34 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,
  Bjorn Andersson <andersson@kernel.org>,
  Konrad Dybcio <konradybcio@kernel.org>,
  Arnd Bergmann <arnd@arndb.de>, Gergo Koteles <soyer@irl.hu>,
  Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
  Enrico Cic <enrico@privacyrequired.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
  phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 1/3] dt-bindings: input: Add compatibility for Awinic AW86224
Date: Tue, 27 Oct 2026 23:01:23 +0100
Message-ID: <353fe3fa68e74c46b88df51b303a7d23235d5ea7.1793135056.git.soyer@irl.hu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793135056.git.soyer@irl.hu>
References: <cover.1793135056.git.soyer@irl.hu>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Add the AW86224 haptic driver to the binding documentation for the
AW86927 and AW86938, as this binding needs the same properties.

They are not compatible though, because the chip identification works
differently compared to the 86927/86938

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 Documentation/devicetree/bindings/input/awinic,aw86927.yaml | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
index bd74b81488f6..655633527c01 100644
--- a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
+++ b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
@@ -12,11 +12,9 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - const: awinic,aw86224
       - const: awinic,aw86927
-      - items:
-          - enum:
-              - awinic,aw86938
-          - const: awinic,aw86927
+      - const: awinic,aw86938
 
   reg:
     maxItems: 1
-- 
2.56.0

