Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BCB3806B4;
	Fri, 12 Jun 2026 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301042; cv=none; b=JedYd6TJ9JmbMG6l+RUirZJQpN+BjBVfquG5V4TYnXD1KD32MVsVBRq7r2H2QSXKafFB1ohsP5FWXrutWSajdr8w1wzBRiHS47+wDZFEWLlL9wbxmiY7krn78RXRW3MG92dHLQLEtxmznu5rBSYOVCHxQFU0MNen+47NMjDXcAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301042; c=relaxed/simple;
	bh=lhJImDCC1WF3ABEqTf4IaqBhaYv/9U2IfUcLAdqu0XU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mr0CmOKUgctaklSRzgcakL+TwAKiSc/Zm/t45OHYNMnh4V+GnxtHM/CqEfb7Uk8Vmn9jPzWwJVlNC7VaPtOmPDenzdHxwPOQDA80a01X13JwMfxq37Ld5DNGaQ1MT45m8XT9f/GamRIoHBSxEON0LYtK+/Qn6EhHTUcrbLxprWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOqKelPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOqKelPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D661F000E9;
	Fri, 12 Jun 2026 21:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781301041;
	bh=p2nA5Tnze6KHUN9XqD8/TMWWvzpCyxCZipWb1FvHtlQ=;
	h=From:To:Cc:Subject:Date;
	b=aOqKelPz0TBX9GC+rYzBL80Yyf93uFKTpDT7fWSlL7HsAXQao7SFx5HdVktWnzYrX
	 vM/tm529dOeTt0aMJcB5MfvvFbTqxr4DPj9yVEfku+pXiOyHWfHcS/9Kozp3pmDypZ
	 lJvunAlUlUisPDJJ75SBL+6nfmCefRxRwLR/gFKsKMAlKdgBV2MKN9Y59NK0x6MKJa
	 7lN2Wsdh7e8JCJUBaERdpYUwzRa26rzSolKOjXapuoed/cBEjF7xgZ0l818F6HAwrC
	 24a0c/X9dApfml6I5eqX8RFOT8OXKNVqzHxAnqbSXsXoEyev+TKSxKflD57lT3ZXsT
	 x7mzxodi3aO1Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: tsc2007 - Read "ti,poll-period" as u32
Date: Fri, 12 Jun 2026 16:50:33 -0500
Message-ID: <20260612215033.1885245-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "ti,poll-period" property is documented as a normal uint32 cell.
The driver used a u64 helper, which makes the helper type disagree with
the schema even though the stored value is still small.

Read "ti,poll-period" with the u32 helper matching the documented DT
cell size.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/input/touchscreen/tsc2007_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index 524f14eb3da2..db18b712999d 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -224,7 +224,6 @@ static int tsc2007_get_pendown_state_gpio(struct device *dev)
 static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
 {
 	u32 val32;
-	u64 val64;
 
 	if (!device_property_read_u32(dev, "ti,max-rt", &val32))
 		ts->max_rt = val32;
@@ -240,8 +239,8 @@ static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
 	if (!device_property_read_u32(dev, "ti,fuzzz", &val32))
 		ts->fuzzz = val32;
 
-	if (!device_property_read_u64(dev, "ti,poll-period", &val64))
-		ts->poll_period = msecs_to_jiffies(val64);
+	if (!device_property_read_u32(dev, "ti,poll-period", &val32))
+		ts->poll_period = msecs_to_jiffies(val32);
 	else
 		ts->poll_period = msecs_to_jiffies(1);
 
-- 
2.53.0

