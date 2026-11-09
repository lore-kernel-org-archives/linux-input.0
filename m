Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204675;
	b=W0UL4tdZrZhBVyesJvgDFN76Ga0u9mwc6T780vXCyoFRBTRhLoGrKM+6MXOqedeordP6
	 JvZMxABheFvCjdeklCGCO6w2d5g7miwWE3FJgXGeYrVvgJVOaMjLNZ/ZbJLKx2OD1HLSV
	 Q5p6XnusHOTG2d9VpTCqvplvO9n87aUJySrQATRX3um16DIjckVVSCh74moLg2aCtA0kI
	 KS9LQWQYAnMx8/v1tu4vHyIrOAWKFiEZgLab+6MIyvrZrw1xeBLbLv5rVUCfWM42NQqGA
	 ow1SvZbO0pSDfo07U6XLnpLS4ntU4LiwU6Zaosin4EO+Z8MQKkPG8CdVKGMYZe7Ba1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gHzyFwE4kZmoIyCMCuEGRvLMldGFpGCRJxETSq1bEAc=;
	b=vB0WDf0u23TvWosVlgyWVvEtj+H36uPw6PFrmuGowu3BCjcbRyFeIt/IbkkPBKKr46Tq
	 F5t3DL++ec9Bva4IJFZHX60M+bMyEOuq/ys18i8d9HnsspjWj1TOr6N0aS41PoVSO37z3
	 MhyEUenQpxhErb+XWMUXCqiqnbwxwAQ1XxAMVAXFg2l5SmTkPGWpx+lp+eGDpMsRD7j+E
	 V16C7m+1N/I2DQG9fU4DtPOX8jEWJUgMfxyBdR95K5JnPjcdo5ZA6oXsmjtQAjCrMP9tr
	 K5tzC18iWapSpgXgnDLW9WmD9tdkZQEMV6EkEn+4Pxcg0A37pwobf03TFaVpbT5gUmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="QzGJvgB/";
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98164606A336
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98164606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QzGJvgB/
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso780791eec.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204674; x=1794809474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gHzyFwE4kZmoIyCMCuEGRvLMldGFpGCRJxETSq1bEAc=;
        b=QzGJvgB/Ha/ubu4EeNf7m+HsnOI0YYdWo0CGi2KAtFmjebJ/JSQV8O0Czo47GbFR94
         UCLgcXOHtgNdPZ3ZDAMNVLQhMf3DbFCy8sC4cB04Z4vda25/yUwx4rvBLPlw57oVyLIX
         zZUACtRLgEXv6WMxsVjdol2ou67ROg2qfna6SidNhHKaQSwIN/FMV/VqBcechWHf0JWj
         ZF141THChrSnWiBqaSig4WugfTksD+QaNgU7/SH5qXhuKG5++6vwC1/NI6o+EBmOV367
         EKf5W2HKFAaJYZqRLIYp90e18woIYsCyN3LnRrsmNKpIngX49JMrgkayGcOjlkneirBo
         ubVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204674; x=1794809474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gHzyFwE4kZmoIyCMCuEGRvLMldGFpGCRJxETSq1bEAc=;
        b=JfG/aA6m6Ogmrsd4f8BBFrXlL2rGe/sqWHfucwPIB6ydiUXtTsPIGGK5a1DNPQV2UE
         LXmqFcBhBHpNlc5RpnUK4TnYnT8OWgf34xZUTHn9kW87Q6hWH+iLumWGZ0r+Fk0WCAt4
         817BXJfMchroSyQ3C9eYiEuj67+uECumLihapBIismthRNPkPrgRaEDM4T5d94RCfL5j
         QBMLxRP8nSE1iSrWlbgPZmPw1TtbkKgTPgZm5cQqbUH1/yp6kihPlH1M+p0KeYwov+kd
         LW8TQOcQ/kj26A0Cu9lHz2tvew+183JQm3JL1x3gytiJ08ULMSMfZg+ycvw94uwRUr0w
         Ip3Q==
