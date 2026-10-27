Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060963;
	b=T9w4Ek/Wgzo6w6F2nifVV2qWOmHFOOlgwk0cWEH8sS07wWqHUmGkn2IfuzRDqu+qadjZ
	 6GzzBId+vrCX1QTvgmP2m2oLyVlVUT+l89+E+tVtIK3Lklzc9fcDthqSOhkiVGXVTLHaB
	 GyLJOtYulel2j5JVMQ5dw94eWOxfjn/984icKI5oqD6vS+s129+/MxcO6I6N+ipVy3ig8
	 eNdnWLAb1dWchViX6fzcf4aYe0G57NB+7apVddcwJ9QH/YZC5ijQLEzdIcNUnA1e8N+AO
	 YYA3FKzeNbqgIk0N94GUbwzsFGETiKpie6FIzQtl0uhtudVYHH+jqMaXXkfh9TIZDjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oxACkjXTSKzxgM0GX6iNXbhJe3SlZ06HmpJL0C117t0=;
	b=kHNs/NF36AYkPm4XC6Twm5LBqwA7OV38rwku5Thje5FohXPKJTMr8qvEGVMpGr6kd/lQ
	 QdfJ3C3NpBD2rCulQpNfGETpRToJMRp7Nch6hWpYpymsfK7p7C0TKf/X8MkfsdWMWNqWT
	 KId8FgLIXLr023B4C91wH+qh1ITX+2e74nAX9585III3UPIGpxeT6iI2GOaK0kgmst+GT
	 i+P0scC3nEG78YlrdaRHKqVFmMLmXvX2WUlkSum/78nnPsjIsTXvgpOu7RtCZ7Fwn7nPB
	 ESyDFnI4TSuboQ9dRl7YQW52XsUTxR1JIuBp1YHT7q/8T9B1s2lkGU9xSuiWyI8Exwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jTETyL7V;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EDE606A31D
	for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 00:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0EDE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jTETyL7V
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so24373165e9.2
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 17:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793060961; x=1793665761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oxACkjXTSKzxgM0GX6iNXbhJe3SlZ06HmpJL0C117t0=;
        b=jTETyL7VabdKXBRrEOFKN/ABp39W/K4e3YSrvrX9Y98eVsLdhDCj6It754zG1fRdF0
         lN0YNCGtXd7I3CQF7Z/Ugf3OGrmSMBhBVnZn5+51Lo9NiXlM6nIq2+e2JVSm2thzsF7n
         Uk7VOumLDxDYHnRdsuIjGTpCR3yRnhlMjndJUa0gRe6KaIZko28EeWLYWhFd30hwNsZe
         VDlCXhrIbzESnd+u4atAWQQc0K5CIfCAWOc4dTF4U0suvdJPnoceQlddPwpC8i5xiaTy
         4sEUuL4crUFjqpzu5GQSkdJLaxJMfRsmCLuyoailhFwkwEZhZHGqsmJaSLmO8iy6a1LI
         DdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793060961; x=1793665761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oxACkjXTSKzxgM0GX6iNXbhJe3SlZ06HmpJL0C117t0=;
        b=hAnlbhAW81CqUfTJAzg0/xSVyqM2pZXw2Iq2dlqjuqQrk839XhfhKqaivYPzvIQH4X
         7lDXZVFdt/fp3yjJR4hgx+NOWouihwr6X45RS6nYks/Nn8k8KkIuzc/uR3m1rIyByztz
         bBiUMM1csLbzbAmmsDfkHEuh3mMM9YW6Cr97uEP0nRD3SyfVhXDxIP+ZfVK5ksaBU5en
         cIzuYQKi1z0VbW4DXNclTy2zzoPT0zCme2fuf9gTIYTn0oC/+oZvDBZYNuc28qLKTm40
         UU0MrXpVM0M/OMBgeVsWtqeowQSRGxpGycTwKZw/tO/hwsIoZXxT0bEc/nXg0HOS9avM
         0cKw==
X-Gm-Message-State: AFq9FYJo5TRn/klUUgBCTB8aJUpY+6QW6frRYu0dROCDH3GYZWFSpaoF
	vswaqNJhEfZnNq2E5EJu0hYbFUgSt0RRvuZEG5VJu0b8v4D1kjwFsrk=
