Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.85.9.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219882;
	b=FllxpfH7MgqXkZjNuscvcuvB+4MgkYRZWjjQs9gui7+U2Bx2eBBBpFGLTbRLWbuk3Jat
	 KE+/irvVzp49yZdl+xf/b16LJGzXx1+mkdaB3raxqnk7FZAVdJ+gtJCk1TOJnUJFp2i5r
	 8V7uGA0QVUOgfDYW1GRhbdoJN22aoVywBnl7CgzOdZ8+ViNSlddUjnsAoRLaQgAjFOYtG
	 SmJaUOgP9+OBZUfvXfbFnbHAHhniaa06CZXs75C2LY8MKDfDjnM5sVqlOc1yklPcL+SCj
	 J+7PZT3jv9csfiF+ddjhQXHGDBYwzgtJJ/2dIIeYNvwtDKSsdot1JIMbC9XMMMpn1ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219882;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mime-Autoconverted;
	bh=slysvFuqVbB8Lo+ysOwdrN7Z4iVI5B0BG5CGxwHLlCA=;
	b=uy1tpMFkSyQfCCGfKjC0poQto99V1Is2ms8caSM6qy3K7j7xDlBm5yXhBIDGRADXJTjD
	 ASXC9xKb1CjZNh13LjExhXfKhCxergM8lGZsAPXW7jE9MHVxTJC8WslhRfj3LbAZN9nmt
	 hD0P9D6DNxdPQIZ2MuifSiPBgAevENSrQr51j4EVYPgKOdONmu81mtq5r85iILuuklgNd
	 q+LLG98X23eACKVITNz3fifrR6o2EsNRpu+SGtJBLI8Ds4SbWTRslOqxzPitkx3OW0CQN
	 hgliP6AI5W7e9ZSfLeGL+qMjPMu+isYtFcoxiUsHVk5P1Acg+UuZq4M3ABQ4B16v8Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=irl.hu;
	spf=pass smtp.mailfrom=irl.hu;
	arc=none smtp.remote-ip=95.85.9.111
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9C59D606A31F;
	Wed, 28 Oct 2026 20:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C59D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68114.dsl.pool.telekom.hu [::ffff:81.182.129.20])
  (AUTH: PLAIN soyer@irl.hu, SSL: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by irl.hu with ESMTPSA
  id 0000000000080903.000000006AE25D27.000329B8; Wed, 28 Oct 2026 21:37:59 +0100
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
Subject: [PATCH v2 1/3] dt-bindings: input: Add compatibility for Awinic AW86224
Date: Wed, 28 Oct 2026 21:37:36 +0100
Message-ID: <ceec2d2a29dd6cdfd984b964ad3a91601490a76e.1793218514.git.soyer@irl.hu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793218514.git.soyer@irl.hu>
References: <cover.1793218514.git.soyer@irl.hu>
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
---
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

