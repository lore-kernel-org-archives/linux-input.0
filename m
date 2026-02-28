Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B643D512
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290000; cv=none; b=r+ZvbYJReBqlsFwXf8J52TvafQLrx+LQcPDRfspJQE5r0tf4CTZ0LvmKFtvg7Jw6V9rcHzvQLWeqag1eaTzY/8Hu0CdyZXTLYvJyIYyO3S+70/8UE1n5c2mK7gRu3cwOGFKEGj5mwlv5FQPobEhvm16uxKQkJ4VccChOpMsbvK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290000; c=relaxed/simple;
	bh=ZYyhJQkdtnd8QDPUZ1anLzQIQsKr2hta6/LxIh0+qI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQQGQsO1n0TziEHbuY1vjfFe4T0h5rQqaflYae/0NHUe3bbXRrjHtuFKAJ+1pN3JE4RfS0miAYa3RJfQMVcj9CuUpOq0ZJ//oisIHxekjeqT3tR/qC3LBjSQ79vpcUXXUNDxJ2LnEi9MOsWgOO0ZOwk195hIpPP2x7vNZI9C49U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FNZCX320; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FNZCX320"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772289996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06tPI1zyP9R/VLmH+jF1xBpu3FdDn3mEhwsITAJzEjQ=;
	b=FNZCX320OMDjyz3iUL8GutbeMfTYSRZgA8PvnSnXWB6rMM5/3ji+UIEl48mduoz+bzLSUE
	g1vR4y5QYtCOXmvyATmZ8D0MimCWd+lhwK411A0nGFD3WIyfIBc9wBPj77WUdiBNDluOjS
	PLOhw+UiALLBapLERrllp//YTDHNfQU=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>
Subject: [PATCH 5/7] HID: asus: simplify and improve asus_kbd_set_report()
Date: Sat, 28 Feb 2026 15:46:24 +0100
Message-ID: <20260228144626.1661530-6-denis.benato@linux.dev>
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

Make the function shorter and easier to read using __free, and also fix a
misaligned comment closing tag.

The __free macro from cleanup.h is already used in the driver, but its
include is missing: add it.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 48731b48523d..61705fd10d90 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/dmi.h>
 #include <linux/hid.h>
 #include <linux/module.h>
@@ -464,23 +465,18 @@ static int asus_raw_event(struct hid_device *hdev,
 
 static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t buf_size)
 {
-	unsigned char *dmabuf;
 	int ret;
 
-	dmabuf = kmemdup(buf, buf_size, GFP_KERNEL);
+	u8 *dmabuf __free(kfree) = kmemdup(buf, buf_size, GFP_KERNEL);
 	if (!dmabuf)
 		return -ENOMEM;
 
 	/*
 	 * The report ID should be set from the incoming buffer due to LED and key
 	 * interfaces having different pages
-	*/
-	ret = hid_hw_raw_request(hdev, buf[0], dmabuf,
-				 buf_size, HID_FEATURE_REPORT,
-				 HID_REQ_SET_REPORT);
-	kfree(dmabuf);
-
-	return ret;
+	 */
+	return hid_hw_raw_request(hdev, buf[0], dmabuf, buf_size, HID_FEATURE_REPORT,
+				  HID_REQ_SET_REPORT);
 }
 
 static int asus_kbd_init(struct hid_device *hdev, u8 report_id)
-- 
2.53.0

