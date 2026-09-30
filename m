Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53584F3924;
	Wed, 30 Sep 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788731; cv=none; b=mwYo159VgESkCTAawgFiwC5/k2exhbB0uB6IF+xWbTsAZZmAmPK8N9dzWDuvORl+k6QfWNXuAxZnWSp7+Z/2RvFAZ4gcavOoO9Cg3Q8n0x9wyzfs4fysZuEo4zhmu8tFrIM3uogmRVtCZYV4wtfyLr02K1VjMRzsQ/W/E4MMIjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788731; c=relaxed/simple;
	bh=vhr3jJVJbkkdrVQjQBqkGhncAIMgy0DHJwn54om0vj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jx1ZGhe3qv3g67MiHkj/tkT2lawLSwaoQTrfqkGJChEt3PC0Syf/R8BP50bNXWEbCcLqX5W3quDzk8LOVri+YDMAWVkcyARSuIWc4uf5XXHZ+nlD5RjkayjGOkOhJUfKaoPkzu2vV2+bBQMbK7LMjYNr6DwWfnKH/Hguti8/dek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvFo9BNj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvFo9BNj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59912C2BCB9;
	Wed, 30 Sep 2026 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790788731;
	bh=vhr3jJVJbkkdrVQjQBqkGhncAIMgy0DHJwn54om0vj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TvFo9BNjxijWWSfrorvijo5PuUVxLXsUzTKv7vswL9UEenlqHQCMd+0483IZ9LPY6
	 KjwLRsiA4q7kNn8hio22XykA7tiEU7454DYZJHKRZZzC0d2w9o/iDyEfNpIW4+wqLi
	 8m9CpN+jhrtnxgTrLr+lY1Ijw8Ue9eC2t02oq/5WiFkK88cN7/LSijTGuiplCQimG3
	 J5gBqltt7W6dNxvmCfI+2Vbrl38djgSCsNTJYxqpTdSXoKzyXeObJRAZq/FhGcpkmj
	 2a8hNZgWdDCPRK2gW0JY5GVoCkAqJpvB7CQEY9YtLstP8J9TiNqB84ChDziVO6SROZ
	 FAafohyUzen5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398B9CA5FCB;
	Wed, 30 Sep 2026 17:18:51 +0000 (UTC)
From: Armandas Kvietkus via B4 Relay <devnull+armandas.kvietkus.proton.me@kernel.org>
Date: Wed, 30 Sep 2026 19:18:50 +0200
Subject: [PATCH v2 1/2] dt-bindings: input: awinic,aw86927: Add Awinic
 AW8697
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-mainlining-v2-1-40bb1b3943db@proton.me>
References: <20260930-mainlining-v2-0-40bb1b3943db@proton.me>
In-Reply-To: <20260930-mainlining-v2-0-40bb1b3943db@proton.me>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Armandas Kvietkus <armandas.kvietkus@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790788729; l=910;
 i=armandas.kvietkus@proton.me; h=from:subject:message-id;
 bh=vjgADZjYsmMEWYX2/CD2xEyWknfDHe2frU9LLl603ik=;
 b=B+IueZ060LvOlZjs57/4FZIWA3lb84vz2tVlKuYnA7Jfxf7ixoRZVn8evYNFvKSW5JySBHaI1
 0LNbLmIPN2lB6TsuYJ3QsJiEiYPmmFFllWS2gmpJqaVHtdgPoSO4HTk
X-Developer-Key: i=armandas.kvietkus@proton.me; a=ed25519;
 pk=wuqmImJ9sKlDVcwALOvfGhjj7G8EBjjM4TpCdmlrAf8=
X-Endpoint-Received: by B4 Relay for armandas.kvietkus@proton.me/default
 with auth_id=974
X-Original-From: Armandas Kvietkus <armandas.kvietkus@proton.me>
Reply-To: armandas.kvietkus@proton.me

From: Armandas Kvietkus <armandas.kvietkus@proton.me>

The AW8697 uses the same bus, interrupt and reset lines as the AW86927.
The register map is different, so there is no fallback compatible.

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
2.55.0


