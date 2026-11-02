Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624930;
	b=1mGOVjqXBpHAGj+GaUC/MuKgi6IunbjZWy5CG6DtdHPjnKMHhZk2+C2lyDwhP4ij5uWa
	 O0dy3Cyt0rDK1EHKbxkIJ/zKvgNOI2br3BNYZqrcLHMr1B4n6dqAHPDGqaUo68Kmrj9Y/
	 FQ5ZL11sXALSGKkqM5AvUiCzqUovX7bFCiYI9+jF0eLj4C+YLPa71k8HPhAdQUJDvmmHO
	 BdhgEnuevTPtTpwfkP8D1hXhsclw6pNgNAWcblJO2ZUL6wCGgyL8LUIxlLk1CdY1ZZKDN
	 nxxCVVWMnuAjZvg38w/bxrnZzA9SiVWI4eHMWN/a0ijvJKgZ4Zg1uFlu70QDDQEqp/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HL+XsKXB5YzM8z1rqG2scE0MEUmB4Pwjr8ldlu8gNRA=;
	b=VjNZ/rydR/+Hvv4nO/qDhOIMNP10m3jgt3gyeaF9Bq7Dlc1kvYRaU/FJoFU3cmEUw9Ec
	 PzH2Ze8mnVaoC7LmSjBdFlwdkQcDHCGrSI0T1YkwDdRyfUkNL9qUl29Rp6BUuqHBllEbz
	 fe0ev5UNX9BXv+1iX5SQEpZeFXClS5ChX1nHOF9XPpsAel34b+j6C5QANmZZAlEDr17+9
	 BXNTtYtWyxOBSypKghZwZ8RGQwJc0WUybfU7a2054fw5PxeizAxWTDbD94LZG4rEk7V9J
	 SsUDuqXqPmlfTtIJoZbGN4Udcj3IGz/J6ij53YaieE3g1zNX4U0HksOrjMVdGVqTigg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XbsWGetg;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7C606A33C
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 13:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01A7C606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XbsWGetg
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3535a54bed9so4487830eec.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 05:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793624929; x=1794229729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HL+XsKXB5YzM8z1rqG2scE0MEUmB4Pwjr8ldlu8gNRA=;
        b=XbsWGetgfmeo7AMDc9fNFDg4AmwKw/yrJ9iTrdlAz7gsiKcMK4A7yO8bvXZ/jA63w8
         4eIjWWXACsgf7banwZHPjOL7D/zYnwn3fQo32N6YNKcJy1aSiGMeqCUnOLQ+QFV+QwhW
         mYoKy1WYy9sYOzXWSDPctygRPuD05zzyZG8Lwe2ekUdv4cWOF4tymkmjutlNW8ugoS/h
         VLxD6FMay1fu+Rd/3zrqPLn4Sg8g5AfIdyRlu611dyX+V+o30tlbii4vV57jdvF2Xv2m
         l4YYqKlKok0GMR7NaHDQBd2Vj/YBpUGHj1ACQEFKV8JKKvFEcHzZ0W9FaKmciwO1z26L
         auTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793624929; x=1794229729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HL+XsKXB5YzM8z1rqG2scE0MEUmB4Pwjr8ldlu8gNRA=;
        b=I/r91w/27ecWYLtZnLyNA1qvpH1c5TkJJ2L/TGlUhhslCvfvLPlgZDX8J/ZgUh8ItU
         w67LmT6sZif52D+3F+z/0zEtXpfTjMvPguGGM3YnP2P/+NvdVP/oj52VxQtl6YbqTUNf
         +NJD5E3z/+xz/BXCfaTrZOHlh9MMd750mxwIcDj/RPhlqTC6oEYHRGFpaPY3/VeaaoBM
         Vg8SP0xToWUFV+4ANwRWBOyMDXvAItz+KbX+SADsoppzOOxMzIy28bSCTRQr1uw8s9VI
         2K2m1EY/0P9wJJdLFknDz6J1BWgTzZCo6j3/p9lmN4GGkumZ1fN8QC+wXO0TcwTudI2e
         qhMg==
X-Gm-Message-State: APuU4Z+FJkWLRXJ9umugID4ZZ6KN7bQoFRLe5PQtIzzUdBSVCQDfZFYX
	MiIuLi6Xg7d1lATpHF9/NOiqu12m/we2XVl+euRy7vWcrxTW1/o2p2ff
