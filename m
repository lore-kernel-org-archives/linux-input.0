Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443357;
	b=oaHWlsgeuIiPWR0hDd9dQyTmP65pxlodEhmcN/cQiCx9QbkIPWb7XbSlUzj4Z25Kq8Z4
	 gW6OxkMUx519lcnb7VM5LGsWd5NA1YWdfCx/GXn/9FkjADbSFt60/HfdJ2m3WFeYjlczs
	 aVBCyGYDdF6WutqUYUEcpBofL92vWQwdxDJHci1AQQv8K2PC3TjGYk5PPQvDHep9zQoQy
	 OQ9btLsGV6aL+J/iRRs52mMNJm1NQgBiV4f/1J62Jhz+iNWeN1IvWJrddOiZSwRx4zDHT
	 +RFWjn8h+80UhdmaX7n29kWzDyXb0tEYVDJlFvnikU7EwFCRadgUDveTLVQxaLCA+5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wLD9EjNf9HjnVz/OoDjNZ+yXnVYBBOhi0ebsNrJJZZE=;
	b=FQzgWCndgMriH9a50mOyaGNACj7aPXzQOUXaWK5xoCPAOvNyJ0CTc46vmrHRuJz85e4Z
	 TKKOnOn8p+V4/3bMmHTWSPNtWomvERKdXxVtG0j1SxYfhOvmD7YY1Y5Qx69HB4pIV22uX
	 HAPW2nvsPmhC1311m6gdRazoQB5XhI7hC7Gq6rjjNydJg8hlh/IIZ3zYegqi7SXfrJ5Vr
	 BCF7+dxuL48LBXKC5gilBVKD+so3LYoG1KAGWvr2b01IjkgjlaB2eR3n/LKAQyewGaUzt
	 NlLFps8//aOg99cG1E/l7GRNssO/REQoP8TPZD3cEo3wZguO67qAk3FXiVta74x/EVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pw+deD1w;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915F3606A321
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 14:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 915F3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pw+deD1w
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b531cd9bbaso21376117b3.2
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 06:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443356; x=1796048156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wLD9EjNf9HjnVz/OoDjNZ+yXnVYBBOhi0ebsNrJJZZE=;
        b=Pw+deD1w2/8TemQyTP3Ee76uk1WvUxuI9yQATm24dLZZ6pFmMPDcoSHtZn9lEaqO6i
         1rwHIqqE4HcSCPNM7zke76bsZHpkCgJhfIApFMctgS8eKYYDn0DsYYyK7Lu4f9OjgnpI
         JBPVy/LsTJxPvqo/nFRiZ0JB0+HxAw6P2oCjwKuqx8vIJryxOTCO57b8l+/onl31uOgt
         aSGo1mBMEjdR5u+SrIF+RHl0gb1tyu/hXBbaq/qCwud8XTp6mM04D4uZdKXIVPt3HeiU
         +PprG+BwYlPxjZqpO6xaWxcqWcGxsy4FeuCnO97ZXaab1rqTwFfRmmJkmQkCmip0NYTN
         Q5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443356; x=1796048156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wLD9EjNf9HjnVz/OoDjNZ+yXnVYBBOhi0ebsNrJJZZE=;
        b=OIbWJUk+aQ0wEAFqnOaFB70XGnj5bMTrLtDm/A4OsvVNiGeihrkOUXwZopvuW3RcFo
         jPmErNF6iKiyiCrPYQc0z+AipLrCgo3MUR5w3rLMgIDJn5m2V1BIhnjodt0GR/OkCGO6
         EjGbIDP2p0XXMSyEVy/p2f5M3UwN/YxKpo5vN7TUCVyX71ywWw5yEAOugGOPKYaX215i
         y7I9tI7+xDAzt0Qa4CTYIzretwruhRqE7UCYR9NBWo68dtf57iBm5F6OSQ5V7d+WYlLQ
         tfctMP2LGl53CzOzqru20dJH5VxU9+d9jJ0QSv27nVtOLdDHUuWiaqaYBj/uNA3PZsT1
         63Vg==
X-Forwarded-Encrypted: i=1; AL+hErG/V2l8buTojDwTHYCmAZAfHCv4E3xV35M+Y/0HdZhhoXqLQEt8DAOX5FyCN1vq3yrHqe9c2RUfwJdZLw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+8134JPnK0qEKFKsNAK7TXQGgF34NJUNnJEdgn4QXGOUsDeVCp
	w1JfAPgB4A3slfAgWewPuutg158eET9HeRl9azfkf5sRzC3t1PtFIAaA
