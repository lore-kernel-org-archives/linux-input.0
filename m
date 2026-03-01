Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8782F49F1;
	Sun,  1 Mar 2026 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329762; cv=none; b=jEc2NmC9leWXw7GLr1T0gq9HBPTYd4c1bEqfvVy/RTcs5ErZQUqoWJblxEspi3Q5VYlDbF2scom3zpq3Tri2AYSEJsUNDI0PaC9G1xgh88FJ74o48p7/W/MdhG2aVjMcAZs1vtRKW5AKh7wuOel9l2bPRAEbYf6EzTqQ2S2gsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329762; c=relaxed/simple;
	bh=SyIet/sO4mB9NtNNPR38C7ZQQPvB6HO8vnMykeHjY0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tknIaOp23cK+jCciKjrheV/PRkJ2uWg+KE0vU4thx/3KyUcmbimvClr7oGSiRm9uLbWBLMalYKCIvip0MGmBFniUuiWGVbNC0i9A1GfR1I96yqErg9dPtCkOUXyNTWqCwpYYNcfLNjcRl8ANlSNsWbTnwdGi7ZjJa10ikeunFnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRyFwtls; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRyFwtls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDEFC19425;
	Sun,  1 Mar 2026 01:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329762;
	bh=SyIet/sO4mB9NtNNPR38C7ZQQPvB6HO8vnMykeHjY0c=;
	h=From:To:Cc:Subject:Date:From;
	b=mRyFwtlso0+pJC8Ced6gkxN7k9i08Zn+mnS6cTrTCJy4ApY+Yky/Knu3nbnUczuoV
	 3PHDOcOTfpc5It/VS+pTonR5akmhjXX3xtUj+sfA93EXEf39NfdXXGUs1szXmG3XGG
	 k+zWBT2GHBGKr/hkIPqnyWC5zuE5WjEUn/6RAkspGq0Jski9VXW59etWJtPfL+wKeC
	 oEPt73kE2ADCwYdZamWT3BE3V/aKJABFylHWyJr8U1W117pJNjZTBP7i7YIClkn60t
	 tZ6bjxJToT7x22II8YS8dAfRygIlTiNar68qRGdMlstWSY0lG2wthDaa3BxvdKSTHT
	 Jmq/C4ZDzu9Mg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gnoack@google.com
Cc: Jiri Kosina <jkosina@suse.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "HID: logitech-hidpp: Check maxfield in hidpp_get_report_length()" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:49:20 -0500
Message-ID: <20260301014920.1713777-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1547d41f9f19d691c2c9ce4c29f746297baef9e9 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Date: Fri, 9 Jan 2026 13:25:58 +0100
Subject: [PATCH] HID: logitech-hidpp: Check maxfield in
 hidpp_get_report_length()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Do not crash when a report has no fields.

Fake USB gadgets can send their own HID report descriptors and can define report
structures without valid fields.  This can be used to crash the kernel over USB.

Cc: stable@vger.kernel.org
Signed-off-by: Günther Noack <gnoack@google.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index e871f1729d4b3..d0a38eff9cfa8 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4314,7 +4314,7 @@ static int hidpp_get_report_length(struct hid_device *hdev, int id)
 
 	re = &(hdev->report_enum[HID_OUTPUT_REPORT]);
 	report = re->report_id_hash[id];
-	if (!report)
+	if (!report || !report->maxfield)
 		return 0;
 
 	return report->field[0]->report_count + 1;
-- 
2.51.0




