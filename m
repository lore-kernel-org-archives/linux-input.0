Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529617;
	b=CNurQjU3ru3tn12C60+sWDZgZkaTEioFtsh7q7BaAYfuKSsOVkUDx50p8eTNK5l3sujg
	 QuRV7yNq1HkFRvDDVxrCl+6HPbKk1CsDI9N4WE5NS05MuoAIR8eFd2o8l42cE4UuC34ji
	 NaRzakdiXI26jeBEC4MZKddBNSgmZJ7NPHMaz2OXJRlbboFUGpVSyWm4vQPIVBTzCi5d+
	 5hGUMo52MBcpB14jF734hqBeICkdBEOZr/wjR979kdKraYt+yCQe1ew5bkMMtBBybmR9T
	 XGOVfnL3jJqjC5HJ4+x6eM4SGeOzXBtz63yjr+JZIPJE2OTxq6QDLpQ9WPp+2rSL7Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2bPFYZxerW65pYcm0C73RGOg35tpYhA92PuOUtYcAU0=;
	b=2FMi3b63yC782DI1lXLZBwA3i1b0bEzRijudM4ozxlMFBjbb7cFg4DocHQ8rRN6PCyBE
	 j/UM0dId3OguR6gmXCi4f224LVvtt/rGOhstvtWQUDErQrvP+fw3DjdwDIAOX0WCrK69b
	 s8OSBXZs87Nvnodqmli5+iemyl70yLOLc7EQKcIG2Yi+3gNIDJjHCAT8L5bfNGIEV7tBe
	 vFdbwm4E1KXHuIgfMRqh57+RPMS9KNhs+2Jj32+aYOHcllsk6deOvpGya3jy4Atb140Rn
	 eazuiT6p2AzOicfw1oqfgwGRrnwxEz9fwBXdnspuxXIsOzgStbQjdzgSEYmwKR49XZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sJpOJQ9v;
	arc=none smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEB6606A31E
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 14:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CEB6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sJpOJQ9v
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ae854fd0f5so33193851fa.3
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 06:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795529615; x=1796134415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2bPFYZxerW65pYcm0C73RGOg35tpYhA92PuOUtYcAU0=;
        b=sJpOJQ9voZO2tNvdXAuuDdwG4hYaYim7zgcVR3LiICHHn1MQZZgl3Qdmu9sGqRE47a
         /D6wr6DA3ZaulvIZBERM3Ik4bNdIJbkBaR/k5QeAS1JTgUovoo8Kr9vzJ4K1pisFs/zN
         RF9r8macegwMGtDKWmHoYKf1jsgProMHPrSv/2zDN46uVd7GZpBKKiWBRHxSllqeGO2k
         ba044tfSugr5+usw4oltKHa/41Vx8UIALvyZGl3dzxy4skHN28Uszs3VUFthd6Shu9U9
         oGV+x8ntBe+rHc7Vj6my5ihLMLqHE8FInba3M1+nxyI3PFOWqedsM5kQRA16YEh5dJoz
         hDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529615; x=1796134415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2bPFYZxerW65pYcm0C73RGOg35tpYhA92PuOUtYcAU0=;
        b=EM+8pC9c3A8TJ7I40+VpqEWilf5/VG1ZoUcAUd4i1dzSOEXKo/HY1bIx7W+Q7AfiXd
         gG1EzpklII/2kPaq/HjPjvGSUUPUNWhonE+WtV2ImvqlbCanYR3k8eIwQJMXL8oJwAzU
         tn0VkaqlLtVqRhmMfUSLl9Vm+S9xrhyGbX6n9lh/xdf9xIu09jMwhm2iAfV/qo/qHnsc
         gP/PiDrCN0bds8Dybck3K/m4GBjxd+ucWqY5IXMamPxCkD7YfJerFqkIcf4bNEGnRPCi
         GLzERJOfOjyZyZek2REpeasp0H9Nod+MbyXHbO36INrcXK6yq5fL5UFprH8H2yfQC4Sg
         XDuQ==
X-Forwarded-Encrypted: i=1; AL+hErE7U7bmmu+KmXU9gb0ksZGFi5f11B5YjlSigKkLi7751Ebro78tzIM9ENyc+J1Ah7rYjBzjCCwwLjSjCA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+rDc/DXAGmV+WqoPfVuieJmmqqaLA3Rqh6JVUzhQTlXCCQj1kG
	XNMaWTCcTw0tOGs+p6h1epYdgI/kD9/+3+Xo7QcQa4V0CxG8OhzJit2d
