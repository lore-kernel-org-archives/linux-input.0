Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E05450400
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349850; cv=none; b=h375b7HkMdo+Lr5Z0CcJwM75SNhXno2aI2hJmAk8dp3YXqMMwzV5HtpwWyxWOv0hwMV8dAZb7aIWGVVqd6uEghIp/OW/SHq/PzCfJDM/cTHLljtpuX1GWre4nz2xCF4+V8Vq9nkm/cgVZsjsaOqrCsVeaWAyl8flQX0qio1tsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349850; c=relaxed/simple;
	bh=fhOi5PAo2gpAxBWIN2cRjpuX4ifBRc2NZjvCoF761Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K04cRo8DwcykUVGSrhVGtbDYmjBEGQ8ds8oKSvzYEilUjX+ZY93p2TpgE7tHKNMKYJ1gARz66XF4WeZT3jHh6AXnR4GJ6Tl5uVtqiIlQMFd2GVDb6N17BRBYZ5ASnNysD9diCKFzvieBhh1azxR8lMeiVtwTrvousYI4aKPLejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vj7q3sxQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj7q3sxQ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf452def93so21775ad.1
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 11:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785349849; x=1785954649; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ovnLIAD+XyGb/mkkC3+YLZwoVPF6ZcojA0tze6Sb0Os=;
        b=Vj7q3sxQJabnUnd9vvZP3gDSS7oDH0yzJPZ+Cf0b4yMmUPdnUUun/Zq2PSaDyKqGfC
         j50D9Vs8Yhj1DsyofYo6DimVJobnhmgQH2b35HmBO3Ngj9fOTVIo3QIk9IaMzEM5TfU8
         pz31rWCPaXCjrqBUCcvadC1N8AnSbkKy5xcYYmJ4jpSOJodnpoqzXgc86AkYH9gKteQE
         w82LvsyPA2t9MEDUoH4HNO0XvHtkl2FPWSk7sJuFkn5uZ1nav8KTxPiWx0loWG/gX/Ci
         NsMwM77sdp3o+b/DqlDSrPzxcsFkLXat/InDhhmvOl1l7M8YeaCuOCboYxz816YN4Ypf
         dnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785349849; x=1785954649;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ovnLIAD+XyGb/mkkC3+YLZwoVPF6ZcojA0tze6Sb0Os=;
        b=glVI+qQDKN78Vi0/ZO/EtnjdI2byeyfCL4QQSBhpd7F7lcRlteXUQzE+9+G9kszC96
         rgEJJ30VGM130aF74JEraVhnkUkGyP3oqD6RlAlntKmcz3tP5JM/tcYCgIDI7+ihwtIw
         2ykJeYv13CfGBU3X17i2f8niRi08dGGZvsxZheBeaCRqg7EAk+w6vu9QYZluDmkyzNiW
         pqLskky3DWW7pYW+1JFOQL0FZPLD9jBLxTbhwvAkrXSyYAg2gtJvhCuyjmwsVaoeHTDA
         KV671zgA2lZtWbrj2+EVYMZueHK+atZMkcJshYgOb3nzG/5QYhpSbNm0uFHZRJI/Gc7N
         SgZA==
X-Gm-Message-State: AOJu0YxUlzXBYcOZefyRbs6p7ixdI55gUmMIZWlr3SgZ9LYr0s554j0Q
	DoWHNL5TZQ1JW7mf/v6hml++V4HDuhfJeGKCgQbP+PrlHQWnvLHx4slBaLhTLQ==
X-Gm-Gg: AR+sD100tv7TYo04Lr13FMroK+eUwLBSEBwGDyMziBSSoQvYjbIsnZfHJNwJJ8cfpTv
	iC5pdECt4jf3i6Vl/lUvTwHAdxjRkL3vy0dWU9ZXBj+/WzXSbhp3N7pnLKAPagifs5IMVca0Zz+
	yZCHoazmrglcyJNedesvFF9zugjrHaZcwfcehka3sekeJJTWvncpYHEYZXHn4kpCOSq+mhjdrtv
	C0kj+IyQjEx94ZOoHn91Dxf4oufeYTMnneN4edB06zy/zAG/wPH7L1Cj9d4nLTtUS4KydlVdgXx
	M4PuvnDbvzN28OgdhGX9rA3cFpgpJB6Fg6goT6Ku8G73l23BYcFU5sdRE2NWK1opiFSHbTjINFy
	bB2AN1QZAhsGy2Y5mFhReKfhKGt72oyCaDblHZY+dDbeO48nIOoPZDgyANGiF0Unk+TvD3ETw6B
	oFk8Z7hlXaa6rV8p2ffX+LJb6Q3jzy8flL2OLGWEB7GdbSWFpKsMHltNGNW3dNu9INEldBUcBEA
	TQ6FWGLOSslI9ueI04rL8Jn9AJkWw==