X-Gm-Gg: AYBFou2JQyYXoyPz/0d5RYLksahJZlm7JnARyHksKaJUtPbtBSG0bS1Pj++xMmkVsoc
	y963uUlxUK0qJtj306VlN9E8J/9gK7bSUndkjtYnKqLf+ioilv38FkDc+0sy+zKpilLsLl7WTTo
	T4zQiZaqXc19dU+QODM32GPhjedavI8v9q0T7aLAQrvIoX9kMznLOo1O8iNdM49fW9+NF8ccz9x
	XgQTkxgS8Zw7JgN05WqKkvzwsTXNq5stcwSUhLlqp3KSZIxurRvlHPPVD+bGFcR6l8PHOWJtbZD
	OwdZlPGVQB5lckVn8kvLH1e+iHAwEuGXCbKCFV2u05D5Xn8T8IvMYy07h7GXQGBVf3TrQnqTalJ
	XZUQ0ql2YPgsZ85gOA2q4od3hOIECYW1ygefR/SPePhy5zQG7s37mtJeffH3pJHFMsBbunS5g1R
	n/t00ANzThJs3/f+Z1ZEZlNVMbwQrYYC5GwEVxrUr4lG4+TZy0wD8MgEmpMNx6RSBwBrYS5msM5
	4c/a2kCQJSbdK7s7Xd7DOObbdnUu2//22X6uA==
X-Received: by 2002:a05:600c:8488:b0:4a1:e0d5:293e with SMTP id 5b1f17b1804b1-4a35aca1366mr145088605e9.21.1793060961143;
        Mon, 26 Oct 2026 17:29:21 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a5ea0df763sm142804565e9.3.2026.10.26.17.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 17:29:20 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH] Input: applespi - validate ACPI property buffer length
Date: Tue, 27 Oct 2026 00:29:19 +0000
Message-ID: <20261027002919.3589149-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
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

applespi_get_spi_settings() reads three ACPI _DSD properties
(spiCSDelay, resetA2RUsec, resetRecUsec) as u64 values from their
buffer pointers without verifying that the buffer is at least 8
bytes long.  If a firmware implementation provides a shorter buffer,
the u64 dereference reads beyond the allocated object.

Add buffer length checks before each u64 dereference.

Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/input/keyboard/applespi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index b5ff71cd5a701..25910786a6c45 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -642,19 +642,22 @@ static int applespi_get_spi_settings(struct applespi_data *applespi)
 	const union acpi_object *o;
 	struct spi_settings *settings = &applespi->spi_settings;
 
-	if (!acpi_dev_get_property(adev, "spiCSDelay", ACPI_TYPE_BUFFER, &o))
+	if (!acpi_dev_get_property(adev, "spiCSDelay", ACPI_TYPE_BUFFER, &o) &&
+	    o->buffer.length >= sizeof(u64))
 		settings->spi_cs_delay = *(u64 *)o->buffer.pointer;
 	else
 		dev_warn(&applespi->spi->dev,
 			 "Property spiCSDelay not found\n");
 
-	if (!acpi_dev_get_property(adev, "resetA2RUsec", ACPI_TYPE_BUFFER, &o))
+	if (!acpi_dev_get_property(adev, "resetA2RUsec", ACPI_TYPE_BUFFER, &o) &&
+	    o->buffer.length >= sizeof(u64))
 		settings->reset_a2r_usec = *(u64 *)o->buffer.pointer;
 	else
 		dev_warn(&applespi->spi->dev,
 			 "Property resetA2RUsec not found\n");
 
-	if (!acpi_dev_get_property(adev, "resetRecUsec", ACPI_TYPE_BUFFER, &o))
+	if (!acpi_dev_get_property(adev, "resetRecUsec", ACPI_TYPE_BUFFER, &o) &&
+	    o->buffer.length >= sizeof(u64))
 		settings->reset_rec_usec = *(u64 *)o->buffer.pointer;
 	else
 		dev_warn(&applespi->spi->dev,
-- 
2.47.3

