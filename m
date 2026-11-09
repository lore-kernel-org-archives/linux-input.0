Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219703;
	b=CTTp0SgUsuAIuOJDqPcnoRSKBO57eGZPAygX550XTFp6+qT9tyUiDuBvTYG01+gRbtEs
	 p4VyEsCKIsDcGFGksKsmFVm5tQPhKlXvzzZC4QTHWzpklQEdj4GpArw8f6P0UcbpQniBl
	 0ISRpf/AGwNpynAXzP9bzgqb+EOsxnzrWRMTOYuXMnAEYiJUjysqzgjmEQZUu7mvYGJSl
	 sYl5PYgLQL/y4/Xkdng4JMPGiCd5qDvqhobBl9PjFOTBTwkgtnH1w62ew0clpMo2pGmcZ
	 L5ADOLpiHiaBglgxY9FVriC3r7q74R33Cktl57XHGqQGdcUTLAI6w8nkk9tQAsW8j5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219703;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B+RSLJ75mRpzQv9+fNleUkQU4c8JN8vTMlHhykHdm54=;
	b=WdO+C9NsUqGwWJfhT4xpBTgpnvleMdYB3ZrnoP1v8LUQEwXVyAkNhiKGVhLB8zdwytCn
	 VpzIOZW9z/Y+cCl3mAwNWVvAmpmhvzWKNpx1hyVcZ++oaEJ9Hqqu7jVAZB/vMD6a/lRvT
	 RPx0pvj52YdjosNdBvu395CZQopU7K1yZF5GSnfZWcCtMXSy/MzOZ6baJ2s3pvWnYy1OX
	 ITLBvvswmPavFO21Pm0ZWuEK0hQFJi6/bTdy49jlUPgqGKImAOpnTRSlN+nvEY5NbkiPo
	 XfDueh6S+1Guxa+cKcxtgKF764m8YSozwSFyZjMbSRhjeLU51+JW1Yb6doCx0yW6uHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lasmh0iP;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D02606A31C
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 10:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40D02606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lasmh0iP
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490f38e9688so536180f8f.0
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 02:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794219701; x=1794824501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B+RSLJ75mRpzQv9+fNleUkQU4c8JN8vTMlHhykHdm54=;
        b=Lasmh0iPZuAacL7/qPnSPWvgAHBmpyL1gvQ5O7MbccmGixGoVMlE68sm6qeRwq6O6n
         DT/aN+2BBCQ+Gi5PZWUwNwz36bfFs4nNWRY1JmkAhHmeAms3KuevnF2tmqFql9nh1cEQ
         ycgJhm9/Jd8pW8ZJzNalFTyxrkCzFNn2fqL4IUGHbijsshSoioGvUN2bY+58Pp49atLk
         sHR7ckDXXZR7+g+nVYYotHritBwoCKG8CO/tEYT+pPcENFnGl3zBFA9f5TRx0ARe7YMV
         372bcED+cZF7Dtu+1Onye8qdqSsJk41JpsZ5WU0H8eyU6rGc4MvB/Hu1ACTwSTXfBCrq
         2Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794219701; x=1794824501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B+RSLJ75mRpzQv9+fNleUkQU4c8JN8vTMlHhykHdm54=;
        b=NrUd6ri0p4pEzk5XnJcOLG1nY5AXCs1MrsPy0fe+UtzxPqTnLz8el2wWmXkOmO8ulr
         TzYGNljcU0EJMz+V5ITDmMcQePK0ne3Fuvio1LT+concao8koh3VEQjORN4+Bmv0dsHN
         ikKYlLN4+TYB1dyG44uM4R3bHfQng1/55g+LsYlaOR2GDnWni5tqxKXap6B9SFj/XagE
         2xGniOPcKntDWpKaniPqtK5cld+phGhn/Fn8AsaWuDS/nLSDyhphByP6ksMUExgkainK
         PsT+CF6kGXMj76Cq65dC6EArNT3Cuq9/7mdPcLzm3u2ztzcTV1NibH6cLvWHJJwwY6jV
         nX5A==
X-Gm-Message-State: APuU4Z8g0NZB0vk9QOnubTqD2QmWwadKylkM6r2VR/tWfetdU/lAmwiz
	htrfhDnlUdWNRGWEkZw1tV77WIVKHPXbIsaMuZAXSNzeXpuRuX5skqxKHwbJCYpb
