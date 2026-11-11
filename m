Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380197;
	b=IfwzAkHhS/yjtKuQI5JVioUSzoo9o9XcqNdh4pd+3joxDJ9P1QBzrO3jNpV1bupFXljz
	 BwIQKnBt84Hyr+xbBTGLu4lda2pX7UHcS/jmwNEA2pzYlLgnBjaKhOa953zatRRjBzxE1
	 9SLsZSjUcEdpU2hZ9TYvUueoFB3o9RJ/yE2GHmeBatCXDPxqGu25SNGyiqeE2vNb5VWxs
	 G0EYJWlY+DYzsBbuQqH9t3Rpv+kmQIgF3wNf/Ah1QH/6dnS/eHHKaZn623MoSpoZ5lM+t
	 xApXZMZazZegutduYxiYEqjgA/lVdljpOD4qnKCOwv7rwGJwZcEf0g6J6jVMEiJ+oLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=y727edWPKrlVhEHY7MYl4i0rzDCyKBHlem7bWOcM13U=;
	b=wVVl3VJNqCXzKeQNq7yh8qg6ahc9+M2kzIX3+9/A1oj5bGgGkMK6e9jXSfli6QHiyJVN
	 wpHPv7RE8dFmCI/B17n6x+4rfhd8fq2mLhm3fYNUKL9PXtLd2AwwWllC0WbuVu9OpprHI
	 iRGCxW0uolg1/CtNTxIO4WjU5Fefkg4xCb+HWE4gsbtAtBMUH9iwyd88fy7ZbtgCNmmZk
	 FgkCgCHDbKmnVYKGJl3jRtCB3pAtFENS64a+w688TahC8AlfBZRvRWdb3g7IWqWlnJGmG
	 IULBD+51DTOeCIHFCB716T8zMT0/7Ylf7FMZAq9jv1vj4ssU0LumphFfR8Ymf9HY7Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kz5duW3o;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED660A2617
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63ED660A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kz5duW3o
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3acec6677so4468671c88.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380197; x=1794984997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y727edWPKrlVhEHY7MYl4i0rzDCyKBHlem7bWOcM13U=;
        b=Kz5duW3oCeUEpQPoyFGx9XDP8NoOLKO/iZVqv0L20raGqMXzZmvh/UvinV+W8Km6Vs
         AsGG6tjv//0Z7AX0uBzeDUYxtlYC9At8NBXDb4+ZlOF/IuRpoon4wqLKDaTg1ewHHfZD
         Imu+FecqmVk7JfqSDddt1+9wtTEKV22IPdIjIsdJLo1Q9HgBIAP9hZt82yqA3Zuvy0IY
         K3t1jHr5IrLk4k7QlMslTDokhWFop5lbdQwvRKuLDeQIoeuPNgvI7xN63W4gLwxTRAgm
         BwdBzHJxde3b7p2KppCnJ5bPFKBAoAQfCdlbBE16SM44Eiq4RMiGm2M6qzCkfitY3v0o
         Hx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380197; x=1794984997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y727edWPKrlVhEHY7MYl4i0rzDCyKBHlem7bWOcM13U=;
        b=C1oeiB7gbPnFogcVGujWjd1mucyhEUYxttmGhtmnEy0YbQ359ZB9tpfEdqaVkjsAAC
         uWbJytQCxlhrf+rnC2r88EgE0hCjpG0N/Bk/07/Klfeyl169uoo63S5s33Cd2yr6ZHyw
         yULomhRPJf5iblfadep10Qcj1LvOfZ2Pi9fQRxV52AzTTINjYXzxIYer+vsp0FxbAAhP
         Q8wMaVJwRqjOGbWakitG595bbuBJzp5uq1mBmiW3h93f6fU4YFm5UEwJzFOzTT6D/aNq
         oh/3wtHy+il4GBe5v8AfYpi2Skw0YSuma7ajNi83xpy0sBhxa/d7LeWgGRyNvOG4tLXK
         iaeA==
X-Forwarded-Encrypted: i=1; AL+hErEngdUIYheYTA3t5TnOoizBrmcHe2sSrh0lxTgS53MNTD29G1pLsjlwp04MFP+g6mZkAh0VTI3JxD1+bQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/NHtQeZ6Y1pVnuxbqCFgVTohHWyY/4RcVePpwDVZqiRZSoLsem
	dR6dJBVhFsvyf6LfP8+GOTIMBnE+Rn/EPZgyQ8LDtq4vGwNGKnS0bFfp
