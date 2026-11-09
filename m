Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204692;
	b=tcVnN5oKkaEAa4WN/osuTahuWBX0uCbbH5vGugKBPgOGZw3DJpk6tqgDKmNP0uLi2E/+
	 xhiak7PT3sSReiAunfkNjxAvOnZQbBGIbucnUtOaJ8ssd4zjhOyYRNiEUtKaLkHUchul1
	 Pg53AXl5JD8CU/oETSi/i7h9PDFfX3JOaS3hhen9BpyoLugBIDzNFKuFk/ewectVLOlSi
	 8wfsK60waXnsqRUWMx709BZowxUR8aVNFmng/0CYmnAeIDAOBztboT2Zk32t2xWruZt+l
	 9U5VlDLxJTRORxC7YGGGHYmNwmw3cns4Gf+/MSJb0vHw5LmBRMrR0lUwJVk+XMmJ7mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nbvpG8myeOhBLoK99qyI+dhTbyOC5nEpen87dSCIGnQ=;
	b=CyAIR50/681DHnVen4MKBPZpv+SatbcPqWuT0hQB52+WrxNVWKKxD2LyaKXrxZGIsqFS
	 hfWW82hvgHLdojB9LZ8J1i71I0aOq4rXXKwcGOWmURPUwd7Kvg0jQFFpnDVufMZ7WcaPN
	 ZcAYT6nc0GlSmThn1aVD6IgG6Ml2em5cPEUrfoKj8jC6znS/owvNxiMekBoCG1aj9o9rf
	 GN770/0yLY2z20NLDUWgIp+gbWRiaZ97ISOVZsY26rdYVw6o/cKJznaVm60AvaCWp2H3q
	 RkkZU30oX/u1eZ2FS5HiM3WOA4CUpgG+BurFZfBieM/PI2BU/kdvAEI4jmskCLsNjbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0S0JNXjY;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F379D606D823
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F379D606D823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0S0JNXjY
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1887778eec.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204691; x=1794809491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nbvpG8myeOhBLoK99qyI+dhTbyOC5nEpen87dSCIGnQ=;
        b=0S0JNXjY7oJ9KfWO5t0IwIwnrbkxF6BH25tLcHUmh4n7dBC4agciOhPfOSoMqii9wL
         wypk23adecTk5BAULlJQEFcN4Uy/dgBSw38KvQ/w9EpJb6LYu+xcd7Wwkg5jhA9/Fc0I
         z/sycY/LC0twI1mC/pEMLxZWbve59lrBoqv9R2ks9yyCYZUbfg6/yA+G6hE+iGaN636p
         L0OM0QnzGYPo15Tjt81SPlvpbIHcAeab0nzHcbtXcEgsLkS9XGhn9Ti+E1DUwZ6AjGaf
         7bijOnXEmFgMrfqP+YTdY3nXKaQJxYEBPSiX6pCCNBJF7NjaPX2X6+1Ph2yWq1ztyTYe
         XIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204691; x=1794809491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nbvpG8myeOhBLoK99qyI+dhTbyOC5nEpen87dSCIGnQ=;
        b=EOfiK9R6HvWzFOXvB0qSCKHfzC6KlYkuqe38ShGcrjoVpos4d4xG8RuRSXoS4i9ofu
         5+jELzxjq/ezrNtvpxjur43kFKoVBiX2A8rqAfdtNPK++patf9CskPmq8qSm68l3MqtM
         T6p8rrE8WpWPRokar/lU0+Do99zGfHXLA87jC9I6gxdxO/J13dS6JuaaPBaok95KBbHl
         4Dl2t/UaE9RRTsyuVhUMoc6TrVTocP9kFdJYBV2IdL4PGKwsQRhgKgZQAW6AmHuzAVQo
         +gzoVFNcsNtR7+le0pS/A60PI+Nt53cU/ymSJLNiD/F8GX8fMLOdf0gxMYX8sJaWcRvG
         Kt7g==
