Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746774;
	b=W/x1NdwDzJR4uOJ4RgUN/2Uou5pEj0INIm+sH5PpzAcQnEtDq0vOGf7bm2g2Xxz0wYV+
	 21E0kfTwTcJptBTzZmMaFwAACGSySDMbpOZUKFEgIpYnBudLz0vsv0wsw/Djk2j6VY91y
	 zx75mpFVQLbgTTraV4NTlG2Ta+X5F9mk0mMYzhBa7ok79R5pOL0+AOm7l7NcWIYek2l/5
	 Ffw20dJgz37bLxhGXOYGMJ2qL2BjRImbBJwMSy055B2oL+RIkrj9C/ZGQh7JrxiGw5EJY
	 wMxcrvVkeZbOMhVZicKoIItIO9TMxBBUIr3hRxDr5ENX1F7K4LIShJt4XZFOFLrbTzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=K8Xl6Cocv0cl5LTtyFifxzrgj29Mq3NqZ1spMjgXTok=;
	b=isXxO+UNs79M71g/qyH76Hr8M5KxOflb2CSl5ABounRunG295UeKxMuYI8w9UehIsB8x
	 iMWGTORia32yCQcHjV7MBKr5rUg3lYaapJfHh2vRsuwmJIJTgeD6sFoUmDcSdO9p19Ws1
	 ztVB5tyoNOtnsPeMTmvs7AYC14EDHRUfJPZAuYEYp7vHpxf5Kx/69mLErk2j82/n3cHOi
	 Bgs1brdha/ZmqCx/8O6weMwv1JHYB94mJcz9bQfx3FpYRJjx0Z9L5xp05ZD1+HZ5wB780
	 1WcuhyqdlYKiXpsh9kqvQlKjlPlunDZ4bzr94fOsVINntbb7xaT+hNiXANqkigZ9UHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X6dmqFFK;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6180606A334
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 22:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6180606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X6dmqFFK
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so78286eec.1
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 14:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746773; x=1794351573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K8Xl6Cocv0cl5LTtyFifxzrgj29Mq3NqZ1spMjgXTok=;
        b=X6dmqFFKDgPuolduHlUByfe23WmdYyeRJH/7WCxeu8+9SiD2WdJO+mQoqt9m22R2CG
         c/rXWu/zk1oEcv6B7E8FV+WcUNhR4+beBKD3P+AOqNeMki9mj/0SWCVBu/Hk+bb1bDQs
         w9bcjmh2eNQq5FsOW0Oo7uRTLzdIxsIJoSEiDYNI0vVpQiBKfyOvloc3IbibWDdEgsVE
         w8unhSX/Uxfr+JbDoHxlTA2q+B9DFS2whxzacqK/AIhUn6RcFa7Z6k7GcI5ZZG7N9mLR
         kxmFqXv5klupYFw9yb7mu7a8iQP1wsa5hffWWHZHk8xmemKyrxiT1Et5VI6rAvS0aCWP
         pMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746773; x=1794351573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K8Xl6Cocv0cl5LTtyFifxzrgj29Mq3NqZ1spMjgXTok=;
        b=t7H7Mcj1Ku7j8cUYvZ5qEfO8JJOx0dWegRB62GfjUfnyZATOTU4j8qYwqQxyVGWQ6K
         Stq7VSuiE55e8lXBTX4jSFuj5b1M9sszwc/nFGAriaaF27qu0b4CX/L1V3IbcySt4Vfq
         CkgrVdXc/qSsSAVRyk4dSpGTGWH3KKN2LPXB92yW352udXArfyHajh16wT8fO+XNPklb
         Bf67UOT68rZ56A3t8HdXqmjy4iwANFm9YxjiTb/VFkNtcnwAMzBcEYNzmYan67uWPmB0
         TzdisvPYQtlirz8XVSS931PbdgpdB3uEr6CRGES8J+jXxfunnb6yMB85TfL3gKwYnBxy
         yebA==
X-Forwarded-Encrypted: i=1; AKwUvBxsYi2geAbEissidKGCHB5yI6aXOKgjysGxGB2Cu0RzqSWlrE2KqcAvZb4I0LIv7sapu7J/vAaEtGwDkg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/9uDWt/OKqobprQAorpAkFFsjfiM3XA+M8rudoCR1/iHrh1u+y
	MNexa7M1LppZf2sOyH3yNz6ZWfpxdGTTJYA5uFpE8eOFq61J13clxIxJ
