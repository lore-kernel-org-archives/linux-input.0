Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793495690;
	b=bpei1d4dXfJSwuKP+eddWQwwo1e6MSmfISqIcwRTgmR7WjPWXutIAWmE26KJZyXAL+tp
	 EItEEIH1L2TcGxq5H5sTusYHJIxIZ4aytd4G9bNJgWJeIwEIqg37t6xdlcnhSsHDzSCvr
	 MsoOEbwd1fbsaSNwmoF7PL7yZZqSDzGow44lxPxwhs1p5aGux+ncBfsDVOYrvHaytKnIs
	 wuFF/yPFrmTZlyJY6Yo1syTs3mkyI2i0evOkwaWHQrN1YLFkELAcaQe5G/j2z3DY/+Keo
	 HuWsSGeLp7ZpiIdrSE9S/Z3b6DKrnLFZIreJv0QK1aoXGMH7v2FlMQzLnpf2q7EOyoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793495690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wGXYQaxTBIJGlm9+hLcQgGKVY+JNn5AF36EC8fQCfG8=;
	b=S+7foy1SeZgsOb89e+LkMmaYX3dQzyhzElx3CywtAV5zcxL+Efr8fgN2BwwrWYGpuP8o
	 UBKt7krS5D+LhO/d8gprKdvFBc3ncZ1vIue8fEiVIV6PhjPZvs/T3frSwP4wf5SjMbHj8
	 1IXGc9iQki/bp1YqtnLcgUVyn5orbU/5b5n7wkSwOMlhw7YtnbiZXzmcbikWUc5IrUHp/
	 lJChKJN6OEgUzhCmr8uSvKVb1Hk96mNeuH0FCGIP7PEwlRuhmjkSypVgPujfGOPbb9Y0r
	 la9Psm5aIL4TIQw2I9ZpI2Xv0TmKnlIRYn2dXwRORwBttEUkJOTwk6PjmWZumAH2spQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QKPpFN3Y;
	arc=none smtp.remote-ip=74.125.227.3
Received: from mail-vs2-f3.google.com (mail-vs2-f3.google.com [74.125.227.3])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC4606A31C
	for <linux-input@vger.kernel.org>; Sun,  1 Nov 2026 01:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8FC4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QKPpFN3Y
Received: by mail-vs2-f3.google.com with SMTP id ada2fe7eead31-7bb53a92ae4so292315137.0
        for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 18:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793495688; x=1794100488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wGXYQaxTBIJGlm9+hLcQgGKVY+JNn5AF36EC8fQCfG8=;
        b=QKPpFN3Y+AhEglAUz9IZ8qnqEpUE15Tm3mKculKM+LuNYTate02/Hz3MimTtDkSd4F
         bQMqUhVsx6YrKSzbD9yyybdjk+FETcusYv4xI4szV0yQbV4REVpLXILxY00EuA70+PwJ
         47Ivp2TwxkVeOnK9w7Tqti46/3+4EOHMj5CBVX7G3hErP8BnLBImewlfm3GnIh3u9PxL
         /BATcxnlxvW+F0LG9rpEWExF82XUuAHI/HMrIozGEz7LxKzBewzSAG4D/HUvV7OWxZCm
         501xz6/xstu/KyYYu22x7QjYE3Dzd/yHT1hQ1fORFYc5L5aVx86PRuqaPeC9GZmijjak
         gAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793495688; x=1794100488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wGXYQaxTBIJGlm9+hLcQgGKVY+JNn5AF36EC8fQCfG8=;
        b=Bqx3ubKV/f32AxpVemQ9KwA16hGyMrGzg4+1RO8xzijT59tktlbmdF02wF5VKIQcOi
         9WkCKk1f7eyEhRA3M7MObSpVjlGz2tgxujGQcExCAGr0/j2okUZg8YNuO530zmj/+AFz
         bWrUDs5M0Awq+92xgu5UHYDwbUJJUdjqDAmW4ehmnB6XsR4Fjok7zKBgqMqfe/nPRn58
         CslvGucuSuvpII0iCYDI0/ziiI2C5eeQUresQvZu9IqBZ3L7x+f6MSELKK7mcQbuIKuC
         ZkWIvcVFCjrOj7/jM4pHnM6krnr2XgaimzjaIFncrRStDhW6DRSsOaNbQHxXH/mofSZL
         hOLA==
X-Gm-Message-State: AFq9FYJS9V4k+EuqycbUtuQh/TYzEW/ksojivelOMlQtIgQOOyq4fpZg
	ohKe6zvqYp/fqBI27PRPzz2bjgNdt2LVyxnoCzTzO/YVko1wqqESahIk
X-Gm-Gg: AYBFou3uB6CpiGAbwwHFIKldzQZW0r6KNVkcByKfTn+yyEFRlqnaKecFULPCHe8wf4e
	uj0qNPoAQCFu/3s3+MVTHKbmkJWMsyvhAsDwdzQRNGLBzYeHLAyraJx7SvgH7mRFUbtDarFvKep
	DxN5MdMyX6AIDATjkfHMFiPdEVE4C11L0aw/vimeFeI/X/IRH1CEejg7WjilAOV9wkq3G5ic8Mx
	tsqqb4qympAtbvm90kH2kT6o3Xz8mFFwveWvs4Hyr2ntABo32NwVFzvUIQOMcb4qIHETsjTfN1m
	FTGOn5Q3/nBtqWudrGAgy1uwMopzLY9Q0fgYF8Bbv4VJSAD6ThPEJfrqgy0c9LGa9P6J/cGd10J
	jXmYA2wiEtJLYa2QyfKnZDR9TqfWJy1/tboLHeqgx858sSW2X3OqqXB0h3zP33w+wwlVwq1E3Xh
	mPWe3xXhd0ZKHIJCxrcTYnhjrDQ1Dfxs5ZQiEntQp3Vpggc4JBMft32NL86iKLZKYy5yoenphtB
	Gc14z3ZahdHklrR8WN3I27nmoUVd01+gvzcx5wU/3RV+hyl6YrawfELyZfiG3WMUcKAnYSbLFKb
	iFMedDtWn9WhLoXL6WG83d3cRSL5/NfIm8pb1BAd
X-Received: by 2002:a05:6102:50a5:b0:7bb:64cc:1362 with SMTP id ada2fe7eead31-7d072c2b96amr1629507137.6.1793495688605;
        Sat, 31 Oct 2026 18:14:48 -0700 (PDT)
Received: from linuxmint.. ([2802:8010:9a2b:a201:7173:4fe:efa8:f823])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d07738ebf2sm6893584137.1.2026.10.31.18.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 18:14:47 -0700 (PDT)
From: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
Subject: [PATCH] HID: wacom: replace sprintf calls with sysfs_emit calls in wacom_sys.c
Date: Sat, 31 Oct 2026 22:14:39 -0300
Message-ID: <20261101011439.261812-1-nehuenlian.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Replace 'sprintf' calls with safer 'sysfs_emit' calls in wacom_sys.c, also
include the header '<linux/sysfs.h>'. No functional changes.

Signed-off-by: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
---
 drivers/hid/wacom_sys.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 628372ab818a..bb51ea4b34f8 100644
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
+	sysfs_emit(battery->bat_name, "wacom_battery_%ld", n);
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

