Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF9B385D76
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274222; cv=none; b=IRqKaJyuzkeT5d+8+7fYw8Q5xUcRf5YlLLnlrmFteYmvSXPcn4PbnV68fCpBvpD42w06O9VLs2A3GPitUs7k9PtBcY+wk/51OLWS7t92qqnQ5FYOiF480o566t7qvYvMWlCVMm4hKANx25E1mBy/PLTo2f5S2T4/vg6HZw4Mzso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274222; c=relaxed/simple;
	bh=bm/CL3q9ejoze6VSO717GlRBQqyQ/Zo6Af21rb7hwR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUO8TaZilaihWTfhCSJO7jLHOp3QOV2Rszf8nEGuqTcuN/FKGVx0aG7Hw3ogDu3lXgHnBSR9H3g65SHvorUcImH65ocySn7ARMO6evPPsX2Ri1bTQ1UZhs5ODRa/rfv1kVTbjwYLvt9rsdsRyXf5E/bmBkAyr2Be//bLwt+rdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KtLowf1X; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KtLowf1X"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781274218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtSKOlX/bb+/YvFJzqUT89tz4pQYiTDPxpw671CWEgY=;
	b=KtLowf1XIP0ynKQLKfrc/l0Iz/3nF6wxc6nB3SQjjVHGUTKUzlH3C9c8cMiw9Y4ULbz+J8
	2pEueQyOw5xGA6Kz5GflhPh50zh8pwPsKbcreccNnf045bM5vpRxWDxsjPzzAIGtfME0nD
	IEMgrrORSeyKUqpFKkogNZjGaiMhQyY=
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
	sashiko-bot@kernel.org
Subject: [PATCH v2 1/4] HID: asus: mitigate possible use-after-free
Date: Fri, 12 Jun 2026 14:23:23 +0000
Message-ID: <20260612142326.1704858-2-denis.benato@linux.dev>
In-Reply-To: <20260612142326.1704858-1-denis.benato@linux.dev>
References: <20260612142326.1704858-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The kbd_backlight pointer is not being set to NULL after being freed in
asus_kbd_register_leds and other portions of the driver checks that field,
therefore set the pointer to NULL after being freed.

Link: https://lore.kernel.org/all/20260612130125.AAAE71F000E9@smtp.kernel.org/

Suggested-by: sashiko-bot@kernel.org
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index d34d74df3dc0..4d7110b892bd 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -777,6 +777,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 	if (ret < 0) {
 		/* No need to have this still around */
 		devm_kfree(&hdev->dev, drvdata->kbd_backlight);
+		drvdata->kbd_backlight = NULL;
 	}
 
 	return ret;
-- 
2.47.3

