Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F56416D19;
	Tue,  9 Jun 2026 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007611; cv=none; b=kL23E1yERoCLVFR1UWvj88CIOHPTZ9Ge9G1nkrzFkiuOLy/86vI4DB5CQ2ROgDN+/Zhia+7RMBghT00BKNEUiz5o36P/P/B3g7n/X9+r6LyNCl49eD71FOhGQAUNVhBIaOyk8gmORHG7ncJ6nn7H6bD5S8fJmzZFugg6Chi6MHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007611; c=relaxed/simple;
	bh=DK8LLllXxGMXy3ja7K4UlLwADjHY/IJ1W3XVtnP8bjQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBWkn2u6/YnSGwi+FFEOzasSBOfGWtCFK63CQvlzcQ+pytygS5t/YRPg01PBioXcV5d6ML81UMAoqasOr7F18Rux8O5NwlFAAgIbVSt72mbvK3Ey6BFiS0jG34S/1oDD2FcVsbZON2GjF3MrTIZpJ2zrMpwSn3/0Va8FcXPftyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YntGJ4Yw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YntGJ4Yw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFD61F00893;
	Tue,  9 Jun 2026 12:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781007610;
	bh=3kbzb+rchJW7m1ToCS5ZhcEAF0BGs19s7zN0dJTrnoA=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=YntGJ4YwsHcQh6/m0N6uLE5R4NOBbw6Z9yw6ewOpkBfSv4kNEoRdapfu0xkoLusg4
	 kKaD41lNj2OHq9VlCJZrUc94zdYJWAojyFZ5JLJ25MY2SniCYvLqWO6xyQtC7Y3qUI
	 xbnD+b2mwh9DCrZAj8ZLqWyZucsqfu6a1psWgkDABf08jDUdHkf5oWglk1VDWxJQzi
	 qCIoONxianLdcxEjsENrOhtCkJJG3IlbErGW3YT8tmkkf4Rjgse3L6PXmFH7suMv4j
	 EQd36ASkmYkd7/E5i63y0RcscKxF77Xn5C6BU02aRVRew5eMt/jhEYGAslFsu1/Fwt
	 slaAu3yFrjrtQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] HID: wacom: Fix teardown order in wacom_mode_change_work
Date: Tue,  9 Jun 2026 13:13:40 +0100
Message-ID: <20260609121353.3743782-4-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <20260609121353.3743782-1-lee@kernel.org>
References: <20260609121353.3743782-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_mode_change_work() called wacom_release_resources() before
hid_hw_stop(). wacom_release_resources() triggers devres cleanup
which calls wacom_remove_shared_data() to nullify wacom_wac->shared.
Since hid_hw_stop() was not called yet, hardware IRQs could still fire
and dereference the nullified wacom_wac->shared pointer, causing a crash.

Fix this by correcting the teardown order to call hid_hw_stop()
first, matching the order used in wacom_remove().

Fixes: 4082da80f46a ("HID: wacom: generic: add mode change touch key")
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 -> v2: Split and use RCU as per Dmitry's review
v2 -> v3: Sashiko fixes

 drivers/hid/wacom_sys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 1b019e3331b4..378dddbf7ec5 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2835,16 +2835,16 @@ static void wacom_mode_change_work(struct work_struct *work)
 
 	if (pen) {
 		wacom1 = hid_get_drvdata(pen);
-		wacom_release_resources(wacom1);
 		hid_hw_stop(wacom1->hdev);
+		wacom_release_resources(wacom1);
 		wacom1->wacom_wac.has_mode_change = true;
 		wacom1->wacom_wac.is_direct_mode = is_direct;
 	}
 
 	if (touch) {
 		wacom2 = hid_get_drvdata(touch);
-		wacom_release_resources(wacom2);
 		hid_hw_stop(wacom2->hdev);
+		wacom_release_resources(wacom2);
 		wacom2->wacom_wac.has_mode_change = true;
 		wacom2->wacom_wac.is_direct_mode = is_direct;
 	}
-- 
2.54.0.1099.g489fc7bff1-goog

