Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380182;
	b=JPUuyeu4yV9GF0k8IxErNgU1qQBayVKQXU9NBWkt7gfGcAn760pjB5HdF+5kJfgO9Lnc
	 FsUEPR7N2vAlYWHADeYIHu8tesFIdxTd7IxR31LlWd68FtZ1R2f9vS/reE0vAoa9c5cMD
	 Sen6AdFUUwwXiq12xyatpOiaNiRZncVSnxGU0QMkYF56iM9n/Mpv70VgwFggwIRAVYtm3
	 roXlGF57RlLozm4686id+0HK2was3+3JNzJenN2h150ROl2CuUQS/hrCX8C+AxNNd9JbN
	 bJSG4STKIsFSctFq3Lre91luB3qVw3cXJ0cQvB1PL3DyNQBJ3s9Yy9F7P28iknFk9aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=jZGS888auqidm4dyipWzlAJPphh1S18LX24ea2d7R8o=;
	b=VaQhuzm8gxgG9Mf9Dskx8J0uuxIeGSd9JBGteBOSc4q3mNrRsMwessjlonVZp5+uosCg
	 4BB4WoSsLezdiUQEt3r/Te1zTztZAOvm3fTKrbPc5PQKOfvIwbZqwY3cWZOB+e0AzTI19
	 6hXvDJdxWqC93Bs/5T7SeHqnW536WB2lRyOvZXlI5YRxag31I0hYss+6TpJI/lFFgi6C1
	 ETqYsA/aBHr8P7aQUSlRBer7V7ofDA704JVy5JW20PZcceiZGDGImXbLUm9nsWJraoe4L
	 jkR8ybVmkW0Ymk4o4N+wNGKEyi7v7WUDCdRSIDAXlVcFd5hPuWMCJEZrmIs2y3KNiyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfxHh38D;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9CF606A324
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F9CF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfxHh38D
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-14394530ec6so3679253c88.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380181; x=1794984981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jZGS888auqidm4dyipWzlAJPphh1S18LX24ea2d7R8o=;
        b=xfxHh38DIVXPpsdcjuU8pKLEB2mK63aFJd7Xf0/+nIUJDjugA4HkTepQxYcL6HRZ7g
         2EcAeV07/9DTk6OKKSedGBjRPZrqBUMcMA7mJLxUAMoeZ7Vt6+igoV/Zg1UL6RikXLlk
         71J7FJxjxEdJQzRMTCBE5YfxqQel447lkS/7KiGU9bC4syVAdvytlNuaSnwUEyrAS2uu
         QxHp9lIzqShCZjJmMomKTT3PX3OiFyaGTvs2U96NU/blOoCpoqCNUY74UCuVHd3mvLBH
         Daj9oufapdgCwLPaJnQYx852SZa0qXB06Y/BfW+N/UJ9EdBoYqZ3cOCjbcSoJ+HlUZXd
         zW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380181; x=1794984981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jZGS888auqidm4dyipWzlAJPphh1S18LX24ea2d7R8o=;
        b=G6zNaDe59c4/xGoUYiHBDVr+mnUr/4jK4SeQp72Cp++MflFKhYSNLF1wMNwh2Ryb3o
         3+yMaaPIwboTmEZ2vfkJsVJL6F5PwXN24LgRzZIi5K0a8O07Kfe+nVDiAaR2I3mZT2iB
         WSkJqMS7DU9nS3i7Un6CqQmHm8j9CsjnGROKbpCkXaBwwXPe125+rBVWHu889NJldiZK
         zq+3LZePvlaZhfD6rHTdjWXekJ3ZJUCEAHOw8X0SXhaIUgpt80gNILmI+Dt+Xo4p/wrC
         mgHm1Y9RfzHUMHd0Z//sGsyyCkY63PK3Rq5N/dIecTTVf9+e/D9Dq1ypvpei3NoBDK20
         vh1g==
