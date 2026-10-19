Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436493;
	b=AsJDB8oxLY3Ca1Caq5cG4sMFze4SkgPA0zgk7KEhv+FcF2ZZC4CnVjVUiP/rcp4MAgo9
	 5x0wHhxykmmrajGusAZuoxR5jfHdkArhilprureYIGME7ee43RK5KEsW5haLo0uqu6Yrs
	 RsSMCzKLlRymqjMb9DhG0XXWMd6Mdz2p9X7MS/138leJ2TCkGq5HjxGclbMic7pfjuywD
	 2tSbMzB6Lag9YSLqHmkY20DNx5omksxqVFQMp/mBUfss5wVN2nzuZIfg8UjD6lpeA0hHg
	 pz814KtUB5laPE2/9GocPas7xxoa5RogzQ376p9z7vDl9tUUD+OB9zJa3y6iXLaOb2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=FaY9xBH+ODoyMqXQ5rD2hltdyGJo1APi4ZaZtmkclWE=;
	b=ffDdHMew1mlaCk4rBpQ0WVv0YtQJ73zP4XYEleF9tRTpbFHiQ4YUHlEcDgSsc5dkugF5
	 6z5czSTnQl3Kv/y6DTVY6Muo2cYcFihGE9dy7zgMwwbyWENWHMGonRpj45u4dMSqOvgWg
	 felYQwJ1iE4qubd85xqSo6RSHoEMHQSoCg2NNJ39YCPIXEfuMc6q+HPXpGhWQzqojYRvM
	 UcIhGAvuZV4pPVouvkM9S8bLpbSJdt7Er4s3tqwBKyix9hP0mo1fflBp2e4UE+vYy+Fe2
	 QeOwcCwSTB0WpZJIj77UlidgW2Dp23N/KTyPxtP1gOh+T9R5ujjHmWCDs5IZwfFO3cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BQq+KE8x;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA5606A33B
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 19:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CEA5606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BQq+KE8x
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e985106c0cso16436975ad.2
        for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792436493; x=1793041293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FaY9xBH+ODoyMqXQ5rD2hltdyGJo1APi4ZaZtmkclWE=;
        b=BQq+KE8xOXbY/uqMBJRUuuiRWixMIYgasL2Q6oCe08KuYbbGLBcRh24ixnfWFYSdS+
         dCiH4G1K7vTp7FQiasyc/3m9GP5veIG+hi/bMw6XJT9kgi/wSJmKm372tZ0JKJdfCLaH
         7FoNQeI1qbJzVaYfIhpmC+tqgs9LZRyoUr7go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436493; x=1793041293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FaY9xBH+ODoyMqXQ5rD2hltdyGJo1APi4ZaZtmkclWE=;
        b=RxHwf05rGKsjBzsBBMRr5hhIT9Z5Vx9pAxOtTe5HyouIJCSeXdzQq78g9fOKkQ0tMY
         TbE0X2KyxN1TG9F5NGojTK34Ixxit/0zVR+l0Kww0t2WYzzV40Rm+zI3GbEnbK/c2x/4
         set7ip/6FjIUtceK6fpL6NO7RYxRC/JwAsbbCYQ09s4YAPF43o1MhaRTFc1d3U5TVgsi
         i+vUCMR+3RUmaXT7+ETB/+X92AMiBJwQvk9xWkf7wn7pyxlUbqxLhKiqKLNUWQLlhQjp
         /MUHz1W5LPXnYdNgdeTeBHvIQ3m7pfJdu+Ub0tx+nNdEAezs/mz8YlWHKzn2E/v+o0IF
         XauA==
X-Gm-Message-State: AFq9FYLmFj8wrfdltj1XJNDe2dgSoz6pzHhNmZMRjLKGGvfhiiH/nBsr
	8ZSz4ITCaLf3DaAce6HPrc0pD0ZsZUPTJvrozMWmkwjZv1eUSL9cwTgKYBDUT1ypug==
X-Gm-Gg: AYBFou08SDmO8tK9EnB0uFco1ldTvoztEiIJHgniFCdhHuSXg/cK65yZgCRpCsL8sNe
	wLo+TISpyR/0Oollz3iVanJA0UjSskvJWFS3lBpEsJeZBvIcp224rpyjZhlfxljAWSXOPmBnHIn
	dGI92fcpx6+RhhK+q1z+f9j/VyleHQRafgCeNyCGk0rwoRt1cTwbIp29uL0HUlD2YyxRnLwtbvh
	9AjCqz/8FAb/x2ymGtbaAsfDbAsKedU0DKnH0Uptz5/kZ6y+/o2oRpkc55PgXYrhzOGXo7p1IYA
	Dn/OlRj33L95cZJQL7iNRQQ2xMd+RpDTyOovVGeqR0/3dMLvtRfQYuE41xDJzpb0EKHIXlannLD
	bcQ99arhZ3q/o/VK4RTadxeiDjBTp3lkN9AskOMed0rJeUCd3pIIaycQB5D1gL4mG0UspO0JFL/
	PWsD/8RUSl0FGmUmx+HMJW5U8atICKFG5hNgshHhEcMDPtErlmC34rTMGsNczaaE74//u6QeB6e
	7cOwfE9Ck3Unccrt6N6c6421Fpi+eZpHWRSA4YthXKfLmF2IOnrK8SL69sla7paSTxwu5wxHyz+
	SIPocg==
X-Received: by 2002:a17:903:283:b0:2df:90d4:1193 with SMTP id d9443c01a7336-2e9a704f530mr82162035ad.45.1792436491907;
        Mon, 19 Oct 2026 12:01:31 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151e1b7esm4473105ad.75.2026.10.19.12.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:01:31 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Mon, 19 Oct 2026 19:01:14 +0000
Subject: [PATCH v6 02/11] HID: Add BUS_SPI support and define
 HID_SPI_DEVICE macro
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
Message-Id: <20261019-send-upstream-v6-2-cb9ba4b3d6fa@chromium.org>
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
In-Reply-To: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792436487; l=1445;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=Z/2OynYTrncR3whlCD+8cLrRCycyd9G1cnZSFD18TV4=;
 b=lJc8V8Nqjo1jioaiCACjgd6Onu1pi3IF5K3H7O9O0Ysv6de+/D34pDGq9QMvDw8mebB528I80
 2kaE6ZZjzlGBGFbwmdNzil47p34PVsQJh7RrChGNGuNtij++kwe8mZX
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

If connecting a hid_device with bus field indicating BUS_SPI print out
"SPI" in the debug print.

Macro sets the bus field to BUS_SPI and uses arguments to set vendor
product fields.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/hid-core.c | 3 +++
 include/linux/hid.h    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a3ff0514f9cd..1b9dbb7515ad 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2373,6 +2373,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 	case BUS_I2C:
 		bus = "I2C";
 		break;
+	case BUS_SPI:
+		bus = "SPI";
+		break;
 	case BUS_SDW:
 		bus = "SOUNDWIRE";
 		break;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8d17b741638c..45f713fe9982 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -821,6 +821,8 @@ struct hid_descriptor {
 	.bus = BUS_BLUETOOTH, .vendor = (ven), .product = (prod)
 #define HID_I2C_DEVICE(ven, prod)				\
 	.bus = BUS_I2C, .vendor = (ven), .product = (prod)
+#define HID_SPI_DEVICE(ven, prod)				\
+	.bus = BUS_SPI, .vendor = (ven), .product = (prod)
 
 #define HID_REPORT_ID(rep) \
 	.report_type = (rep)

-- 
2.56.0.212.g129ede20d9-goog

