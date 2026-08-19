Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E6642EEC4;
	Wed, 19 Aug 2026 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130915; cv=none; b=GsQCwxqkmafKdvTdzSS5UGjlg+1BpQEEKBDKxJBJeju5OPlprVQUia7VBGCIbJbO+SFWOsRKsAYP9ZBgC9rGF4xrAAdWXzGUlAb+2oGeeJGRNnY8nHqnMzwT+fmWvrSe5gFHJT5Jz0ALZwxuUk6NMM22riAZbL4yYPIwtfIEJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130915; c=relaxed/simple;
	bh=beJwIZSZw4l9YcUCZjXfQ3EkBpd+Qo70n13K73XoZPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d43GRMdCkDg5TTGh1kUBTU9tlbP7jYCuCZ2AVT0gtZuXfSDZ5mLjqzCwWPM3mbpBIebH5ATpeE+36vmr36p7bIIDTsOqShVwAPBrJfFvUnjQKBkC8bxqpp9DLom2pqHbuvS215/OXi9QgbHPDzrRTjPzaIbR7mTeKz/3okEUSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=R5tjHD6X; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="R5tjHD6X"
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward205b.mail.yandex.net (postfix) with ESMTPS id 6E82F84133;
	Wed, 19 Aug 2026 12:09:50 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:3033:0:640:ec58:0])
	by forward100b.mail.yandex.net (postfix) with ESMTPS id 52C7A80892;
	Wed, 19 Aug 2026 12:09:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (smtp) with ESMTPSA id d9S1FtTdD0U0-0mq0uHds;
	Wed, 19 Aug 2026 12:09:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1787130581; bh=dVOHb0TMVHPFK9tJEyH5h576sNfuFhtOu5O4lA2zyrg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=R5tjHD6XIuuc07mchwoFwzf2YbIwwyqV/UKrSExT+34LDBuZQIejU3FPRb9cmHLEV
	 /t3oF0dgPQgcQfxMx1y+/r3ambf/jja+7EWrhZ6oARsypv1//q0EryhBlYdgJ/TpZF
	 XbEVWgoojcUitu7cxzS9zFKwwFmQ9V4ZDa/E9duY=
Authentication-Results: mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Anirudh Rayabharam <mail@anirudhrb.com>,
	linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+e2c057ea576d2644e2be@syzkaller.appspotmail.com
Subject: [PATCH] HID: usbhid: free unsent raw output reports in usbhid_stop()
Date: Wed, 19 Aug 2026 12:09:37 +0300
Message-ID: <20260819090937.2856848-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When HID device is stalled or unexpectedly removed, there might be
an unsent (i.e. never passed via 'hid_submit_out()') output reports.
So free their raw buffers in 'usbhid_stop()' to avoid memory leaks.

Reported-by: syzbot+e2c057ea576d2644e2be@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2c057ea576d2644e2be
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
This is an (obvious?) companion patch for f7744fa16b9 ("HID: usbhid:
free raw_report buffers in usbhid_stop").
---
 drivers/hid/usbhid/hid-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 96b0181cf819..599a7566b825 100644
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
+			(HID_CONTROL_FIFO_SIZE - 1);
+	}
 	spin_unlock_irq(&usbhid->lock);
 
 	usb_kill_urb(usbhid->urbin);
-- 
2.55.0

