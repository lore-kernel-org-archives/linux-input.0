Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310395;
	b=N1XQvBaHOi+kmc65fNrfVTSoBLoFHTs/efuO9+vzv2H6x9CEK+at++jkiCEqiBgzWcfX
	 ovAiQmGwCKg8cBqReE9kYvdI+hMdGGh6lIZDKcezbJVGR8NB+IW04MMfRGdn/OppvAg9w
	 u08Sz1FyzTugaEaXgTRJbwv74Wbf2KKXffK0J0W9hv+tlqTPO0ZJfbl921Uq6cP9mhcj4
	 UNvyROTTUa+tNkQM+PKxLUwf+wFsQOYhRhWCbrbCqD9ITHvXUoXalkNr7a9wEmVPVs1gg
	 iMVZ+xLNqjc5k6kDeJmwN/lq9lxUOoxEttOySwiuwmYtT7ulRqg0XHLQJY1aoH6r5cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310395;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mime-Autoconverted;
	bh=R8aPoXyKfMT+bONY62G7lc//xT+eeMGpJAGl+cHyS4o=;
	b=sSgFWdW66e31r+uiiHXY/nOXnzbCf28QN6M7QQmaccgNZnR5j6t20GNeTJz75jgLp4pa
	 wHvA90VFLzcjSjkqew4+b01ODEvPxZ5yencS7Zg74dqjM2/mMCdkHuXqNRNCsqyS/M96d
	 6xtZS5lrmwmq4Yf918kzXX60PxO8/VrgbkGd72cKi5iiEZFT+wP4OXjnp/Zvw+gjL/hj+
	 pj+GBuF9LJHrKhQjI05DHfK2p2nAogyDzcLsUJLbIKkcsq0pyeRnVClv1gaExdz9LbINJ
	 IOiYHhcfbs/fSZxp6eMLHVJ3u0SSa8QQkFA0jNqHHdUem9oKsNz4aYE6ag4dUAuM9kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=irl.hu;
	spf=pass smtp.mailfrom=irl.hu;
	arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 06C8A606A32E;
	Thu, 29 Oct 2026 21:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06C8A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69268.dsl.pool.telekom.hu [::ffff:81.182.146.104])
  (AUTH: PLAIN soyer@irl.hu, SSL: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by irl.hu with ESMTPSA
  id 000000000008098F.000000006AE3BEBA.00036879; Thu, 29 Oct 2026 22:46:26 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,
  Bjorn Andersson <andersson@kernel.org>,
  Konrad Dybcio <konradybcio@kernel.org>,
  Arnd Bergmann <arnd@arndb.de>, Gergo Koteles <soyer@irl.hu>,
  Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
  phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v3 1/3] dt-bindings: input: Add compatibility for Awinic AW86224
Date: Thu, 29 Oct 2026 22:46:08 +0100
Message-ID: <ceec2d2a29dd6cdfd984b964ad3a91601490a76e.1793308351.git.soyer@irl.hu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793308351.git.soyer@irl.hu>
References: <cover.1793308351.git.soyer@irl.hu>
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

Add the AW86224 haptic device to the binding documentation for the
AW86927 and AW86938, as this binding needs the same properties.

They are not compatible though, because the chip identification works
differently compared to the 86927/86938

Signed-off-by: Gergo Koteles <soyer@irl.hu>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v3:
 - none

Changes in v2:
 - add only the new element (Krzysztof)

---
 Documentation/devicetree/bindings/input/awinic,aw86927.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
index bd74b81488f6..264c4c8f7a65 100644
--- a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
+++ b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
@@ -12,7 +12,9 @@ maintainers:
 properties:
   compatible:
     oneOf:
-      - const: awinic,aw86927
+      - enum:
+          - awinic,aw86224
+          - awinic,aw86927
       - items:
           - enum:
               - awinic,aw86938
-- 
2.56.0

