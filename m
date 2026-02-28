Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1F43D519
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772289997; cv=none; b=lvXE/XgsaWx48iaAJea+sTYjVvkiPvAMEGzZE7u85ynMwQ7AG8XWyo5gLmjZpbN+QJaud0YUm3cJq5Cz9LzMgyINWw8m52+UU9T3jRjvNV3eid7aVzFo/F4qNpWSK06nOdQcIX6ix6jYi8/qCiVGnfswW3qLZSMBvuQKCVjvSDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772289997; c=relaxed/simple;
	bh=yHtNrxb6RKeEMvwyoM6DYSEQq5BjHIRjmQEhkK00GiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jc8zwA6Ks++E+DK+BfnPOoNbg1c2OcuWgua3ZlCxhznbd0ofUl1papWHsmVY2dSMUg66ty/CzwiQtyA9kbwS8RPSU+P+navIageIBFWAbvzKwW5rKDtCpNkMXAEnWtEqIWIJyCOFT2OQd+0Iq2YqcGbyG4i3FBd0xLKQNWzfjC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ss3/BGAc; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ss3/BGAc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772289995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZ0ptMQdDcnwROywUM/EVbQICnD3WeNoaINlJhVc+bo=;
	b=ss3/BGAcPpCzdcOPu/CyY9Cua7jbp5SL/vEETSKOWdA4kYg1ItiIh4Sm5x8ErnRbn9NYq/
	ZUlAlDjMzuH57co4n3F5HEQMW1ZHg1u3/vr1Q1eM1a31DcxTKjWvoJyWaOYKdJe4zjmMad
	BlNBXbRzMPCI3ADK0IfBZ08G0iR56qc=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>
Subject: [PATCH 3/7] HID: asus: fix compiler warning about unused variables
Date: Sat, 28 Feb 2026 15:46:22 +0100
Message-ID: <20260228144626.1661530-4-denis.benato@linux.dev>
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

