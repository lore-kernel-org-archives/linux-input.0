Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636002;
	b=A218PObFfm/r7p5oUVEZg3diotNa1PM5L2JS/SHMkHc+TlAsvpQ6Tmaazt2jGZ0g9Hgw
	 R+srKtRLqhWGI+2qfwmtNQDDy56/d13l9zY9nJpmL9Q43pK++snovgjRJR2qSKssmWiqn
	 Q2gaOCewlcfJpxsUqORPL5bfTllG/y1LcIV7o+1ZW2B0Lj1IztaPN3ju5SK3nlfOYq1HL
	 PQRXTcs5bO84Xhc3Yf6YjcyGUh3Cv/hQ8Wh0jglexqL9HQL5W47gYknKFj2NSeqy/8a71
	 FOEVS0a0G5TcO62NGietvLyhFdiMH5FN+QXt+GVIE7mHuK9I0YlFQw5Uh8G7CxwucXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=nitv642DJIuPKcSaK1AiD/SOvyc25qlxCIBt+/0tYtI=;
	b=ihtC2YAo+5BXajqRQrcP2mW/0Md95/sxkcTZQtOs/9dc72DxTcb0700BukEElMNkzu1b
	 074pSNVqm48zgP30Pe1UXeXJN3QK34tQyojvBEnry06TdYLv163NFf5oR8AKlVQcxqAzt
	 KQUzSU6ZPvnxDeecIMlPbERECQSzmcqq141Bo48MDybKIPFu5vJLgDzbH+GLjc1qtvZEn
	 wtMF0x0ACwH7UqDu09xBtt1P6331GLkrxST9YHmBvlIVq6TDNw1NqE30WutTQK9eweZfa
	 SGg2sNnbEnS3w/rIuU6G4u7iNQ2CDI4CjH41HsPgUwlBpm9LMhjSt7UJq6pd366lPzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tz0QAjXA;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1018F606A334
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 06:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1018F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tz0QAjXA
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3791619605cso3501848eec.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 22:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794636001; x=1795240801; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nitv642DJIuPKcSaK1AiD/SOvyc25qlxCIBt+/0tYtI=;
        b=tz0QAjXAf1Cc2MKwU31CKxEfqGZtKCSRW6xsbROQULBVyz+kyY+hS+d48ZfMPnZGT3
         EXOO6qfV8SFS/YJXx2PkxyDKoaaXUK0RNSuH59qXR6BjYdaG+Rl5THkDj9KGr6j5ng0M
         sdt6TIG3DuX08xc+7XQXedXZZpaJV0nNFAtA3IiTZz+ecmLNva2decH7FQqza9yCMqYJ
         3vQvmaZEDJfC+yGobQr5n1lu5BDLPCyFKgpLfi+r71i3JDTMgVYlEGn/1VT2UgNJFFzi
         K56Lve6mXHsanyxWMadPOovdPC8M0CU4IIIsQLL8lW8Q6n8AoJE7N4V5q9oZy+T5rwmn
         K4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794636001; x=1795240801;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nitv642DJIuPKcSaK1AiD/SOvyc25qlxCIBt+/0tYtI=;
        b=dbPzWK9GmXyq/dFziMsSvgeXwpMTzegODcmpMzO+jzfQjCBUGCwJrygkJugjuMRCw5
         zNWeJb/4j9RmqceIur28ay6IG1T0gWh+NgxOe5skltHKacqLk06HiT3pgZW/bHyVU0SA
         /9XE9onM9V//WRSmAqNBxw6EUGTuW3sdoIDobS50ZZ3M3hols78PNs2dMhW/Rk/arin6
         /2xYVSQlvV5GVW7FyWyHxL/nCgjBoQHdws7PpBFpEC+QKhHlsRgkNyEPbsDoEK1A9Stc
         NLsSywtmEzc3a57905Zw5+qB2GpDz+AX5nl0NapQ+jdNGYJ+dbHTowlrqzpYUCT7kFc1
         t3IQ==
X-Gm-Message-State: APuU4Z9toXK3jcSqJsVW4pXJ2zeg5Egqxih6p+WsEtBD05gXtd7b8ziE
	DHDPRul2IIZNxi0+8tUV6lEWpnlbaXIMymOUUOd7/5FslxU9Fb20n5Bx
