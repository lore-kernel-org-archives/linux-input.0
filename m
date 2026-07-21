Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7CB403B06
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655423; cv=none; b=oDra1xgScYFPDzv57I+NNp8n4YESrpd9Yjl7foETJSovfTyClC07x5Oof3MubfJBz0pOk5ADBPfVgTFkOAtHBT+iebDYMb+dGC5JPqS+iXzvLFCWw0sQaZq82LQI6hbpvVnIuqj/dHKuQW21eiXpoweN3kz9NaQtZtmmA/AJ+8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655423; c=relaxed/simple;
	bh=loyLNndZe2BsYTu+pwFvnvfZ47duYi2JsExezm3i9E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jOqgtJXkx7DFG5lgwfbje93uMdY0kpzf71ljsmf4tAr5059ldHqFuVuEO3qb38cKUPZUoh10d6KwOg0Xx22jj68FuARmReq6BtcI22W9zJrRbZA/ZRhlqcdv1XaaHZECrU2m+/V/OeJSOy/TIEUXqwWbGhyIzP4hHnoDHGxfN3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABhKisTP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABhKisTP"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4955de8797cso15263045e9.3
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784655420; x=1785260220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VqKbZZve1omn9QDF5HbJvkWT8nFz96JXw+SbxJwozH0=;
        b=ABhKisTPQvQYZt1MttjXKL2c6YUIorDyVTrqs4Z/t6uboa/lokqN+QeYY7hgRxemd5
         pom6DfGYZNNN78bWM11ugnZjuYgyQr7tuS20jWQ94VEN5xCwdJ/Y9m7fPUYN29zQ6KX8
         LI6TyhBeg1mlmm1EB35iivodDT1t71jYEr8AHiYrOeD10OEpc7Zehq5FbPzwIe1utUgM
         ViLpjc3NEvlkAZp5sfxnWAgVqSALt3/+upGDqczRWciiJfR5+5zjk2KOtkNRB29Gu+c/
         ISEuxDpHt+1MsoR/Bh5moQCqgk6qSX7ZsYcACz91OPZIz2O972sqh4xeNdbFfx9WnANN
         u0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655420; x=1785260220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VqKbZZve1omn9QDF5HbJvkWT8nFz96JXw+SbxJwozH0=;
        b=p9biVFuCOgx4I3gSPTmbubejwZ/dPtgmN/8XNuJTGT47g/gtnF1sjxeuSWG/PxngnP
         wDibovTCxeL3VIOxA/o5T98XAaHDCLNtbJv5htKHQVNFwZoGORev2a8CPGUb2DVLc9WF
         8P6Qv9K05NNBr5kVLeK63E4z6zM6tUyPhLntQJE+iEtciTohPAdeFM2iw/DbVyhi0fPS
         sjS4Ti72AdLc6nVbMggU5xrybGB7vn7+/2RLNNv2Kwbo/7WzANgw/05YMDYZkiSreWEL
         UpOO0IatiTg3HAmvTeWbWMamF06TJCO4fd2YD+93V6KLloT9k2Jjk8BLtkq27hfuTk6y
         5lDg==
X-Forwarded-Encrypted: i=1; AHgh+RoAk8x+rV50v1jLeXF2ZqTMMwZgBnQQDewSPQ0EXvHOecA2lF5N1cHN1sh4afPxsrQSlar+o6BTCTFApg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSHhjKYU0BFgQ7FM1ITfs7V2xC0j383/BpnsBJzXpVycJ+bB1o
	OBPX+RbwYNGvSenCGSS0HIhlzIH6eWIZjkfwb6qt4HboGnfSX7NdZadf
X-Gm-Gg: AfdE7cmaWZrVY7fP3GUZGKi8Byy1mImkeqjMBlKzSYmJv8g+fzw8WyNKklgSnrkzY/Y
	IYQDfQegocL134/LqfjiZMTwlO0OJJS0oVKAMireqN4vTDy3mphwytyGY9iZawumWSB90lHndWW
	OV/pltWwW6Tz9B565usWI6nokTQD//1MRvB1fEy/qhlMDS7K7tWeh8A1XXAB0ZRUuK63+hrNUlK
	FAUBlUdtc3XG04nkH0/rZsyA8ADuVuUwh+496/0UugGCLViQ1cHHae/a0O8DTIbfx1pf3BOln+4
	gyrkPDK7M7DranizpDC6SfqhmYrqqScoU5XSmlXjnq+Emo/7eYp7ojAN/Kml+soNK8twE3jRrZ3
	+7V6QbZvyCZVGJGAZ6Zae5Im/nA+sFxIIu3Wcf9FvgabdGeD/ep+/Nq1xSvrGsKsNNNjkqYoYA4
	XtaqEhXTLh7UfFp9uIXPc0lBk+qqJMYvEEUCodrUDvMB8sxjYQ24eYMRi+jG0mjIz92MLmy8TzX
	w==
X-Received: by 2002:a7b:c054:0:b0:495:5172:661f with SMTP id 5b1f17b1804b1-49551726896mr124397195e9.19.1784655420192;
        Tue, 21 Jul 2026 10:37:00 -0700 (PDT)
Received: from snakeroot ([2a05:87c3:2001:7400:4192:928d:2808:a0ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40801454f8f.28.2026.07.21.10.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:36:59 -0700 (PDT)
From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To: linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>
Cc: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>
Subject: [PATCH] HID: logitech-hidpp: Add support for G502 X Plus USB mouse
Date: Tue, 21 Jul 2026 18:12:48 +0100
Message-ID: <20260721171246.461232-5-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wireless dongle is already supported, this adds detection for
the mouse in wired mode. Supports battery reporting.

Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 90b0184df777..25620494e741 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4647,6 +4647,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082) },
 	{ /* Logitech G502 Lightspeed Wireless Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08D) },
+	{ /* Logitech G502 X Plus Wireless Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC095) },
 	{ /* Logitech G703 Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
 	{ /* Logitech G703 Hero Gaming Mouse over USB */
-- 
2.53.0

