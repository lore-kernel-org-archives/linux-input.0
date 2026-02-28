Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22943F9342
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305828; cv=none; b=hIJWt4PiMQ02tnYv3qTZb+WC6gXFBk7GjGGSl8+fvaR1ovDIT2aaUuaX1/qP/vc2aSyQ/PP/fNsYf/Sf6tTj3sEGzHLGfVT+1mnnG7Uefj7I70E5D6KV/XiXZ0kpVQUmNl5sf6zeaQvVooWi5Ls0qwXHHf2K578W6cRY9uirI+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305828; c=relaxed/simple;
	bh=RLfUS5tra/gyyd3lDFT3Jo+sr3I3Gar7nGUgIP4tNNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dP3SAh3J5SmGnBjs63iOFI6eYH1mL/jdQABacuzv3DqFBDGrsy6ehQB7dCbE7rBTeYSLFHf4/h/FqRdHYGob8Z3wjSGklXlHznEB63BQZ7+xgY5FXgz69iQyjA9ZPK8bMQn/MIB69PKufsN6UIi+P+tDo9UfjSlW2FhIS7QT9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fss56nmY; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fss56nmY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772305825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/JjveZr9Jn4MeDPTXiAb+xofPvVBJSGHbnUYefB24Q=;
	b=fss56nmY0Eu1+BT5YM+hB3ZsFEpfRXr47o9fxNzx+QTYpAMEyup/o6jthnoviVIBJDWqO0
	jK1IKfaVdETm0Osq/yK+Cf6X9EKC8gyAYytTPoT4U7vKwV1BzadS+BdRDTgWMn7O2f46RN
	0ZVzYtp8z9o5DazNVbstvK+YQwRaXjE=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>
Subject: [PATCH v2 4/7] HID: asus: make asus_resume adhere to linux kernel coding standards
Date: Sat, 28 Feb 2026 20:10:07 +0100
Message-ID: <20260228191010.3830758-5-denis.benato@linux.dev>
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

Linux kernel coding standars requires functions opening brackets to be in
a newline: move the opening bracket of asus_resume in its own line.

Fixes: 546edbd26cff ("HID: hid-asus: reset the backlight brightness level on resume")
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 2b4411399571..48731b48523d 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1171,7 +1171,8 @@ static int asus_start_multitouch(struct hid_device *hdev)
 	return 0;
 }
 
-static int __maybe_unused asus_resume(struct hid_device *hdev) {
+static int __maybe_unused asus_resume(struct hid_device *hdev)
+{
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
 	int ret = 0;
 
-- 
2.53.0

