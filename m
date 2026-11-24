Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553008;
	b=Vjr20Q6vL81nLiNh1nIu8W25GnEFajE5vb0bryaQKOMjMUwggMKEJzVfiuWhiog+yddb
	 XJ/bexHg5TPCHvcetXxHWRfQF4ZKkvrrpxuiplcwQt9ohNr1BxIDNwPTIz+WLpgGqQ5LC
	 KOEP+Gizl1U3BIMxfqxa3BBwJPGxgYz/CVXjBfO4WUAQAqvy9gOPi9Ts8PXQDHWJO9uFU
	 fo6jcGZomEPjzMLnfmY9v7I+EAw4shNkNx4lSs/CQYw8doSUW8mqkjMCDtThkbIGzqJW/
	 VRwJ8+xXywvgArwjcfJV6nVoxaXKl4IFjRe8DRsBwD/5WP47Jx/ICS43EABleTgLbUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=wffwv16aDhgOHgRJNfimJ93EfWALxpawng2gAoer5pk=;
	b=5AkqUsdXeeeNFCOCyjaJ9UcpKlwnI8DoJkv+Aux+Tafooha/oVdJ1Z03Yoyqxf93IfyE
	 iTFUqTxj6vkkaFVs3UYdRt8fT4nFSFBfvNFgDt+RY42mjBNtikEU7fzsXEYQ1EU889Mwv
	 IV+nfwKQaRwA4xZDjU2MqMeYoL3bofTqXJrZyXCsbwWpL+P4bL2tSFGqgyiFJRLFeguCD
	 /Grq7X9bE+IY3gD4F7HBnU8fjZ7+F/e5OaPoEAZk7GW1kVnItD2ewyB4qZyMbr78yzNG1
	 VJ0l3nGaDVWLaFgV+QRyU1EkGSKZrGKHVHAKwirb4uPtVAJKYhlTC4XyHVDdmV0dikA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gr8vucTX;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE73606A323
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 20:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EE73606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gr8vucTX
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so816468566b.2
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 12:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553005; x=1796157805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wffwv16aDhgOHgRJNfimJ93EfWALxpawng2gAoer5pk=;
        b=gr8vucTXCLBGUkcFT5OGO7txLV3Mc/tM844NtT/mavP4IQRGmsnM4m92oKe8oo58yL
         LrBMpdkeMqh+DdFnmZavCI6XiKChzEFnULhVoLYoE04eoDJZ9z1kZHc7rkot86w9drKs
         cRn65lqbnwEr177/PYN3XP4MP/LYJIljrdqaDhiMlJTDyzQFUvxvJSAKm5Br6e9+9y40
         VLcjpnKWDyr+l/6gdNr9Pf0cvfwIoHgpaabvqVfj621M6usVXfenxyr9lbUTK/erWo3w
         odfukVEiLdWn+cKTSSAjuNL/Ch3Rh38XP6hF3RWCg7onA5oynEU2yPNyyTM6CRZnK+bY
         6Bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553005; x=1796157805;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wffwv16aDhgOHgRJNfimJ93EfWALxpawng2gAoer5pk=;
        b=vNdRzQN1e0P7CaVfwnN+VNT+O+vm29eRJh+SXOxUs22OpEkiXnex29sLJVtC29cJYL
         D+oY+zHM9tpJ+nlR0yjRoxj495FJ4qzsoJRgkVihBSyigPx+9LN4SAHzdVRXBzMzz5mw
         RL5z4u2NcHZHJ5HrcX12mshaS6kEEyy8WA4naUtxUhocwRPabouyoDXKHfmnkRTfGbkP
         iIMntAPpgDqlwWDm1yTEnhKEukuqawdGuilRh2Hw+sxOrNoeozCoJUFxomK4E55pY/jn
         9RsEB517+pRzkP4JyY6iXoaXPo3FidkXVCOocG8EpxwDunM0O+PmZNV/yaNZmMO+jjpj
         kTaQ==
