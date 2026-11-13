Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568964;
	b=X6693gbxw/NkxA0D4hKuGDL9nm1zO+O+D+hPYFo6eFabH5sUeR/1Ul4RBwtN0lNAUD4J
	 flqpGyfMGq31wUqC09D04VNQm4tvae2KjGJFU8nH+kDNLkSHf3Mrq8KpyPAt/LGfB8+gB
	 20WMeZ60vlWnJCoaDROR/mLQ2VKU+QXUUHTgviE9rz1D5fn20sx6juUHaIleCTcq2J5Nb
	 kZ3M9mXTsIgvsnjY8jIHwN4wYgjk6jlYy2L8pwFGRIaqKRYJQtl65z/3AkEPi2zyDJmDR
	 hYHZB5xHw4jsIHbrXzYoeqP+3A8YN13TJog5OQDBDiStNlRRzVDj/23WvdY7aRQuaag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=P9cljPUoqRCp8iQx8E6PP9Ijpsz+IopB+BeFDzWmoxA=;
	b=rjU1V/8jqycrN6tm6wkyQbGxtenZTwBQExTOPU3XOH3F5e7Wy/edKdUgC61PSemZGkal
	 S6lVrsEfwhRXZiNMwFQM5CNYLQkvFH4IdMSShXmCN9rDmHxK0pY/zfMHzK+luaT5iM476
	 P6ozyf6QSJTgnPxmfo3cgULhqQd77VU8KiB881WOsdFP1/KJxYzFbecAi7kWnku6V7rCl
	 rb3Nc1kdkxyapEqiS2BDgplvz4+mGW8ugIyfpvkRADvS4eucJqq2C4y1apwk84xJW/hxb
	 qGbjYVAcYDcAdZgs+iWC/CVpIul286xnGbmbem/Xh8dwPjlJjl7s6iv/HEMuDuhfNFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tyDx3rEe;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430AA606A323
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 11:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 430AA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tyDx3rEe
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso857016c88.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 03:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794568963; x=1795173763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P9cljPUoqRCp8iQx8E6PP9Ijpsz+IopB+BeFDzWmoxA=;
        b=tyDx3rEej0eOLwfvK4itRoSmGb0qAKV7J6aBqVlqyENDFtjUdEEV7Dn1ZtNx7+VxVe
         lz3PaaEboAB2QO3SM59uqMfM4YCf/aenDSIQH9xXq6lquWyoMVNmLOWzQsOZPR7cPV0D
         jAXNE5clc55+rsWFEe8Vfhpfdt8jIhUnkAWOxPyD1vn966twQinv5/DqeR98kqEU0jDp
         Oh7HtTjH5QVLnaxvZq/OpADu3j0CSen/LTaliMaRFQ6vzzYHoQF0rVPSDJ0mD0zJ/j5X
         d1NfFd9/Eair7J3cNxjvf2o5ycbeOdFJuMjN4hvNqKeAKFWfLPRTXtDeYgPK9FBAjSFq
         HYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794568963; x=1795173763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P9cljPUoqRCp8iQx8E6PP9Ijpsz+IopB+BeFDzWmoxA=;
        b=moLL1og27A4+0x6U6WJXAZ8s5E8DMczdmPqvH0xGqSS3GV3exesfw4v6+ljEqPzJ34
         x+/NXreNZ2DBfXKPinkN/R/IoKDfuBdZOjMgFzNAgruccRoBSqljtWOw+eI4fot7UDfk
         v4vPxo//Mb3hu3EM4wmTuJWX2CHUDNQrQBoavzs1lloDK+G1H5J29Z36SwoMvw2K5Q9p
         e9UgwDnG6OR0f4a2vj/5LgdlLLYN36cdfw28FwP4GbdxHj/dyWzCt9IGFrecO4bY6bXe
         ErV9yPsfv/3JtPud8/PCMQ9dV44yV/eid9uQq7HG+5FtDQS7mtyuctSQTphk9ZaPbAmr
         kXTg==
X-Gm-Message-State: APuU4Z8YFJCEQs8wRtJKkN3KZTqaO82vEEiw9vdqOizqtCnzi+Mz4qpn
	RAjocx+ixZDm/zGwPE/RV8z/8nZUVWhouoZCnzSYG6PjpRMZuICuT4cHfm4qhQ==
