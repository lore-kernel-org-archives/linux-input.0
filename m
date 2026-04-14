Received: from mail.extremenerds.net (mail.extremenerds.net [180.150.21.244])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E3923D7DF
	for <linux-input@vger.kernel.org>; Tue, 14 Apr 2026 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.150.21.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202917; cv=none; b=aA0fs26zn94FKv11yKgWK5BIGntSwz/peb5JN5ug8THWQ+ZHy6Hx7P51/23rnZi34LDGwyAZ9aBNWpVmCdk43N5ANwI5mGd0Ro18vsEf7zCmroUm08+l+qCcaJ9+xjH0nUnbVL0v92Z4B22AVCTdnrZoX19cti++XQwQzlVZbp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202917; c=relaxed/simple;
	bh=vfhNY8eaItJKHK4x8S9gLbogiBGeZm+ZwPoC32CVzyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNOG2qJjvZt3x8Octe3PMwCSD4XxiXI7X2vsPCO59JUmp+HgSI7xBD/24HpyUkjn62c1+AP9vquLmvvzxBz2xwkkZHFROkDQCAzQuecSGr+cZ8s4+ipuDxwXHEF7zuR7hOmpUA4Ko07Z0nZJh16oDaeubvkxmSoEM9v8Wcuoz8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=extremenerds.net; spf=pass smtp.mailfrom=extremenerds.net; arc=none smtp.client-ip=180.150.21.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=extremenerds.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=extremenerds.net
Received: by mail.extremenerds.net (Postfix, from userid 0)
	id 4AAE57A038E; Wed, 15 Apr 2026 07:41:48 +1000 (AEST)
From: Anj Duvnjak <avian@extremenerds.net>
To: linux-input@vger.kernel.org
Cc: benjamin.tissoires@redhat.com,
	lee@kernel.org,
	jikos@kernel.org,
	Anj Duvnjak <avian@extremenerds.net>,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH] HID: core: downgrade short report warning to debug level
Date: Wed, 15 Apr 2026 07:41:43 +1000
Message-ID: <20260414214143.23796-1-avian@extremenerds.net>
X-Mailer: git-send-email 2.46.4
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus
memset()") replaced the silent memset() with hid_warn_ratelimited(), which
causes dmesg flooding on devices that legitimately send short reports,
such as the APC UPS (051D:0002).

Downgrade to dbg_hid() to restore the previous behaviour of only
reporting under HID_DEBUG, while preserving the security fix of
removing the bogus memset().

Reported-by: Anj Duvnjak <avian@extremenerds.net>
Closes: https://lore.kernel.org/linux-input/MW5PR84MB135613E7947113897DD9FDA4C7272@MW5PR84MB1356.NAMPRD84.PROD.OUTLOOK.COM/
Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Closes: https://lore.kernel.org/linux-input/6256259.lOV4Wx5bFT@natalenko.name/
Signed-off-by: Anj Duvnjak <avian@extremenerds.net>
---
 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 833df14ef68f..de8a179347ec 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2057,8 +2057,8 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 		rsize = max_buffer_size;
 
 	if (csize < rsize) {
-		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %d)\n",
-				     report->id, rsize, csize);
+		dbg_hid("Event data for report %d was too short (%d vs %d)\n",
+			report->id, rsize, csize);
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.46.4

