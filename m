Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2BD2264C7;
	Sun,  1 Mar 2026 01:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327969; cv=none; b=fVyqOxBxKRYQlTpkcvCi95fKdbzsBFKcUmDPm0dnigUIa/95WsFOLYwgXMce/DoosNYEBadxXFaIUtpYe8x3nVJDJG+rYinYMFGymosDT+pSnFKdT0zEgcsWEVfvcQtJZlxU4wT+oUafYk3rXLUNBOU+0VGV1JHDrMht9umMO0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327969; c=relaxed/simple;
	bh=8o4fcosklGHxuh/5t5C2/JLIuyrCxzRe97mfDApwyXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=deDeuqwQxIni/3SvqXiijScrzeX35hO0OrxekIMaiw1oc89x5M0PMot+WW9DfS3kGgoKxCofPvfM98d5C17za9lzmSVPXOCgQn0Add53b6aGUU/B7x5N6IiqY0jKFFi8moxXM+0lui1sUhAuF0mZS7S8hKz/7IS9WN3PxLEkcaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JErvTv4a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JErvTv4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7A7C19421;
	Sun,  1 Mar 2026 01:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327969;
	bh=8o4fcosklGHxuh/5t5C2/JLIuyrCxzRe97mfDApwyXE=;
	h=From:To:Cc:Subject:Date:From;
	b=JErvTv4a9UZfHG2n9K3X11akr0+iA5JYLaoFEpA2kOqsaCduk86mepu+me+6aQvMu
	 Bi7xropkQJ7C8Sbsff45BKmoyOLoFtaN2Mw4UHneRsqP2/xrFer/hPzft6NRxx9Qcr
	 x237vP3xwlWTh/AjXiWiwo4Ea2OeSgc1+HNZ7SN5XQ3Lk+hF1lgmTqqwep6RF5Tj6F
	 VO4R+K5o0tXrcQDIrOOHm2MGrFVbDvYlDMWaegUvcs8bhmpeEIgyRWfRhCpPsoDWZV
	 0ORUw4itTqonPr6VINSQszRBi/uSwQGXXeFfXTWyxowG7YuX3FR17r0Mzwxb2QOD9d
	 4WqXi4motWvUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gnoack@google.com
Cc: Jiri Kosina <jkosina@suse.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "HID: magicmouse: Do not crash on missing msc->input" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:19:27 -0500
Message-ID: <20260301011927.1674524-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 17abd396548035fbd6179ee1a431bd75d49676a7 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Date: Fri, 9 Jan 2026 11:57:14 +0100
Subject: [PATCH] HID: magicmouse: Do not crash on missing msc->input
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fake USB devices can send their own report descriptors for which the
input_mapping() hook does not get called.  In this case, msc->input stays NULL,
leading to a crash at a later time.

Detect this condition in the input_configured() hook and reject the device.

This is not supposed to happen with actual magic mouse devices, but can be
provoked by imposing as a magic mouse USB device.

Cc: stable@vger.kernel.org
Signed-off-by: Günther Noack <gnoack@google.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-magicmouse.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 7d4a25c6de0eb..91f621ceb924b 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -725,6 +725,11 @@ static int magicmouse_input_configured(struct hid_device *hdev,
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 	int ret;
 
+	if (!msc->input) {
+		hid_err(hdev, "magicmouse setup input failed (no input)");
+		return -EINVAL;
+	}
+
 	ret = magicmouse_setup_input(msc->input, hdev);
 	if (ret) {
 		hid_err(hdev, "magicmouse setup input failed (%d)\n", ret);
-- 
2.51.0