X-Gm-Gg: AYBFou3mLLy1VryBiCjo0ZWCvcMScwYjxifAGgmzfIrpUN8BTD3m7eucrG4JgL2cK4b
	rTZs1BhCOHygBqMLN/4I269Nx6Bo9AzbsOjURcfq3jTLFXijcUkxHeV0aFFdjP4R0bbo9dvTf7/
	XtO3OvF5WeVSdt1JPY8q4SNT1ZJs3jBUCEmPRd9DVPtvgh5vYIWSxnRcujBYT9p5rlIg2Lldvpa
	T40My9k/0R8BKmd0V1o3Kkw3blV03gUKrLo7IFd5JXCwpWrgaoSbqV1u8hGh8UhRsCPa/D2Crm1
	NpH1B7vGKgAo28QBh9jMzP9FGilNya7W9+Dp+aB5qKJsfw6LKop5F3QQq2vHgnlFyaBysCcYZNI
	4Y6V1PKsmV0Wtj5nAbkrxxD+dhxSVgKK12+a+T725rVZpoKHrCsNvAUVa+Yu7gc5VsGK/iTZL+5
	h3w6o5NwsHYb1DwA15pZQs7nXoURhoikKjb4ohPmT+tqFsWyeLAemKv1ILoLco8ePj/M2mIee5J
	4RVq/DWZ6bEHCOo2qtMA+qLp6Yu89baKUIcYUdPu7lRSZM4dOVQus+42LZdkDNyJoiHbqpSsWfV
	+JacKzTXBaao1rHnpQixeBpT05jZBcYuxNjIEzrZFNLpBPj4
X-Received: by 2002:a05:7022:3a87:b0:19a:9a93:c9b2 with SMTP id a92af1059eb24-1b5030980f2mr2439664c88.13.1794568963315;
        Fri, 13 Nov 2026 03:22:43 -0800 (PST)
Received: from localhost ([154.21.93.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d8f5sm11023797c88.3.2026.11.13.03.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:22:42 -0800 (PST)
From: Yuan Yao <yaoyuan0329os@gmail.com>
X-Google-Original-From: Yuan Yao <yaoyuan@linux.alibaba.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vishnu Sankar <vishnuocv@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuan Yao <yaoyuan0329os@gmail.com>,
	Yuan Yao <yaoyuan@linux.alibaba.com>,
	=?UTF-8?q?Jingle=20Wu=20=E5=90=B3=E9=87=91=E5=9C=8B?= <jingle.wu@emc.com.tw>
Subject: [PATCH v2 1/1] Input: trackpoint - Add new TP JYT_NDT device variant id 7
Date: Fri, 13 Nov 2026 19:22:02 +0800
Message-ID: <20261113112202.10304-2-yaoyuan@linux.alibaba.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113112202.10304-1-yaoyuan@linux.alibaba.com>
References: <20261113112202.10304-1-yaoyuan@linux.alibaba.com>
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

The new trackpoint variant id 7 is found on Lenovo Thinkpad X14
Gen1 laptop(Product Name: 21XMA006CD), it belongs to JYT_NDT with
confirmation from Vishnu Sankar in Lenovo. now it's incorrectly
probed as Generic or Logitech PS/2 mouse.

Add the variant id 7 to match the TP_READ_ID command return
value, probe the device as trackpoint correctly.

BEFORE:
input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input63

AFTER:
psmouse serio1: trackpoint: JYT_NDT TrackPoint firmware: 0xa1, buttons: 3/3
input: TPPS/2 JYT_NDT TrackPoint as /devices/platform/i8042/serio1/input/input8

Signed-off-by: Yuan Yao <yaoyuan@linux.alibaba.com>
---
 drivers/input/mouse/trackpoint.c | 2 ++
 drivers/input/mouse/trackpoint.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
index 3bd8fdf56cd3..2dde8cc5cab1 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -25,6 +25,7 @@ static const char * const trackpoint_variants[] = {
 	[TP_VARIANT_NXP]		= "NXP",
 	[TP_VARIANT_JYT_SYNAPTICS]	= "JYT_Synaptics",
 	[TP_VARIANT_SYNAPTICS]		= "Synaptics",
+	[TP_VARIANT_JYT_NDT]		= "JYT_NDT"
 };
 
 /*
@@ -285,6 +286,7 @@ static int trackpoint_start_protocol(struct psmouse *psmouse,
 	case TP_VARIANT_ELAN:
 	case TP_VARIANT_NXP:
 	case TP_VARIANT_JYT_SYNAPTICS:
+	case TP_VARIANT_JYT_NDT:
 	case TP_VARIANT_SYNAPTICS:
 		if (variant_id)
 			*variant_id = param[0];
diff --git a/drivers/input/mouse/trackpoint.h b/drivers/input/mouse/trackpoint.h
index 3e03cdb39449..2aa76311e400 100644
--- a/drivers/input/mouse/trackpoint.h
+++ b/drivers/input/mouse/trackpoint.h
@@ -30,6 +30,7 @@
 #define TP_VARIANT_NXP			0x04
 #define TP_VARIANT_JYT_SYNAPTICS	0x05
 #define TP_VARIANT_SYNAPTICS		0x06
+#define TP_VARIANT_JYT_NDT		0x07
 
 /*
  * Commands
-- 
2.56.0