X-Forwarded-Encrypted: i=1; AL+hErGBL/FuIOQ4sLuOXcDHEbQe+N/zhLfMHlDph/p1apV6lLzNnZA62giJNHucqxHRdh+ppxuemm5KE5VNyw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/QQDchEw5HP7lg7NMhyp4fSf2gD05tGlt7m1UuHjVKdGuVJqip
	1t22j9tlvLQ2YjwU4TttpMvSET4zKCQaT2kHd5Jo/XobQ6gmtt9cr67IoSlpCg==
X-Gm-Gg: AYBFou1rK+9PI3UeBbsnniASMrBaM1gw+rizBlnLy9Ay9WTXeaZdHY7dwGqoTttX5cl
	bQsheA+6xTuKqXbr/OvxZ/iPWntKpaF5/vMoRnEZcxMTWWUrFEv1IwPm30kHd4Gnnh0UJPPgZAk
	7dseK5eR3IAhTe1NuuDFzF8sh2Y/8YA5ZmebaWsZ5C51zS3VKUy1/mp0mJ7nhNzCJlT8RudvYip
	DMUMU6EcDvpQOiczZTJXB2fg2tPzcemzUbbYtSmF+M6qavIeQfM+mxnZR/W1TQ/XhRXsVd1djFV
	py89NmGqK8Hs3iM1GIe9NhkWa3rSBAhcdEwz0zrv4i4Dpcl8DoPlA0PVqW/VkuzA6/gldf96aGB
	4+4yLUXDD0qqKJj5R4DNPcQe9TqszicuJXxi6XMUgTblhdvmLcWZf2c8yxjXPB3czh7wZsOSmLh
	HbLSy4gqeZeudg7TVELbCHcrgmsR06y4yf7b9+M5nO7tg72lVYIURPup/Q//kS8PbVWfPqyt7S6
	lE7DR+wwy85CF//4yLZBPfAYNPEv95t+VHUbYVMT9Jd8CoyhCGBmC2HaGrWDEJRNHMcHIItJ6Br
	FIXVhomTy9P8yZi922tBpM9ru70ABtRrlmz8Yd1gi4Mx29pjhwluFG8Tv4H+vjQr6XnIsF2IQ50
	tjLYyjDVJzcDj3m4oqK/h/DWdSGpy9G/HPR5AdA==
X-Received: by 2002:a05:693c:8382:20b0:35c:8b96:94d9 with SMTP id 5a478bee46e88-3725546fbfamr6786230eec.19.1794204673770;
        Sun, 08 Nov 2026 22:11:13 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:13 -0800 (PST)
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
Subject: [PATCH 04/18] HID: logitech-hidpp: disable works before stopping transport
Date: Sun,  8 Nov 2026 22:10:48 -0800
Message-ID: <20261109061103.2887636-5-dmitry.torokhov@gmail.com>
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

Device removal cancels the connect-event and hi-res-reset work items
after stopping the HID transport, leaving in-flight handlers able to
issue HID++ transfers or register power-supply and input devices during
teardown. The connect failure unwind path in probe likewise cancels work
after closing and stopping the transport and omits the hi-res-reset
work item even though incoming packets are already enabled before
connection setup.

Disable both work items synchronously before closing or stopping the HID
transport on device removal and on the probe post-I/O failure path, and
drop the unreachable cancellation from the early transport start failure
path.

Fixes: ed80cc4667ac ("HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 476c0f0eb086..4e0758cdae64 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4799,12 +4799,13 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return ret;
 
 hid_hw_init_fail:
+	disable_work_sync(&hidpp->work);
+	disable_work_sync(&hidpp->reset_hi_res_work);
 	hid_hw_close(hdev);
 hid_hw_open_fail:
 	hid_hw_stop(hdev);
 hid_hw_start_fail:
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
-	cancel_work_sync(&hidpp->work);
 	mutex_destroy(&hidpp->send_mutex);
 	return ret;
 }
@@ -4818,9 +4819,10 @@ static void hidpp_remove(struct hid_device *hdev)
 
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 
+	disable_work_sync(&hidpp->work);
+	disable_work_sync(&hidpp->reset_hi_res_work);
+
 	hid_hw_stop(hdev);
-	cancel_work_sync(&hidpp->work);
-	cancel_work_sync(&hidpp->reset_hi_res_work);
 	mutex_destroy(&hidpp->send_mutex);
 }
 
-- 
2.56.0.506.g506a7eabc5-goog

