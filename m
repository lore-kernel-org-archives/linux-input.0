Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D3E3F9338
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305827; cv=none; b=PK8Y11f0YvW1cr3hN61cW/Ke7co31fFtOYrDQtvc9KvUcRImh1KKQlsbhJQVrmXqB/eQXSUigwbnKGZB+Apz/f8iA1RFmoZUrPMad0F+k5jckVGkywhvQ9j6KaQqEeGWO41aCA1HV40OOSXrO1RGGX3FqeDXYJRcLS6gtgHaHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305827; c=relaxed/simple;
	bh=yHtNrxb6RKeEMvwyoM6DYSEQq5BjHIRjmQEhkK00GiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMVTlIz6kaFrOuUoZ/NFU3LdT8uV4YBaRgf2y87rKFd+gc+yrUy1sp80mTQwzrVRfkK3gir+8zFja7AocnhWlHHkrKLoe5tpyDDv7vo6qNHrT5jYEjneocFqq9pkxU1c4jTdnXKFovQPNOr/KlYUuvTBoA0ov4QaXLDRewSkUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PjVld2OE; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PjVld2OE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772305824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZ0ptMQdDcnwROywUM/EVbQICnD3WeNoaINlJhVc+bo=;
	b=PjVld2OEEb19FJ/u8Z73WiTKx7UDM5qJG06V8bDrz+QhVMqVckVswtxu/c6gxeAs2mWAJb
	8dNTZCSZ5xVzBSLsWlOiUA4/8pDkNI681ucQgoyBASw7KaLL45Uj2qOKW/8qudbKy/R8Q5
	vS2tpQT00xxt6AkDcEHIoCMZRfEYdMA=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>
Subject: [PATCH v2 3/7] HID: asus: fix compiler warning about unused variables
Date: Sat, 28 Feb 2026 20:10:06 +0100
Message-ID: <20260228191010.3830758-4-denis.benato@linux.dev>
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

In the function asus_has_report_id there are 3 unused variables clang
warns about: remove them.

Fixes:0919db9f3583 ("HID: asus: always fully initialize devices")
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index fbcf38b15290..2b4411399571 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -723,10 +723,9 @@ static void validate_mcu_fw_version(struct hid_device *hdev, int idProduct)
 
 static bool asus_has_report_id(struct hid_device *hdev, u16 report_id)
 {
-	int t, f, u, err = 0;
 	struct hid_report *report;
 
-	for (t = HID_INPUT_REPORT; t <= HID_FEATURE_REPORT; t++) {
+	for (int t = HID_INPUT_REPORT; t <= HID_FEATURE_REPORT; t++) {
 		list_for_each_entry(report, &hdev->report_enum[t].report_list, list) {
 			if (report->id == report_id)
 				return true;
-- 
2.53.0

