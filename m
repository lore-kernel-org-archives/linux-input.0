Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C345A286;
	Wed, 19 Aug 2026 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138637; cv=none; b=pc77mOjyeUHlSsD96tNyL6k6a1H1d1MFYfaiYjwo4afhfkV94pYwvIzdM8ugl0diR7nbyQXFKhi3iyAvkBb9PJH7fX2W6MCR49tsBv2QTrwmeK51dCeo5mmC82+kRkUAw3BribJdBL6ekwMuX1i6bJZTFws6Yolqc9XTv7n/tEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138637; c=relaxed/simple;
	bh=0PjfMFfsbccvAoufctFiVqYGSzyefHryP6UDpasB6pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rnfWVeoAKeQU1CF9VBoZU39LCEtaRQBr1XETOY3N4ZEQu+7H4IdfSoFVARG8SxJQDRxGoRxLSIWXK03uaqGQXepSGJRlO979Qoeozz/k77gsLQEYwfcsKNJRTCHRMqjqQm0FmIIgb7NtPvsQg3GsiK+0UUe6eKzBYKIb6BOFglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=YGki7UEk; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="YGki7UEk"
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward205b.mail.yandex.net (postfix) with ESMTPS id B656F82947;
	Wed, 19 Aug 2026 14:23:51 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:313e:0:640:a643:0])
	by forward101b.mail.yandex.net (postfix) with ESMTPS id 5DEE5C0074;
	Wed, 19 Aug 2026 14:23:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net (smtp) with ESMTPSA id eNURGNUfA8c0-T21cwSLk;
	Wed, 19 Aug 2026 14:23:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1787138620; bh=BU/YXNYBLzY/+0FtaCr2BCtITUDanvWTzfee7peqzRE=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=YGki7UEkGuNSOaKuhBOx5Ybbsj2PEeYMXZ83VdKMmGuC6tTejYRXufr1501OaQqwU
	 CeHm9tZe0/iZrUBCSBGB+iYqYS6Tfvd0d8UnjL4TnQQmSlYeyWMwMwT+HKq/TJejsB
	 e2RdHtTnhqYpfjFTZh7WH0vOxiEFrMY12IW5hYaE=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Anirudh Rayabharam <mail@anirudhrb.com>,
	linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 1/2] HID: usbhid: adjust output pipe FIFO size
Date: Wed, 19 Aug 2026 14:12:02 +0300
Message-ID: <20260819111203.2883239-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For an USB-specific HID device, size of output FIFO should
be HID_OUTPUT_FIFO_SIZE rather than HID_CONTROL_FIFO_SIZE.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://syzkaller.appspot.com/bug?extid=e2c057ea576d2644e2be
Fixes: 4916b3a57fc9 ("[PATCH] Generic HID layer - USB API")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: initial version to join the series
---
 drivers/hid/usbhid/usbhid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index 75fe85d3d27a..c408e694a7b2 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -74,7 +74,7 @@ struct usbhid_device {
 	unsigned long last_ctrl;						/* record of last output for timeouts */
 
 	struct urb *urbout;                                             /* Output URB */
-	struct hid_output_fifo out[HID_CONTROL_FIFO_SIZE];              /* Output pipe fifo */
+	struct hid_output_fifo out[HID_OUTPUT_FIFO_SIZE];               /* Output pipe fifo */
 	unsigned char outhead, outtail;                                 /* Output pipe fifo head & tail */
 	char *outbuf;                                                   /* Output buffer */
 	dma_addr_t outbuf_dma;                                          /* Output buffer dma */
-- 
2.55.0

