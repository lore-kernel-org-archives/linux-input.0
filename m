Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204673;
	b=avFUgPJDCABxCDOlrK6p7z4ZEWpmcoTYekZiPpIaoOwFFLliI6PIrg0JmlC11f0jPYq0
	 +33M3xyO6f32EW7OtANve/FqLOefUMyj2sGvV4VjwsBvbhaMgDHkT8zJp7vD3OHtG8qRb
	 TIl/iQ2Bt+2kwNhpNtWHtMBBmiXw7cNF3gOp+uh5iDXU5CKeOvqSFbJ+8Os5pime/dYcw
	 x4+34m7HwH1xojnwBmL8WmwgwiLsJkvIsrfp8acIs+zYkhn0PqiH7K38jD9OzuGdQkj0Z
	 aUskRaEE7Kb7RTvQoWd2zSGDrsHc3wDAd64O/WMPiMMJAjqWxZSKTTvZszSYY+H00QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TomoyXuW3KzDnQ4RGzocEg0P8W0o7cjVqZCap0ep/+M=;
	b=svDu9pfRp3h/a4ZMzuSX8Ob6oSaUWlUeaNQCN1wVVgiLl0smET9sqf4j3fOPDEjRyWdQ
	 ux0+m3ZXF+UOc0X9s85DqZzyZIcIeHjsc8GovsW/ZmPYfi4siOAKKpyVJ9sHRczXD+YlN
	 hF8uJyMxSCo8EndZ9hGF5X5WpymXzX7VJxpebA5AD7RvwSc0kWGwUUf8ioBVTknMOnPaS
	 0bW0da/xycVeX28aH1jx1zRG0TbVS/TdiYmqy2WuZ/hfzBqXX6/rsWakFUgsqM3g32jyx
	 cOXGL2I7JpknqZdqDk7SU0JKvyMLpwDKLCwmEclLcYvkbmO7NpcqYIW4CIotDcRYhmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="N/cIv6lV";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD90606A333
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DD90606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N/cIv6lV
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3704d30b84fso639006eec.1
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204672; x=1794809472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TomoyXuW3KzDnQ4RGzocEg0P8W0o7cjVqZCap0ep/+M=;
        b=N/cIv6lV8NTkVBBSUycvVcrj7rND78t8AE/YqsYo9OzA1BJ91Kx6BTU4uJzZt9RUwe
         8fZ8kUzRGssO/FOseDzPt43d5H7XzWtIhH720k+ooYQHcQCPUOOytdFMfUThBb01wXKC
         jX8nFtWoMdW90I8yXPcWVSopiLvkeglrIuH2AUnGZpndpQruDTVKYqL6aXJnCZ+rgzs1
         9RVnMCEgIG69vnjXPkoie2QaDGHm3P/U4cKvD+rTuv7ZykvSWx6nK5RB09Og1n23NwuK
         oCn5V688CYorifP/d4IymWPHOLsBkzh2WEwO9csFIj96qmlipgvwlUaSwYbFm6wFhUDX
         BkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204672; x=1794809472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TomoyXuW3KzDnQ4RGzocEg0P8W0o7cjVqZCap0ep/+M=;
        b=MY+8d9uvsHbpopzS918+U7Qwa+qKVb/pCKW1NO9Kax4fun6vmLKX3oaU/VSr3+HzXZ
         zHweUoYgwI87lH3fGEKI6bILBUnKSaupl347kQqKZLntUnv5OJa4zDUEc3b4mMvyOOgv
         o2WBnoWT2SDMhAEkMGCDCNCXdHC/zOPwaRa8NS10szKxo5J2ZIJGXDuoarUcdFJGaSRV
         N3v1YVZQcpK3Mk8247rWGUUWLBx/W5hVqLKE3EtVtWDgsVfOc7mUotp9nQ8JVJRmId5U
         hJEYFojd/2WNystUnLmJqyqNnUG8+vqa/NcDebzqzxluy/mOV6I4f5PsmieGmu9gkirq
         I8MQ==
