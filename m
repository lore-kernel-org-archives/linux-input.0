Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848492737E0;
	Tue, 24 Mar 2026 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380051; cv=none; b=hyXlb4PjAQk+dZKx65cBT9z8uexb6C6LcS6sWsQu7jbr9rNQXMyKie52VIl3Mrj+RwNUZnWH729/infhHQrcsMbrmuqt46VD5cvXQHBokvHbsWeviHRdq6UG5/HyPWWMf5il5fTUFlX3+IqhJ2c5/DSaONLnsIiYUtEhyFMDZ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380051; c=relaxed/simple;
	bh=h8tdSSTQbcZNV4cteUXOngDi4BhrQN0Ynj00eZGAv7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ji0ogdspTDBrpsehc0q2sdfcMgPlj/PYRDyKzkOct8Rrtr/Wqyw6jd+0wr8YyrkZOlt31+NiO+F82Svt0WQ6PwR39atQbAObp8VKoETHGNgh2tt61cF6o14lI+aIXLKup8T7R9EotejVjyQ+h7xk5UyRUKgKKvlJWUZGoZ19BFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jp5Gq+Ep; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jp5Gq+Ep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE154C19424;
	Tue, 24 Mar 2026 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774380051;
	bh=h8tdSSTQbcZNV4cteUXOngDi4BhrQN0Ynj00eZGAv7k=;
	h=From:To:Cc:Subject:Date:From;
	b=Jp5Gq+EpzyqymjK1h4DUl54TL0yeqiOY9if0y4C6rcEKwS0nvpcdtbvRUWyZ/7RZr
	 dF7zBvkRab/DF9yTEBZiI1sdb2obdPqB2kJay04h/sTwAt98MsxXFjzBX9V80YPBzG
	 jGypwdNtzbTEGfY8uM6md1nahv4zMaEDPac1p4EGSmucj5dGuVQxX3z0RZrC0dCLMY
	 H0tcEyY4PpiYBJXIJ9nDskRZP5m0gNdm0JurOq+ZyPZTw5lgl3fwy0GvD7L4AgYnAm
	 g6yRtxXwkXVo1u5XlI5dGrokW2Z1G3fiboxa2Hpe62CREG40dhHr8FAsE9upmhVXIP
	 6WidNpwV76G/A==
From: Arnd Bergmann <arnd@kernel.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Aditya Garg <gargaditya08@live.com>,
	Jonathan Denose <jdenose@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hid-lenovo-go: fix LEDS dependencies
Date: Tue, 24 Mar 2026 20:20:28 +0100
Message-Id: <20260324192045.2895560-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added hid-lenovo-go and hid-lenovo-go-s drivers attempt to
'select LEDS_CLASS', which has a dependency on NEW_LEDS, causing a build
failure when NEW_LEDS itself it disabled:

WARNING: unmet direct dependencies detected for LEDS_CLASS
  Depends on [n]: NEW_LEDS [=n]
  Selected by [m]:
  - HID_LENOVO_GO [=m] && HID_SUPPORT [=y] && HID [=m] && USB_HID [=m]
  - HID_LENOVO_GO_S [=m] && HID_SUPPORT [=y] && HID [=m] && USB_HID [=m]

WARNING: unmet direct dependencies detected for LEDS_CLASS_MULTICOLOR
  Depends on [n]: NEW_LEDS [=n] && LEDS_CLASS [=m]
  Selected by [m]:
  - HID_LENOVO_GO [=m] && HID_SUPPORT [=y] && HID [=m] && USB_HID [=m]
  - HID_LENOVO_GO_S [=m] && HID_SUPPORT [=y] && HID [=m] && USB_HID [=m]
ERROR: modpost: "led_set_brightness_nopm" [drivers/leds/led-class.ko] undefined!
ERROR: modpost: "led_set_brightness" [drivers/leds/led-class.ko] undefined!
ERROR: modpost: "led_get_color_name" [drivers/leds/led-class-multicolor.ko] undefined!
ERROR: modpost: "led_set_brightness" [drivers/leds/led-class-multicolor.ko] undefined!

Device drivers generally should not select other subsystems like this, as
that tends to cause dependency problems including loops in the dependency
graph.

Change these two and the older hid-lenovo driver to behave the same way as all
other HID drivers and use 'depends on LEDS_CLASS' or 'depends on LEDS_CLASS_MULTICOLOR'
instead, which itself has NEW_LEDS and LEDS_CLASS as dependencies.

Fixes: a23f3497bf20 ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Fixes: d69ccfcbc955 ("HID: hid-lenovo-go: Add Lenovo Legion Go Series HID Driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/Kconfig | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 10c12d8e6557..f658ed0168ea 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -610,8 +610,7 @@ config HID_LED
 
 config HID_LENOVO
 	tristate "Lenovo / Thinkpad devices"
-	select NEW_LEDS
-	select LEDS_CLASS
+	depends on LEDS_CLASS
 	help
 	Support for IBM/Lenovo devices that are not fully compliant with HID standard.
 
@@ -626,8 +625,7 @@ config HID_LENOVO
 config HID_LENOVO_GO
 	tristate "HID Driver for Lenovo Legion Go Series Controllers"
 	depends on USB_HID
-	select LEDS_CLASS
-	select LEDS_CLASS_MULTICOLOR
+	depends on LEDS_CLASS_MULTICOLOR
 	help
 	Support for Lenovo Legion Go devices with detachable controllers.
 
@@ -638,8 +636,7 @@ config HID_LENOVO_GO
 config HID_LENOVO_GO_S
 	tristate "HID Driver for Lenovo Legion Go S Controller"
 	depends on USB_HID
-	select LEDS_CLASS
-	select LEDS_CLASS_MULTICOLOR
+	depends on LEDS_CLASS_MULTICOLOR
 	help
 	Support for Lenovo Legion Go S Handheld Console Controller.
 
-- 
2.39.5