X-Gm-Gg: AYBFou3ooO6QRXAlBL+HuImFrpemm4oSbKov7QS5xcF3p/oRIEWuv7GwN91zddu1nVX
	3gZCKomnTKl3mTwaSt79U6INVf6cuNHDLJRUBYePbidTygUGLX0e5Mk3eUiScid+Oxfh/48uZpa
	p2KTVfaz8o1EK/ZQbtaq4kvZe2/vsvzQ9EAiqOrdm9ndd/Wlv9E8lu+9lyZKmsx/QGJaYl9Oy+f
	9/QayonE5+6bSqJui0lg83neXEp1TQHk2Ma+1Zv/k0u4MfvJpaHYV8GLdp/jESnqzWYgV3daa1l
	LO/i1LJWPngxwC8fyI7jfv8KPKDn5IsIkprVWPI+Xg2tige86jp8LyMKtwrJ1udgZKqkQvy98C/
	ej5Xog76E9W+GeRZdRccdSn3OfyXCFKY+KW0bjwRnbxy3DEJ1SqQIGXZ+9gFjDFQ2P5lOVjRFL8
	xz+4MjDgsTewDcrr25I4IchGSDLyf4CiIi7Wjhz/s8q4OioniT4oOb9pHcrBp8odvSNDI6VAl0d
	OYO94im6ubbzwszA/LiLInA48Ap7xR6SCT3lQ64ocyZ3n3hbvkVlrCxGkT9x989Gk40uuWzmzOE
	+KwNwRgT1HbWmCEXnjrLj0XG/fPMry+qp55QGCCT2Ki1H8BT+1pCSPFJol5VFZ3HZfBoEvc5YVe
	1KBCnN/4gGQUrVl7s
X-Received: by 2002:a05:7022:3a85:b0:185:fd0c:4585 with SMTP id a92af1059eb24-1b50312b3b0mr4578152c88.33.1794636000901;
        Fri, 13 Nov 2026 22:00:00 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:560:7267:5908:e9a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm11323590c88.13.2026.11.13.21.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:00:00 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 00/12] HID: rmi: Fix report handling, device lifecycle, and
 clean up code
Date: Fri, 13 Nov 2026 21:59:50 -0800
Message-Id: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIANb492oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyND3YzMFN2i3EzdJAsLk0Qj0zTjxBRDJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tAIratKlrAAAA
X-Change-ID: 20261021-hid-rmi-b884a25f3ad1
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

This series fixes several report handling and device lifecycle bugs in
hid-rmi: it treats short output report writes as errors, limits trailing
0xff stripping to attention reports so register read replies are not
truncated, and validates read data report and transfer length bounds. It
also gates reset work and power management callbacks on device start and
suspend state, re-selects page 0 across resets, avoids GFP_ATOMIC
allocations with hard IRQs disabled, and stops modifying the shared
platform data template during probe.

The rest of the series switches output report packing to unaligned
accessors, uses scope-based cleanup for the mode buffer and page mutex,
drops dead code, and cleans up coding style and logging.

Jiri, Benjamin, could this series go through the input tree once
reviewed, as I have follow-up RMI4 core changes that depend on it? Also,
would it make sense to move hid-rmi to drivers/input/rmi4/ alongside the
rest of the RMI4 transport drivers?

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (12):
      HID: rmi: return error on short output report writes
      HID: rmi: only strip trailing 0xff bytes from attention reports
      HID: rmi: validate read data report and protocol transfer bounds
      HID: rmi: fix device lifecycle, suspend, and reset work handling
      HID: rmi: re-select page 0 across device resets
      HID: rmi: avoid GFP_ATOMIC allocation with hard IRQs disabled
      HID: rmi: do not mutate shared platform data template
      HID: rmi: use put_unaligned_le16() to populate output reports
      HID: rmi: use scope-based cleanup for mode feature buffer
      HID: rmi: switch to scoped mutex guards
      HID: rmi: remove dead code and reorder report write helper
      HID: rmi: clean up coding style and logging

 drivers/hid/hid-rmi.c | 506 +++++++++++++++++++++++++-------------------------
 1 file changed, 252 insertions(+), 254 deletions(-)
---
base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
change-id: 20261021-hid-rmi-b884a25f3ad1

Thanks.

-- 
Dmitry

