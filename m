Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8D635C6A7;
	Tue,  6 Oct 2026 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299230; cv=none; b=edI+FpsoBVfrlCBjM9tW2WRe0aoyx7BiJ7r9cU8oyfl+OuPAb/B0Otcuta5LQOKiaYYVs6Csij9l90rL8H7ERYYwWiHBBwgTtJdGcXhP4CnkN+5zZsgjddcifqmA5rWji8D9wWNhaYSmxB27lLaY1Nu5o8J3+imqrX9hiiRwdMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299230; c=relaxed/simple;
	bh=7yktdAY9yUfIqZGz/JEBEteZ14h7xZPkoOwH3LXmM4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=vFDeMLKj7UM+4BRveJCPIylaXHGmJ51zqbcZKnAPbldS0GL3PuYC7C4iDEXbiTaBauAzfuFGxdZcjQ7Oe9PKs1CK5zFyrYzNDWxlu5PMs7WyEdzVThdsd94m2m4OT4/7XDrs79bkr/aOKjTMGcQ2ur9616Aa1AZef2zFNDI8VIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkhY5VOJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkhY5VOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 437AAC4AF60;
	Tue,  6 Oct 2026 15:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791299230;
	bh=7yktdAY9yUfIqZGz/JEBEteZ14h7xZPkoOwH3LXmM4U=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=RkhY5VOJjHJETNBLwPvOZA9rjg1sCxAjij2OTIwRyPpTN7bq8dOXBjkOYgf90dE/8
	 /g41rr7IdecyVut1uX/JByLtxLCrKesqxSe044HnryeaLV6aoe5dPq9mdJrxKr0fab
	 jROCej4Ev4Uc18YDc/sFvAq+F03p9BkxRHiWHLwu5FyzgeA4h1aXtU1Of7A4SBKSKX
	 Y+MbzwgI3FNNKjamISBOoSAb7ke8MtRHuZ4RnRVDrmtWRgNMSc9On6XlFkdCPj8aDE
	 oHwHMoaTQSZ8rZkh7/SKBb5C0oxfGtMV2MGO03fz3Od96U0WLzZP1rZTPwRebeyWjo
	 m0djYnB7L/Aiw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFA0CA5FED;
	Tue,  6 Oct 2026 15:07:10 +0000 (UTC)
From: Shashikirana H K via B4 Relay <devnull+shashikiranah.chromium.org@kernel.org>
Date: Tue, 06 Oct 2026 15:06:59 +0000
Subject: [PATCH] HID: vivaldi: Validate Report ID and length in feature
 mapping
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-upstream-vivaldi-fix-v1-1-bbc9a7f14ea6@chromium.org>
X-B4-Tracking: v=1; b=H4sIAJIOxWoC/x2MWwqAIBAAryL73YIJSXaV6MN0q4UeoiVBdPekz
 xmYeSBRZErQiQciZU587AXqSoBb7D4Tsi8MSipdS6nxCumMZDfMnO3qGSe+0TRyVMaZVrUaSho
 iFf1v++F9P2ZpSF9mAAAA
X-Change-ID: 20261006-upstream-vivaldi-fix-950b29c98286
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Stephen Boyd <swboyd@chromium.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tzung-Bi Shih <tzungbi@chromium.org>, Sean O'Brien <seobrien@chromium.org>, 
 Shashikirana H K <shashikiranah@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791299229; l=2360;
 i=shashikiranah@chromium.org; s=20261006; h=from:subject:message-id;
 bh=uAkI2tjfGATd6F6F8iPXHLDEZi+ZRl+aVUmYMofx0kI=;
 b=ueu7dpcwaxS7DUKnNMIqB9NbKhf3V7YFPhuMO2Cr41iJS0zivr3GaHpR8KorQ6XDKYpMI6Rum
 HpvsCMrqL7IB3Jh0y7GnPTGMMQ64vgnty9Y8O4sbDBvqhzUlNvS2c3t
X-Developer-Key: i=shashikiranah@chromium.org; a=ed25519;
 pk=bCw+8sjBcORxp4WEsvVPTz+Jb/+irkV4RK/8uR5xsYI=
X-Endpoint-Received: by B4 Relay for shashikiranah@chromium.org/20261006
 with auth_id=1124
X-Original-From: Shashikirana H K <shashikiranah@chromium.org>
Reply-To: shashikiranah@chromium.org

From: Shashikirana H K <shashikiranah@chromium.org>

vivaldi_feature_mapping() currently passes the descriptor-declared
report_len as the received data size to hid_report_raw_event() instead
of the actual number of bytes returned by hid_hw_raw_request(). It also
does not verify that the returned Report ID matches the requested
report->id, or handle a zero-byte return before decrementing the length
for unnumbered reports.

Validate that hid_hw_raw_request() returns at least one byte and that
the returned Report ID matches report->id, and pass the actual received
byte count (ret) to hid_report_raw_event().

Fixes: 33bbe04a15f2 ("HID: google: extract Vivaldi hid feature mapping for use in hid-hammer")
Cc: Tzung-Bi Shih <tzungbi@chromium.org>
Cc: Sean O'Brien <seobrien@chromium.org>
Signed-off-by: Shashikirana H K <shashikiranah@chromium.org>
---
Change-Id: I3cf03bd2457f44c6ed47835f3d603f235f5993de
---
 drivers/hid/hid-vivaldi-common.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-vivaldi-common.c b/drivers/hid/hid-vivaldi-common.c
index b12bb5cc091aa..ea2c661e623d1 100644
--- a/drivers/hid/hid-vivaldi-common.c
+++ b/drivers/hid/hid-vivaldi-common.c
@@ -69,12 +69,18 @@ void vivaldi_feature_mapping(struct hid_device *hdev,
 	ret = hid_hw_raw_request(hdev, report->id, report_data,
 				 report_len, HID_FEATURE_REPORT,
 				 HID_REQ_GET_REPORT);
-	if (ret < 0) {
+	if (ret <= 0) {
 		dev_warn(&hdev->dev, "failed to fetch feature %d\n",
 			 field->report->id);
 		goto out;
 	}
 
+	if (report->id && report_data[0] != report->id) {
+		dev_warn(&hdev->dev, "report ID mismatch: expected %d got %d\n",
+			 report->id, report_data[0]);
+		goto out;
+	}
+
 	if (!report->id) {
 		/*
 		 * Undo the damage from hid_hw_raw_request() for unnumbered
@@ -82,10 +88,11 @@ void vivaldi_feature_mapping(struct hid_device *hdev,
 		 */
 		report_data++;
 		report_len--;
+		ret--;
 	}
 
 	ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, report_data,
-				   report_len, report_len, 0);
+				   report_len, ret, 0);
 	if (ret) {
 		dev_warn(&hdev->dev, "failed to report feature %d\n",
 			 field->report->id);

---
base-commit: 388b607d107c07aaade04c7f22f344cab6bdccd3
change-id: 20261006-upstream-vivaldi-fix-950b29c98286

Best regards,
-- 
Shashikirana H K <shashikiranah@chromium.org>