X-Gm-Gg: AZFdTZcy/iK/gdaZC/08Sb74GPnWsCjVXwhlb+F+t6xZNipg3q+wZgesEqbcR+6Wo4F
	tx7ig5bIs8004VHhc5dZ6ApSgSrf/RKoJ8RaHCag7IOSALyrNRbIRZi28GR2dF9zjQczbLt8CGa
	7sQi9mtoMXNbY9G5RBI0C1PKijYN2ZMPoJuVXo0Hj1wlWwIphOHGJKcOhZHFyI7be2MN3rglMbA
	64Dj/5U+gi8XJeFxw1ZtilgsVDdnvLu4uveZHNHf3BGo6hlTvzKLv/W5EusVFpvW/4/vwxs0Gfz
	eu11GopzYLDu21FeS4PEonhGJyxAfTE3T0J0K17ds76HCBrbikWQHv5BSMC/IuRHlNqk7DhmhLQ
	yV+LiouyNWIjyAncvN6tBH1coPbrUHhlTENe7BOla6jeeNjBinQeFWhPrdoDj21EHinCQT6TGEo
	pDOmw4S1KZDoE7KWQChYfBDZTYqGC9F0ArpJoj0ze6Rj3bdxbddwTh564rthDY0a+wri2sYKDXT
	fOPp0UUA7YzXkahZd3d8MosN+opPzxmDftcz9pM19TImdlcdX796Ywe53n67BPrP4pmq9j6Tsok
	+o0hVVEZZRr/UAAE
X-Received: by 2002:a05:6512:23a0:b0:5c1:5d1b:9142 with SMTP id 2adb3069b0e04-5c1bc7fb790mr4527558e87.13.1795529615333;
        Tue, 24 Nov 2026 06:13:35 -0800 (PST)
Received: from pc-i7 ([192.3.12.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae80536529sm41169621fa.27.2026.11.24.06.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:13:34 -0800 (PST)
From: Aaron Ma <mapengyu@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Nikolas Koesling <nikolas@koesling.info>,
	linux-input@vger.kernel.org
Subject: [PATCH v2 2/3] HID: pulsar: resume device for raw command execution
Date: Tue, 24 Nov 2026 22:13:14 +0800
Message-ID: <20261124141315.6745-2-mapengyu@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124141315.6745-1-mapengyu@gmail.com>
References: <20261124141315.6745-1-mapengyu@gmail.com>
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
active during command execution. Log a failure to acquire the power
reference before returning the error.

Fixes: e55cf379e822 ("HID: pulsar: add driver for Pulsar gaming mice")
Tested-by: Nikolas Koesling <nikolas@koesling.info>
Reviewed-by: Nikolas Koesling <nikolas@koesling.info>
Signed-off-by: Aaron Ma <mapengyu@gmail.com>
---
Changes in v2:
- Log an error with hid_err() when hid_hw_power(PM_HINT_FULLON) fails.
  Suggested by Nikolas.

v1: https://lore.kernel.org/all/20261123141542.8128-2-mapengyu@gmail.com/

 drivers/hid/hid-pulsar.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-pulsar.c b/drivers/hid/hid-pulsar.c
index 86b1050230e9..b3f15ddeb39f 100644
--- a/drivers/hid/hid-pulsar.c
+++ b/drivers/hid/hid-pulsar.c
@@ -148,7 +148,14 @@ static int exec_cmd(struct pulsar_data *drvdata, const u8 *payload,
 
 	if (atomic_read(&drvdata->stopping)) {
 		ret = -ENODEV;
-		goto out;
+		goto out_unlock;
+	}
+
+	ret = hid_hw_power(hdev, PM_HINT_FULLON);
+	if (ret < 0) {
+		hid_err(hdev, "failed to power device for command 0x%02x: %d\n",
+			payload[1], ret);
+		goto out_unlock;
 	}
 
 	spin_lock_irqsave(&drvdata->raw_event_lock, flags);
@@ -164,7 +171,7 @@ static int exec_cmd(struct pulsar_data *drvdata, const u8 *payload,
 		spin_unlock_irqrestore(&drvdata->raw_event_lock, flags);
 		hid_err(hdev, "failed to send command 0x%02x: %d\n",
 			payload[1], ret);
-		goto out;
+		goto out_power;
 	}
 
 	timeout = wait_for_completion_timeout(&drvdata->response_ready,
@@ -175,7 +182,7 @@ static int exec_cmd(struct pulsar_data *drvdata, const u8 *payload,
 		drvdata->pending_event = CMD_NONE;
 		spin_unlock_irqrestore(&drvdata->raw_event_lock, flags);
 		ret = -ETIMEDOUT;
-		goto out;
+		goto out_power;
 	}
 
 	spin_lock_irqsave(&drvdata->raw_event_lock, flags);
@@ -190,11 +197,13 @@ static int exec_cmd(struct pulsar_data *drvdata, const u8 *payload,
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

