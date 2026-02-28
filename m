Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B13F9ABA
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305829; cv=none; b=gaC0c4CatehzVfl4EkzOIwGlV/z0TQYgs4QUnQYgzbNOYdGcpdB+7t7aHpNxauX9bVTiIlftcBx983xer/gFTzL0T9mHIbCTPyUOk+/oW8AvhZT/fsqbAIy2S+FvX5bbd2ilhX9EfarHbqQcA2yBfkUuKCUXMd8e7u6J2Xmj/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305829; c=relaxed/simple;
	bh=+hO6iQf23aDHJWjlmmPPmW0kYzSr2lluvlArNaY6iJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOhjNvmTWNK193sslVvL5+xAvhS3vhwxqyv6dqCNXClMoeYQ4haFL/8O8/D8TZAh32YNGhIHuIyVEYMfAS9ybbFg7wqFWMmVKXnVaz4v/6oSzfA7qbxqF5aJl2gt3OuimEvI7rBMonmIAlebzz6sy4Bvu5KA3d8w42zO+Chf9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r7eXozvH; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r7eXozvH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772305827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hK9pvyiMFiVuWdo7FDW6CctiOnWHX4mo/tf9t+wwwNk=;
	b=r7eXozvHQ32tE5sARGteH4/yX20HjUb5quDUCkbpSTmnNIWIbc/wdRAmf+GRWjBe3hd6Es
	3O+qQ6jBhkrPARTvqYmx14iYfvGkTf3WQY283BxbkeXBnNvx3PpY9m0wydz6wBozIg+Kf9
	e+wIoVq3niYw/ZrfwR4WtJHrLpew+xY=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>
Subject: [PATCH v2 7/7] HID: asus: do not try to initialize the backlight if the enpoint doesn't support it
Date: Sat, 28 Feb 2026 20:10:10 +0100
Message-ID: <20260228191010.3830758-8-denis.benato@linux.dev>
In-Reply-To: <20260228191010.3830758-1-denis.benato@linux.dev>
References: <20260228191010.3830758-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Avoid possibly printing a warning about the inability to initialize the
backlight if the hid endpoint doesn't support it.

Also fix and move an incorrect check in asus_kbd_register_leds(): that
same check is now used as a precondition to call that function.

Fixes: 0919db9f3583 ("HID: asus: always fully initialize devices")
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 5780e70aebd5..9291f23c10b7 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -737,10 +737,6 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 	unsigned char kbd_func;
 	int ret;
 
-	/* Laptops keyboard backlight is always at 0x5a */
-	if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID))
-		return -ENODEV;
-
 	/* Get keyboard functions */
 	ret = asus_kbd_get_functions(hdev, &kbd_func, FEATURE_KBD_REPORT_ID);
 	if (ret < 0)
@@ -1306,8 +1302,10 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
+	/* Laptops keyboard backlight is always at 0x5a */
 	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
-	    asus_kbd_register_leds(hdev))
+	    (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
+		(asus_kbd_register_leds(hdev)))
 		hid_warn(hdev, "Failed to initialize backlight.\n");
 
 	/*
-- 
2.53.0

