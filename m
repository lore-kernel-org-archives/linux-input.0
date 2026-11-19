Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.160
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795085766;
	b=qzBRd12jvtTGduvSbgqIbpXvvkEA5ljgCIFWqt6bNm7EXtcu0RNcN32qOUDnWPeLu1cW
	 Qwf31DRntxrmMgnmJyFrD5fqP00JV8yuLV8jwxUQPivQe3mJExgwC7QqzpV7dt4r027XS
	 9NTbS7vJl5B6grMw0HibqPOGg4/UCpiQEBNA0SsTlk/Wd0LPLMc8qE8368COBZZex0KrY
	 i3MHCF+8gPohAP+FYtVIkRTI0nXOBq2riYLZu430JSGM+xTqGhWL4OWmZX7df2ddWCUMM
	 Gpnh4IcBYH8T+6Nn4yHdrj/Pfg0c3Vt77frfnZBn9Wq3vIXCIbgRdE4/ADOOvSntORQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085766;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EUvxCVVdQ+q92ejascOtvWN6znuibOaC+AbhEBsnX98=;
	b=QkMjfwLC72MKhc0Hubr+kk44tdRQLYVbUtDeYJBsiT8uEQqgCyUspLHWda224ksFl9nj
	 DPY7iyYTKw2c6xTh1PtcIhLR4d3JFtJLAGsFFRaSOK89BFMmO+SLxRURTQoL+rytHa8Hv
	 Vcj382sf/jibWrJ844GlXKOsZO1GDIOjEXDMZX2jhmNb38aQO4vRx84cTJjJwDGf9vRcd
	 DAcqss4C9pFHFz4sC7IT7gqUeeUI/93urrYYo7pcC67b7b9Q7BlS+wMt9WXBx3qPJFS+S
	 BYqQ1ahzA/JN8hKeYABf9aNooPgKzmZNSX8ROnS/kygkx8B4PJwL1Mn4lPjc8QYwniw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=SAJs+v3z;
	arc=none smtp.remote-ip=51.250.60.160
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [51.250.60.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA28606A324
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 10:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FA28606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=SAJs+v3z
Received: from mail-nwsmtp-smtp-production-main-88 (mail-nwsmtp-smtp-production-main-88.yp-c.yandex.net)
	by forward100d.mail.yandex.net (postfix) with ESMTPS id 63136C7D05;
	Thu, 19 Nov 2026 13:56:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88 with ESMTPSA id wtYqg79mX0U0-YeoTLvyF;
	Thu, 19 Nov 2026 13:56:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1795085760; bh=EUvxCVVdQ+q92ejascOtvWN6znuibOaC+AbhEBsnX98=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=SAJs+v3zFcIItDmHu5QKOjvrHJ0QJB4ujJhEpfElTHQhpej0Ab3rZTr53DIaMKo6d
	 8V1UBmWNjbM3qPzDuiXrzsAHWwI2VbTmqBQLLtuBkMqHvRJapJmfaJHifdcb5P0YZH
	 NTduDZh/wsmphd5PzdQVGYCB7kbNK7e7puYGoDbs=
Authentication-Results: mail-nwsmtp-smtp-production-main-88; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+e2c057ea576d2644e2be@syzkaller.appspotmail.com
Subject: [PATCH v3 2/2] HID: usbhid: free unsent raw output reports in usbhid_stop()
Date: Thu, 19 Nov 2026 13:55:51 +0300
Message-ID: <20261119105551.488524-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119105551.488524-1-dmantipov@yandex.ru>
References: <20261119105551.488524-1-dmantipov@yandex.ru>
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

When HID device is stalled or disconnected, there might be an
unsent (i.e. never passed via hid_submit_out()) output reports.
So free their raw buffers in usbhid_stop() to avoid memory leaks.
Adjust hid_irq_out() to prevent hid_submit_out() from using an
uninitialized output pipe slot as well.

This is a companion of commit f7744fa16b96 ("HID: usbhid: free
raw_report buffers in usbhid_stop") and inspired by that one.

Reported-by: syzbot+e2c057ea576d2644e2be@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2c057ea576d2644e2be
Fixes: c500c9714011 ("HID: hid, make parsing event driven")
Assisted-by: Sashiko-0.2.5:gemini-3.1-pro-preview
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: tweak hid_irq_out() to follow logic in hid_ctrl() (Sashiko)
v2: adjust loop to match actual FIFO size and tweak commit message
---
 drivers/hid/usbhid/hid-core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index d7cf2b56e117..bb3cb80d908b 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -452,7 +452,7 @@ static void hid_irq_out(struct urb *urb)
 
 	if (unplug) {
 		usbhid->outtail = usbhid->outhead;
-	} else {
+	} else if (usbhid->outhead != usbhid->outtail) {
 		usbhid->outtail = (usbhid->outtail + 1) & (HID_OUTPUT_FIFO_SIZE - 1);
 
 		if (usbhid->outhead != usbhid->outtail &&
@@ -1260,6 +1260,14 @@ static void usbhid_stop(struct hid_device *hid)
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
2.56.1

