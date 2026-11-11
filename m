Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380207;
	b=BDVLToHxvt9jj6m+CMCOLEKjWYh6ukgdTPJ3BXZOVpDLZotgW6ukmyAFE8SBsFQwO+Ky
	 1CzlPAsYKV/tf1SV1qANigrFCOtvOxz5wVCSiCa5tJHdjlINAv1e7drzsWlK57OiU6gZ3
	 3TfJltm5ZGjiXYIjagu+946r6ZGfrmdTQGA4vQ89J93eLX5PwJ3ifdrAp/Ydbw4zBlUXj
	 tmZIzF7V54RGrpjJ/XI+09IwE3gqo+c4PSENtFF477LmyTXpPjcxlmKRMmyyfAtwzbWNb
	 x9ULbx3DsOFWUiAxac9wtxMzmO79fr7Ex1j6nOeKET0fIyNMpfqbP10jx/pzzz15h/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=V0SudJReUigpH9kPPiuUeay8kYja2Ksn/VXL40qXqEQ=;
	b=2RjPpWlntJEYarBLi93Qj+xRvE8DDAcTUkf54BHk7aw8CP/NZ4AQnt7XbCbV+Og28T7/
	 fk6e4zvmHAugjUAiWBmj3yAY/uugdBaz3DUK6buuO1pfJ+Y/jRcjJLYpdARW3A1kMYYas
	 9KntRFNwC337PUA++Alp5Kr0r0vlOSvEnwiog8yiu5NG9HHdzjAFrIgBY4trE4a3kGK6S
	 DmGfbyPOe6d+xkLf2AMzYnAhTFb2lNakrh2sL7abQU+YY84OXSq1JhEXuwCRnKTtgcuet
	 AEXlVgdqQIkXeaAzfIeDkns4JW6P73c8S7VOMRodOSdH9UvNFgml2XRAm5BACe6bSjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nksu4jHp;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E325606C95E
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E325606C95E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nksu4jHp
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36dbde64409so5978821eec.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380206; x=1794985006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V0SudJReUigpH9kPPiuUeay8kYja2Ksn/VXL40qXqEQ=;
        b=nksu4jHpcfAOaUPAVzxMc0QPljS/0Fqs6XLSRw1eRCpkzQs0UC8pbStG7BXBxjZtZH
         TwdUecsQRvfFl1MmDG3lcmjb8WqBvxWlgJsEzdIZQKDSiYX415zZS3KInSvqsG/2h7mk
         zLSuXp0WyLzwemADh1gyL5tpydKh4v0oTfDrxNw4qhgJQ93FJQIjFT4TAG1k5uQNs296
         i1R+wWKNo9JD6XFhOiBNcej3RhF29pLmda3sLfowdY41qCSfGl+yQXWb9+OpOzxyUxu6
         q6gcUuyHW1FRDqV7uHKSID0yACzyGbxeR/kVrDjqyNfWqZuyt4jQOLrdyb0hazuI2NUe
         jMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380206; x=1794985006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V0SudJReUigpH9kPPiuUeay8kYja2Ksn/VXL40qXqEQ=;
        b=lY8AtgF72igzBTaTqIt6uF9OyfOM0UELraBUmxiUf3rqaKb7ArnMnliEnMl++IIF22
         KyN9u13FHU1YZAyfzl8Fs/wmlgci2W4AF9C76QOi6k1uYqWtEP6yN2oR9LnnUbQqJ9ka
         Nr8WP36JPZlpxTd7fpXPlQ3o8Z//bL55gWJ47X3XKB8p2z20iJuLZfODG6ypRMBfrJpD
         Cb71Ife43zu5vkgdBUvtxjSUJZRPOuGrK+J1ZPA5V6Z0XH7PswLw4dpNj2QF5E88Ra8p
         J8WV6qHmNHLAJ4PDncQpIH1trSmK1djsi7is8zQsXJyuLSAHV2Vlzaoi8NG8oRAJt/i4
         jdzw==
