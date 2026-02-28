Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329943D510
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290000; cv=none; b=CqXy0QafvbhaiKewZocuupLSmPjuMME/EpSnm2JhEoioN2tM2IHBP/BZ6fC3WSQ5IzChpaV+fp6zZVAlVwkVgJHARXFYOusuQ2q4K6QfnQb7f7e7hMKYfDWs1uUFxw2joEJVErnzxE7EBvOgAWlRM7WYz+38E6jP//7ozQaTsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290000; c=relaxed/simple;
	bh=LqPaTLW5AI75ZNkQD/QdAcSIUZ/1Ek73aCVguRLEBCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6tuy0O5Y7O+8hqhtQlpmelsmCSvYm0XOk4KoAW1o5qv79H7Dz2JlkI4s9/NSYuZzKSida9sXTJIwL1w3oeFaQoZm17NNr6++cXnH9XWTFdPjL8Itzf4JZVTCO6EGxm9uPAgMdroKdeSvLwnDtB5ZDbfcjQGzmAcW2dKP2RboHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BMvz77VT; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BMvz77VT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772289997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itnmQQEA5TtzfBKuC42LtASy2zNtasPxJdWo4/puqdg=;
	b=BMvz77VTZ6tGQca8Xc2Zk7LDoiPFcp/jeyaLZqUSGvB77pko4fiRFKjIOIN1KT/zAsSP3f
	xcl/KkIFd/fubZG8u9EkivPoz/G0J73jYBUpcA/6oM2ltz0nhKld94jP2kyljxk3Do80iK
	k/HCiYILDxLtliyAl2hGq9Tz8ohSkLY=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>
Subject: [PATCH 7/7] HID: asus: do not try to initialize the backlight if the enpoint doesn't support it
Date: Sat, 28 Feb 2026 15:46:26 +0100
Message-ID: <20260228144626.1661530-8-denis.benato@linux.dev>
In-Reply-To: <20260228144626.1661530-1-denis.benato@linux.dev>
References: <20260228144626.1661530-1-denis.benato@linux.dev>
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

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index bcf3b0c7c758..6e9a3a3d5616 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1309,7 +1309,8 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
-	    asus_kbd_register_leds(hdev))
+	    (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
+		(asus_kbd_register_leds(hdev)))
 		hid_warn(hdev, "Failed to initialize backlight.\n");
 
 	/*
-- 
2.53.0

