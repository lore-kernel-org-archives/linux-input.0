Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C24748B39B
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120425; cv=none; b=HW5y00pzjPk6fZgn6PYE2ty4WQXAcpdrhwMPkcahIAeKqXLwBkhfv8T9wUIepj2wJVenYkNc4gRPzI9O0QVygjla5fy2PRkeShh+VZj6Fq5n8qlNRAzidtTTmZhFlap1s/8IkAWpjiIIptwq6BEdbSB8xUHsymCJNRFL2ronMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120425; c=relaxed/simple;
	bh=MODmpC6MDclgoR4f64anBxcZ5VnnvWuNREypyTh4Svk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j8J0ZwKMfz3vXAB8LSSawtHDz8y6gYeHKkBYM32mg5PUuT6aRXsDHz0ZhwgSN2I9kD3avpUdBLbIrbzrxSkcL6kfRoO2Ea/0lu/H+LytbRX5QM0uIU9pgE6f/97gLq9ByzJUdNdF1QJZ3eKT+Vgy/IQnqG65PSDO6WCgbtwBK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=eZ4jlJVw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="eZ4jlJVw"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bce57c132b2so688885166b.0
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1779120410; x=1779725210; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cdfI3FSQ8qouwIK4zMFyf74YPISgTZP1ua2NsJ/Fjc=;
        b=eZ4jlJVw6LMaDRKaRiypS6ST255EWWej1YccrCzLM3potOfGoKpaZJNa8k5d0t+MiY
         23ROuoq1yKrzcByZcqvOf2i/RuZqSHP03NjXlUKDntlZoW0I9/AsE6w4GvIZaB1YQ845
         QW1tZ95fyLcOHB7MsAqAwRufkBPXjjWN+KUbVYaN3ABKOAawB7B3o6cHepZQVKQ3wYfC
         TtImh++adE73SJHmaTIaDFiqUaNgX7u8Qw4pq77X8awdT6ETS0qjLcL2d5feRQnwWq+y
         E75E57p+46/0/04rXQx5xiqeo8Ic5cyW727FqFoMF34c39+YMEUHMdnRwZGGQXVh+H6N
         rGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120410; x=1779725210;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1cdfI3FSQ8qouwIK4zMFyf74YPISgTZP1ua2NsJ/Fjc=;
        b=XiXIKedPZC+8cXQspPlLU851DyS5S6fudcPhCdim3RkMLxpO574/MKIcd80uRDoR9V
         rkzEVk68DE2BnrSF097wZprs89vkfLSCElBIkVvqzMChvOD6114MeCdi0wUd2zAmgHPH
         pQMCD1NY3iM7U0CejiAHY4nlR2Vk59x332qlrMBx4RJxFdz5841lnYlTj0KBkkRoo1qn
         K6PUfR8Mc8DJ/qjSeyVCvYSU3UjrQIaoXTi6+UUy5ovabDwLcx9sACCQQnQ70VC6wdOm
         VNR2XSao7pI+ngBssF5AuXvv9JkHckCcgxD7AYZ9zzX/AW77zdW0zFKOYLXWCK/YcNTu
         1F1A==
X-Forwarded-Encrypted: i=1; AFNElJ++gYwMRnz6UZbtXTYfAPfqwvKhXSRIGIKte9pBX8m/XayO/gmo1Rcqo2tge8xU1J1s5Cumew8mvm4/TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/1rl+YFg4M+zc9xEKSGO8UQnd3NyTAtn/ORJCorXcDujIm2cL
	2K6JNz/VLgUuYcSTEyttOfuJpItfeHzdlii2yR8PK/H6JxbBAhEWQexX0HyFk4L9tVg=
X-Gm-Gg: Acq92OELukO5oVhEvbD+yqsQhBdcHOSHjOK1d9LnJkc+BuhNk77D3nUgzkiTsg1gJEG
	rVPMeSgUtzsta58vdyb1pRDH5WWOgrxqfD1R/+BLKNcBDagHXO+WMd6gwIRDGnQxto2kQvWRGCD
	MnEqnV5pdHP8BjhaOSy8AEMG29hrfSyvIsJHNVD7HnV2NqjXREPXYzs66VRnGH6t9uPm1T9cHDQ
	jYrsQRJNYAOhL8bN7aSBIyN9QdE0HPuADal/Nupl600/AbunEQPTiRhYPr2pqDXA0Ri0M0VIaKY
	MkYZZrzQmm5vd2FiocK/8dPrQQpJO3MvzSAWCQuDlSbkYZ/+izMY8SLeMOcrjo6JRTz109xDA5i
	bdxinao6+J9+9gwSZb4QO20COky9wXc6vvAoqPrhfWKwH58MQEkLkb61retV8PWb14Q1B4U3yM5
	vESXCMhNRJuwXmb1ZLNTgs9Vj5u4QAfLIzYuLa8EbksDrqSZND6GuVYz/u1jJ0/g==
X-Received: by 2002:a17:907:3f1d:b0:bc1:7da0:21 with SMTP id a640c23a62f3a-bd4f34bd0e3mr887805766b.23.1779120409652;
        Mon, 18 May 2026 09:06:49 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:de11:5404:1c7b:7b76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm38867318f8f.28.2026.05.18.09.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:06:49 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 18 May 2026 17:06:28 +0100
Subject: [PATCH 09/11] HID: mod_devicetable: 'hid_device_id::driver_data'
 add union
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mod-devicetable-hid_device_id-v1-9-a08e3989c283@thegoodpenguin.co.uk>
References: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
In-Reply-To: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, 
 "Christian A. Ehrhardt" <lk@c--e.de>, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779120401; l=1264;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=MODmpC6MDclgoR4f64anBxcZ5VnnvWuNREypyTh4Svk=;
 b=pKDZ0ItP8V5W0KDl2VXaAomicXcLScd5Y+e8u+VsK+U24YkxEai5c30Diwo6xP/2y9lkQGhnh
 DkZs4XfnbumBkGhA1KCtdt9dSS74zupFZaA3ovr4bgYFxQtwjby+Uaq
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

The 'driver_data' field can either be interpreted as an unsigned
numerical number or as a pointer - this depends on the driver within
HID subsystem. Unionise this unsigned value with a 'const void*'
pointer. This change allows to remove explicit casts to pointers
in the pointer-users case and as far as integer-users of the field
are concerned nothing has really changed.

The change doesn't affect the size and layout of struct hid_device_id
which is part of the userspace ABI.

This change aims to improve type-safety, readability - as the
intent is more clear - and portability of the code in the long term.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 include/linux/mod_devicetable.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 23ff24080dfd..90b2dae75109 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -175,7 +175,10 @@ struct hid_device_id {
 	__u16 group;
 	__u32 vendor;
 	__u32 product;
-	kernel_ulong_t driver_data;
+	union {
+		kernel_ulong_t driver_data;
+		const void *driver_data_ptr;
+	};
 };
 
 /* s390 CCW devices */

-- 
2.43.0

