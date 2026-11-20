Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164279;
	b=hPjVzEpwyPuMEcu0xqlsL/1Z2WQF5zcu+/EokpffrLzJRXT3KdWlFXoHuvBxrUbUrg+I
	 0Ug55KvowRGM6tYonDYpDfinPntH5dE39IGvu6QQtkP2mDjiY270Mq4cb0SENIFBASwRk
	 6kntJW5RmDTCXGPIQvOy/fPNHrgWzaI6eDBgt8PGYkvkt5Fiu9o1AoAtasIEoQ/lqBurb
	 UHuRaVbOZq1HizynvsCpPpsilI6EaufiJX7HLuLqr4QG6SZndfZAL4iIvUlcqGqofqXB0
	 kyJ3BlQjyvaHg17wI2e8z4uAVeAJB2d7feV3F6NYLguuw3w0eY1f1eb4KXFhP1b3XaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=tOCPuzD3mb/9AQ/h1SGIaad3lZj+puZXHmyeEPKL9VA=;
	b=BvHKLtHGnffx3+IWgjuddg2BDKFnCAChn56AlPA/w7aGkjLENuLSI8IgaeLyo77v14T8
	 tNHoQTCWzYpWp/Ar3ua7wXQ3HfUCbxWq6RDKyJJJOCoLASiu1qoNWsB5bAl8Drt4wNBfj
	 a8iKpPPtXnb3sDUeTT8/vRcX/aPUWcRE0rIAmQaOTd7znSPxAEIiAWeRwIAPCvtp7eoq+
	 MUemoRSratfLNMuL1JrxA0/1PjvIEV2/4upjutBipoMFXR65MUYm8K1U/INmKtenSr/HW
	 oz2F6hFerMQE27pq0HdWAMQq4GwtlRrQZMq2iXvagMPWnL1fG/cciGna2EqipJhUPcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kJzR9/MZ";
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE33606CAEB
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CE33606CAEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kJzR9/MZ
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b244fb7fffso646990c88.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164278; x=1795769078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tOCPuzD3mb/9AQ/h1SGIaad3lZj+puZXHmyeEPKL9VA=;
        b=kJzR9/MZbw+opyxDmMh8DNVury0Lo1W9ftyv2yVAZ30yE9IXhY3rfBJmAE19PA3YUq
         wQbsT3qSUyQm7vGPoAlTJxFUUfVUz9VogfHvUl5nVHNhrDE7NWxlw9+wu5aE5lXrGJy9
         WF6BfBTGVGfnYIPn+XJFLrIBN3DGiv3k4IE0qr0Fp8n5O+LcDVRNJETTX2V1vI1KvhQy
         q60moWLto2CQnEGCXScbO8Lblr6UrudKt6Fia155rOmvjnOpXIGIdWsKqHv8Fh69u9Vt
         yaVyBC5dLzqdvw5p7c+PTLOzt6G+RU2h04H9k4T/rx/GvW2bE9NCPJIk3R82fFAGLQh9
         v8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164278; x=1795769078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tOCPuzD3mb/9AQ/h1SGIaad3lZj+puZXHmyeEPKL9VA=;
        b=n+CHTFjkibb3gSFvNYiAaHam6H1xkUWT6xVyXy2F+NW6rqG37h+o6MADEFxh6UYUhp
         N7Cb/H45iKCnkKqzIKoWzpWphQ0/VqvQvas4iVLjoqJu4hYa5Cww+oPybbYaONfSzHnf
         wNLPEXK1kcrqqeCxGxzC6yqS5HzbPh+aIrEW6ZwgDuzW+gIFtQ5ffuyUNKXlC4GcXrLK
         Lp7KfpWhVFnM2BIjgcS2FcsJof2sjD9rGiyD83oeLA96OAJTjjFpsiwetgoc00xWR51u
         3fl774Dc42jdkd9ugIAHkZazAhR8OTT1mFNuNxMnqSxvIaHQlmpSGUbVBCq+adr9kctQ
         2Qaw==
X-Forwarded-Encrypted: i=1; AL+hErHXWgIgYS7PggDTIBjeqlayavu2xNYMfXJN9o58X1j7KM7mkaBag2KB71ef9C41mnmtmPCNP2rhnIudZw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9+9Kbw4S5NH48v7Bwrs1zu0mvu9uiU5SnhUQ1nSS/U5X+qAxnX
	5hCFuITjTNw1ZFLHn0EpJ2WKf2lfiSHeMnPWAvfQqtxdym82S8Uw9tRR