X-Forwarded-Encrypted: i=1; AL+hErEho3Kw7mo62SQaLsRWLcaVW3Ue3HySWFgyuJyQ12PHBCCqMBQUDB1IK9oCgP/JsXEQPVgrurS5/xfJNQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+wYVyXCEzgajnDLWmRFpTZJWZWAFdZBuq6Pkq5RzyuAmc/Wx2/
	j/W+ClEm+o47kglKj+BTbJIlYsROvungoO0cbQTJy/7CsZV1mpFGL0r6
X-Gm-Gg: AYBFou3n5eDdgdj2JfnC4wzWm0aIMizvP38uuUpA6ssuv/IBsj0sdeTgvJNZrvfRQqR
	xSI83f2jCNDDyHcSpPYwodUTfu4s7T0OMv86BmwiFAUm69pqECcasGHzMeRbR4P5riQJXtNOtQK
	MmDBWWEGHG3wSUZxBvmbVbCfELOZ9pNyekaAKf1RoMIde5j4oMsdpDq9GvM0sWgSU1xNAR5qnxL
	HZpoMyCt6ZslGJY1nDEJr5kb4F9Rf8RBP3sQ7zEmot0osomO5ZD/TwqiUIo4rbG13V9rfOvYL0N
	u12y2eCEGnJngknxEDMpoc085Aedxc7LJ88koo2wRXblDRzHFyWxAKMWsqQGBmvjZyKJXYINsOF
	z4+vv9oWGIUT/CRT+G9IXiJDldfOV5qZ1fBRSJ2ryP75Ds7haK3NESv3uyeuF2LNlXMCYXj0uTl
	02KBvd/vBSLCcG5lTdhcRg0cTbbLEoBGffCr+T/cmdGDWTSOXy1fOV4WzezHai2j7uLRTkNZ2Xs
	wf+7Jgp4svoQpjkunNL4oP6au9zXq9APZvKMMXaJ0NbhCwybq6IkQWstlrZ5vgTLo5xfJD4jnfQ
	rgb46muiSHpKGgeFsgcSYIIo/UMzyD/AXd3HdPcAq+MVWcZsQ2QvVioRZ40NP3o+HQ/PSfayBQd
	GC0nXbbniuPtVw5ZMjw==
X-Received: by 2002:a05:7022:ea8a:b0:160:90a3:ca8c with SMTP id a92af1059eb24-1b3c0334a40mr1624823c88.7.1794380180963;
        Tue, 10 Nov 2026 22:56:20 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:20 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:47:59 -0800
Subject: [PATCH v2 01/33] HID: logitech-hidpp: fix G920 force-feedback
 initialization timeout
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-hid-logitech-hidpp-v2-1-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Commit 544315e40172 ("HID: logitech-hidpp: move FF initialization to
.input_configured()") moved Logitech G920 force-feedback querying and
initialization into hidpp_input_configured(), which runs during
hid_connect(). Because hidpp_probe() calls hid_device_io_stop() across
hid_connect(), incoming HID++ responses from the device are blocked
and g920_get_config() times out with -ETIMEDOUT.

Temporarily re-enable HID device I/O around g920_get_config() in
hidpp_input_configured() so the hardware configuration queries receive
their replies during input setup.

Fixes: 544315e40172 ("HID: logitech-hidpp: move FF initialization to .input_configured()")
Reported-by: Gideon Heinz <gideonheinz02@gmail.com>
Closes: https://lore.kernel.org/r/CAPb1+K1-pirdLGZ1wTUw26G6pvhg7rGP3QZ172ys5DB7rNCf5w@mail.gmail.com
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 60fc6b86a085..85d8d168ff15 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4096,7 +4096,9 @@ static int hidpp_input_configured(struct hid_device *hdev, struct hid_input *hid
 		if (!list_is_first(&hidinput->list, &hdev->inputs))
 			return 0;
 
+		hid_device_io_start(hdev);
 		ret = g920_get_config(hidpp, &data);
+		hid_device_io_stop(hdev);
 		if (!ret)
 			ret = hidpp_ff_init(hidpp, &data);
 

-- 
2.56.0.542.g3ef89b7020-goog

