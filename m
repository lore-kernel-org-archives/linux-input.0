Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47F439017
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772289994; cv=none; b=KdKhzVVZyBYMRQiAWNKcoE8UBWivThRx8BYOWAetiVbksaVmYzfJ9YmOnzP/cZ7+9B2vOpEimzbWhnTmXB6BNmIvD55QHUWhc+OzQeCEvWaIfWHmO3GBrBHwjtSz2y5jyzqHFdv1miSydB+Ed35YIdr+nh0aBaejT/lZRL2+qPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772289994; c=relaxed/simple;
	bh=zgNG83WO+5qFxYkeXCc8cWN8flAQFaJPnmP22z8TkWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/dgXyyIw1HA1gz1ziwtW+RBM2XEkR5hoPDGZvjBORZz7G2IWv6+p6RgfFQiHEdT6r9mnch33Ed570KFccaRjNGXd+eG3dhdlb6ErNNh53Rik12o6lQL8aGk284MA6R2szuTs9AQhA9Jb0+TnK6t2H2b6RYgq0UF3w5HyY0RgfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XpOQ2JIJ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XpOQ2JIJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772289990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8ZWoUXilN7rq9eoSEwgxiKdI4SoSqyZwtNrXIWLO24=;
	b=XpOQ2JIJMF+awRkByumNkmXb5W9apC9Cae87XpYFDIqnGsNvfSop3c3gXCOIcJ1U/TK0Ph
	lkM0OWTPcsdlhBkmxw9/pM4AX6IXXbZuhZoty2FmStdAxHbjcnXlBKKHZ7XQWqXXaeBQiS
	YVmOjkqSPyCgSeWVRyZQMHRoz3GWNzU=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>
Subject: [PATCH 1/7] HID: asus: fix code style of comments and brackets
Date: Sat, 28 Feb 2026 15:46:20 +0100
Message-ID: <20260228144626.1661530-2-denis.benato@linux.dev>
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

In asus_raw_event there is code that would violate checkpatch script
such as unaligned closing comments and superfluous graph parenthesis:
fix these stylistic issues.

Also remove an empty comment spanning two lines.

This commit does not change runtime behavior.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index ffbfaff9f117..5fcb06b16167 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -20,9 +20,6 @@
  *  Copyright (c) 2016 Frederik Wenigwieser <frederik.wenigwieser@gmail.com>
  */
 
-/*
- */
-
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/hid.h>
@@ -359,7 +356,7 @@ static int asus_event(struct hid_device *hdev, struct hid_field *field,
 		      struct hid_usage *usage, __s32 value)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
-	
+
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ASUSVENDOR &&
 	    (usage->hid & HID_USAGE) != 0x00 &&
 	    (usage->hid & HID_USAGE) != 0xff && !usage->type) {
@@ -448,21 +445,18 @@ static int asus_raw_event(struct hid_device *hdev,
 		/*
 		 * G713 and G733 send these codes on some keypresses, depending on
 		 * the key pressed it can trigger a shutdown event if not caught.
-		*/
-		if (data[0] == 0x02 && data[1] == 0x30) {
+		 */
+		if (data[0] == 0x02 && data[1] == 0x30)
 			return -1;
-		}
 	}
 
 	if (drvdata->quirks & QUIRK_ROG_CLAYMORE_II_KEYBOARD) {
 		/*
 		 * CLAYMORE II keyboard sends this packet when it goes to sleep
 		 * this causes the whole system to go into suspend.
-		*/
-
-		if(size == 2 && data[0] == 0x02 && data[1] == 0x00) {
+		 */
+		if (size == 2 && data[0] == 0x02 && data[1] == 0x00)
 			return -1;
-		}
 	}
 
 	return 0;
-- 
2.53.0

