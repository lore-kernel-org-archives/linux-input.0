Received: from mail.extremenerds.net (mail.extremenerds.net [180.150.21.244])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4853A9D8C
	for <linux-input@vger.kernel.org>; Tue, 14 Apr 2026 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.150.21.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776207622; cv=none; b=AVP+3jJruNO08Nc1xqbZ9tiEqQiYqlADgG9kky8amo27awV/9bHDnf3Ra+Nc3Wdp5cBFP8ZfeViedhH6Mt8a8Pt7qX4Z0Q/ywEC24cjqS3joIaJajFmOM3D1YnoOXlVEqsgZQZoF0jR352Bwi0SO+2oBu0Qx0dH7CGCR+IZ5Np4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776207622; c=relaxed/simple;
	bh=hp/cVYrN5yFks5044VzVD2zRsTHsIbaRYr2Ev7je3Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kgcqsw1PX82FVl5mQyGH7fdg6FDYEmwo+PFViV8dQNqvlxhTEt92TlPMKGwTIXov4MXHimEOPZ4TSU9OQ9ln7LCZx1ANSKYphUVDzLzEaEx2YIv3F0S4ZXxWTPEk5xicqChJ5OfvvcVYoQeWckY1V9Zh0RGPzbaIZFN8N8OVlnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=extremenerds.net; spf=pass smtp.mailfrom=extremenerds.net; arc=none smtp.client-ip=180.150.21.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=extremenerds.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=extremenerds.net
Received: by mail.extremenerds.net (Postfix, from userid 0)
	id 8D0C27A038E; Wed, 15 Apr 2026 09:00:19 +1000 (AEST)
From: Anj Duvnjak <avian@extremenerds.net>
To: linux-input@vger.kernel.org
Cc: benjamin.tissoires@redhat.com,
	lee@kernel.org,
	jikos@kernel.org,
	Anj Duvnjak <avian@extremenerds.net>,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH v2] HID: core: downgrade short report warning to debug level
Date: Wed, 15 Apr 2026 09:00:17 +1000
Message-ID: <20260414230017.30217-1-avian@extremenerds.net>
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

Downgrade to hid_dbg_ratelimited() to restore the previous behaviour of
only reporting under HID_DEBUG, while preserving the security fix of
removing the bogus memset() and keeping rate limiting in place.

Fixes: 0a3fe972a7cb14 ("HID: core: Mitigate potential OOB by removing bogus memset()")
Reported-by: Anj Duvnjak <avian@extremenerds.net>
Link: https://lore.kernel.org/linux-input/MW5PR84MB135613E7947113897DD9FDA4C7272@MW5PR84MB1356.NAMPRD84.PROD.OUTLOOK.COM/
Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Link: https://lore.kernel.org/linux-input/6256259.lOV4Wx5bFT@natalenko.name/
Signed-off-by: Anj Duvnjak <avian@extremenerds.net>
---
 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 833df14ef68f..f30091509517 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2057,8 +2057,8 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 		rsize = max_buffer_size;
 
 	if (csize < rsize) {
-		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %d)\n",
-				     report->id, rsize, csize);
+		hid_dbg_ratelimited(hid, "Event data for report %d was too short (%d vs %d)\n",
+				    report->id, rsize, csize);
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.46.4

