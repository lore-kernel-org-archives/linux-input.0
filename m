Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD87851DAF2;
	Tue, 13 Oct 2026 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902566; cv=none; b=izjWFbr+DYxrwiZwBiyKABHsrGfh3oo/foqSE0Ye/q6h5dYMYpW0bOct5s8YSwK02n8Ln0eH0U/xT0QwKN8uHd5nOoNVDCXrYgb1R3OucD+AEZ346tj81N1hoo+cehzQgiEmCLgoo3hzgyTJakgLYwBkVvcsLlRCWdX04PYqQJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902566; c=relaxed/simple;
	bh=gvaGaYQkbeWArfJjf4/3OQkbb8OjcIRrL/oIOYNJ1DE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cpn55yB240yCtqyBP8UK98EEj+0JSZ9K5UjTFrmwk8KTPirGFxCRE9Z0rT6TMXnHlXRLz2TPaNnT45HacDlHCNonfhq0lmnXmYKCTQtnxBE2LWaL3c9khCZ5BiPVEa8naX4oBp4QkAqgXKNHuEJjTXMov2pb74kVUUhEb4z0pNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5YNsM74; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5YNsM74"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92CFCC2BCF4;
	Tue, 13 Oct 2026 14:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791902566;
	bh=gvaGaYQkbeWArfJjf4/3OQkbb8OjcIRrL/oIOYNJ1DE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=h5YNsM74OuWi3UYuIFB3ruhVGx9Wzj3arQTPbjY0lj5hIlit6HbNZn2veg5UWFVsx
	 kScHcPGH9B1ZLD6uafr6Q51rupbS+ZuSlLo48fKS5ruKwrYUqYZlzm6YyuhlFfWrtH
	 AdMvaXDWkKM8MxfjoIDHczs3hRc1SbN5h8uiBYFutOYV4fYjrmH1Z8qFFsXruI0jyq
	 kS7uLU+hty6UwXwNSwTLFg0NjPcIO22O+FIBnD8xVixvDVt3V4OMTDsEQiUFZ8hxX0
	 qDTqqvIVT90fdqFZiISCTluDWT0wocdShR1XYx9UXJZvH1J+NrVurnPUIDrB1/P15y
	 QtQxng2A/NLkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F968CC6B0E;
	Tue, 13 Oct 2026 14:42:46 +0000 (UTC)
From: Armandas Kvietkus via B4 Relay <devnull+armandas.kvietkus.proton.me@kernel.org>
Date: Tue, 13 Oct 2026 16:42:45 +0200
Subject: [PATCH v3 1/2] dt-bindings: input: awinic,aw86927: Add Awinic
 AW8697
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-mainlining-v3-1-fca981f62b57@proton.me>
References: <20261013-mainlining-v3-0-fca981f62b57@proton.me>
In-Reply-To: <20261013-mainlining-v3-0-fca981f62b57@proton.me>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Armandas Kvietkus <armandas.kvietkus@proton.me>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791902565; l=980;
 i=armandas.kvietkus@proton.me; h=from:subject:message-id;
 bh=v2utH8bn4ck8w7y8XqqfjpsT2mkH8/UIQhAb6iOyg4M=;
 b=fwXzgFDvGcAJdXr1aWobB3U2hvv6UAs5ogte3Rnp94GLYLlHqdCK8/4/8c7qvfy3d/xzvKI4l
 eBFMMGAlJSHDW0On6Z96E24/TwCg+xAsxkBPsODzOdU4rAUTT8QJ9pM
X-Developer-Key: i=armandas.kvietkus@proton.me; a=ed25519;
 pk=wuqmImJ9sKlDVcwALOvfGhjj7G8EBjjM4TpCdmlrAf8=
X-Endpoint-Received: by B4 Relay for armandas.kvietkus@proton.me/default
 with auth_id=974
X-Original-From: Armandas Kvietkus <armandas.kvietkus@proton.me>
Reply-To: armandas.kvietkus@proton.me

From: Armandas Kvietkus <armandas.kvietkus@proton.me>

The AW8697 uses the same bus, interrupt and reset lines as the AW86927.
The register map is different, so there is no fallback compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Armandas Kvietkus <armandas.kvietkus@proton.me>
---
 Documentation/devicetree/bindings/input/awinic,aw86927.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
index bd74b81488f6..f0e26664e3e4 100644
--- a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
+++ b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
@@ -12,7 +12,9 @@ maintainers:
 properties:
   compatible:
     oneOf:
-      - const: awinic,aw86927
+      - enum:
+          - awinic,aw8697
+          - awinic,aw86927
       - items:
           - enum:
               - awinic,aw86938

-- 
2.56.0


