Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE2D37756C
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781364645; cv=none; b=BBhRBVogmQG4XXUZ29/5GuEOA+FwjurgLCN5DCuH46a17HZ59C+9wRgxcvfowiOQNkMHxz2rz2Gb2oogXTnfn1+OQku4V5HyNrnxTRbEx4D6VxwgtiU8YAU4JHsqlb4nan1qo0Bq+so3/9X2gfmH5bsdP08MsMlAKNEEooVdQ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781364645; c=relaxed/simple;
	bh=VusbUj8p+T+MFMkvMCqRDytDwrMT7MDJ2YBcoYaEGgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnpeAGeu/PeOe5731TSwIhcy2XyXCBucet3tduwY1kQerdqgFAreNfONOG7O4mRq36yYX2rJZ3IHxWUAxiRBNYiQYpDeJ8p+OzP9G2aaq475FPlThu/loCtLkc4hcySvv0/GcS8f7oTl3PQOzCLfAavPUk6tkS2d2TNI50DaVpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hQ1kKL4+; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hQ1kKL4+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781364634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFD1GicoxE0fLhqpGTRi6m4boj42UehFQ0rfHVzbp5E=;
	b=hQ1kKL4+O90yqOOv6WPu8JEdzPIQvCRVf8bIPH8FABO0QWlff8XjTU8B/ppeqS3K8z6Z2K
	KaOZblyPi+WDRFV8OSC+BPV+1pgEQ7TH/7EftH3qdrkMu39/P8u3XnOB57BcwddITQBcm8
	9KiCSrWmRT9mmoR/V91eSRXjMt36E6I=
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
	"Connor Belli" <connorbelli2003@gmail.com>,
	sashiko-bot@kernel.org
Subject: [PATCH v3 1/8] HID: asus: mitigate possible use-after-free
Date: Sat, 13 Jun 2026 15:30:22 +0000
Message-ID: <20260613153029.2559774-2-denis.benato@linux.dev>
In-Reply-To: <20260613153029.2559774-1-denis.benato@linux.dev>
References: <20260613153029.2559774-1-denis.benato@linux.dev>
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
Reviewed-by: Antheas Kapenekakis <lkml@antheas.dev>
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