X-Gm-Gg: AYBFou2PC9UiFzdvG0QZuBvcni6fEa3CsKjXkXPhcKGug0MX3+hkEzxlltsNYM1S9Ij
	S95kV6pCLAz2gs5M/jbsA8ygj0Rkr/q5EScZtZn0xZNnSlSwUYmwUrDA4aSfvBKik9X+sR2vKmk
	IxjBiDYcs2fxuD2T+ItUW1NaBE2ROksdfc4FiQroPOtr9g3R6yIteCSRAwZP/KWDx7fsnrD+lqe
	JWsgfPql09oHU2kV1GC9QL4q9r5/krsayVRVpxvcadaaul8RVKs1fVt0kW5b1tUikZ+hgIEHweb
	NsU+Fwbm07+1egWFUATmyj9r/31ezNTELlias1F5cIOOx9rlCSMAkC2zBzENtOceDvI3XVR6Omc
	DpoMpLNYnTNqU2+XvhPm3DnheeFDyjjjiJu7n0eLwwoUvF8BADOjtBx/GObRoTOB6eeTqZ1MO+8
	wQogiwJMiCjFcDyMDgm9+WrVHCdT5DUUskg50O+gPPbcRQGCEWSeWZULmynYhWjWWoH5SrAMOUv
	yn9oYuzPDKLQ85y2hCzd94efqB8haAfB090b8N0IA9pr3wD5QMVChyu5BUGuPnhudlmWaE1jKcm
	+f0WnL7EioT6SMDGPqpJrM0jSY4swbhjc957Gch3SbR8PHUyeQ07U6eyH/up4qvxO3uN3NzKSg=
	=
X-Received: by 2002:a05:6000:41d3:b0:491:eb12:e151 with SMTP id ffacd0b85a97d-4941f5733a1mr11983875f8f.4.1794219701331;
        Mon, 09 Nov 2026 02:21:41 -0800 (PST)
Received: from acer-gaming (121.red-88-28-14.dynamicip.rima-tde.net. [88.28.14.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39899sm8247794f8f.3.2026.11.09.02.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:21:40 -0800 (PST)
From: Juan Parrado <jparrado.1817@gmail.com>
X-Google-Original-From: Juan Parrado <jparrado1817@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	Juan Parrado <jparrado1817@gmail.com>
Subject: [PATCH v2] xpad.c: Add support for Hyperkin Xenon, Hori Taiko Controller DX, and 8BitDo M30
Date: Mon,  9 Nov 2026 11:21:27 +0100
Message-ID: <20261109102127.9417-1-jparrado1817@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <avFwGwoJ45RGvxRH@google.com>
References: <avFwGwoJ45RGvxRH@google.com>
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

Add specific support to various controllers:
- HORI Taiko Controller DX
- 8BitDo M30 Wired Controller for Xbox
- Hyperkin Xenon Controller

v2: Fixed format

Signed-off-by: Juan Parrado <jparrado1817@gmail.com>
---
 drivers/input/joystick/xpad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 810e52782..be81990ce 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -259,6 +259,7 @@ static const struct xpad_device {
 	{ 0x0f0d, 0x00dc, "HORIPAD FPS for Nintendo Switch", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0f0d, 0x0151, "Hori Racing Wheel Overdrive for Xbox Series X", 0, XTYPE_XBOXONE },
 	{ 0x0f0d, 0x0152, "Hori Racing Wheel Overdrive for Xbox Series X", 0, XTYPE_XBOXONE },
+	{ 0x0f0d, 0x01b1, "HORI Taiko Controller DX", 0, XTYPE_XBOX360 },
 	{ 0x0f0d, 0x01b2, "HORI Taiko No Tatsujin Drum Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x0f30, 0x010b, "Philips Recoil", 0, XTYPE_XBOX },
 	{ 0x0f30, 0x0202, "Joytech Advanced Controller", 0, XTYPE_XBOX },
@@ -380,6 +381,7 @@ static const struct xpad_device {
 	{ 0x294b, 0x3404, "Snakebyte GAMEPAD RGB X", 0, XTYPE_XBOXONE },
 	{ 0x2993, 0x2001, "TECNO Pocket Go", 0, XTYPE_XBOX360 },
 	{ 0x2dc8, 0x2000, "8BitDo Pro 2 Wired Controller fox Xbox", 0, XTYPE_XBOXONE },
+	{ 0x2dc8, 0x200a, "8BitDo M30 Wired Controller for Xbox", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x2dc8, 0x200f, "8BitDo Ultimate 3-mode Controller for Xbox", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x2dc8, 0x201e, "8BitDo Pro 2 Wired Controller for Xbox", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x2dc8, 0x3106, "8BitDo Ultimate Wireless / Pro 2 Wired Controller", 0, XTYPE_XBOX360 },
@@ -389,6 +391,7 @@ static const struct xpad_device {
 	{ 0x2dc8, 0x6001, "8BitDo SN30 Pro", 0, XTYPE_XBOX360 },
 	{ 0x2e24, 0x0423, "Hyperkin DuchesS Xbox One pad", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x2e24, 0x0652, "Hyperkin Duke X-Box One pad", 0, XTYPE_XBOXONE },
+	{ 0x2e24, 0x072e, "Hyperkin Xenon Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x2e24, 0x1688, "Hyperkin X91 X-Box One pad", 0, XTYPE_XBOXONE },
 	{ 0x2e95, 0x0504, "SCUF Gaming Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x31e3, 0x1100, "Wooting One", 0, XTYPE_XBOX360 },
-- 
2.56.0

