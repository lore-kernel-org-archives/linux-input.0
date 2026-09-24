Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C338A720;
	Thu, 24 Sep 2026 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228083; cv=none; b=IvdrzQazPCbN4EWB0Sdj1P9H0mEhV91NBOtl338pGGhS3vyYyKU9pn5pKulQbMoIQMmJu7Xv1RZcQfWPFvGWmoHL5YuBKRWpXEUBSsfL0ZU4CEADTddGEwS1LQECuRHRACHkl7raKa/tzs/3+KwrOkkcqcVi7pz7N8Dv8RDhAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228083; c=relaxed/simple;
	bh=XcIGfAnJrnYbeHogfOS381lzlAK9XTIRgTSoH7NRArk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MBLdpZ6fcGH4LDdu5XMNSZcpWKgRkgJLq5NnpkuZnAAIA7TMszYqaRiGVFG62urzR46Ob5QSzX+kkNd43UGMabxSlGtTseZ/bzRLzuhp5REpkG79wq/Rbl6xzCXw8Osve4RK18+eidpTUhguPjxJTy4ECySqYOwJYBv3ZRn7IuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwwBjSvG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwwBjSvG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2478EC2BCF5;
	Thu, 24 Sep 2026 05:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790228082;
	bh=XcIGfAnJrnYbeHogfOS381lzlAK9XTIRgTSoH7NRArk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=fwwBjSvGGRXbymBVhtomRpX+5Fk2P6h95rDsVCcF8sppeKwuCpa9rW9exFtUawgOt
	 3QG7XfNZDcEFbDti5zrAyg5gBhWrjWMrlvs6/vQkDml3k6hyJDpLdIhf0iQvRtGp70
	 b++IjggnAej39J8rxLT9J7BTRmzP0sRd28V5sNJZqXqMlWm3Y32B+Uayx2ifmFqCBk
	 D+Qw4ced0JMc8u5WQzJpt5kzHfFB0JBr0+ByKGL3oIs8/Vm+FeynmZOLwqPFiZ86Xi
	 uOG4eVhWQoSx+P9LQJ1NT+R04X6xjpi4q5HfQJMrPe3PPj3Ner0plM+elywXp4uhi1
	 ZCJhhPSgmM4eg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED461C98313;
	Thu, 24 Sep 2026 05:34:41 +0000 (UTC)
From: Nikolay Plastinin via B4 Relay <devnull+plaztininikolai.gmail.com@kernel.org>
Date: Thu, 24 Sep 2026 13:34:41 +0800
Subject: [PATCH] HID: asus: report the airplane mode key on ROG Flow X13
 GV302X
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-gv302x-airplane-key-v1-1-f05192f55ec5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSw5AMBRG4a3IHbtJ1SPYihhU/bghJW0iROxdY
 /gNznkowAsCtclDHqcE2V1EliZkF+NmsIzRpJWuVKMLns9c6YuN+GMzDrzi5mwaLOrSKlhDsTw
 8Jrn+a9e/7wfusWV/ZQAAAA==
X-Change-ID: 20260924-gv302x-airplane-key-1fbce85c0eca
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikolay Plastinin <plaztininikolai@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790228080; l=2177;
 i=plaztininikolai@gmail.com; s=20260924; h=from:subject:message-id;
 bh=mJdKPQatGowY1qY91BwxCcA//J2IOAjSEGPrBaT1nCo=;
 b=sd4+LVrV3OzwpJyu9AV/5TZBiLYlImtYXkdWKlYvHT13RBSOl/92G0NGXTXxFLMFI34ogI5wO
 d8kbX9LdzxuAk30nV53WcRc84TyskXmuIjVvmfANGffKuuDnkeTi2bR
X-Developer-Key: i=plaztininikolai@gmail.com; a=ed25519;
 pk=bmHrETa14IbiLNkJSoiLqUMni+IeSFwhOSDM4vVFN4s=
X-Endpoint-Received: by B4 Relay for plaztininikolai@gmail.com/20260924
 with auth_id=1052
X-Original-From: Nikolay Plastinin <plaztininikolai@gmail.com>
Reply-To: plaztininikolai@gmail.com

From: Nikolay Plastinin <plaztininikolai@gmail.com>

On the ROG Flow X13 GV302X (N-KEY keyboard 0b05:19b6), Fn+F12 (airplane
mode) sends report 0x03, which the report descriptor declares as a
Wireless Radio Controls collection with a single Wireless Radio Button
bit followed by 7 bits of padding. The keyboard however sends the ASUS
keycode 0x88 in that byte ("03 88 00 00 00 00"), so the button bit is 0
and hid-input never reports KEY_RFKILL. The key release comes as an
empty 0x5a report.

Replace 0x88 with the button bit in reports of the Wireless Radio
Controls collection on ROG N-KEY keyboards, so that hid-input reports
KEY_RFKILL (it already simulates the release for this usage).

Tested on a GV302XV with 7.2.7: every Fn+F12 press now reports
KEY_RFKILL, and Plasma toggles airplane mode.

Assisted-by: LLM
Signed-off-by: Nikolay Plastinin <plaztininikolai@gmail.com>
---
 drivers/hid/hid-asus.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 7dc6417fe..cee7d9a1f 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -51,6 +51,8 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define FEATURE_KBD_LED_REPORT_ID1 0x5d
 #define FEATURE_KBD_LED_REPORT_ID2 0x5e
 
+#define ASUS_AIRPLANE_KEY_CODE 0x88
+
 #define ROG_ALLY_REPORT_SIZE 64
 #define ROG_ALLY_X_MIN_MCU 313
 #define ROG_ALLY_MIN_MCU 319
@@ -549,6 +551,16 @@ static int asus_raw_event(struct hid_device *hdev,
 		 */
 		if (data[0] == 0x02 && data[1] == 0x30)
 			return -1;
+
+		/*
+		 * Some ROG laptops (e.g. ROG Flow X13 GV302X) send the airplane
+		 * mode keycode 0x88 in the Wireless Radio Controls report instead
+		 * of setting its Wireless Radio Button bit, so the key press is
+		 * lost. Report the button press instead.
+		 */
+		if (report->application == HID_GD_WIRELESS_RADIO_CTLS &&
+		    data[1] == ASUS_AIRPLANE_KEY_CODE)
+			data[1] = 0x01;
 	}
 
 	if (drvdata->quirks & QUIRK_ROG_CLAYMORE_II_KEYBOARD) {

---
base-commit: d72f75f1d9c038ead2588b42de6c2531e3b80bea
change-id: 20260924-gv302x-airplane-key-1fbce85c0eca

Best regards,
-- 
Nikolay Plastinin <plaztininikolai@gmail.com>


