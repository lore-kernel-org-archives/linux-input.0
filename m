Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73CE3B71D3;
	Tue, 16 Jun 2026 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781609229; cv=none; b=bTHFOkERh3UxcvfJTPXHc8O2t4XTuE1PTH9C8hjuY8ux+yc/95kR4wZB+w0dD7C6nHGJKPmLluJ4AjfnezpffmBAP/jlsxhBLbsJIW/eU8Zdn8qEtZTQaDK84RPievMVtnYDTelhw9xoVbgUO+g1XLkr33C9bz588s7AjYhzqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781609229; c=relaxed/simple;
	bh=gzInbLIwgr1bYPLpB47qJf4xqldqS4PcGB+etD2FsPI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aYQ9W265TW6j7LLIsnlLmZg87nNXt+rrknwS+CBiADFgqV5JcmViXvu67s/HnP2pg/5sHm+DKcPggiRi2TH7kLuc5CshDo1Xqu7r49cCRyUuAyUU/34Z+wKKSA53qBvxFewM7GCFZS81YqOEHV499IYy5oJgyEvqpHC+fY4hGRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XECa+FPk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XECa+FPk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F551F000E9;
	Tue, 16 Jun 2026 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781609228;
	bh=OIJwcNvVp9saFTDSTPnnxmVDNFS7Z4DeWeQLdLU2dHg=;
	h=From:To:Subject:Date;
	b=XECa+FPkqIZw2dent9Gd0zHrbWIPncfjcHDVTdHaBBHkxt1APnXU33QHqo1HxmcVC
	 64lycACNQv6MW0ITjL/gcNxGuZUfClHOgu5t6fcPK2GXksI+uZoXeM69zwt4nY7NK7
	 XMnFtx0Yl/rRV1kTkyM4uNp7twr0dftEUaTHKRc/5AyJQo1S3z0XE6kE2c9AYNZRNv
	 /gHeACDg2Hxg/L9kXgLshQEnmBP34XzcSdKfK3j8neOTpLNJYUnHtSbKv6VnGN0VQ/
	 WtdeQaVg3CvskXbuGHWrdfleOhtgu9zGZQYh5FPzrAHa5l7yigc4KJFAoRBOk8F5mG
	 2OC+5cGTBFSHw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] HID: core: Fix OOB read in hid_get_report for numbered reports
Date: Tue, 16 Jun 2026 11:26:56 +0000
Message-ID: <20260616112700.1990813-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a caller passes a size of 0 to hid_report_raw_event() for a
numbered report, the function originally called hid_get_report() before
performing any size validation.

Inside hid_get_report(), if the report is numbered (report_enum->numbered
is true), it unconditionally dereferences data[0] to extract the report ID.
With a size of 0, this results in an out-of-bounds read or kernel panic.

Fix this by moving the numbered report size validation check before the
call to hid_get_report(), ensuring that size is at least 1 before
dereferencing the data pointer.

Fixes: 2c85c61d1332 ("HID: pass the buffer size to hid_report_raw_event")
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 41a79e43c82b..cf123347a2af 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2045,6 +2045,13 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 	u8 *cdata = data;
 	int ret = 0;
 
+	if (report_enum->numbered && (size < 1 || bufsize < 1)) {
+		hid_warn_ratelimited(hid,
+				     "Event data for numbered report is too short (%d vs %zu)\n",
+				     size, bufsize);
+		return -EINVAL;
+	}
+
 	report = hid_get_report(report_enum, data);
 	if (!report)
 		return 0;
-- 
2.54.0.1136.gdb2ca164c4-goog

