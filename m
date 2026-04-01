Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E54779B9
	for <linux-input@vger.kernel.org>; Wed,  1 Apr 2026 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054906; cv=none; b=bvv/2jCTr+cTxegLxc26bWChza5py2yx6aHO8EOnGCxBprZUPTq28z9r8CFgmfuQ3pIEEDpj0ME/hu15t7uvwHiflJlmRgrBBKwTL9JwCx1UVLOZpZCAnRATQ7a9GAdWeF4YpZYqpg2nbXCa5s7Bf4BDh7UlR/2hPy+SBKvxILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054906; c=relaxed/simple;
	bh=gfu8a4I+/sJXCMRFXUH7ETxcIlZFh7QaBEWEGohuf3Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f4AZtGRryd1Wq5LYJgwYGt/1mhYgwDTfxotUmr+C9HJ+8Bu0ZydXqeIeFxL60e/xagay7WOxOVdeLpDUOZprs6Yb79dKySKeshdStIiKCrgXYtjVnaQ3TdQYRT2Rzk79uby1+FVASgCHTK2bNS3bNmR+LY91xEPYTFNBCzW+Ldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S2m5Vi2M; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2m5Vi2M"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-66c73f6be2cso1693461a12.0
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775054899; x=1775659699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QT3vxZejCM69HEFY76z9Yry9MQ0IbkM3I0QXLUzp4IA=;
        b=S2m5Vi2MWr7Ymn+ONx8k3r0KOcXMb6/Nrf8kKZfgViTt56TBhE23LZZ8OnvHLMf6X9
         aHxmLIGfXuVsB4AavWJIMuUmo45giGqyi6FsdmVg0S2oGriPN3+2ispl4Biu/1dYASd7
         OhgB38E1BNl86E6GjkhPAiruJyPZQhi9ySDGGRj3ucGNjqEYvD5dGW9f2SRTNLlkrQLX
         5P7qNljjuKXHRU0KZdDs/fa97FPG/da7Ixzu2xZkHN0wjxCvvsy/RiScYbyXNt4JglZf
         asxlQd+OwagKBRd3D0egTY+tNY5VHVmwjDVN4V+z2yXfAGhx6vDaUny7ulQ6+cPbYApR
         +XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775054899; x=1775659699;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QT3vxZejCM69HEFY76z9Yry9MQ0IbkM3I0QXLUzp4IA=;
        b=q3yqPywPlBGTC+tEHkCXGMSGNgmGSh0DEvqQfMTghhC0PjDAos49wv8QJRGpu8UdGa
         N3KBTb4FCQUeI5SWdhqs3WV8nzIa24KNHADxFXIMrSZZ1eZvw/f3Xr8Apm322M2ZnYfY
         F9d1VBuurbr7s0zDHAFDE7cRoSFZKBPjh/dQG718xmBVdZv2jjLWlLX9t2wIfd1S6Ukd
         oTYzRNeJu/0o10a1BspqQC3C+Gkyj2SYK9cfbsJWYJFN/3yNewFcnxq/j8b1oGWjV93X
         htFzW97je2skmaZ5+T3fNQhag06EXF5nmEvnJThahR9U4rx9Usz4Yn+aRayceMFHAveI
         p3Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWer7FMeKHxMXyRDhyoB+tS18ipPPOElSPB9Qf7j+0VzK8AYxdB/OhlrfnixxJfLA1atECbLqHG5beN1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQzJHsFLh2BdotH6v6Rn96ozTNQEk3zDbHGcjO4rZ3oPheZyj
	LUILNMkhO19OfYkfr6v5dqZCrDChNqc5MmyjKpjJmkgihfxSj9zib7DpKIIrPLVLEFcutXkd9Xi
	2Xra6fl5u8w==
X-Received: from edaa4.prod.google.com ([2002:a05:6402:24c4:b0:66c:1cd0:6f8e])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4001:b0:66d:eee2:8c9e
 with SMTP id 4fb4d7f45d1cf-66deee28de7mr374028a12.3.1775054898469; Wed, 01
 Apr 2026 07:48:18 -0700 (PDT)
