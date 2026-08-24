Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66E37B014
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593056; cv=none; b=l5buKHObA9aQk+cnENK3Cyx5JG0fKtvk+sgt3oyLrPUfZLZsKdOkA0IiliSGcS2+3oyj5372XaCqJpZVGrgwQat/H2ZSaMREEAUFE6bIkRMAtETSlz12UvtTSlb/m6Goj/II6VO/UkMQitl1qqdQnAkAA/BfILsKLpSHrANfd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593056; c=relaxed/simple;
	bh=iXOhgnPLmwpFGKlA/HthfKQsOb2m2ZTvoRHdiAfQ6Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTm2AizMNlqSoD05+J2sxG4AMh5o9YCWuYKdMTkJKlFiCROYX/KAVas5dydtPUiHXmNhiFCslwOG/RZnKM0qtHSwTmzK6IfGGXgX+8GUUeMjqTtMrZxF0e7vc60xminsVQpp4gtHkpAieYTGSF1sA8UnD3j3lRZKKGozoDEPTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQU5SJR8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQU5SJR8"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so7165788a12.1
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787593044; x=1788197844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N8DPaTwYfYl5EcD9GcdAo2GOI2V8KsaETPVZPUOF+EE=;
        b=BQU5SJR8wyhVViMs1tCw7KtNw4bZYXrTT/fMg78WkCsVb+0G82zKKYHzSpV3fsCqwy
         S6bECrNQqCOtmygiVkfhOEoXP2sC69X29iykDRP92NGHM/1tNGunBtu2DqSs6Om8loSt
         yuo1TIO//QtYWtyua4Kg70ej3EAs6WfMgWzhrTxeP6Woxe2HH1n2n8Woo6gj+D9iLeT+
         fFatXPtL0PaaCZX8Lg4FTVrvcmuyennUqjjVC+s1Vo9/aWX3tDPSPmVAGTOAvZiMy5BC
         D91mUnzueibxAT4DlYLMoBEl0EDVt9Cf7LzMrk5IjTXBVxrk5W2YthHnSsQGN+M7SZz0
         6Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787593044; x=1788197844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N8DPaTwYfYl5EcD9GcdAo2GOI2V8KsaETPVZPUOF+EE=;
        b=U8r+744SP5tWtNMecoUCPxASttSIako5dTSWs67ObYPsMjkIbekir6tBOmWKyEVR2b
         gLtMkeidamsmf1RjK6+6+P5fmgXkir9UdeoB3SLHWa+yl1MzC64c2htICvs8s0j+Sq/b
         YN0ct2+PZhUXNP4X4WS4goTLCmljtFpR+Ex3Cx2GM8PDN6exY8uvNNLoAPQkWv7v0V62
         CFkrwBK6wWpNTLPTM9XDmhXvari6rM04XO/w8hD32+KofKmpKGtH+hwRgqfFiLY8gR0e
         3k+buLQjqlE8vwF6hy9JAYmtu8JsOR/vc0B5ormXGT/G0te7MTXvlWYJdl+o7yrJl3mg
         FdyA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9kCo5qfVtRbrwffdl1tlowT3QU3OZehiVU8Q5K1scV34vLlJojs2o75xUW03wS5uOq9BJckLJLlCIpA==@vger.kernel.org
X-Gm-Message-State: AFuF++lasdxjOLTv1Y6sEXhvTmI3Fxa5mgc3DsPGAP/TlzW6ZBY32x6D
	zKX0AbXRpJgfc+iqMAaYL8nzU+QxwjKgRfZsuISfdbeqpz/jOb4QFz1/cjsxeHBz
X-Gm-Gg: AR+sD10FfACy25IAHJbPQ9cTNyhwzhEtb/p/bxxz5FrpYpDgzB4khJIKqCI7C6KdOiw
	b+pXhOaKpitkdVvTGAdKb0cCsZIOVlkt45otjUZXNHW4RX8aAHgsiAqIuvrMQHW32D1KFh0aV2k
	eW8V+FwZwzrdn+n9peQ6HSV2gI6GVTkcs/8zH3WxwDS7mxZIUL3vO3OhKtQTzNUeqDg2wdZus/M
	vELS6OOMQ32sEKSC997B6GGkYbXY2RuIIcuKJft92BAsIYLAfzNX0IrBjOTXj09DLuBZ61usTdq
	4YF8VUh88W6R2YJeuQ794V5lqSLJnitUupiChre6YIUJBXUY1QcJCUFT/6X50shPj9WUjI0dqIr
	O5+witMkyd//35qxK9umcG/iKIixQcu+gmcpGA+seS5eB55nmybNC4Td52hLWoGakvR6bLXkLAh
	TWPDWdhrH+fu7kY+1tjvZXM3J6QdKZzQv72W3g1eOOvxXCY4dVIm+Ev7ySa5MT/f9zczoWAGgvC
	VbRs2IbqvwLDwboHeQUNNoDx1qvFfFnTdRFDmTT7RJE5bhFEXPZzlB8BuoU1/KNHn7bwNY=
X-Received: by 2002:a05:6402:1906:b0:6a1:f8ad:6c0c with SMTP id 4fb4d7f45d1cf-6a42f1fce20mr34626689a12.16.1787593043662;
        Mon, 24 Aug 2026 10:37:23 -0700 (PDT)
Received: from dmig-l13.lan ([94.139.29.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e0190d3sm9361057a12.9.2026.08.24.10.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 10:37:22 -0700 (PDT)
From: Dmitriy Geels <dmitriy.geels@gmail.com>
To: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: [PATCH] HID: logitech-hidpp: cancel reset_hi_res_work on probe failure
Date: Mon, 24 Aug 2026 19:37:18 +0200
Message-ID: <20260824173718.14687-1-dmitriy.geels@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe error path cancels hidpp->work before freeing the HID++ device
data, but does not cancel reset_hi_res_work.

reset_hi_res_work can be scheduled while probing the device. If probe
subsequently fails, the work can run after the driver data has been
freed.

Cancel reset_hi_res_work in the probe error path to prevent a potential
use-after-free.

Fixes: ed80cc4667ac ("HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL")

Signed-off-by: Dmitriy Geels <dmitriy.geels@gmail.com>
---
This patch is a result of Sashiko AI review for "HID: logitech-hidpp:
add native touchpad support for K400 Plus":
 - [High] Missing cancel_work_sync for reset_hi_res_work in the probe error path leads to a Use-After-Free.

 drivers/hid/hid-logitech-hidpp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 9a6b04283130..279384fa9835 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4925,6 +4925,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 hid_hw_start_fail:
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 	cancel_work_sync(&hidpp->work);
+	cancel_work_sync(&hidpp->reset_hi_res_work);
 	mutex_destroy(&hidpp->send_mutex);
 	return ret;
 }
-- 
2.55.0