X-Gm-Gg: AYBFou0tCrw8M8nNXCfWyOHSCYSGGc5+/6fQRhmui4ZdNgLgJzGlSAdQ9zEkB/LMWQV
	AdL/iIyF9iLQm4kH+/c1dvoA6V6Oa+IYJ6nJj9U0r/zYnFeTAjJrS1y1wSzJL8wJ4qTshFHwKWy
	WzQiaFCD+aVR+EvC0c1lPxRjpYhWw/oIu5DNLXvKw74tvfXsDK38n+wsdZMZhlyoB6KYdHq6QXX
	JgVeeryc9mbHVROEHWHo2wtULoZ24PHW0wLfXTuGPqYbeqcQqisDKvL/OAAqmyqmz1SBOn2BoI6
	8TZXcXPTqIGzXKwkfumDcASzmbi56EpPf4A9cGUD2jYAIeQG52waystKP5sfKGR9v0aJrpJVO+f
	XrP9qtm+eJsuYqkHn4W6yK13VTjYosgGTpXowUvcQY8JyZwSDXeAKAHrSEGfGTsKLlTEzj9PDiT
	eSHWS4uPrCFrcDkB1tYAAuZ2tHoIcmzxrl+D2hRXarTiOEAL2yxShoPqtxhQKWwCjpthMlIgIHZ
	WuM6sFIEH0WV2suQ6QOdzvCqW+BQnxoNoMv+YySBfYIy8uSXzj1mO6nGImw4zkpKtFmAGtbXCS2
	ziKRdc4oZ+3OoAAF92zZteOH1ILklqkBRGo4ujSzcGtxQxN+JbF+yTLsz021jrzYCURVAMCVeWs
	gWGwqeuy2B813HTF+bfI=
X-Received: by 2002:a05:701b:451a:20b0:1b2:42ae:94fb with SMTP id a92af1059eb24-1b3c034e996mr1553319c88.37.1794380195717;
        Tue, 10 Nov 2026 22:56:35 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:34 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:07 -0800
Subject: [PATCH v2 09/33] HID: logitech-hidpp: initialize response buffer
 before publishing send_receive_buf
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
Message-Id: <20261110-hid-logitech-hidpp-v2-9-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

__do_hidpp_send_message_sync() publishes send_receive_buf before
initializing the response buffer. hidpp_raw_hidpp_event() runs in IRQ or
softirq context without taking send_mutex whenever the mutex is locked,
reading question and answer from send_receive_buf. If an incoming report
arrives after send_receive_buf is published but before response is
populated, hidpp_match_answer() inspects uninitialized memory.

Initialize response with the outgoing message and clear answer_available
before publishing send_receive_buf with release semantics, clear the
pointer with WRITE_ONCE() on completion, and read it once with acquire
semantics in the event handler.

Fixes: 2f31c5252910 ("HID: Introduce hidpp, a module to handle Logitech hid++ devices")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index c486488efe99..16dcd79059d5 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -300,14 +300,17 @@ static int __do_hidpp_send_message_sync(struct hidpp_device *hidpp,
 
 	__must_hold(&hidpp->send_mutex);
 
-	hidpp->send_receive_buf = response;
-	hidpp->answer_available = false;
-
 	/*
 	 * So that we can later validate the answer when it arrives
 	 * in hidpp_raw_event
 	 */
 	*response = *message;
+	hidpp->answer_available = false;
+	/*
+	 * Pairs with smp_load_acquire() in hidpp_raw_hidpp_event() to ensure
+	 * the response buffer initialization is visible before publishing.
+	 */
+	smp_store_release(&hidpp->send_receive_buf, response);
 
 	ret = __hidpp_send_report(hidpp->hid_dev, message);
 	if (ret) {
@@ -342,7 +345,7 @@ static int __do_hidpp_send_message_sync(struct hidpp_device *hidpp,
 	ret = 0;
 
 out:
-	hidpp->send_receive_buf = NULL;
+	WRITE_ONCE(hidpp->send_receive_buf, NULL);
 	return ret;
 }
 
@@ -4148,12 +4151,16 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 	 * previously sent command.
 	 */
 	if (unlikely(mutex_is_locked(&hidpp->send_mutex))) {
-		question = hidpp->send_receive_buf;
-		answer = hidpp->send_receive_buf;
-
+		/*
+		 * Pairs with smp_store_release() in __do_hidpp_send_message_sync()
+		 * to ensure the initialized response buffer is observed.
+		 */
+		question = smp_load_acquire(&hidpp->send_receive_buf);
 		if (!question)
 			return 0;
 
+		answer = question;
+
 		/*
 		 * Check for a correct hidpp20 answer or the corresponding
 		 * error

-- 
2.56.0.542.g3ef89b7020-goog

