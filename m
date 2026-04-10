Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB63CBE7C;
	Fri, 10 Apr 2026 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775829799; cv=none; b=JYLGd6DgkXrBslw+Pvkv6z9Rwird8NWUIIa+Pa6yK20tsK2evYFXOU9ZtuD9Q0kPg1VSdAQu/LvgK+rexp81neBGfZP91/EPMOMf1pyakObqT+leY/u04nL+p3Zmx53ATMDDvLjoeEmp5TeTYDRAXaHN4rky/lcA9LvtBhKqTwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775829799; c=relaxed/simple;
	bh=8WIEdH132aD1IHAvrvzWhzKrm0X8VJbA6Xb2Re1zh/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qu31BSzAtg9RsC3OngKUGdl2P/KebTCKtDWukTCDUeZpa+O5ekrnDv0o7pDQkcKjk3X2tGaLrpYDOYLuHns9PTZchTPyfWYCq9nuHLlFVc0QvVmNTJp740x84TGkDpvgRCv+SLO+/S0iudCbb8+FTbkVSqh+WPHo/jjcwc4hTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/SmYVBm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/SmYVBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36C2C2BC87;
	Fri, 10 Apr 2026 14:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775829798;
	bh=8WIEdH132aD1IHAvrvzWhzKrm0X8VJbA6Xb2Re1zh/M=;
	h=From:Date:Subject:To:Cc:From;
	b=u/SmYVBmDwTtH5h6xpg76wG3w5W+2zV20Bw1BEpG386+FDk8FEewVW9sSjLeksykk
	 tu3W21DQxTHdVHk/xB1zzS0yUExj3ddrwgk1MS3rQOxWa9r/+Brnq6DFawGET/W1AD
	 URSsL4XuWEBVk7yubinGhLqEl+Q7eQVyGEwyBUVlvjjWPgQo+bWKP+T3+A6wNBdzeO
	 3JAsA2VpFvt/I/GjF87Jw2BbipRRjXmjuigeoLgnKOzzZaQYnQ//hu91g2/EWO+2Wg
	 98oTPONeCa7byw9guKlYcIJA0447GMzSeBMNSxujtvstjxWRUO8yLvj9Qc+duDmDkE
	 XeG2IbDrCRJdA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 10 Apr 2026 16:03:07 +0200
Subject: [PATCH] HID: logitech-dj: fix wrong detection of bad DJ_SHORT
 output report
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-fix-logitech-dj-v1-1-5533381f8d1b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7bmGTkOor0SFz042o0IhA+nvSc
 WBmMiSOwgl6lSHyLUmOvUBdKZjDtHtGcYVBkzbU1ISLPLgdXi6eA7oVuSNDlmzTWgelOiMX5T8
 O4/t+f768s2EAAAA=
X-Change-ID: 20260410-fix-logitech-dj-e9060b0b48bd
To: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Jiri Kosina <jikos@kernel.org>, Lee Jones <lee@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775829797; l=1709;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=8WIEdH132aD1IHAvrvzWhzKrm0X8VJbA6Xb2Re1zh/M=;
 b=4htIro7RCAA0ZhYtja6t643iFVVc2P5I4QW83gUdC44QshbXtYymHgNgxKIem3jB4SN5ayh1z
 UItaia+qkf9AQv3EY9PoyR3tZAC2sbyfkdLdHtcDJlN7C96AIUzchuv
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

commit b6a57912854e ("HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT
related user initiated OOB write") assumed that all HID devices attached
to the logitech-dj driver was having an output report of DJ_SHORT.

However, on the receiver itself, we have 2 other HID device we attach
here: the mouse emulation and the keyboard emulation. For those devices
the value of rep is NULL and we are triggered a segfault here.

This is doubly required because logitech-dj also handles non DJ devices
that might not have the DJ collection.

Fixes: b6a57912854e ("HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT related user initiated OOB write")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-logitech-dj.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 838c6de9a921..695d3031009e 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1907,7 +1907,8 @@ static int logi_dj_probe(struct hid_device *hdev,
 	output_report_enum = &hdev->report_enum[HID_OUTPUT_REPORT];
 	rep = output_report_enum->report_id_hash[REPORT_ID_DJ_SHORT];
 
-	if (rep->maxfield < 1 || rep->field[0]->report_count != DJREPORT_SHORT_LENGTH - 1) {
+	if (rep && (rep->maxfield < 1 ||
+		    rep->field[0]->report_count != DJREPORT_SHORT_LENGTH - 1)) {
 		hid_err(hdev, "Expected size of DJ short report is %d, but got %d",
 			DJREPORT_SHORT_LENGTH - 1, rep->field[0]->report_count);
 		return -EINVAL;

---
base-commit: e2aaf2d3ad92ac4a8afa6b69ad4c38e7747d3d6e
change-id: 20260410-fix-logitech-dj-e9060b0b48bd

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>

