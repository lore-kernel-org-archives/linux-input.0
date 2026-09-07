Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CFC45041C
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775623; cv=none; b=Qd3LflW8w6QmjiqiYc+o/mpmKhAajSKCXHARa1bRNwrJAM4y0pXvisd7ONZ69lXmzPIgUFKSxJc+8SK+yiXG0Pdw7P8fKxK4343hNikvIoRpMj7nuj/cnHHs6k1uLYXoZ8At6zW/Ukd0AisqX3qOIZOD+mOasn1qBzyP58HkFQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775623; c=relaxed/simple;
	bh=0PjfMFfsbccvAoufctFiVqYGSzyefHryP6UDpasB6pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uv/ofhmnXh5LsxY1B4tkz3IdGnfk+LFQozaCrzlel1Xb3vkXNRBQ+DDFjtk3IMMFhv0jXZF2hJU1yGYQZsLGm3Wy+gw7u3EzrAzOPU9CAnO6/m9/7849OM3KsPCJj5AOVD5PFXe/DcTAXDIaE77rHR+Di575GkHG5VI1w3X9j3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=uBv1BUA8; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="uBv1BUA8"
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:69d:0:640:32f2:0])
	by forward103b.mail.yandex.net (postfix) with ESMTPS id F3425C0079;
	Mon, 07 Sep 2026 13:06:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp) with ESMTPSA id n6JUhPGfxa60-lFrgqmnU;
	Mon, 07 Sep 2026 13:06:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1788775610; bh=BU/YXNYBLzY/+0FtaCr2BCtITUDanvWTzfee7peqzRE=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=uBv1BUA8fr9teh9OpR7XaNVALam3LLxRiMKt1aLgQLX2u+c3aKSkYey0jfvPiVUai
	 IXEM07tmIAQBVAnTCtA7aE1uo/0F4WB3dZWenqGhyBNP1vfXp2nmN1VFtNxRslkX1d
	 f8OV6F2uRwLpLZZ1nK/l5pgNJrvET2yHIUcK810g=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [RESEND PATCH v2 1/2] HID: usbhid: adjust output pipe FIFO size
Date: Mon,  7 Sep 2026 13:06:44 +0300
Message-ID: <20260907100645.86990-1-dmantipov@yandex.ru>
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

