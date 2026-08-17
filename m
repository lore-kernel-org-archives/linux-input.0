Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346CB3B7B6B;
	Mon, 17 Aug 2026 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951741; cv=none; b=DZy2RBslMXTEIpglBI16YIZrg+s8egovGtGg/I0XIU8Xnc+bcrnooPkeIYuvCMnytMTTX7lGM/p9tbxfjKpHj5Dqf8/raL7zTsG+u3S+uDBU+hbNQUCqEO1aEzPak/BdekA0zVSqdlshP3+kOcK/cUlnO0xcxuTQaJifXQ0JQx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951741; c=relaxed/simple;
	bh=2GPpxbEieBrPwwR2UfDd+4p7Y2TdSS54vc8mHiowxFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lWOal1rP7Ago6yXXK2kPC2uZIc7a4Idl/bfJmnqE5uZ9wFClxVNz136p3wPrmvko6mj4ImhprVnzQAl6E3tOo42W1YKCk2crWE8hcdgnjRz/2S7HuOAvMHhHGWnnECjJkulMLQQNpQ8dLTV4J5a3S+1OTbJl3d5eHC9T52fU/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RR/YTsOL; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RR/YTsOL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mD
	S6gvg/YNhPCOM2+99aCyJhJ1wSgs9dOUKaGNwzb2U=; b=RR/YTsOLdUAhWlrhOT
	TC03KNWHYX2HAb/TZOA3tHgsMD6vBCoo20GOVaBjiXDmiby4ZHlbnLAwndWeQYEV
	4xdWQQHtBRAv2pQOQdRNxbN8pOj+rrZJpy+gZtfX5Oro/WJx9n3J8ShHwr56zIwu
	bs7WcEzZZMyWYuvC9UjgJIYb4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDn4yIjuIJqQvnOMg--.51174S2;
	Mon, 17 Aug 2026 15:28:35 +0800 (CST)
From: Chen Changcheng <ccc194101@163.com>
To: ccc194101@163.com
Cc: bentiss@kernel.org,
	chenchangcheng@kylinos.cn,
	jeffinphilip14@gmail.com,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+0a031a76585d1c7e737d@syzkaller.appspotmail.com
Subject: [PATCH] HID: corsair: do not re-schedule LED worker after it has been cancelled
Date: Mon, 17 Aug 2026 15:28:31 +0800
Message-Id: <20260817072831.139954-1-ccc194101@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260817072354.139154-1-ccc194101@163.com>
References: <20260817072354.139154-1-ccc194101@163.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDn4yIjuIJqQvnOMg--.51174S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWkZF45ZFW5XFWxZF4DXFb_yoW8Kw1fpr
	Zakay7Gw4ktF4v9r4qqF48XFy5W397GrW09ry7tw4UurZ8JryIvry0k3W7uFy8ZrZ5KFnx
	Cr1Ygr4YqFW0yaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi89N7UUUUU=
X-CM-SenderInfo: 5fffimiurqiqqrwthudrp/xtbC0ANxUGqCuCP-SQAA33

From: Chen Changcheng <chenchangcheng@kylinos.cn>

Commit eb51c9f8cb4f0 ("HID: corsair: cancel worker before unregistering
LED to fix use-after-free") moved cancel_work_sync() ahead of
led_classdev_unregister() in k90_cleanup_backlight() and
k90_cleanup_macro_functions().  led_classdev_unregister() internally
calls led_set_brightness(LED_OFF), which reaches the driver's
k90_brightness_set() callback.  Since that callback schedules the worker
unconditionally, the worker was re-queued after cancel_work_sync() had
drained it, and the subsequent kfree() freed a still-active work_struct:

    ODEBUG: free active (active state 0) object type: work_struct
            hint: k90_record_led_work

The removed flag check inside the worker itself only stops it from
dereferencing freed memory once it runs; it cannot prevent the re-queue.

Fix this by making k90_brightness_set() a no-op once removed is set, so
the LED_OFF update issued from led_classdev_unregister() can no longer
re-schedule the worker after it has been cancelled.  Also apply the
cancel-before-unregister ordering to the probe error path
(k90_init_macro_functions() fail_sysfs) for consistency.

Fixes: eb51c9f8cb4f0 ("HID: corsair: cancel worker before unregistering LED to fix use-after-free")
Reported-by: syzbot+0a031a76585d1c7e737d@syzkaller.appspotmail.com
Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 drivers/hid/hid-corsair.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 278c6efb565d..73b3c1ff78c6 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -194,6 +194,9 @@ static void k90_brightness_set(struct led_classdev *led_cdev,
 {
 	struct k90_led *led = container_of(led_cdev, struct k90_led, cdev);
 
+	if (led->removed)
+		return;
+
 	led->brightness = brightness;
 	schedule_work(&led->work);
 }
@@ -507,8 +510,8 @@ static int k90_init_macro_functions(struct hid_device *dev)
 
 fail_sysfs:
 	k90->record_led.removed = true;
-	led_classdev_unregister(&k90->record_led.cdev);
 	cancel_work_sync(&k90->record_led.work);
+	led_classdev_unregister(&k90->record_led.cdev);
 fail_record_led:
 	kfree(k90->record_led.cdev.name);
 fail_record_led_alloc:
-- 
2.25.1

