Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793512121;
	b=00V+5J5D79hDNAxpX7UYAJ4kmTDSoabVhD5ghD6BinvYCUyAJwxg+i8jqRzcgSpwgclE
	 F64hvpDUksn4iNku9C1gNw4oP7NDj5EIf+UBc6Umw/28RuYGkMvNUYpabnm0mjVt1NJnM
	 uj3+FFJ1WLGLM93oCjYoo06AeB00Cs4dUf1S8FF8LWR6Gtk9IUjz4XyGhdkzU5modWHQy
	 Hc5iKLKpII1iU5y/dhUhKH8vvPFBrjFfeK/g5UbJk/nEc599Vp0/jT0+uBtuvdk80sSM7
	 Mmr7mnSbHjW/pew/chdJF4Rn5Onm5blujigmDuH4UjKP6/YILBsJ5d9cRxOdQzSEPMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793512121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BQb0A5w/TIxC6lzjJIWIQRoZPxtk3+ao0g+gODR3ezM=;
	b=rLPj8ZNekqK+jFxoqUIZitME9OlvYnwN+wI0lo9v4a/9iH9bVBVn5nckva+w7R4tFyfB
	 QX6MbQaOodV7XxN90VeTOhvLdOB8HIOE5vcsOLbXfHk4lU0LhQFNpG0JtfY+yQFHYqe9R
	 YVygzOkPL7HIw9qNFJjisL1BksgSiOmW0TggthT1zTBssHHAjvGPWgn6UfRn+CqvfJJ7V
	 kcVRdH7lZXj/wtltUtNCMVJeBSJY/3KufqAvtnsp3Lsj/CoZJvoCxehlE+zGIhf5LoNWT
	 xjQT8mW5MQFntL2Aq7aCP/6cLn9lGzCSOHZGC7XMai0WcPU9fF2fCHuLGL8Yk4TFLiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZOl9pIRg;
	arc=none smtp.remote-ip=74.125.227.8
Received: from mail-vs2-f8.google.com (mail-vs2-f8.google.com [74.125.227.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A203606A325
	for <linux-input@vger.kernel.org>; Sun,  1 Nov 2026 05:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A203606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZOl9pIRg
Received: by mail-vs2-f8.google.com with SMTP id ada2fe7eead31-7baf9629253so704459137.1
        for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 22:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793512119; x=1794116919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BQb0A5w/TIxC6lzjJIWIQRoZPxtk3+ao0g+gODR3ezM=;
        b=ZOl9pIRgZ2gEt1igLhIQtZ+2nDEKeKhEjIQQOmGCNyeQa5gB+pzfXlpYmlS2L4OhsX
         DnZtYAcxB/UMQt0p5n/zXDqgVZ89TrGN+xIBnz4cjPH7zMzf4H9rSeYhttSF1Lcidryx
         eAtSNDOglJXpE3dv2TisasVYYW7zVpEQVEaxe2B/WtfaiYtDIIBzExEx8p/sRIGdxFaa
         H4fGGg/auZNOXMD39WOYNJH0QptTMB6pwR75+vhc/PPg9N3ztgFOH8TT3YovHyTefrXD
         Y3O2kV8Fv0Gomyej0dsnY0tDGeq6BHwgDDYmJeiXDZj0FySxzZ84OXVaBiMoBXEj7b2N
         TICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793512119; x=1794116919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BQb0A5w/TIxC6lzjJIWIQRoZPxtk3+ao0g+gODR3ezM=;
        b=SMwyNwZ0rS0QJ/5/7pY6ASyEyOX1On45oYS/i1zHiUjfuvr7NeLcy3L6tXr/BwmzGB
         +dAu6yOB/UJ0VY4hzF9AiFd6nx2FcwmQkhoSVMN0KgsVlUCI3MBHkTqFqYYRRLjL4FHk
         xESJNc6JKciH7sPK53o1Z2CjrYD3SWMgbHj6aQKXpV5qQA7TixXkUC1GWwp5nfLzmAuA
         3AzziyezaVvYBQWqQxU87tj6mnmKJ/43Xk/15galLoFNdMtegIRAssqp/moMIAl/DrRe
         79qwMxLyseqoJO3HnpT0pouQuC/CiO/NV5CNphlAueyfhmqzsdqaRZrUrEJF+FwiuisU
         V3ng==
X-Gm-Message-State: AFq9FYKF4RrXp0pF9wwQBpkuKd1jRkzVcsb5PNPNyi37gvLa5SXHy++p
	2yern8xBixg4JCvHy6ybjv/wfOID9Au3iabryprFLtYQT3e3wvayMsr2
X-Gm-Gg: AYBFou3yDCXS4GfOg8UgFwlQtVuszsBT+54VPtCcDHXio3GcDpyw3tcp9lhhxzePjcB
	P4e2obDf2hF+H4PUxErPBT3m1MZ9PzCf0bzoHdyciHyhOLrSCx0NvOXUg85UJGGIrP9LvnZ6ifK
	uA3G0lrs9azIn+Z0gevvAmC4MKhLmJu3CbPj/twKTROMX0HayzLzrJXNveqnC8mWxj/S8sUEBAg
	wgB40dvIcuQ0Ksj901kFxHtX2w2DcASO/68QQpGXDbCODe8uQ+VnZfCn4baIViXXpsyfPDc7PRd
	0IPGr7wKS5YNECyv5jrdOrf+KiDEhGMYhc0QZ1XiwCbzAliLFeM8AbgYrsp4cLjY/dn5GOLikfE
	cdwiHCdOa9dUfao7L0SbzJ+cPt7QfxLr7bZItSuLzvGHjpwvp/QJZvBONewqXFoAw+3tZ8znihO
	5RF97j/uUE8MFxIv36yNPJE/YVZpj4yB2rprShkgtpI/8Ev3BLaf/HypVELDHXy204MaqhomN/l
	ssdL/Wt+xMc1ah4zedf9kyIUzglLVvdpnk4su6xNCttxWtPLCKMvLn7JpXyY32L3FE8GE/cr1+4
	xLoHpnr2a+3/MGdlbRKqQeBor7ElZ1EEaqVj3ZA=
X-Received: by 2002:a05:6102:5712:b0:7c3:881f:b620 with SMTP id ada2fe7eead31-7d072c56c97mr2848817137.21.1793512119388;
        Sat, 31 Oct 2026 22:48:39 -0700 (PDT)
Received: from linuxmint.. ([2802:8010:9a2b:a201:7173:4fe:efa8:f823])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee41f108sm8591353241.7.2026.10.31.22.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 22:48:38 -0700 (PDT)
From: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
Subject: [PATCH v2] HID: wacom: replace sprintf calls with safer alternatives
Date: Sun,  1 Nov 2026 02:48:30 -0300
Message-ID: <20261101054830.291749-1-nehuenlian.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101011439.261812-1-nehuenlian.kernel@gmail.com>
References: <20261101011439.261812-1-nehuenlian.kernel@gmail.com>
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
 drivers/hid/wacom_sys.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 628372ab818a..bb5bb9c15f93 100644
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
+	snprintf(battery->bat_name, "wacom_battery_%ld", n);
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