X-Received: by 2002:a17:902:ea0e:b0:2bd:2c3a:2a36 with SMTP id d9443c01a7336-2d02623c6aamr35799715ad.0.1785349848973;
        Wed, 29 Jul 2026 11:30:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7d64:4b7a:74dc:6d35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504dca6a8sm12418157eec.29.2026.07.29.11.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 11:30:47 -0700 (PDT)
Date: Wed, 29 Jul 2026 11:30:45 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: evdev - fix information leak in evdev_pass_values()
Message-ID: <ampGGKo4UMKru6f5@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In evdev_pass_values(), the input_event structure is allocated on the
kernel stack and populated field-by-field. However, it is never fully
initialized. On architectures where struct input_event contains explicit
or implicit padding (such as the 32-bit __pad field on SPARC64), these
padding bytes are left uninitialized.

When this event structure is subsequently passed to the client buffer
and later copied to userspace, the uninitialized padding bytes leak
kernel stack memory, potentially exposing sensitive information.

Similar issues exist in __evdev_queue_syn_dropped and __pass_event.

Fix this by explicitly zeroing the entire event structure with memset()
before populating its fields. This ensures all padding bytes are cleared
before the data crosses the security boundary.

Reported-by: sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/evdev.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 5764c98b4f1f..114524806293 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -146,11 +146,11 @@ static void __evdev_queue_syn_dropped(struct evdev_client *client)
 	struct timespec64 ts = ktime_to_timespec64(ev_time[client->clk_type]);
 	struct input_event ev;
 
+	memset(&ev, 0, sizeof(ev));
 	ev.input_event_sec = ts.tv_sec;
 	ev.input_event_usec = ts.tv_nsec / NSEC_PER_USEC;
 	ev.type = EV_SYN;
 	ev.code = SYN_DROPPED;
-	ev.value = 0;
 
 	client->buffer[client->head++] = ev;
 	client->head &= client->bufsize - 1;
@@ -212,20 +212,20 @@ static void __pass_event(struct evdev_client *client,
 	client->head &= client->bufsize - 1;
 
 	if (unlikely(client->head == client->tail)) {
+		struct input_event ev;
+
+		memset(&ev, 0, sizeof(ev));
+		ev.input_event_sec = event->input_event_sec;
+		ev.input_event_usec = event->input_event_usec;
+		ev.type = EV_SYN;
+		ev.code = SYN_DROPPED;
+
 		/*
 		 * This effectively "drops" all unconsumed events, leaving
 		 * EV_SYN/SYN_DROPPED plus the newest event in the queue.
 		 */
 		client->tail = (client->head - 2) & (client->bufsize - 1);
-
-		client->buffer[client->tail] = (struct input_event) {
-			.input_event_sec = event->input_event_sec,
-			.input_event_usec = event->input_event_usec,
-			.type = EV_SYN,
-			.code = SYN_DROPPED,
-			.value = 0,
-		};
-
+		client->buffer[client->tail] = ev;
 		client->packet_head = client->tail;
 	}
 
@@ -247,6 +247,8 @@ static void evdev_pass_values(struct evdev_client *client,
 	if (client->revoked)
 		return;
 
+	memset(&event, 0, sizeof(event));
+
 	ts = ktime_to_timespec64(ev_time[client->clk_type]);
 	event.input_event_sec = ts.tv_sec;
 	event.input_event_usec = ts.tv_nsec / NSEC_PER_USEC;
-- 
2.55.0.508.g3f0d502094-goog


-- 
Dmitry