X-Gm-Gg: AYBFou2Am2TtuW6p9j0+L+BSahBcjYS14sTssNes7IjNktap8J+Q8sgEtNsXqmhPQ2A
	MRGzMdZxMn7XqxzMq5BjA2DWv29NSxbRs03zasSA/XdAiB6THycydx1qfoFqOrJKMFxhLeH3T4j
	YAkYKuF14tYwpbmdAeC0PlQjRDtr6BdL1hh1beY450M2DKR5uw/YbdhrdlF8RrQ0pKVSWvm3PFQ
	XUekag4jKR54FCcEdAZ7DyYpJ1mWZE4m6a8cSubLMTh1GFFaga6w4IwbOr+3C7DF/767KYrMHK/
	haX90ScvAtH6kSXalB5oAW0oRfw4CWNMMZf80hUm+2G5Hwfme6QSkds2f/ilxzeOiNIoO66mrtK
	lFd2S5WjGd9BtSbxwlv3byB+kZQYKrOMG9ySUKS4g0Spdp2bZzudcgshcNhnLdymi8qLrc/icGo
	KDq1vEcAXan0sqEYWe/kYH8V8QGd3vaFZXTdjoY0Fqdrc87mwtwznhCz79bHIxNuIQ/2k8TPqTc
	3rmvzWrEz+wLsXCipFWjUJigmwviAcFKlQdyJtNx45dylh/mWuRYurbOPULF+DqHQup2wOA20zE
	6VynEMDuqTivwxSoUYqnPSxIQsc=
X-Received: by 2002:a05:693c:601c:b0:36a:270:ce76 with SMTP id 5a478bee46e88-36a424de9abmr16340388eec.33.1793624929009;
        Mon, 02 Nov 2026 05:08:49 -0800 (PST)
Received: from localhost ([154.21.93.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a5eee0f20sm17056520eec.17.2026.11.02.05.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:08:48 -0800 (PST)
From: Yuan Yao <yaoyuan0329os@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vishnu Sankar <vishnuocv@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuan Yao <yaoyuan0329os@gmail.com>
Subject: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device variant id 7
Date: Mon,  2 Nov 2026 21:08:36 +0800
Message-ID: <20261102130836.11863-2-yaoyuan0329os@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102130836.11863-1-yaoyuan0329os@gmail.com>
References: <20261102130836.11863-1-yaoyuan0329os@gmail.com>
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

The new ELAN trackpoint variant id 7 is found on thinkpad
X14 Gen1 laptop(Product Name: 21XMA006CD), it's now
incorrectly probed as Generic or Logitech PS/2 mouse.

Add ELAN variant id 7 to match the TP_READ_ID command
return value, probe the device as trackpoint correctly.

BEFORE:
input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input63

AFTER:
psmouse serio1: trackpoint: Elan_variant7 TrackPoint firmware: 0xa1, buttons: 3/3
input: TPPS/2 Elan_variant7 TrackPoint as /devices/platform/i8042/serio1/input/input65

Signed-off-by: Yuan Yao <yaoyuan0329os@gmail.com>
---
 drivers/input/mouse/trackpoint.c | 2 ++
 drivers/input/mouse/trackpoint.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
index 3bd8fdf56cd3..f46fc1665c96 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -25,6 +25,7 @@ static const char * const trackpoint_variants[] = {
 	[TP_VARIANT_NXP]		= "NXP",
 	[TP_VARIANT_JYT_SYNAPTICS]	= "JYT_Synaptics",
 	[TP_VARIANT_SYNAPTICS]		= "Synaptics",
+	[TP_VARIANT_ELAN_ID_7]		= "Elan_variant7"
 };
 
 /*
@@ -283,6 +284,7 @@ static int trackpoint_start_protocol(struct psmouse *psmouse,
 	case TP_VARIANT_IBM:
 	case TP_VARIANT_ALPS:
 	case TP_VARIANT_ELAN:
+	case TP_VARIANT_ELAN_ID_7:
 	case TP_VARIANT_NXP:
 	case TP_VARIANT_JYT_SYNAPTICS:
 	case TP_VARIANT_SYNAPTICS:
diff --git a/drivers/input/mouse/trackpoint.h b/drivers/input/mouse/trackpoint.h
index 3e03cdb39449..b67fc228cf3e 100644
--- a/drivers/input/mouse/trackpoint.h
+++ b/drivers/input/mouse/trackpoint.h
@@ -30,6 +30,7 @@
 #define TP_VARIANT_NXP			0x04
 #define TP_VARIANT_JYT_SYNAPTICS	0x05
 #define TP_VARIANT_SYNAPTICS		0x06
+#define TP_VARIANT_ELAN_ID_7		0x07
 
 /*
  * Commands
-- 
2.56.0

