Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E19F1F09A8;
	Thu, 16 Apr 2026 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345423; cv=none; b=AZkuO0aBkJWcwv1qSOPXZUnkAJ2xZmkhCq0PzXM8sqRyBVOtQEiDzzzuiH5zqHoQO62LnKZpeCHeQ6IcrY3+myr6pbyjhmxHtvkpDLjH6WhBK5jN/TQ8oeJP6ALQHBPG8ofA378dZLOLw+eQdcvSd8ZwzRP/P0TzOaf+SWZ7eiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345423; c=relaxed/simple;
	bh=Cci4igCj/oFKxfanEuLe+wUyT8SlKY8NAJHzJcUUWA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lCH5bowuYdADpiouNjkOWsMchxnXdiZ1uO7X21r/yrULOlKD5qzxUO6By++bQCzAfqgP1OglZfFA4lnQqVOKVPQTkUI393YEP2dlI9odATBWObQMPj4v4p9mBas/51HxlTYojVoZ0RM3XJ5jTEqOuZnswvZELs4AnpjRHrn8sZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbNrLxKm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbNrLxKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38A5C2BCB6;
	Thu, 16 Apr 2026 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776345423;
	bh=Cci4igCj/oFKxfanEuLe+wUyT8SlKY8NAJHzJcUUWA4=;
	h=From:To:Cc:Subject:Date:From;
	b=AbNrLxKmWHQ/uaZ5fEHSmdZjzyZaSCuYRpmbUMR8+8B/Fiij9Cv89R4ENcjKl26MX
	 y9yAbi8raPdNwPlput35dL1Y/NL+jB2cwRREGS+ubWaQ+qEvSXaFTzldAUTBgWdajj
	 dVCc2lUuJt0NeI1AxI44zGeUe2ffPybV/K2mme1FaDVHCMnCw2JnJ+Nrd5lAGRt+BE
	 Bl4gcc7h6gUA4SygrriBGRYXc4yDRvucMbKT6FmSX+WejZFr8zjDpoiLMWAGyzUnff
	 M9k+hrVqP94o+/GX5r0Iu6NqeX8D6FYyAdnycg6zZnrK9Wp/3DpuxkPGBVWB3E0tZk
	 zjFNo9wUtOdLQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: gnoack@google.com
Subject: [PATCH v2 1/1] HID: magicmouse: Prevent out-of-bounds (OOB) read during DOUBLE_REPORT_ID
Date: Thu, 16 Apr 2026 14:16:54 +0100
Message-ID: <20260416131655.2279756-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
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
v1 => v2: Add more size checks to protect against issues during recursion

 drivers/hid/hid-magicmouse.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 91f621ceb924..e84e6b21d113 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -390,6 +390,10 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	struct input_dev *input = msc->input;
 	int x = 0, y = 0, ii, clicks = 0, npoints;
 
+	/* Protect against zero sized recursive calls from DOUBLE_REPORT_ID */
+	if (size < 1)
+		return 0;
+
 	switch (data[0]) {
 	case TRACKPAD_REPORT_ID:
 	case TRACKPAD2_BT_REPORT_ID:
@@ -490,6 +494,18 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		/* Sometimes the trackpad sends two touch reports in one
 		 * packet.
 		 */
+
+		/* Ensure that we have at least 2 elements (report type and size) */
+		if (size < 2)
+			return 0;
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
2.54.0.rc1.513.gad8abe7a5a-goog