X-Forwarded-Encrypted: i=1; AL+hErH9RWXkv3j/g7XebNhVzGFX3d+/17doj797hFEz6MZOdFsGQqa7fseiyQ5PzaKQK7CenotMNWciXKXaFA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/VnoOQ9U4yMO19ZZwXtASpqIsOpzn3btOlu2ihTZDt2FTgFAAa
	mX4s3iCW/f0fELiynb+nSzMoC8DElSZFHWXCx1bmBTLqpNGeHIj3f3Jb
X-Gm-Gg: AZFdTZcifrFpii4CfvQywwefsbbcUB2c3re4zZ7DG2M1INiQgCbIZ0EuJA/aWAU8XxC
	mcq3YIioaDCAypikgoVmIafdLySk+CxrEeJIYGU3rzZu069NThrqSpOp9/3zNtaQeoAbvDZbjmm
	AbN7brPXOzUJNApeQmDgQ2QJVIZhx+NimvjNt1W85K2C8DS9c9UnI9u7pz7zATzsUNL6Bhli5Ad
	MU09i8zR1jc5hrZTvgyLqVLZ1Z6K2WsHLmn3keXWl5d/3aKjAZNC3D1rf2aFQMA7848U45BBsZd
	vaf+oAM0fCrMwgYaoJYfdAJzwg4evmtuK2PkElkpA1IFgJp6fDRJsrPQ0R0peloBe5Dsn09/Axh
	q7gRMKpfpUDf99WaEdY6+2RcDgYL/ayIwrPlt0R+rwgxIWaoE8CtG+X79qTXtG0lcPZzjTU6eiQ
	MsFtjtLETK5LkFULWxP4VxyL9cpNdXlMhx1RPwVKpPhYgU7c0LYbwDCeK7Fui0RNLwGTI8jHLNk
	mUZyDEf6Bf1+SCmwpsTvdfr31wQ+iLOO0dvIZCJZp2IMMjiMvmMXv8vZZPWiMCGslke9WfYIDuL
	opiIUf5KO7gJeEGssit/uHEruVmEQBEDPlhbfn/0O0K97VR8INSmJ9ZJ55sCJzzpAK21d2hQvtk
	BwKV6MjSmC0Izku531tu8IgU4xylrFDKA5jI4czw2hg==
X-Received: by 2002:a17:907:1b1a:b0:c46:7ec3:fde2 with SMTP id a640c23a62f3a-c513a5ea1b5mr1248192266b.11.1795553005278;
        Tue, 24 Nov 2026 12:43:25 -0800 (PST)
Received: from localhost.localdomain (78-82-127-150.customers.ownit.se. [78.82.127.150])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad00232sm576160866b.12.2026.11.24.12.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:43:25 -0800 (PST)
From: Pooyan Azad <pooyan.azadparvar@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: u.kleine-koenig@baylibre.com,
	meatuni001@gmail.com,
	w1zardsec@proton.me,
	robh@kernel.org,
	jeffrey.lin@rad-ic.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Input: raydium_i2c_ts - use a fixed-size report buffer
Date: Tue, 24 Nov 2026 21:40:04 +0100
Message-Id: <20261124204004.98278-1-pooyan.azadparvar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3e575d6e2eb90d4a3707319d37134c1a@gmail.com>
References: <3e575d6e2eb90d4a3707319d37134c1a@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

A firmware update can change the touch report size. The driver keeps
its original packet and report sizes while updating the contact size
and data bank address. The IRQ handler can then read and parse reports
using parameters from different firmware versions.

Embed a buffer large enough for any value of the u8 packet size. The
managed IRQ is requested after the driver state is allocated, so devres
releases the IRQ before freeing the buffer. An embedded buffer also
lets a controller that probed in bootloader mode accept reports after
a successful firmware update.

Stage the firmware information and report parameters locally. Publish
them together after validation and after all reads succeed.

Fixes: 48a2b783483b ("Input: add Raydium I2C touchscreen driver")
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/linux-input/3e575d6e2eb90d4a3707319d37134c1a@gmail.com/
Assisted-by: Codex:gpt-6-luna
Signed-off-by: Pooyan Azad <pooyan.azadparvar@gmail.com>
---
Changes in v3