X-Forwarded-Encrypted: i=1; AL+hErFZ9uHSWdGBnjrNzSZwWdy65hhe8/+FfsiCANFsYwSJOQ8U0D1hp72b8gMdqJ+3n8ZfZjk1kqFnkp4G4g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/O7Hi87vQnfrLW9Ra2T+A5Sro499eSKx1t8qhFIrm2ajVHd/+v
	TUarPTMqbkkksDMtr/oimjIpIPWYc6zlNicW0cytpGK/GNkl8Rmjq3ju
X-Gm-Gg: AYBFou2ugrWVWi/rRB/wz1a0Z/5qZIG4oImFD5pyqfNtY9OGlAHaggownDHY18CG201
	gtdRTUiRezskS7/ytwFGWY25+Xynj9IySOAya8/KleT5itG9t/CN4Y87Fi5h95SkH2sjDtFRdlE
	ZvGKcfsn/EthPfp9xVWNY1Sn6qZ+Kp+2w9oRQbMUhczhiiNMe330Wh2XNc7nTt3V/5EiRkDFTb/
	u0kfD/vgBlVLJ5vFwo27FH55xXJxkUIMGD5AoQZkmJAfUw14bmxBTiivHPpfYAZ9a405oAdll8d
	T5zGizNQzlJi+Jwf29NE92M9rOgjfqyXSe7vzMw7qSGCQUFDZmsiybCNCfItFuMI4cUvFUbXpFO
	RBaH9VgFgJsadK81r4ZBkIg3Y+jTN9g2XwfLd5QBNOz3jq87WmZfCIsgmDlXb9V3ej4GtjQd1EG
	iEe0I1WDVWVkdfgjAr129GElkWVdQ7gZ5KXk0ioOaxzB2aQ5omzPvwgk2xAuWMoH50Qxda72SYZ
	K2P5OHBZTP8opJ62nDrWCSO8SVuQwfDIzT2iLCWsEuyaVwXORQ1MNaChLoZeOvO0QjTeGfbdxLN
	oyfSb8/wvJeT+WK3xD3Npljnnnj+G6iPPvtc/Kh6V9C/MP6Y6qDTtlMPFrhx9teqGinr8wata37
	xD549GNA/2bT33/LEng==
X-Received: by 2002:a05:701b:454b:20b0:1b3:8814:8383 with SMTP id a92af1059eb24-1b3c033442fmr1588819c88.9.1794380206269;
        Tue, 10 Nov 2026 22:56:46 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:45 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:13 -0800
Subject: [PATCH v2 15/33] HID: logitech-hidpp: keep connect work disabled
 until hid_connect() completes
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
Message-Id: <20261110-hid-logitech-hidpp-v2-15-30743e91d83b@gmail.com>
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

During probe, initial feature discovery and device queries run with
device I/O active before hid_connect() exports input and hidraw
interfaces. An unsolicited wireless connect notification (0x41)
received during this window queues connect work (hidpp_connect_event),
which can run while hid_device_io_stop() has paused transport or race
with hid_connect().

Keep connect work disabled from initialization until after hid_connect()
has finished and device I/O is restarted, ensuring that connect work
only executes after interfaces are fully established.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index fb9ad4cfc583..15fe9dcbca6c 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4768,6 +4768,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	INIT_WORK(&hidpp->work, hidpp_connect_event);
+	disable_work(&hidpp->work);
 	INIT_WORK(&hidpp->reset_hi_res_work, hidpp_reset_hi_res_handler);
 	mutex_init(&hidpp->send_mutex);
 	init_waitqueue_head(&hidpp->wait);
@@ -4819,6 +4820,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	/* Check for connected devices now that incoming packets will not be disabled again */
 	hid_device_io_start(hdev);
+	enable_work(&hidpp->work);
 	schedule_work(&hidpp->work);
 	flush_work(&hidpp->work);
 

-- 
2.56.0.542.g3ef89b7020-goog

