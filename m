Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0527427F8F
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775624; cv=none; b=WvGWgK54wYDI5sRe9gqJTpFoOCzIQYy/o6r9UbFfjl8gllR9Zw/6BbD9Tq1PSTrNsetjrsJiai02uNsHfsGCvlA2tf2LcVCO0NFoWpVrl+JHmHqTYCfp+mEMZ7lIPlbDLP2Z8fdT0uC3u9d2JJHkdtjniq4x0+iYnS4s/l0nQDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775624; c=relaxed/simple;
	bh=qvB2UueIYB5P8EdTgr4KwYAERVfbvYdvKTBBlPnIqt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cg1YOjCYXyvR8s3rSUlEfpyrSnxzcLpn93lyRNCXLoyge7HhgDrFOIl9dRQdwSgnkcmkLRZO5TA5/H3NxO7PvkLdo38+QZcLtRpBxjYSWLOylRQCtNZVVxyCXE4wcXxAp9v20z6bRQwCF/VXX42+ENhCIrOs1rsxbB7pPrnTXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=hy23ViHs; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="hy23ViHs"
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:69d:0:640:32f2:0])
	by forward101b.mail.yandex.net (postfix) with ESMTPS id C38F6C00C2;
	Mon, 07 Sep 2026 13:06:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp) with ESMTPSA id n6JUhPGfxa60-uCKPQInD;
	Mon, 07 Sep 2026 13:06:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1788775611; bh=1vD9AOqjhIBuZYMLfF1Vpe3iRIADHyGzQ1oktbVRrXc=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=hy23ViHspCQWQ0VkBVJ6sL0dmRwveGZmyHIWaiLOim21DzeKL8jbCEtoXwFXotzTa
	 5j/LpX1KMnSFLsK/5/AUHFLR//cfF7QXF3t70B4b9C4WaZa+StwS/t3/ieuu1dMIX9
	 H4qAeJiOHCleaAmPzvTYPa/38XeQ7V0BAMBsO2GA=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+e2c057ea576d2644e2be@syzkaller.appspotmail.com
Subject: [RESEND PATCH v2 2/2] HID: usbhid: free unsent raw output reports in usbhid_stop()
Date: Mon,  7 Sep 2026 13:06:45 +0300
Message-ID: <20260907100645.86990-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907100645.86990-1-dmantipov@yandex.ru>
References: <20260907100645.86990-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When HID device is stalled or disconnected, there might be an
unsent (i.e. never passed via hid_submit_out()) output reports.
So free their raw buffers in usbhid_stop() to avoid memory leaks.

This is a companion of commit f7744fa16b96 ("HID: usbhid: free
raw_report buffers in usbhid_stop") and inspired by that one.

Reported-by: syzbot+e2c057ea576d2644e2be@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2c057ea576d2644e2be
Fixes: c500c9714011 ("HID: hid, make parsing event driven")
Assisted-by: Sashiko:gemini/gemini-3.1-pro-preview
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: adjust loop to match actual FIFO size and tweak commit message
---
 drivers/hid/usbhid/hid-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 96b0181cf819..60662616fd2a 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1253,6 +1253,14 @@ static void usbhid_stop(struct hid_device *hid)
 		usbhid->ctrltail = (usbhid->ctrltail + 1) &
 			(HID_CONTROL_FIFO_SIZE - 1);
 	}
+
+	while (usbhid->outtail != usbhid->outhead) {
+		kfree(usbhid->out[usbhid->outtail].raw_report);
+		usbhid->out[usbhid->outtail].raw_report = NULL;
+
+		usbhid->outtail = (usbhid->outtail + 1) &
+			(HID_OUTPUT_FIFO_SIZE - 1);
+	}
 	spin_unlock_irq(&usbhid->lock);
 
 	usb_kill_urb(usbhid->urbin);
-- 
2.55.0

