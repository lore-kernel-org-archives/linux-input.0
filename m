Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681234;
	b=SrovdGJA5On7SLOmB7myboLg2tbRJQ9BhQR2Vwm1sXie3jRE9Y67AIxs08Zo2kMNAOPG
	 9qP4wVR2af0iD7sN526Bo70V2ITkwVZPGCqe5gVWojKSjxpi2sjhwQIjMCrva+/Co1YK0
	 tHd7u3JQyq7oO/mLEh0oZRHzC972leiS943ZVaZ3W8ZrUPYD+oScF6v/rMWfaZI9yggeE
	 P8mUGAXwGRrB5ep7K+iP83NnWAoXmYOHdv5E36JXb7FkWyJ7y3k71x6UqpwAIiFzMAgmf
	 8tZ842/OnClRqvtcxEzUHtrfB1YU/AVRprZCsrM65U1/va+WHtajvXr0PMlLQjqUK0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TcyaLHkkCUFFThAgS7XPoF0D4DJks2eSDppGrJXvVV8=;
	b=YxEeo9wXfOcInUedGZLHJgnYcOovGtXdOILmIcv3m9kwyWMwmK3xZ+zbeQgJayN++1h9
	 4LB4P8Nu1vxbMb0APng648aGAC6LC4NC+x1bxNlqSWCEKcx3QITrs4scMcTbVG3auiaoU
	 PpRjR86kWrFElM9bVFJ26MdhjU2gQjDoPMub0IfDmnCwsDQgBr7SnsdefLCE0Jhqu1Ltk
	 8QzWvynH887h36ED7dzMrxTBXkCXxYIb7CKZ+Qn+HkGTuWPzJBsBOuBf95blSWFwKlwNg
	 K588gO1JKXAi/k/7yV498LYU2JvYh6py+7JsXgfSQiy80grWAp0FfPrlkDIyOIU0Ofg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uWKNb4zQ;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D017606A327
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 04:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D017606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uWKNb4zQ
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3514b90bb89so7794373eec.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 20:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793681233; x=1794286033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TcyaLHkkCUFFThAgS7XPoF0D4DJks2eSDppGrJXvVV8=;
        b=uWKNb4zQkfQnVtQVQO3HN7YYB7/LcN7F+L5w+WX7HUn2IG/VU4h3eOA6FtdooO6iFJ
         YFHyUO0MTH+CaGkUnJScBTg7eWwCWr/rWbiL1TFdpK+dwksmNFE7D6m1+W17e3EjSwKi
         /b6iNt8tCpFlEWxrlo/TZ+JAj85Q46opq3z3Y/D90ves7yISmd/InusNQqaEnD+WOJ5i
         MDjtYO+RnolVs6INGc/fAW+dV+LfrmfZwvrTCT48jgowjir6FLBexDGq5Q540ImRBRSa
         koLAZdeTEuiSd3Mae6Tt6dAkVrsm+yq1cCtwi+p9lhVOczHcB3lZ1LEUG+X27Q6l65Ar
         7Eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793681233; x=1794286033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TcyaLHkkCUFFThAgS7XPoF0D4DJks2eSDppGrJXvVV8=;
        b=PgFonSeEzZbqzQ3tFioIomvGjvxZS49Mvpo/h7OgXMrKrEyVUB1s6ADwUF2091F9E8
         mLwrmPh0oU/0RtLxiLHjs5ZeIFsEOhmDeu3y/DtwqwRby0dVzBxWTVJ8Yw5ct0tl5jyS
         6GAWynUAETLvztwtllqWmgyPHLKFKxsYx1XoLwYZl8cyA5nl/yCEICk/4DCRtX7s8Rdl
         fCm6w4lxnBoQAEodh0U/PAx0rEAhTzfNnqJ3uzTm+/yGvUx1lBQzw2jUgt9FHZeqzCDu
         1TWVgJybOVZczQAZeAUL/13TJYvUM9o8p7U79AvNtRUwg2bsTXiEQk1LxqeWhqX5eZ/5
         /FtA==
X-Forwarded-Encrypted: i=1; AKwUvBxpkaYQZOyIRRnBVR+6t5kibLLAPYFHFZraJGC+oKFw2OJt36VOmbLG0QcQmCa4woc1pGM9xvpyuSqpFw==@vger.kernel.org
X-Gm-Message-State: AFq9FYK1R1hQEfJI7b6cpA373c18u3I93vCMIcQWBFk9jsFL0t6GErsJ
	OShe2G4AYEXnoV+z3RqsoyV27jd3VVVSI+hvbldwk6FB920d3mZs+auy