Date: Wed,  1 Apr 2026 14:48:11 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401144811.1242722-1-bsevens@google.com>
Subject: [PATCH] HID: logitech-hidpp: fix race condition when accessing stale
 stack pointer
From: Benoit Sevens <bsevens@google.com>
To: "=?UTF-8?q?Filipe=20La=C3=ADns?=" <lains@riseup.net>, Bastien Nocera <hadess@hadess.net>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Beno=C3=AEt Sevens <bsevens@google.com>

The driver uses hidpp->send_receive_buf to point to a stack-allocated
buffer in the synchronous command path (__do_hidpp_send_message_sync).
However, this pointer is not cleared when the function returns.

If an event is processed (e.g. by a different thread) while the
send_mutex is held by a new command, but before that command has
updated send_receive_buf, the handler (hidpp_raw_hidpp_event) will
observe that the mutex is locked and dereference the stale pointer.

This results in an out-of-bounds access on a different thread's kernel
stack (or a NULL pointer dereference on the very first command).

Fix this by:
1. Clearing hidpp->send_receive_buf to NULL before releasing the mutex
   in the synchronous command path.
2. Moving the assignment of the local 'question' and 'answer' pointers
   inside the mutex_is_locked() block in the handler, and adding
   a NULL check before dereferencing.

Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
---
 drivers/hid/hid-logitech-hidpp.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hi=
dpp.c
index e871f1729d4b..42f7ea5b25dc 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -306,21 +306,22 @@ static int __do_hidpp_send_message_sync(struct hidpp_=
device *hidpp,
 	if (ret) {
 		dbg_hid("__hidpp_send_report returned err: %d\n", ret);
 		memset(response, 0, sizeof(struct hidpp_report));
-		return ret;
+		goto out;
 	}
=20
 	if (!wait_event_timeout(hidpp->wait, hidpp->answer_available,
 				5*HZ)) {
 		dbg_hid("%s:timeout waiting for response\n", __func__);
 		memset(response, 0, sizeof(struct hidpp_report));
-		return -ETIMEDOUT;
+		ret =3D -ETIMEDOUT;
+		goto out;
 	}
=20
 	if (response->report_id =3D=3D REPORT_ID_HIDPP_SHORT &&
 	    response->rap.sub_id =3D=3D HIDPP_ERROR) {
 		ret =3D response->rap.params[1];
 		dbg_hid("%s:got hidpp error %02X\n", __func__, ret);
-		return ret;
+		goto out;
 	}
=20
 	if ((response->report_id =3D=3D REPORT_ID_HIDPP_LONG ||
@@ -328,10 +329,14 @@ static int __do_hidpp_send_message_sync(struct hidpp_=
device *hidpp,
 	    response->fap.feature_index =3D=3D HIDPP20_ERROR) {
 		ret =3D response->fap.params[1];
 		dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
-		return ret;
+		goto out;
 	}
=20
-	return 0;
+	ret =3D 0;
+
+out:
+	hidpp->send_receive_buf =3D NULL;
+	return ret;
 }
=20
 /*
@@ -3840,8 +3845,7 @@ static int hidpp_input_configured(struct hid_device *=
hdev,
 static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 		int size)
 {
-	struct hidpp_report *question =3D hidpp->send_receive_buf;
-	struct hidpp_report *answer =3D hidpp->send_receive_buf;
+	struct hidpp_report *question, *answer;
 	struct hidpp_report *report =3D (struct hidpp_report *)data;
 	int ret;
 	int last_online;
@@ -3851,6 +3855,12 @@ static int hidpp_raw_hidpp_event(struct hidpp_device=
 *hidpp, u8 *data,
 	 * previously sent command.
 	 */
 	if (unlikely(mutex_is_locked(&hidpp->send_mutex))) {
+		question =3D hidpp->send_receive_buf;
+		answer =3D hidpp->send_receive_buf;
+
+		if (!question)
+			return 0;
+
 		/*
 		 * Check for a correct hidpp20 answer or the corresponding
 		 * error
--=20
2.53.0.1118.gaef5881109-goog

