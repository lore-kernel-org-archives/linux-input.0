Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E283112A1;
	Fri, 27 Feb 2026 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772209843; cv=none; b=Y3HZWbNTRjzkfODZFGk0Va9lo2k+MknMPArAwr1tUafgA99WCFGrSKRGtcVkMB1p9z7vPW5tq8t1iI+qLXpHxqUTvNPCahDKFPZsmrD3HIlnddf38IZRUyB8rolLlj501mbhIGoJene0mFUTUto5/+sgW0/XLs39fwCHty7rMag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772209843; c=relaxed/simple;
	bh=cCA8k6yKPmYovw6iprPEa5UVPULy9gk/wIucX3dFQ2c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AXkIWqar+ap7oC70vQDJSpkBDLwwt1fWxpnCI7fes/cK4BruW/1kH5ILtlZWDF2vt/y/qG8MKvQkIzxYayWpP/qfRr1PHlwVjaIDT8J6I5Q7K3QmDWESSTpLWJhI6OTO5PYyEEHdHgNyvQYn+3XiiLwNnLfJ6IYNs/VyQEjWfF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDGMcNhK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDGMcNhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89D8C19422;
	Fri, 27 Feb 2026 16:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772209843;
	bh=cCA8k6yKPmYovw6iprPEa5UVPULy9gk/wIucX3dFQ2c=;
	h=From:To:Subject:Date:From;
	b=kDGMcNhK6moeobqvrDcq9Fo+ok4MH89JF8ldb08JESozTVn6LHkRlXu9u4s5B84Lh
	 7s73C+/XsjjBx9PdWDIh7rvokBcU2O4dDrM+oK85wqgBx2cWv7F6qXJ4ZpWKi2jMAH
	 kOumkhobglat7Jdza+6s4oILmz2TWNEG/Gr0y04/uGBYWRhgAoVKOxIl/yp2z/ES3G
	 6ybZkZ0mpOhU7iuS2Y7J7e/ce9DO/wtDOXoe+vk2iq3CGqA4WiID8PbBxyK0gMIKb5
	 i3QuHEnFk2q/Vd+CRSjF0bsS0pEIXqnxHFADW9e9RaNVk0zKqRWpiS11kLoNU3d9n7
	 3PPpwsnas4PRA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] HID: core: Mitigate potential OOB by removing bogus memset()
Date: Fri, 27 Feb 2026 16:30:24 +0000
Message-ID: <20260227163031.1166560-1-lee@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memset() in hid_report_raw_event() has the good intention of
clearing out bogus data by zeroing the area from the end of the incoming
data string to the assumed end of the buffer.  However, as we have
recently seen, the size of the report buffer isn't always correct which
can culminate in OOB writes.

The current suggestion from one of the HID maintainers is to remove the
attempt completely.  The subsequent handling should be able to simply
use the data size provided to prevent any potential overruns.

Suggested-by Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a5b3a8ca2fcb..1d51042e4b1f 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2056,12 +2056,6 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 	else if (rsize > max_buffer_size)
 		rsize = max_buffer_size;
 
-	if (csize < rsize) {
-		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
-				csize, rsize);
-		memset(cdata + csize, 0, rsize - csize);
-	}
-
 	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_report_event)
 		hid->hiddev_report_event(hid, report);
 	if (hid->claimed & HID_CLAIMED_HIDRAW) {
-- 
2.53.0.473.g4a7958ca14-goog

