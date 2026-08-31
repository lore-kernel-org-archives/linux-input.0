Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3F9377AAE;
	Mon, 31 Aug 2026 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205468; cv=none; b=mseXwxY5GElwf/ZVwSlXGhTp4YObjIDwxD3nRUd/NUumZnK1LMWV01NuZ0ohhHPOyfZc+dNPc6VkQRU3q1aO3AllxY88l/1dzk6p7IcTR1597UCH7KzQwwh3U8WautQAJYWGI+WnrpRU+tXE3CpLsVqN3UU2EnZA2KvpIcKokRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205468; c=relaxed/simple;
	bh=WaI+eKV4DR5mUmT1E+fqoerjniSdCFN3Rd3imyHMaa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BSvDPrAQopdBqANEkFqwCrYUx9zCpHFLrRGxPpgnkz6G23LZiHI+X+1YxSL48hx6WszVVZgleEvvH6WWsqlPMbRpkozygt8XN+R4vpg76ai8LB37jU4l9xxYH0AJmams836pN2VCmS3Xzri77gVaAzgcTu9uwa3rBsCgJ/WA/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krgxc2lP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krgxc2lP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAFA1F00ACF;
	Mon, 31 Aug 2026 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788205466;
	bh=wW4zXjGobP6AEfFVB/lI37dPwurLEMgPURkMjoyY0is=;
	h=From:To:Cc:Subject:Date;
	b=krgxc2lPL4XsVh2ZFvFGC3CtxQ8oQ9MSZr4Rjh5cUjgINwsMbyGfQobhJHWE/ePSI
	 8dQBXvl3cfCyNmLLFdXlFRslhtvHqvHMJnLh5AbZQLqULAD9Te6ykXtrmO+sUEhGJ/
	 Xi1YgTX3vBNwOMhpGYSVBlwAjm3OG91Plp9CBnFEGDkRpB11BpuPPPHJKxPUNFrKQp
	 Np+HLIwTOK3mb25sBCMywAhVOEayP06n8ySi1Ha+7MNnkL27nDa8kVMUEetfTcrlmL
	 wuu6d0rSAqfGIezrB8KP6hZO2OQkEXjpClS30GyhU7NEfd1vb8NqCJQWK25qsbLzIE
	 mV6Y1lJaFD2oA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] Input: tsc2007 - Read "ti,poll-period" as u32
Date: Mon, 31 Aug 2026 14:43:51 -0500
Message-ID: <20260831194352.1185860-1-robh@kernel.org>
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
index e4d7da0f4434..e2f49b37e18c 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -221,7 +221,6 @@ static int tsc2007_get_pendown_state_gpio(struct device *dev)
 static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
 {
 	u32 val32;
-	u64 val64;
 
 	if (!device_property_read_u32(dev, "ti,max-rt", &val32))
 		ts->max_rt = val32;
@@ -237,8 +236,8 @@ static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
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

