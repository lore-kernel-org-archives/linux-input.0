Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4831A6815;
	Mon, 23 Mar 2026 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274436; cv=none; b=kvkoiYRU0cH9rnv+RX6u3JsbUqdB+UvyV0AORj5mEIwtJG0YcZRQZhCgflJKVKzMFNCYtBtZ6IGByzQKyMYqn4VT3tFLgyLANJEWZu6YHFdTG+CGzOWhcYNpVnza8OBHLFUwQhfKE+rZdAEtu7vAWWzMXyksrLhEZaACdogVyyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274436; c=relaxed/simple;
	bh=lmdhqIzPyxkLSNbG2elNPk6ySF3ItrITYENUA7kqbBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FN7fhkT03ssRaR6FeL0KDunlRw799bvS1qpMXh+6PRzCELCGV6RATikBbPkFS7G1GBYd9mk9mZLSSyrbnyEZN3Pym3QKxcNK807rCOBrtm+igkomiIOIAjD+P6shy6X1br7x8S+4lkxI8JZ3HvZKoLdhYjFvtSGSGeFPOR7Ko9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=VoS7vqBL; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="VoS7vqBL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=C7J8fgLWBAj7/wGmEJ5zpUPN5BtLb1ls5YQ6XDZJxUg=; b=VoS7vqBLBPnPGZPPCg6qgb0lyA
	oFnEa6N+qHrIK7H+vC08oJPGaPCPgi0gYBc/5WURiUSYXIHiAkRdoWgRp75PaZE6L7pN9PhNLGPlo
	44+v3womXUubjIZv50O10lXzA9ChZCwUm7D7gdtwzfaSk1tXapAwk+N68PZW0PLSnYTU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1w4fpT-000000006GY-1D3U;
	Mon, 23 Mar 2026 10:00:27 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olof Johansson <olof@lixom.net>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: input: matrix-keymap: fix key board wording
Date: Mon, 23 Mar 2026 10:00:21 -0400
Message-ID: <20260323140024.104475-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The correct wording is keyboard, without a space.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 Documentation/devicetree/bindings/input/matrix-keymap.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.yaml b/Documentation/devicetree/bindings/input/matrix-keymap.yaml
index a715c2a773fe..ce910e4ac823 100644
--- a/Documentation/devicetree/bindings/input/matrix-keymap.yaml
+++ b/Documentation/devicetree/bindings/input/matrix-keymap.yaml
@@ -4,13 +4,13 @@
 $id: http://devicetree.org/schemas/input/matrix-keymap.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Common Key Matrices on Matrix-connected Key Boards
+title: Common Key Matrices on Matrix-connected Keyboards
 
 maintainers:
   - Olof Johansson <olof@lixom.net>
 
 description: |
-  A simple common binding for matrix-connected key boards. Currently targeted at
+  A simple common binding for matrix-connected keyboards. Currently targeted at
   defining the keys in the scope of linux key codes since that is a stable and
   standardized interface at this time.
 

base-commit: c369299895a591d96745d6492d4888259b004a9e
-- 
2.47.3

