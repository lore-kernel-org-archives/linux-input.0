Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793685834;
	b=2CZCRbQ/kkWIGN1WStwKwoz3eoD/DovJl0GkElD1wR1Ob3SNjpowOH++lvchhIqfyH98
	 ujvYMwY+jn5fzpk6GXwQEelA8UiTYlHrY5pY6eklaBdZkU35rlEHJpvkrj0ZrGjJTg4up
	 b0IUPMQ+EU352o/Lb2gJ2+BGehqzwGH58+rNnDQ0dq5CywBIH8i8rCvxmbpOgdSgryF11
	 qBHXRS/fY8ZvjNngnlmmePlrWoUti/1gJMBDMX7FopYiEzqw1C4ee7TE0f9hnK3b1ypkP
	 a5C5zki+2VsgGMBMe4C3RWhaKGgR4rQQBNA/9KYmbgcBAC4yjfrEqFx9dVjCBmo2o4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793685834;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-FangMail-Miltered:X-FangMail-Envelope:X-FangMail-Bounce-Flag:
	 X-FangMail-Outinfo:X-CLEAN:Message-Id:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=XTjbkRg7HqVSljiT3X2hUyDmsiJPQ+XvjYgbHN8De6o=;
	b=Om7NWnsa4sOXzrs2AhN0JukMImGPgg7YF6rerI7qC/ZS3RkgW90Av7Gg7ag7aMdXztou
	 NSlHq+uzz2Kc1XDwIH/a/n57jI0TYBzQ8kmk8kfO2fMryocDeeixEm3c/F+orMeKVBK9O
	 wEfRSGMJffDe4KMwuFCnuUvkzxkkORIe+Yl3n4jZnb9HlVm9NCkaYiHN7z2CC9N2XdpkI
	 4bgfKA7p8FqMpbi5d4Rc0mMF3lNKD7OB/hV49Gdd4sqzsOzUXbY4q7FHdyFokOQpcNg3Y
	 bLphHmMDrrbbjpRIlUnwuezP2cQxasVlkk3xOzq1ZbiWwJAH+5FPiZl8GX70TptPfNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5FD606A324;
	Tue,  3 Nov 2026 06:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B5FD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jJdL723VVz3CP5;
	Tue, 03 Nov 2026 14:03:43 +0800 (CST)
From: zhangdaolong <dlzhangak@isoftstone.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Olivier Scherler <oscherler@ithink.ch>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangdaolong <dlzhangak@isoftstone.com>
Subject: [PATCH] HID: xinmo: prevent NULL pointer dereference in xinmo_event()
Date: Tue,  3 Nov 2026 14:03:42 +0800
X-Mailer: git-send-email 2.48.1
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TLS: YES
X-ENVELOPE-SENDER: dlzhangak@isoftstone.com
X-SOURCE-IP: 221.226.109.28 unknown Tue, 03 Nov 2026 14:03:43 +0800
X-FangMail-Miltered: at fangwg01 with ID 6AE9793F.000 by FangMail milter!
X-FangMail-Envelope: 1793685823/4jJdL723VVz3CP5/6AE9793F.000/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1793685823.6AE9793F.000
X-FangMail-Outinfo: 1793685823/6AE9793F.000/4jJdL723VVz3CP5/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1793685823.6AE9793F.000.4jJdL723VVz3CP5@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE9793F.000/4jJdL723VVz3CP5

In xinmo_event(), field->hidinput->input is accessed when handling out of
bounds negative events. If the device has not been claimed as an input
device or if field->hidinput is NULL (for fields not mapped to an input
device), accessing field->hidinput->input leads to a NULL pointer
dereference.

Add a check for (hdev->claimed & HID_CLAIMED_INPUT) and field->hidinput
before processing events, which matches the standard pattern used across
other HID drivers.

Fixes: cb2c9e3f9248 ("HID: Add new driver for non-compliant Xin-Mo devices.")
Signed-off-by: zhangdaolong <dlzhangak@isoftstone.com>
---
 drivers/hid/hid-xinmo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-xinmo.c b/drivers/hid/hid-xinmo.c
index 66b8bfb6e647..f308f36bf5a7 100644
--- a/drivers/hid/hid-xinmo.c
+++ b/drivers/hid/hid-xinmo.c
@@ -25,6 +25,9 @@
 static int xinmo_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
+	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !field->hidinput)
+		return 0;
+
 	switch (usage->code) {
 	case ABS_X:
 	case ABS_Y:
-- 
2.48.1

