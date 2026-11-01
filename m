Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.0
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793517511;
	b=Ra8g88Jqicfxq9xb8YyZiuvdMMokybCmwMGmiWt5Am0xmGC7rIdLIIX1HO4noCSzIUdE
	 aoef3cG8krkbfGNcPqbK+LxWSuqpLymUv59jTwaA8/AWcsAGOIfHYMq0B6ORZ3jcMYuXF
	 WPstgP19NogGk+Rg5Uo9GoQ+2HBfFclCWZm0C88llEHGNrO32cZIQktmqF7lVwi5J4A+O
	 d2pDVNXfLQIFvZfwQn0jbSMGeWI1ujEWAqzYfb5yV+6pgozn0xY95k5J5v8/iCjbfLPul
	 fhyNHy+a+FXXW7oTwONrNYKGj6sxaCpCo1eotZ4VlMIJyFuTjbifRxg/FQSb1iil17A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793517511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hJ8t74G6PjkYvphhbVRv9I2mF9huPrhkTGoozlSoI/Q=;
	b=NtMAW+gTcPF3RwYB0Tb+U+0Rh9YjRZiWNfMJdRLwJdwXtGuwyxqgKokm2QVk56JmE86Z
	 +1VOauFjXQkNH4T71P0NBCl4mqL5hbCnLfyCdTTzJHHnvwySaPSGQ63tQ3GbkYUFPKI7i
	 QrLRF1l7UevYFYg1KiWXhqWHwrHKBZ3w4nzxXL+Pg1SwPmxYnccHu82ad1C8xRjogTvg2
	 uoij0ZEDGI0Adriry/pNPdBp/eblqORh9liAGuUMyRR7QwecROcHmW02Q9z2WVkvBoAXO
	 aZ61/+CRzmQ83dQ/YlSQS0tlCeRhmuLoVeNJfxhU8pKpwlvGfZjShZSNCFLg6OBnOjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Guq6jjwU;
	arc=none smtp.remote-ip=74.125.227.0
Received: from mail-vs2-f0.google.com (mail-vs2-f0.google.com [74.125.227.0])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4FE606A330
	for <linux-input@vger.kernel.org>; Sun,  1 Nov 2026 07:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C4FE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Guq6jjwU
Received: by mail-vs2-f0.google.com with SMTP id ada2fe7eead31-7565f2f85c5so560045137.0
        for <linux-input@vger.kernel.org>; Sun, 01 Nov 2026 00:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793517510; x=1794122310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJ8t74G6PjkYvphhbVRv9I2mF9huPrhkTGoozlSoI/Q=;
        b=Guq6jjwUTy97WcRmKyfssGanRmy4Cgzjxn8AeTeIadPIDswcDYhqdDuNAJak6mljDZ
         roQBz1Jhnznuy8rIPsUl0RRCepY0BBFWCY66ujBiuv5MixdqWeMbbqiDV4+1NG87a09n
         v+d1ScRAAH9q7XAAJoY2sLkkpO7Zaix2aJojcKe4oavI+mCAfopgwm/sFJZfb6Zhzp1O
         ypaPvC5pKP10DOraP4oqQw1i2eS/Ou2Ik7WQt5GiuD38lT5QFU8kvKJAJ/VKv+pKRZO7
         JfYBMcTt1O9KfPVvIvIynN/RWmndA2KRNL3N36Pnr87Spgutd7pSeuRGC2HSoYuRI2tK
         9dwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793517510; x=1794122310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hJ8t74G6PjkYvphhbVRv9I2mF9huPrhkTGoozlSoI/Q=;
        b=lXgjnF/BIzPLK6AMcwKQd/ROtqKJvqDTJHjF1k18OR1iwYaY02nEBXBc1OwRF6qg+7
         +i4qFvbwU1ro38nY++GlDwoH5jLcj/yWeeHKluv6rVUhW/B2d2mPftesHL7C+htkZJKp
         Zp7Xw54SbCI2aoe7xN14swJivndYgwE/SEY08EHdlY9r6nGbEHVqkznaWlbopa6nADC3
         SECCcLgSZZJBslNHK82J8yyXnnxxdHshBLUX9yNAFsvh0jxb+uEwCAfvb1QTsEqK0Rsz
         +C8IAjSsKqIFgjCNbH8UUjFZGL5jRxCVThbC0QHp1m8JoFfS8S6hSv8ial1oAlSCT/yF
         lHGg==
X-Gm-Message-State: AFq9FYKES+PmPc8typexjavh9360JgwnrR6Zqm6BRaD2VcygJ9JSC/yX
	By0brQBX+Xa1b0jpgcB/7s2Lop1T42cZdSXRPctWjlNXVa0ghu/6fFnB
