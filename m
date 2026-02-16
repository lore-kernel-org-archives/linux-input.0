Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BDE7261C
	for <linux-input@vger.kernel.org>; Mon, 16 Feb 2026 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771212024; cv=none; b=JBNbPJl7iWJXx1ipC2jx1nyW6KUZh3qp09f07qfewxvsM6nlmwEwxhSlpvP29I0WKWulhY4fF40xFO9diy2fl7nn3/gPLqYkW1aGE66DfIQI9EHix2aHjKE3o5Kyx4lCkoChjnAGnC5kpyelvsqJmU2ADcxE75IdM8l9S7rkE1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771212024; c=relaxed/simple;
	bh=942O+hf+F5rfx/qQl9prdoFML+eV1a+38fZ2S9Dhrpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAtw5UtO049VcqA3hWaTaom/wwuNvf79L59cbuevezWKBY1Kl/3tjXwCE7KgosHVNFnl1qYjDQopr+FPz5rWFrLy+ohGVU8Mim6YuUtiWKVO2H5R9nBlb2co5iZfqExEX5OPeDpkfLBFXEylc1enkD1Cb+2vzracfuodjdQWfps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8P7G6GX; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8P7G6GX"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ad019bb5eso2397746d50.1
        for <linux-input@vger.kernel.org>; Sun, 15 Feb 2026 19:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771212021; x=1771816821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6LGvUKq0n4wsuyCdZHTh6SpLNtepx8NmVuHEeyoSw+8=;
        b=A8P7G6GXrvglCoYI8FJGKQMtJdXIDwH8OmbXPUqpJupm/JzVjhV9PuaZ94by6obUT7
         0z1fTtYSd7HOESygpLnUagbgO5FbdSMLuKoPgQuzDCdbWsHHxtKYu+T1YxBu/IVTL8cq
         hImz93cx4f/fvAqF4iKrajfkgksPa4FkQ4bjfodEhSPGetfMvQKvbIQZu8We+lqjPwGv
         xXW2BhhAJ5lthRemC6S253jqH5iFe/OpwonY7S8yzca/rsF3Wjl5UE3VI++00uqPcJu2
         65NBET1qVBxOzBW/EQRoNvQdlGRAkGjQUZxfxlmQkMpQweXN5nYyDIAi0EgznbjvXioG
         O22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771212021; x=1771816821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LGvUKq0n4wsuyCdZHTh6SpLNtepx8NmVuHEeyoSw+8=;
        b=gK3lVcgmzwONwTWl8mqFOCISZA7fm6/Qclre3X8sV0EsNrXgaHOzwFEewTKRPSWNEF
         L63NVFthziVf3qk4e+sdy/HCjzpO+hugc6j5fpz+ZMOR2TBbJlUBF4mqOAp4TAgtZZ8Q
         LrwfP9ml8JWC/v+DQp27gvV7Xvs6SrZLSzfhrQs0eIX/qn09rk4Yzdp32Ve9yoAoF7Br
         qboRUdxRyTPpQ5esGwp4CrDNDxN8LxH2fINDpNk1X6Kv1Dbs1TQjNNkQa6qn3ByzmAkg
         Y0+FwX2jSa+/5dGFXhe6DtZzhd7tVlhNbUoexU/d1AqCMI8z9C1K88mlVYkQd+QRcN4F
         Ce8g==
X-Forwarded-Encrypted: i=1; AJvYcCWnGdXDky+o36fyaG4QUXYX86F6ucTRmfRg4qmAeiz1/5P2M+7yojMDWgy5poFClrXiCE2EWaiBYRGYYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/JRPEUSuIqMMkL5pz2ut0v8djW0GkkI7ErzRmvTz+WPkvTFkG
	f9mzmU88Y+sLRF4FMNHBxpgUiob5iE+/59fpUHnkYhVuDAUg/IN28Bhj
X-Gm-Gg: AZuq6aI5KXOuOmWYuLJFpU7oiqCx3c35ncOILhEB3AeHZvix0XhbUGczPa0g+AkP5X7
	qDPi2nrUcnBPcmxN8oqUlyJPt1qzha6aEN20hRyBwNWUeCY62JuP8pJ4rSTfL7N6PxZM+2ineCk
	r9ZuivgUP5Si0sL0c8wjlfOHYZo7zVWsIOirL8SkuBMlq3/BbYv3jWH9hvJeowRmFG0Ijxik47D
	emJGbgCZmaDToAMPh3Xm4DRgNwjlJOjIhzyo9rt+VUyFMQiSFiL+zNWNNTBcdKnZzWdAiG6JHTe
	EBxUs3e3IW/IPglIWSiYNoUeZ7lbD+oAulqpAMjzwDiRE5SLiq+yLwJdxZALGXzqrwqos0ZLqM7
	xbAGM0N52KWr8y77nViYxyt0+F6IR8dtHLgVop0XTBCCfGrJ57XGYUEmMsaUOpTq2dwEfDhHvww
	qtjgAceVVn9Qjf5Our7IDhMkk8tIjf317CiOKeqEUxN3v4MD5CYZTq3fgAmKQGtcFitPrH3Pkc7
	QwbfPgCf84+kd3B47/DXb5si0nTtewafJuVHun2oZGyhSx93dmQPA==
X-Received: by 2002:a53:aa4c:0:b0:64a:db8b:e429 with SMTP id 956f58d0204a3-64c19b677fdmr4110257d50.90.1771212021022;
        Sun, 15 Feb 2026 19:20:21 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22e6f7e1sm2917849d50.2.2026.02.15.19.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 19:20:20 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: david@readahead.eu
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] HID: wiimote: change wiimote_cmd_map_mp() to return void
Date: Sun, 15 Feb 2026 21:20:03 -0600
Message-ID: <20260216032003.37959-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function wiimote_cmd_map_mp() returns bool but no variable is ever
assigned to its return value. Also, by it returning bool it causes a
signedness warning from Smatch because wiimote_cmd_write() can return
-EIO.

Detected by Smatch:
drivers/hid/hid-wiimote-core.c:510 wiimote_cmd_map_mp() warn: 
signedness bug returning '(-512)'

Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/hid/hid-wiimote-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 5b5fc460a4c5..c4d11ff3c898 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -487,7 +487,7 @@ static int wiimote_cmd_init_mp(struct wiimote_data *wdata)
 }
 
 /* requires the cmd-mutex to be held */
-static bool wiimote_cmd_map_mp(struct wiimote_data *wdata, __u8 exttype)
+static void wiimote_cmd_map_mp(struct wiimote_data *wdata, __u8 exttype)
 {
 	__u8 wmem;
 
@@ -507,7 +507,7 @@ static bool wiimote_cmd_map_mp(struct wiimote_data *wdata, __u8 exttype)
 		break;
 	}
 
-	return wiimote_cmd_write(wdata, 0xa600fe, &wmem, sizeof(wmem));
+	wiimote_cmd_write(wdata, 0xa600fe, &wmem, sizeof(wmem));
 }
 
 /* requires the cmd-mutex to be held */
-- 
2.53.0