- Dmitry already applied v2 patch 1 to for-linus.
- Combine v2 patches 2 and 3 into one patch.
- Replace dynamic report buffer allocation with an embedded fixed-size array.
- Address Dmitry's devres concern by tying the buffer to the driver state,
  which outlives the managed IRQ.

Testing

- x86-64 Raydium driver object built with W=1 using GCC 11.4.0.
- Seven mocked cases passed, covering report size limits, query failures,
  firmware updates, bootloader recovery, and IRQ handling.
- No physical Raydium hardware was tested.

 drivers/input/touchscreen/raydium_i2c_ts.c | 43 +++++++---------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 68ada037f694..fa6e93bec9d2 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -19,6 +19,7 @@
 #include <linux/input.h>
 #include <linux/input/mt.h>
 #include <linux/interrupt.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/overflow.h>
@@ -129,14 +130,13 @@ struct raydium_data {
 
 	struct mutex sysfs_mutex;
 
-	u8 *report_data;
-
 	u32 data_bank_addr;
 	u8 report_size;
 	u8 contact_size;
 	u8 pkg_size;
 
 	enum raydium_boot_mode boot_mode;
+	u8 report_data[U8_MAX];
 };
 
 /*
@@ -333,6 +333,7 @@ static int raydium_i2c_query_ts_info(struct raydium_data *ts)
 {
 	struct i2c_client *client = ts->client;
 	struct raydium_data_info data_info;
+	struct raydium_info info;
 	__le32 query_bank_addr;
 	u8 report_size;
 
@@ -355,27 +356,6 @@ static int raydium_i2c_query_ts_info(struct raydium_data *ts)
 			return -EINVAL;
 		}
 
-		/*
-		 * Warn user if we already allocated memory for reports and
-		 * then the size changed (due to firmware update?) and keep
-		 * old size instead.
-		 */
-		if (ts->report_data && ts->pkg_size != data_info.pkg_size) {
-			dev_warn(&client->dev,
-				 "report size changes, was: %d, new: %d\n",
-				 ts->pkg_size, data_info.pkg_size);
-		} else {
-			ts->pkg_size = data_info.pkg_size;
-			ts->report_size = report_size;
-		}
-
-		ts->contact_size = data_info.tp_info_size;
-		ts->data_bank_addr = le32_to_cpu(data_info.data_bank_addr);
-
-		dev_dbg(&client->dev,
-			"data_bank_addr: %#08x, report_size: %d, contact_size: %d\n",
-			ts->data_bank_addr, ts->report_size, ts->contact_size);
-
 		error = raydium_i2c_read(client, RM_CMD_QUERY_BANK,
 					 &query_bank_addr,
 					 sizeof(query_bank_addr));
@@ -383,10 +363,20 @@ static int raydium_i2c_query_ts_info(struct raydium_data *ts)
 			continue;
 
 		error = raydium_i2c_read(client, le32_to_cpu(query_bank_addr),
-					 &ts->info, sizeof(ts->info));
+					 &info, sizeof(info));
 		if (error)
 			continue;
 
+		ts->info = info;
+		ts->pkg_size = data_info.pkg_size;
+		ts->report_size = report_size;
+		ts->contact_size = data_info.tp_info_size;
+		ts->data_bank_addr = le32_to_cpu(data_info.data_bank_addr);
+
+		dev_dbg(&client->dev,
+			"data_bank_addr: %#08x, report_size: %d, contact_size: %d\n",
+			ts->data_bank_addr, ts->report_size, ts->contact_size);
+
 		return 0;
 	}
 
@@ -1130,11 +1120,6 @@ static int raydium_i2c_probe(struct i2c_client *client)
 		return error;
 	}
 
-	ts->report_data = devm_kmalloc(&client->dev,
-				       ts->pkg_size, GFP_KERNEL);
-	if (!ts->report_data)
-		return -ENOMEM;
-
 	ts->input = devm_input_allocate_device(&client->dev);
 	if (!ts->input) {
 		dev_err(&client->dev, "Failed to allocate input device\n");

base-commit: a74c1c7406d06839d0eb15b69bca344e62e729fc
-- 
2.34.1