X-Gm-Gg: AYBFou0Uws9NfczaAGNudUSf0umywQp5pqBaDu8lZbY4dV1bAB0plPjh05fH8KPwyL1
	MwgAKLtuSXYBYJVp8oJRodeNaJ0mepDrXZXPfh+6laRJfQKo5TMPhE+VnOgC35lbR0ykQEtv/AX
	vjWeuy4t+mcNO3ipxDefgTvkAC9fsH3/B/fO1XNvVNOUK3NixmgWQ9EWu3R++wqUFxireDjVoKe
	aABuMU37S0gQJDS4+tulkbtjd2Q7c1aiam3jkpdKpaiRaSSNBxjbKwCSI9VDjyX+Vt3khlYH/XE
	Rc2HsE2osK5sNV+6/kXbaPbbIEugREyVI3c+ZnnplHEv++P/V+/iYWJpSposZiEO0feh+dC4pme
	Wry09nL+8qVOPdenAXVFQtTYwW7YN3GQExEUvCs4fTLPULsXqLyG8N6ilzYIpLrWYMRFPWxIrxR
	YQ60xA4bTmp+REXv3q6KSFNd4yBirVkIddgzcdbRau3H79HHHfBF6c89WLEQCUux6bPagRSDWh9
	HvkEWaSwOUD9SA4O43nQ6Lfrikcd6yTe5/njFuyKJplvV2MN2xU6Wvx8IdIcsY6t4cc6DUGVxec
	NbCBIJ2xqxeLqvOSjJkomiLKDFqLanAWyJxJdeVlQSW8AbZS3Ubmwsj99ju36YNbr8C34sCQTcg
	6hUsR/uqbNqIm7CxvMgGdBo7DEnEETWsuMQW/JA==
X-Received: by 2002:a05:7300:7a83:b0:35e:2c6:d46c with SMTP id 5a478bee46e88-36a42362460mr17331914eec.10.1793681233040;
        Mon, 02 Nov 2026 20:47:13 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:98f:6bcd:858b:7a64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm48385807eec.11.2026.11.02.20.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:47:12 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	David Heidelberg <david@ixit.cz>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Val Packett <val@packett.cool>,
	Hendrik Noack <hendrik-noack@gmx.de>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Jeff LaBundy <jeff@labundy.com>,
	linux-input@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Input: touchscreen - parse touchscreen-x-mm and touchscreen-y-mm properties
Date: Mon,  2 Nov 2026 20:47:03 -0800
Message-ID: <20261103044708.2461481-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
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

The common touchscreen device tree binding documents touchscreen-x-mm
and touchscreen-y-mm to specify the physical dimensions of the touch
surface, which userspace uses via axis resolution (units/mm) for gesture
scaling and palm rejection. However, touchscreen_parse_properties() has
not been parsing these properties.

This series teaches touchscreen_parse_properties() to read
touchscreen-x-mm and touchscreen-y-mm and calculate the corresponding X
and Y axis resolutions from the configured axis ranges, accompanied by
KUnit tests.

It also updates wacom_w9000 to drop its manual parsing of these
properties, and adjusts goodix-berlin and apple_z2 to set their fallback
resolutions before calling touchscreen_parse_properties() so firmware-
provided dimensions can override the defaults instead of being
clobbered.

Dmitry Torokhov (4):
  Input: touchscreen - parse touchscreen-x-mm and touchscreen-y-mm
  Input: wacom_w9000 - rely on touchscreen_parse_properties() for
    resolution
  Input: goodix-berlin - set default resolution before parsing
    properties
  Input: apple_z2 - set default resolution before parsing properties

 drivers/input/tests/Makefile                  |   1 +
 drivers/input/tests/touchscreen_test.c        | 209 ++++++++++++++++++
 drivers/input/touchscreen.c                   |  18 +-
 drivers/input/touchscreen/apple_z2.c          |   2 +-
 .../input/touchscreen/goodix_berlin_core.c    |   4 +-
 drivers/input/touchscreen/wacom_w9000.c       |  10 -
 6 files changed, 226 insertions(+), 18 deletions(-)
 create mode 100644 drivers/input/tests/touchscreen_test.c

-- 
2.56.0.385.gac671c819a-goog