X-Gm-Gg: AYBFou0/3OuXPgprezfRYV9NL/HXFxskxAxI4pCH6nTYlWeJhE2cMiQ/t4jQGb2NvAQ
	0Vr1KluJz1gPAabcxTQT4otRc5HUmBzI6UOdk2SOipiTwTl+GiuuqXYynvosIuGcGIw2NlMpQMI
	2fU8GiJFbFPIoEKrLD8KMpidu3o6GieE1owRJgBkanZnW7Oa7sGa9hFJCVeo7f3PIpmqweBdMNZ
	qWJQQmjP6UF8/gVFvUm1lYo+LNU+k3YAjTwBU+nUR9/C7CNvwYGurUNKIlHZBCaR2bXvUd8Zp6j
	d2xxYaZqTW5hXOLMaotbPIAZjVwnFS7aRYPGKg+bg5k1a8vojfg0wwmd2txqSxHajTjaAbJtqCD
	Rfb4yBSDxIyoDdSR1gYD3MVQYiPjEQs1D/JYLC/KXtDTN99GUaMNWwWtIu3eS2NeeKKTbwpVJbG
	oaLgzGIIwlE227yeui0EzxcNDVj/uofA2d3LlDiAAVgxusJ6SM9bfN1QN1M+SK8Ml+UdKsHdM3Z
	RLjXhDdf0knQ5eNIMEEyr0fP2VWAXqGYJ7ksc8DAnuv7DJRnwTQPK2XQOox9r794wjQSx77Mz83
	+FIaq5xM3UQgZqoPXsqbBM+7Bzip7x5IgDN4LIN5ufx2qgL4T6U+IKhnPFgQeVHW6wFuKHSPr0o
	28pYs6dWmzkEFdayM
X-Received: by 2002:a05:693c:8817:10b0:36a:1788:3d1c with SMTP id 5a478bee46e88-36a423fd04dmr21957538eec.34.1793746772523;
        Tue, 03 Nov 2026 14:59:32 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a67edsm1187111eec.8.2026.11.03.14.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:59:31 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Petr Hodina <petr.hodina@protonmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Input: stmfts - use touchscreen_report_pos() for coordinates
Date: Tue,  3 Nov 2026 14:58:43 -0800
Message-ID: <20261103225923.3892612-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103225923.3892612-1-dmitry.torokhov@gmail.com>
References: <20261103225923.3892612-1-dmitry.torokhov@gmail.com>
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

During driver initialization, stmfts_probe() invokes
touchscreen_parse_properties() to parse axis inversion and swapping
properties into sdata->prop.

However, stmfts_report_contact_event(), stmfts5_report_contact_event(),
and stmfts_report_hover_event() continue to report coordinates directly
using input_report_abs(), ignoring any configured axis inversion or
swapping settings in sdata->prop.

Update coordinate reporting across all three functions to use
touchscreen_report_pos() with &sdata->prop so that axis inversion and
swapping transformations are properly applied.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/stmfts.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index 25d127aa8642..f68da3e1309b 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -241,8 +241,7 @@ static void stmfts_report_contact_event(struct stmfts_data *sdata,
 	input_mt_slot(sdata->input, slot_id);
 
 	input_mt_report_slot_state(sdata->input, MT_TOOL_FINGER, true);
-	input_report_abs(sdata->input, ABS_MT_POSITION_X, x);
-	input_report_abs(sdata->input, ABS_MT_POSITION_Y, y);
+	touchscreen_report_pos(sdata->input, &sdata->prop, x, y, true);
 	input_report_abs(sdata->input, ABS_MT_TOUCH_MAJOR, maj);
 	input_report_abs(sdata->input, ABS_MT_TOUCH_MINOR, min);
 	input_report_abs(sdata->input, ABS_MT_PRESSURE, area);
@@ -344,8 +343,7 @@ static void stmfts5_report_contact_event(struct stmfts_data *sdata,
 	input_mt_slot(sdata->input, touch_id);
 	input_mt_report_slot_state(sdata->input, tool, true);
 
-	input_report_abs(sdata->input, ABS_MT_POSITION_X, x);
-	input_report_abs(sdata->input, ABS_MT_POSITION_Y, y);
+	touchscreen_report_pos(sdata->input, &sdata->prop, x, y, true);
 	input_report_abs(sdata->input, ABS_MT_TOUCH_MAJOR, maj);
 	input_report_abs(sdata->input, ABS_MT_TOUCH_MINOR, min);
 	input_report_abs(sdata->input, ABS_MT_PRESSURE, area);
@@ -375,8 +373,7 @@ static void stmfts_report_hover_event(struct stmfts_data *sdata,
 	u16 y = (event[3] << 4) | (event[4] & STMFTS_MASK_Y_LSB);
 	u8 z = event[5];
 
-	input_report_abs(sdata->input, ABS_X, x);
-	input_report_abs(sdata->input, ABS_Y, y);
+	touchscreen_report_pos(sdata->input, &sdata->prop, x, y, false);
 	input_report_abs(sdata->input, ABS_DISTANCE, z);
 
 	input_sync(sdata->input);
-- 
2.56.0.385.gac671c819a-goog

