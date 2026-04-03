Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC0285C8B
	for <linux-input@vger.kernel.org>; Fri,  3 Apr 2026 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775208746; cv=none; b=mb8XEYKqaM+YhZAy2q6j2Y5ESLiD/075tLp5x9aX05f29RMEQUmlV28eJJHI+0FOR6/8VAc37tLhDGgzisuxAKMqycIUDrj6eYWcjk1Grcc4MSC1Y2pmHJfjBmVhGH2lSwI0GiHKumPPKVt3/NOEdXCmQZVYbfrGEAGUoBR6RA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775208746; c=relaxed/simple;
	bh=hVd3xS16ofqjg6oUvBpPYeEZQLQPcrMBUpCP4tWPMH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svBmGgvE7rNiCzHl/sfr6mkRdJmewJPaKcBUR3IyOmepaL0Dc0XPcIL89HhdYO8DYGN4660tTaCSv5CX+UIUwmmbzkX41NPtbQh/YT7oTl2qOwoZHMVDoBlg3yNVJdq0h+SCMREXOEgJdWXTp8IcIuAOa4wdd4I+AUeBd4v1Mzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGzHjt5O; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGzHjt5O"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82cf96ca071so747012b3a.1
        for <linux-input@vger.kernel.org>; Fri, 03 Apr 2026 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775208745; x=1775813545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0iLKFB2VCqf6ai7H/mzGQPjeZOnWszHvi1gfvGRgyg=;
        b=jGzHjt5OyJjjfl79Gj5EjESqtjsolMYB8TKpFkHliU1lNHOQYLLcaA2b5m7NdRZful
         C3ziFK7k+SSZIxVR7U5Le9Y7N41lqcdRwH1amUD9zqcpVCSqBUpBKns395AtmKLrCkd2
         g8TBJFFJ5AQfcmNHftf/S5kku2/ya8obRm5Si6ceHPRRNTU3Cd++Jgn4JtRX3t3Eau98
         E7Qe3uin5222DJuxGbUi35pLQ8Tmlm6ziH6BsQ4o+mVBE8ojTm5dXoFeDMxphSxQVgLj
         ikdplFJftGKP7yeDmb0pPpISxLowyJZjriFxI37/A2PXAUHC5grWst0DnVJ9c5kZvOMs
         wQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775208745; x=1775813545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M0iLKFB2VCqf6ai7H/mzGQPjeZOnWszHvi1gfvGRgyg=;
        b=UrZZXJodSkzwqbVkTx1Zt8GPWrxIUxaiou3cYjkS9WdoZ40EWYOw17PFTQbAojf27B
         1n0sbZIH9rOtPKMfdmHCOoXWILfNsNGOXVQvDOLHeq8ObpIJSgJVnHz7snniqxP7TTlv
         C0Q1/ZBH7AOOBJbxZpLzzazlptwlBSBj+7+9rxpnZmgIAJARsKzBsN+CiSzrFrOoo0J3
         hEPqDd+aBMUfoyLqkFW0wTH1lAjidJwye7emIEFcQ4bab4yTEJ6lLB8MTyxNDkrJehhS
         hXUoiPBWeP9cx121ZC7gKrrFLSGsE1XsJi0D7nackzQNmbeuuJ2UQ+b8iTfRhWk2p4Uy
         qesQ==
X-Gm-Message-State: AOJu0YyIc5eob6l7huVWxPWn8teSkQQ2MZOsqQsdytalJ0e9sf/yq1Up
	YNGKrE8h8hl9VudO2jtZD59d8Y4hIkz3mmpGHFY1lvPHRtyftpnMOa+Q
X-Gm-Gg: AeBDieua3A1H6lNGwAjkWB7dvfkZafwgm3+1wv2AwdIij4dAC4bBL4ON8RsVVXLS8Sn
	UL288/9crS1HO/iquvLl1bRV8daDu7mJWEyEs5LM1O7WRVMs2N7x/IBVKNzbxk3yPZLALowqnXO
	yBEd4tK/QpST/YnxuCKUioQcDG2amn8C8HiSgY3QqSPpYd756Wv/JwlBzqpM+UMl4IaL/qrHsib
	J3sknauXwtq8UviY7hHRcimql1jo65phSGyU9Z2VeWcm/7vxphXyV8SVAw0SgDqOfNWT36sf+Os
	5cdrZ7gXZVk0gZfqECEBndUqfWLFhgm0j5/FBZ0pPlTemyBBcawZWO9Baz6XKbxYCd6eBrdjSga
	Z/d7eGYTGJUWs/8mvtAX2frWx4ZlSY8eI48+iTDpamfyBZV6Ku3AaB+7+6yI43ojzYuWFvGemGH
	7VYLNlnT2oreCCwDlZnglUxDua
X-Received: by 2002:a05:6a00:3391:b0:82a:17b8:1474 with SMTP id d2e1a72fcca58-82d0da3db08mr2390397b3a.1.1775208744722;
        Fri, 03 Apr 2026 02:32:24 -0700 (PDT)
Received: from gmail.com ([2405:4802:8548:f4f0:ffff:ffff:ffff:ffa1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca4efesm5498889b3a.61.2026.04.03.02.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:32:23 -0700 (PDT)
From: buingoc67@gmail.com
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hmtheboy154 <buingoc67@gmail.com>
Subject: [PATCH 2/2] HID: multitouch: add support for Dell Pro Rugged 12 Tablet RA02260
Date: Fri,  3 Apr 2026 16:28:48 +0700
Message-ID: <20260403092848.10223-3-buingoc67@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403092848.10223-1-buingoc67@gmail.com>
References: <20260403092848.10223-1-buingoc67@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: hmtheboy154 <buingoc67@gmail.com>

Tested both multitouch & stylus.

Signed-off-by: hmtheboy154 <buingoc67@gmail.com>
---
 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index afcee13bad61..2d40d33a6a90 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -447,6 +447,7 @@
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001	0xa001
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C000	0xc000
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C002	0xc002
+#define I2C_DEVICE_ID_DELL_PRO_RUGGED_12_RA02260	0xc005
 
 #define USB_VENDOR_ID_EDIFIER		0x2d99
 #define USB_DEVICE_ID_EDIFIER_QR30	0xa101	/* EDIFIER Hal0 2.0 SE */
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 9e46028746fd..228fcffc3423 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2250,6 +2250,10 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(HID_BUS_ANY, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C002) },
+	{ .driver_data = MT_CLS_EGALAX_WIN8,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_DWAV,
+			I2C_DEVICE_ID_DELL_PRO_RUGGED_12_RA02260) },
 
 	/* Elan devices */
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
-- 
2.53.0