X-Forwarded-Encrypted: i=1; AL+hErGYgIt0SaydfTKj2s/qeF6XxdjPs1gRnp121MDr7SmwNrgekQgoYaUs1uPrZtwnhGOEbNcKyTkbAuCXkw==@vger.kernel.org
X-Gm-Message-State: APuU4Z97P92pnj36cfYnyjjFcrJCKY80J2AAgeT+Gy+qShq5Qp8DnOQ+
	wM3UziUSF1qnycVXb0T/Dp19jNutI+Q9jHEOoLqKfRn/GI74rmjboH6A
X-Gm-Gg: AYBFou1E82u7ubgVjAE/2PD3fAApzN4dRTL6LMEYmowbVWbcjpf2Rh4tR18dr4fuPNf
	IlkjGViGkAkOaQKyQ/+9aCGYZgN+VdcKCtBD3o4UtggAJMfBFHm2o1IKWX3VYHkv4FJKymLfOWJ
	z22d/7cOQylXPRUO+Px6+L1/eEPzfjnrsWpxWaeFsqTafqgvb3YIZf+Ygujesp1uEksyd9QW2zh
	vaufc04CgPRsPcYvhkiUzCVC9HWJO5iOKh4+NmULFoRCGKDVAPYww63GOubs3uExV67j7O54FIf
	Zsr6P9PJfeerKb6/YUyRrmxlHrPgG7jE4QD6lA7+k72Lu0Q6MPSSOKS2DqY55PlRJgGSxpojq3b
	zP2BmkbcvrU77m5Sc6qELTxA3hVbUx6lm8tU7nsfueIR8/cYstOIu2K9379L5guLT4eiHpvizWl
	Wr+GyA+K90twvw1Dbaes+zSxycD650Kz9RZlNuE6AcKCF7/X6nqq6uTrn8kjcqI4U9jQ6ak6RfY
	EKvwAdTiDrZxkS2jdzi5B/1pMRGdOJ5mbBrbqVmQh2RBCOG3G6JgeI52ihUe35Spy8sMvijrhLT
	ht3mnlA2hm/g7viHQZO7JNHTVC3gQBKFYV0iBfmCIAJUzYW3OpXy55oDxiATLqb281TmSNjAQTH
	ejRZksed8ZEVLfAo1
X-Received: by 2002:a05:693c:415a:10b0:36c:9af3:2309 with SMTP id 5a478bee46e88-3725827055emr6050311eec.0.1794204672142;
        Sun, 08 Nov 2026 22:11:12 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:11 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 03/18] HID: logitech-hidpp: drain G920 FF workqueue before closing transport
Date: Sun,  8 Nov 2026 22:10:47 -0800
Message-ID: <20261109061103.2887636-4-dmitry.torokhov@gmail.com>
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

Probe no longer keeps the HID transport open indefinitely, so the
underlying USB interrupt IN endpoint only stays active while the HID
transport is held open. When the last input user closes the device
after input core flushes active effects, or when the device is
inhibited with commands still queued, releasing the HID transport
shuts down transport I/O unless another client holds it open. Queued
force-feedback commands then fail to receive their HID++ replies,
causing command timeouts and leaving stale slot mappings behind.

Override the input close callback once G920 force feedback is
initialized so the force-feedback send queue drains completely before
closing the HID transport.

Fixes: 91cf9a98ae41 ("HID: logitech-hidpp: make .probe usbhid capable")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 40ebab5241b7..476c0f0eb086 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2815,6 +2815,15 @@ static void hidpp_ff_destroy(struct ff_device *ff)
 	kfree(data->effect_ids);
 }
 
+static void hidpp_ff_close(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct hidpp_ff_private_data *data = dev->ff->private;
+
+	flush_workqueue(data->wq);
+	hid_hw_close(hid);
+}
+
 static int hidpp_ff_init(struct hidpp_device *hidpp,
 			 struct hidpp_ff_private_data *data)
 {
@@ -2897,6 +2906,8 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 	ff->set_autocenter = hidpp_ff_set_autocenter;
 	ff->destroy = hidpp_ff_destroy;
 
+	dev->close = hidpp_ff_close;
+
 	/* Create sysfs interface */
 	error = device_create_file(&(hidpp->hid_dev->dev), &dev_attr_range);
 	if (error)
-- 
2.56.0.506.g506a7eabc5-goog

