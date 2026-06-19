Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C62AD03
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 00:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781827908; cv=none; b=Vy1IQdjQjpA3wCudHwbla3c+GrrZPHO7tdts3MF8mtgWAoVoSAUHPRxRqR7ws/xTdllMMycKbCcN2m56MZY86+iyGRtPPHDdc/z+yFUasuMlUqRnKilQPz/aeaJNud+XwldXIRe1vGS3uN1stQSUywE0HX3yK6U8I45h/25syjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781827908; c=relaxed/simple;
	bh=d/94336IJYKhNzc7tCO53aOwwlniBJUm3r6xL9weX98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2ZGvtvZJj/c8XX7cT17c2n7rVgA/CVrjO+r2IvjO48r6nZp4NFpsqA4I/ux0b3qt5JmIK+880q8/Gbnps+1+wvD99HRbhHgMmhM00x3awVgZu4TrlUe7mBPFkVVXMKGFaRifQZZBj8CpcjAIQhYfkWBPCzCDPDEYSWcHT6c4PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FlbvxBKG; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FlbvxBKG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781827905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ngO2cxlMaBepRwMRumzLRhZm+oDZptROdmMyfq0o3E=;
	b=FlbvxBKGBrSU7UL4hglgWzrxEo2kylT54j7pyEzM5bHuI8h3fOV3NK80R18nl19riCaKPl
	RTzGtixG93PqsPVerTEflxIc4mA5f54gUwg241jEEWHFSplJIZdUPRhCyU+wpvxd9r5r0K
	QjBanaSZoOMDCA7tzMizokrb5Yi853I=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>,
	"Antheas Kapenekakis" <lkml@antheas.dev>,
	"Connor Belli" <connorbelli2003@gmail.com>
Subject: [PATCH v5 3/5] HID: asus: fix a off-by-one in mcu_parse_version_string() validation
Date: Fri, 19 Jun 2026 00:11:01 +0000
Message-ID: <20260619001103.1189200-4-denis.benato@linux.dev>
In-Reply-To: <20260619001103.1189200-1-denis.benato@linux.dev>
References: <20260619001103.1189200-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In mcu_parse_version_string() a size validation for response is stricter
that it needs to be: relax the check by one byte.

The device always answer with a greater byte count so this does
not introduce visible changes.

Fixes: ("hid-asus: check ROG Ally MCU version and warn")
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index d31e71ce3d19..0fb8cd6437b7 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -841,7 +841,7 @@ static int mcu_parse_version_string(const u8 *response, size_t response_size)
 			dots++;
 	}
 
-	if (dots != 2 || p >= end || (p + 3) >= end)
+	if (dots != 2 || end - p < 3)
 		return -EINVAL;
 
 	memcpy(buf, p, 3);
-- 
2.47.3