X-Gm-Gg: AZFdTZemfB6ngtmXzluZFTvC86Og30TKvucUuFsXsgukvfibANzkaeuxXuVpgoQGcVK
	OwSKjCibT/KDZ+SvebG1VC92pko4JRdQ69a7LdBbqSb01G/ndwsOb1IEq0/ZQJSLC5/mdJ3zxXB
	iqGZTNmNuS/pFRvlL/I9j3SMFxmPf7g7GPFeAVOuiWlvBL5u2/iIal8Es3MgZJiHrzHUxJjreM/
	xsMWCQkGn7ICMl58nEvTDuRhQ0OdrQG0K14prxBkNQN/hKXoyfhnBEuMi/GsX+6BNkHTgj4irIx
	1PEcNkQ+1d7xrDBcgPhpkl2nRWYJmC6LrTNEnMGiZL7Uv8xwMBEiREZcY4lftvTGKZALaSSImpB
	TMkMQcbrmq27s5f7cQ8ELa59763vYuPKZHBwJVGxLNwqx7YXjBWkcRLGhSWWX5Cbw7WHUyUBK5e
	9Hv9sp6GNzwgsI942YG+Brh/7Czf6v242Nx7ThmEXocDr4jNufmDcljsHJ+gnlA2XpYMO2YmC+R
	It+g7vBKsRiKaGY3IQ729puIVMgXWPMIDzqmQ/Re1kmlzFh/Atz1ix17GWxk8GEjOS7ah/aY/yW
	BgP7+eIfwGKLn61BLw==
X-Received: by 2002:a05:690c:9a82:b0:8b0:c71d:2b2b with SMTP id 00721157ae682-8b5205137b8mr51392227b3.45.1795443356556;
        Mon, 23 Nov 2026 06:15:56 -0800 (PST)
Received: from pc-i7 ([192.3.12.183])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202c089dsm45681087b3.22.2026.11.23.06.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:15:56 -0800 (PST)
From: Aaron Ma <mapengyu@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Nikolas Koesling <nikolas@koesling.info>,
	linux-input@vger.kernel.org
Subject: [PATCH 2/3] HID: pulsar: resume device for raw command execution
Date: Mon, 23 Nov 2026 22:15:41 +0800
Message-ID: <20261123141542.8128-2-mapengyu@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123141542.8128-1-mapengyu@gmail.com>
References: <20261123141542.8128-1-mapengyu@gmail.com>
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

usbhid drops its runtime PM reference after open, allowing the USB
device to autosuspend while idle. When suspended, hid_hw_raw_request()
fails with -EHOSTUNREACH (-113), causing battery status reads to fail.

Hold PM_HINT_FULLON across exec_cmd() so the device resumes and stays
active during command execution.

Fixes: e55cf379e822 ("HID: pulsar: add driver for Pulsar gaming mice")
Signed-off-by: Aaron Ma <mapengyu@gmail.com>
---
 drivers/hid/hid-pulsar.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-pulsar.c b/drivers/hid/hid-pulsar.c
index e726dffb2f33..299baf38a2ff 100644
--- a/drivers/hid/hid-pulsar.c
+++ b/drivers/hid/hid-pulsar.c
@@ -148,9 +148,13 @@ static int exec_cmd(struct pulsar_data *drvdata, const u8 *payload,
 
 	if (atomic_read(&drvdata->stopping)) {
 		ret = -ENODEV;
-		goto out;
+		goto out_unlock;
 	}
 
+	ret = hid_hw_power(hdev, PM_HINT_FULLON);
+	if (ret < 0)
+		goto out_unlock;
+
 	spin_lock_irqsave(&drvdata->raw_event_lock, flags);
 	reinit_completion(&drvdata->response_ready);
 	drvdata->pending_event = payload[1];
@@ -164,7 +168,7 @@ static int exec_cmd(struct pulsar_data *drvdata, const u8 *payload,
 		spin_unlock_irqrestore(&drvdata->raw_event_lock, flags);
 		hid_err(hdev, "failed to send command 0x%02x: %d\n",
 			payload[1], ret);
-		goto out;
+		goto out_power;
 	}
 
 	timeout = wait_for_completion_timeout(&drvdata->response_ready,
@@ -175,7 +179,7 @@ static int exec_cmd(struct pulsar_data *drvdata, const u8 *payload,
 		drvdata->pending_event = CMD_NONE;
 		spin_unlock_irqrestore(&drvdata->raw_event_lock, flags);
 		ret = -ETIMEDOUT;
-		goto out;
+		goto out_power;
 	}
 
 	spin_lock_irqsave(&drvdata->raw_event_lock, flags);
@@ -190,11 +194,13 @@ static int exec_cmd(struct pulsar_data *drvdata, const u8 *payload,
 			"invalid checksum in response: 0x%02x (expected 0x%02x)\n",
 			response[USB_PAYLOAD_LEN - 1], checksum);
 		ret = -EIO;
-		goto out;
+		goto out_power;
 	}
 
 	ret = 0;
-out:
+out_power:
+	hid_hw_power(hdev, PM_HINT_NORMAL);
+out_unlock:
 	mutex_unlock(&drvdata->lock_cmd);
 	return ret;
 }
-- 
2.55.0

