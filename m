Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484DA16A395;
	Tue, 14 Apr 2026 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776178180; cv=none; b=HPls8ejNRSpS9+dubHwnknZVWNdj3z+YRN+2WlldDremRClCjmuCc/veOBBY3G56QORYXTxyUVoQWYmi+YlaUqr+5Bc4oWA4ouYppSMO/YZkw9xl+t2vL0BLgcF36UBtX6MIcg4gbjPIbXz+yJldnSWrL0CVQ0/AkAObDJb1Qx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776178180; c=relaxed/simple;
	bh=x7vODSmMrpMKIvj2RWcJTT3ZgcaZRevKitvpQvecFj4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MrkbjDBuu6KfL4A2slae9LgZLVwfNtosM9HWETh5R46LoSaalSqeMXe6gX3wclAVc9nkhtkb0tMJLaqJpxQspVLiQ8Qqh7iCNPP6axY0BE6mrFSzGQ4HgTR241J98PhVEY+SHDnxcTM2nRbpGZ1fHz+GQeQpa5QVfselynNGNMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4dK5SNT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4dK5SNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E3CC19425;
	Tue, 14 Apr 2026 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776178179;
	bh=x7vODSmMrpMKIvj2RWcJTT3ZgcaZRevKitvpQvecFj4=;
	h=From:To:Subject:Date:From;
	b=g4dK5SNTq9EyyRsjJ64hjiPAnJe2QcsXY3GMyYROdTrZoDOnJkRRRxU/sFxf/XYfA
	 Z1pZ1tP2Zom+Ud7Ktqa+43oOfg7bYkY0mBSTSloOfrAsInPOoaarTN5upcgMM8vyWk
	 mw5OND+RByqWh4bXpBqtgpEDVeNoq8BrUWYm0tUjmyw6DXbFynpYnZUR6wXwA5CGZ8
	 yZwiULPFd5UC+Al8bD4WgqMWlqcPlYCCkYhg43VYixC6N9iX9sGBdtPTxdEddDE3ba
	 6OaII+jFz07alHdBh7Ka0pC4K+7qx2CwVF156YqhuNG5Lhz3DhsTflX3MWaBABxRii
	 E+cKNU1BP+cjg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] HID: magicmouse: Prevent out-of-bounds (OOB) read during DOUBLE_REPORT_ID
Date: Tue, 14 Apr 2026 15:32:38 +0100
Message-ID: <20260414143238.1177080-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is currently possible for a malicious or misconfigured USB device to
cause an out-of-bounds (OOB) read when submitting reports using
DOUBLE_REPORT_ID by specifying a large report length and providing a
smaller one.

Let's prevent that by comparing the specified report length with the
actual size of the data read in from userspace.  If the actual data
length ends up being smaller than specified, we'll politely warn the
user and prevent any further processing.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-magicmouse.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 91f621ceb924..5f44129e6dcc 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -490,6 +490,14 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		/* Sometimes the trackpad sends two touch reports in one
 		 * packet.
 		 */
+
+		if (size < data[1] + 2) {
+			hid_warn(hdev,
+				 "received report length (%d) was smaller than specified (%d)",
+				 size, data[1] + 2);
+			return 0;
+		}
+
 		magicmouse_raw_event(hdev, report, data + 2, data[1]);
 		magicmouse_raw_event(hdev, report, data + 2 + data[1],
 			size - 2 - data[1]);
-- 
2.54.0.rc0.605.g598a273b03-goog