X-Gm-Gg: AYBFou28QxqbIEBdOdBZtSIPkTWFLkbFqmNAVVhC1PIGwyIFR9ERIDzZHOqkT/Kyi7v
	nlPbVzP4sVT9EK21FYJiVlTEz3NqY/7Vgd6afAOrhmld0tP75g2ZYKp0n9hZu3Pj6GdKIma/QHF
	42JX4Ja0sZpb/YOVUXEYoeP6kgNq0nm1Lh2+MvPHQ21LeY6kZiPtnQdPCSM0oUKCilE1FZshWrv
	E97ekzgQfj8Px6gbVCVKBHLHhwmh/lA6kWUAlljxQC0hu41cXb1FwYl+ae3MkSMQyNDC2KPTcUf
	VgxTUgxJ8z6Amje5IHH1ZzNy2GMZUjK9jcQxXT9b2sSq83SCxo0iVgTEEMjwX4njwB2oNhEg6WS
	9nAOsUorGXRP4gPhW7lyCuuUIUS8hPm00GahZcrFVizQfEA0AdbH74r+o0JioWMaMmy7dFYu/N5
	8xUw2acwZYg+j0LbRwh0TicBafd3z6sTRUmZZSTMVoZ3AOgamtgh8U8HWjKvBfj6F3DAy0cZKgI
	XCPNAe6aBo4cRiFfo8AvbhgOUcJH5b0FuwFb39ohi5u5/rr1MXx5Pdh9nYURL2lK4VpwHLk6D0L
	ldmY2kzc9q/2qppISh32rw8XIDIAAcGXXhuJQPWjHULfabCP5gli1Z0cwAkJ
X-Received: by 2002:a05:6122:1d46:b0:5bd:aba5:3830 with SMTP id 71dfb90a1353d-5ec68295940mr3359656e0c.0.1793517509948;
        Sun, 01 Nov 2026 00:18:29 -0700 (PDT)
Received: from linuxmint.. ([2802:8010:9a2b:a201:7173:4fe:efa8:f823])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69caeccdsm7408536e0c.16.2026.11.01.00.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 00:18:29 -0700 (PDT)
From: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
Subject: [PATCH v3] HID: wacom: replace sprintf calls with safer alternatives in wacom_sys.c
Date: Sun,  1 Nov 2026 04:18:17 -0300
Message-ID: <20261101071818.529598-1-nehuenlian.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101054830.291749-1-nehuenlian.kernel@gmail.com>
References: <20261101054830.291749-1-nehuenlian.kernel@gmail.com>
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

 Replace sprintf() calls with sysfs_emit() and snprintf() calls in
 wacom_sys.c, which are safer and avoid buffer overflows.
 Also include the header '<linux/sysfs.h>'

Signed-off-by: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
---
Changes in v2:
- Use snprintf() instead of sysfs_emit() in __wacom_initialize_battery()
  as suggested by Sashiko bot.

Changes in v3:
- Pass sizeof(battery->bat_name) to snprintf() as suggested by
  Sashiko bot.
 drivers/hid/wacom_sys.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 628372ab818a..7d9bbcb13ae0 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -6,6 +6,7 @@
 #include "wacom_wac.h"
 #include "wacom.h"
 #include <linux/input/mt.h>
+#include <linux/sysfs.h>
 
 #define WAC_MSG_RETRIES		5
 #define WAC_CMD_RETRIES		10
@@ -1838,7 +1839,7 @@ static int __wacom_initialize_battery(struct wacom *wacom,
 	bat_desc->properties = wacom_battery_props;
 	bat_desc->num_properties = ARRAY_SIZE(wacom_battery_props);
 	bat_desc->get_property = wacom_battery_get_property;
-	sprintf(battery->bat_name, "wacom_battery_%ld", n);
+	snprintf(battery->bat_name, sizeof(battery->bat_name), "wacom_battery_%ld", n);
 	bat_desc->name = battery->bat_name;
 	bat_desc->type = POWER_SUPPLY_TYPE_BATTERY;
 	bat_desc->use_for_apm = 0;
@@ -1928,7 +1929,7 @@ static ssize_t wacom_show_remote_mode(struct kobject *kobj,
 	u8 mode;
 
 	mode = wacom->led.groups[index].select;
-	return sprintf(buf, "%d\n", mode < 3 ? mode : -1);
+	return sysfs_emit(buf, "%d\n", mode < 3 ? mode : -1);
 }
 
 #define DEVICE_EKR_ATTR_GROUP(SET_ID)					\
-- 
2.43.0