X-Forwarded-Encrypted: i=1; AL+hErH3Kty3gyCdiln14ziLdI35m7YR1Fug8JC3vw2CqUpvILxR+K6ntXeOrfgaXPJjblb9Q92jWPILwflPtA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+OpYDoMy0B/mGE1KqqX6CbumuZPAN6A8autB39DoSbWB5Gf6DI
	WOFpf9OuVVKgn31EXbgmZ1dHp17Gr7HvJ2Q4gCHo6h+7qrZQMVJL7BPH5/kfEg==
X-Gm-Gg: AYBFou3ZGpeeTFaOsD4jULXCtQxYZNtJ4djE04Z4RTTOpU5AqddKUE6Jt2JnYZcUxRV
	OCLLXBle9HglzfMj5CRFq9/BOXkSGetvqNuP8Vd0BMn+tJcvWefBIQu8/14AMEJjLfEl+IonKNC
	oHObDb3biF/wqM5ZGX1cJ20ZAIJOuYWIvV7qPSN9tz8kQ3grSvYAaL/iKn+1i+DpBuK3ADMgihB
	y5S0HJcOUy5QmYXaN5bOXCSnkoUsDDlisyshgVC2XyfyrB0RW4Ms5lcQn+K3yfDhpZ2n9kCbvt7
	QD8/rdJznSMiQF4Pt6BeS8dpXdOA0OWIZp8t1dCV3ePQ3QAK+KQcoYE2EBI0QaiR+VF2EV0Yiou
	C7L3Rw4dG+xK8GFNRXMwXlYn6arkRbyVf3EUHVB+5os9NgfcFlYQy8lkqz0ogDBIK05buN9osX2
	0BsHDVMmmmJ+0pB6BMF+tvCByhAD6d7cPnd7xQYcZIUa2DNiuru70dDs7UfjUwh/yguYczxHCG4
	vgUFJSoY9bG3fjgDiTHKXkji9PTkHmqhq3TVOow9JtraVXvASGymleAXzW5snCYdnCRQ3HS9wmY
	zLYTeaA/r5kINHt1oI2mdZUFvpMbcUkV8ADnFAkUmPBFCXXzTZvLiXSCuOt5BDvAPEuqH0k96qj
	/7O0BhUpUi3UVIxQi
X-Received: by 2002:a05:7301:a0d:b0:36c:a321:9fbc with SMTP id 5a478bee46e88-3725302c0a4mr6307270eec.1.1794204690967;
        Sun, 08 Nov 2026 22:11:30 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:29 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/18] HID: logitech-hidpp: use guard() for send_mutex
Date: Sun,  8 Nov 2026 22:10:58 -0800
Message-ID: <20261109061103.2887636-15-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
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

Manual mutex_lock() and mutex_unlock() calls force early loop exits to
break to a shared unlock path instead of returning directly. Convert
hidpp_send_message_sync() to use guard(mutex) so lock release is bound
to the function scope and busy-retry exits can return immediately.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 3a3baeb9fbb9..bf13e5fbe142 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -361,24 +361,22 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 	int ret;
 	int max_retries = 3;
 
-	mutex_lock(&hidpp->send_mutex);
+	guard(mutex)(&hidpp->send_mutex);
 
 	do {
 		ret = __do_hidpp_send_message_sync(hidpp, message, response);
 		if (response->report_id == REPORT_ID_HIDPP_SHORT &&
 		    ret != HIDPP_ERROR_BUSY)
-			break;
+			return ret;
 		if ((response->report_id == REPORT_ID_HIDPP_LONG ||
 		     response->report_id == REPORT_ID_HIDPP_VERY_LONG) &&
 		    ret != HIDPP20_ERROR_BUSY)
-			break;
+			return ret;
 
 		dbg_hid("%s:got busy hidpp error %02X, retrying\n", __func__, ret);
 	} while (--max_retries);
 
-	mutex_unlock(&hidpp->send_mutex);
 	return ret;
-
 }
 
 /*
-- 
2.56.0.506.g506a7eabc5-goog

