Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.160
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795085766;
	b=If+YhuKjrPvRZLBvleOhM+Q+LoPI5/Uqw/rJvyjKbB5sEm2dW23ubbYFbL2av2CPvGya
	 d33rlNW6rC1jhDOHUtTGyIJPgNx9YygKZcnSgfjzyeU1q95NreMexkF2aCbrh9q4Wr9kX
	 mtjLhnGhu4qEMbaZToJogx4sC/Uz+yC8xK/jeezHa49C7xfWNHRzOW7N/fDLycZNxhG8J
	 hxaa/TUlyAHOTPd5B8uTipqkIyvW/WQfuJlf6VbbDIK46IoAVc0iRJiR+oWu/jbmDEOQJ
	 eWNIut30FxUR5E6rYmBhIIE6vU3ietCoq0sklVsBS6MDNLChBZXYGimZFC/Z4cJPt6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085766;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eVUlkkjfEUOOpjefhFNaHgJ2IiGfsXCDTO6dRq8Ha/k=;
	b=mSV5a/VmqDlFTdKFAcVoZ+Pr/0uO6jzURQWEb8PtgpbOaLYxuE+iO9M36K1sHkRnlAyQ
	 R72/eLt8QTC5QZOQqKGFkb7f+btitzUM1y5zHihA2XrY1git1Npm/Q8wh9k8agq9Q0mPM
	 7TMLaJzzthHfFdQtVyiFBb2zHFG04Y46w+21nm5FO0OShViKVEHKw/sN34LQ8Vf5ju9go
	 dCp9LZ6GpVOtVswlEPOwKJ9NnwfKKl8GFZ82V+bLjt7D9fIQZIely4aeT5W8ocXxMLKPr
	 dClmQzui8nGfEErGXA1HW9kIIWE+8p0wo9k5mkUY05KRJ8i3PgBQwReT2eMWhhmUg8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=Hh3NcsGe;
	arc=none smtp.remote-ip=51.250.60.160
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [51.250.60.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0A606A320
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 10:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89A0A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=Hh3NcsGe
Received: from mail-nwsmtp-smtp-production-main-88 (mail-nwsmtp-smtp-production-main-88.yp-c.yandex.net)
	by forward100d.mail.yandex.net (postfix) with ESMTPS id 870A6C7D15;
	Thu, 19 Nov 2026 13:55:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88 with ESMTPSA id wtYqg79mX0U0-zNAyDeki;
	Thu, 19 Nov 2026 13:55:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1795085759; bh=eVUlkkjfEUOOpjefhFNaHgJ2IiGfsXCDTO6dRq8Ha/k=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Hh3NcsGeGXYm+M6vMCVsTOmYtGgaxd775n5QiQVBObTU45KJqSXfo0jB6iqUzx53Z
	 wqT7lMuylblPIJqhWznbx3uJek5CxjKgHlfVi+u40sIfnTc171tbKqYWFxNln/5Vpa
	 66VPC5fV7dZlYlRp4yo/As+E69obzRSZnv63QW9w=
Authentication-Results: mail-nwsmtp-smtp-production-main-88; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 1/2] HID: usbhid: adjust output pipe FIFO size
Date: Thu, 19 Nov 2026 13:55:50 +0300
Message-ID: <20261119105551.488524-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.1
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

For an USB-specific HID device, size of output FIFO should
be HID_OUTPUT_FIFO_SIZE rather than HID_CONTROL_FIFO_SIZE.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://syzkaller.appspot.com/bug?extid=e2c057ea576d2644e2be
Fixes: 4916b3a57fc9 ("[PATCH] Generic HID layer - USB API")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: unchanged since v2
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
2.56.1

