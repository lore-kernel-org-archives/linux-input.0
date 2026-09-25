Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930104071E2;
	Fri, 25 Sep 2026 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338177; cv=none; b=Z2rvAYZaepnwev3u4LZ/SJ5rBDAblsA/BAFJNXxoNv+PeIEX1E1MNjulMcuo/t8vFBo+dkZRAe9zqtR4n6lsB1zLz+RoNNUaeGB2oVj5PHE1spCOGO2M5ttx72Ho8QS+FCIAy+C2WhFSwGYRimnVY6n18KnkvNH+KbKbTFZ5PfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338177; c=relaxed/simple;
	bh=SxIZzWCnD27F3bETzw8GzrIINZnH9G/TAzwOYgMlEyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hHvJsV1+jQrwRuGIKmzvNpmKfM0YrCHkMwczmhij1SCU2d5tN7pe+lHFip2aZ7wW1llGbD+UX7M1VNc/bMVyTrRR5RBL/vptsCmoQcO+7apAlkDnSfnd5cI9Y/PPjzwVMqj6UG1Mqojwt6SluX2EknPolnyDT0AJoP6vL82smpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS22LBsm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS22LBsm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4578CC2BCF5;
	Fri, 25 Sep 2026 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790338177;
	bh=SxIZzWCnD27F3bETzw8GzrIINZnH9G/TAzwOYgMlEyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JS22LBsmOBePuRE8hGHkmbQEwP5MX78l9vNViuou6gfzeRmxXH3D7OsDzcvo3UjBm
	 ZzK7wqnm2VY2VPcse1QBrvCSkH57ZTucGPI0TYa/eJp5hHWQmUM0K3qYoMx78/Bea9
	 FtyDp+2Lccnl2rvRGxzZoN3IivrClXX7/qA+KqtUnu8dE6Rd6pcv4HYLJArUFNgXeC
	 N//Mx5c+OE6lGsuXjk7HFSCN6JwiC+XAridrF5ZFyEqnkjTRJ1ibrzK8T7QMYLotnZ
	 wJfD80uuqqC8Cq43E/0gBGkv+d1YzapoybFbJ4ywfr0iE/QhYXuu346jmySbHKWd8U
	 6/giq7hPFuMqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23473C9830D;
	Fri, 25 Sep 2026 12:09:37 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Fri, 25 Sep 2026 22:09:28 +1000
Subject: [PATCH v4 01/10] dt-bindings: mailbox: apple: Add M3 ASC mailbox
 compatibles
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-apple-mtp-keyboard-final-v4-1-304c267518f4@gmail.com>
References: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
In-Reply-To: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-input@vger.kernel.org, 
 Yureka Lilian <yureka@cyberchaos.dev>, Julian Braha <julianbraha@gmail.com>, 
 Sasha Finkelstein <k@chaosmail.tech>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790338174; l=1133;
 i=michael.reeves077@gmail.com; s=fedora-20260918;
 h=from:subject:message-id;
 bh=jWZaHgDdQBahv3cP0BkPbF81okNWtgFAdgZ27z/Vurk=;
 b=0rsYrow1jqZPifdOdsKzXjIzKnOcpqXNXFCbdZNeUjZfUfOBUh5g83BBi45ADvkbSoRf4MFDz
 ZsEPUIeunVYAHEcPiO5Ofc/NbfflBrGtWleLTwfyWORscJYLn0lH3wx
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=VJ0TvyQ9TvfzYZa908YSE9kpkjFLLD5luv0bERu+boc=
X-Endpoint-Received: by B4 Relay for
 michael.reeves077@gmail.com/fedora-20260918 with auth_id=1035
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Michael Reeves <michael.reeves077@gmail.com>

Add the t8122, t6030 and t6031 ASC mailbox compatibles used by the
MTP coprocessor on M3, M3 Pro and M3 Max SoCs. They share the existing
ASC v4 mailbox interface.

Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
index 28985cc62..9a6dfb0b2 100644
--- a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -30,8 +30,11 @@ properties:
           - enum:
               - apple,t8103-asc-mailbox
               - apple,t8112-asc-mailbox
+              - apple,t8122-asc-mailbox
               - apple,t6000-asc-mailbox
               - apple,t6020-asc-mailbox
+              - apple,t6030-asc-mailbox
+              - apple,t6031-asc-mailbox
           - const: apple,asc-mailbox-v4
 
       - description:

-- 
2.55.0