X-Gm-Gg: AYBFou1lQYOjpyYXNCtmdglIstlUy3HsS5rwbsoALiIh5Zja4r8wNz8vN5/NYZWoQAr
	zpYcGdgO/ikF6EDdauGCScpAT6I2JO5j+YNXp1y3ALl7ESWUfdlIAo47CXAAj63IxH6kxs6XzRM
	zMkO5YaWcjpRKJTlTjqrELbnGd3wkOLSH3ARv14AfxC/IYIiPsuGOKNZM2hSSmGKfENL3gwhSIz
	IcftnqIuiFQ4GVUEnhqiBJ19nfbaw4QDljFqj2sDij9Jc8eWrbMiKGdditbvIyY6Ey7pHVy/DFV
	hW/yY+TmL9M/1Sw8lM3uQIoTsjgRgs3uUnt8w3rJ9ns+404AbY/ibsouiDciNGNewTqqu8tu3ul
	LO3fVRDGBKaUFkPIv6+cdCh5UJv/WbMkLo5f19IX8aoEOGYVw0DGzs5y8adoh/cXgi006kdmPxc
	euECivhziBSgddVWmiC5ElaQAOTpi5GywuQy/5/iOJBFH0zG4mc3H0TUzmPNrC9f9ab+eRSs6aS
	rCGa26I/QZzgYFFE+41qOtyJyagKG/zX8QRBb1oodsxcg4ukWnnlUe3HzeMiV7hBh+P/1YDmf/4
	s3pG9mC3MZR9YfLhBnQM3hb9qoTuhFJ5ezfkNTckeE3RFk2SWR41xl3CiGWa2sASv2qxrhnc0xa
	+FQhBJ+TPK96nJGpeFQ==
X-Received: by 2002:a05:7022:e80a:b0:1b5:4b48:b9fb with SMTP id a92af1059eb24-1b5567c0ea6mr2231915c88.5.1795164278408;
        Fri, 20 Nov 2026 00:44:38 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm4808244c88.0.2026.11.20.00.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:44:37 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:44:09 -0800
Subject: [PATCH v3 18/18] HID: logitech-hidpp: remove unused kfifo and
 clean up minor helpers
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-hid-logitech-hidpp-next-v3-18-ba39242d4336@gmail.com>
References: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Remove unused linux/kfifo.h header inclusion and the unused
delayed_work_fifo field from struct hidpp_device. Also drop the unused
finger_count and button_feature_index fields from struct wtp_data.

Drop the redundant input dev.parent assignment in hidpp_allocate_input()
which is already performed by devm_input_allocate_device(). Also drop
the stale ret format specifier in the hidpp_connect_event() input device
allocation failure log message.

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 5c2d967246e9..06a5482029c2 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -18,7 +18,6 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
-#include <linux/kfifo.h>
 #include <linux/input/mt.h>
 #include <linux/workqueue.h>
 #include <linux/atomic.h>
@@ -198,7 +197,6 @@ struct hidpp_device {
 
 	struct work_struct work;
 	struct work_struct reset_hi_res_work;
-	struct kfifo delayed_work_fifo;
 	struct input_dev *delayed_input;
 
 	unsigned long quirks;
@@ -2833,9 +2831,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, struct input_dev *dev)
 
 struct wtp_data {
 	u16 x_size, y_size;
-	u8 finger_count;
 	u8 mt_feature_index;
-	u8 button_feature_index;
 	u8 maxcontacts;
 	bool flip_y;
 	unsigned int resolution;
@@ -4346,7 +4342,6 @@ static struct input_dev *hidpp_allocate_input(struct hid_device *hdev)
 	input_dev->id.vendor  = hdev->vendor;
 	input_dev->id.product = hdev->product;
 	input_dev->id.version = hdev->version;
-	input_dev->dev.parent = &hdev->dev;
 
 	return input_dev;
 }
@@ -4461,7 +4456,7 @@ static void hidpp_connect_event(struct work_struct *work)
 
 	input = hidpp_allocate_input(hdev);
 	if (!input) {
-		hid_err(hdev, "cannot allocate new input device: %d\n", ret);
+		hid_err(hdev, "cannot allocate new input device\n");
 		return;
 	}
 

-- 
2.56.1.750.gf70dc682cf-goog

