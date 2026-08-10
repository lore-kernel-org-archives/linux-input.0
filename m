Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A13A442FCA
	for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786395404; cv=none; b=Q8Xh1N06k6raRBDPrN6ftD3qYCZnA3Xlos08QInd7ehyg3yUTIIWWieu1VJu01eTFAxZdfFfSqzvtA4sn7uzZFRXjxya3w9Mx6FLtJGish0EftwWDOYD1dkuLFDbLOgPTeFWsMCJ4amfWTU5TxCuIKU0r7gnbIlyL5sVP1vwu/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786395404; c=relaxed/simple;
	bh=sk/fuLEHM2sShww709RnR6w+4evX+CynIHQsezCGfPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGx8mbT1U31qN5gPkNBhaHqG+4DDKiwOV1xkQAv+772NzMEwkpMVq7F10nroT5NC8ayVjiLmJI+NDfNhjIjXvA3KQDzcCx8Xz5VTCfgOVRV0wB3eXdg95BrVkU/VCms0rWoRs9ukpyZ/kfr0mvzbWjSm92NMLWmC3p51+vYaKj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7kRbnbt; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7kRbnbt"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso3218429a12.0
        for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 13:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786395401; x=1787000201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lKsxTzH21DgUBKx7bOD+M/xNsOvOGRSp55gh8Kt9+ZY=;
        b=k7kRbnbtFAuQjJHVLZj5oobOuDgS/riAVH6t1xWmEF7bgxn67zC015672mWOlPluXs
         3ARY1px4ktlHF5a5Lu8gJxqSVNe2Kz4yNYrkXzqjCfuKh0dhBKDK+jL/e+u7d8k87Hds
         Iy/+LfWKIgWCm8QjwUuiaWLfRFqbwGxtrn+an1a4dVV4rOPOrxYtHrOeSJY1m87il/oU
         usPboVq2L6jkCZcQPMIhqUwJIvbOL5aQLXRyjSl3H00gm5e7Vr87wjBk3lZqrSW6MFTB
         EYLeLR0A/YCdKPdViIdZ6us7PiW8RgvhS+YeX2rxIxhuIPS7tKU4JGhFcNBoeNcnZPLg
         LOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786395401; x=1787000201;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lKsxTzH21DgUBKx7bOD+M/xNsOvOGRSp55gh8Kt9+ZY=;
        b=OFzkeZxfzBpAIodle/GZw7MdLO1HKneBSiek9+rNQVLpur8ZbpRGYkL5u0Rhkiib4i
         tBmKuRVJhzvr9nbStHz6IhGUArWNXwgrWvCCWFOIbqaZOL7KWRCgPqw3Vi8Epkjwos76
         j1vzznk2RIAW4qB5+w3Mbd5B9kckxuW2xTkesIsujPtF3Tsafps9M/3CXZjCOx7aPtOq
         Pc37lugURoH5If/dgNrZpz3lL0KqyBPTMT5mP3VXfZSFIsoEDFq9sDV34H868zQsiuNG
         Lj+Yo4g74ez9iO92NX8adaEgbOOvpQ063ikJbApVqYHeSHk9Ju3Hq2NB1dEysg+DReKT
         5XYw==
X-Forwarded-Encrypted: i=1; AHgh+Rr8IXLO0B6UmU2D9EeS836MxAP/hNgn00wSW11ThT6NiKxoFrnGVqG+AolBlmRb8iWUe61usQuD7nCH5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJCvaQQIGSMcpHkzbrRgLFOab56jzCS0kmY10WcO6FVuYqpf+h
	3XxluVQdrhk9NAYlqIwja7p9S5vyEk/a96WjJs6uDFS2HnmuqCVJ2gLw
X-Gm-Gg: AR+sD13HxO8PG1X+J4G6Euk3YEWUse+fs9g/dKEhT+ON5hhZWeVkv70ltce1rn74Ey2
	l7D9aOT6w1olQ8hUyirWw0exGQaSBNTk64UHrYHTJPXBwrFmFTHH4ldVdZ0XZkUok4rcETODeOo
	bRhGWqG7eTml1GM/DdIVw4aTU+JISi3RnNgyGiLP1c+fPaNeay/b0vSjRgIAw5odtOQsctPTjDj
	pmM0PrcbNnECh9v7xOVQmk5RY5Ojd7GcBUK9dCyPebepnUowxYCwouqamjwdNnWV3bHy5Rqpsjn
	Nj5fvk747ZG1atJuJIOB44cNrpyRJOlMWuaXrTMM9CdGWa+6y3s88+lj2GoQxFC4XYmIWmuBB2y
	zNJFOLPmw/Stb0u3j5v5NkaU+0DZOp0f+xo8cPi/TXvqLQud5+0DI3486OghMsod+VzSATgVeGJ
	EKQGWoZGQZPvHV4kXwJ73e9l52/3RA30L7wHp3vCgomVtn4Bkp1E4O4SR4HbBR3VxU+Q9mSAZB+
	Uu4yns2tWALHvESvDPR
X-Received: by 2002:a05:6402:538d:b0:6a1:333f:dc8c with SMTP id 4fb4d7f45d1cf-6a1f2f5da9dmr11524539a12.20.1786395401071;
        Mon, 10 Aug 2026 13:56:41 -0700 (PDT)
Received: from fedora (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7c9d912sm4450986a12.2.2026.08.10.13.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 13:56:39 -0700 (PDT)
From: =?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	k8ie@mcld.eu,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
Subject: [PATCH v3 0/1] HID: logitech: add Bolt receiver support for Logitech HID++ devices
Date: Mon, 10 Aug 2026 22:56:33 +0200
Message-ID: <20260810205634.209099-1-erikhakan@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <f44b06b1-e1fd-4d96-9728-4567fe62c501@gmail.com>
References: <f44b06b1-e1fd-4d96-9728-4567fe62c501@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds Logitech Bolt receiver support for Logitech HID++
devices so Bolt-connected HID++ peripherals can expose battery
information through the kernel power_supply path with the correct device
model.

Changes in v2:
- Handle only the Bolt receiver/control interface in hid-logitech-dj and
  leave the other Bolt receiver interfaces to generic HID handling.
- Handle Bolt HID++ unpair notifications so child HID devices are removed
  after unpairing.

These fixes were based on issues reported by Kateřina Medvědová.
Link: https://lore.kernel.org/linux-input/345f7347-30a8-4568-a7a6-c70f54a52a8d@mcld.eu/

Changes in v3:
- Handle HIDPP_ERROR_CONNECT_FAIL like other disconnected-device errors
  when retrieving the protocol version to avoid protocol error messages
  when a Bolt device powers off.

Thanks to Kateřina Medvědová for testing v1 on additional Bolt hardware
and identifying that Bolt interfaces 0 and 1 must remain handled by the
generic HID path, and that Bolt unpair notifications need explicit
handling.

Tested with:
- Logitech MX Keys for Business via Bolt receiver

Erik Håkansson (1):
  HID: logitech: add Bolt receiver support for Logitech HID++ devices

 drivers/hid/hid-logitech-dj.c    | 48 +++++++++++++++++++++++++++---
 drivers/hid/hid-logitech-hidpp.c | 51 +++++++++++++++++++++++++++++---
 2 files changed, 91 insertions(+), 8 deletions(-)


base-commit: 0d839570765118029aa8bf4a95444c6a11aacf85
-- 
2.55.0

