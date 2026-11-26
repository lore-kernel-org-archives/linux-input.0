Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661025;
	b=KYhdZdbp/TLR5oE53MIGtIER3kcTqzkUdK7+nGrMy3R9BYuGGFY50fiOMeawHxdeBVH2
	 cjtxVQLOs/FDfmGtLjMQGn5NQe4J3JDyRPlp++Ut7Ij4uzrPO3qbcIE/micKSJd/VVLY+
	 HeP+MXOgBvI9JsiQnXPDubHUrWgf7IWaNmH2CNUmFrU/U3VckI+WRC1VUS2ydT5UlVzxC
	 IGi8rrkxuviS2rBoqYd9LXiHroCqfn2Tc7xCzUtFriq9FHrnbC+Q1DnPZr73UiMkNmQsR
	 /OeSLFdEeAJA1g4b6qe/KsLfibuqytnQNLEX2LuZ0P2TIRppB1GN9fjAUCYNlpHwtMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=2s/G/b1FYIMZ47gP2ccnxd5i0/ZdtDVq3vi7/8u2GaQ=;
	b=zcFkNcAPgfWd1thF6M6sKJ/wqPxhL7X8G1B+9jfSjWgtWQ6sk3KDJw5Zn9zLjmCfyMJR
	 FWY+ZTuY+FIIDqZWNFulaogj3aNxPBdFTMcElTAqjz/pxM8YuLOoNgWbWvs2Vn0U9qSKM
	 HJskXwnEIo4IINnsJ3lWsDI540HRWZ89o8jxzynSnDFwj719DVXdhXBROSb01L7Z4EYiY
	 suydM+pMoS0KW09jS6DyF1zRpMp3FRFoEmUOZ5ewQsR5IxKPFq5cHOD6KptANN5Fl+rNK
	 lysBcr3fLZhHqGcKmUszNXCuaW6klzKzWmYMJgi5PaYn7k0A7fyosVkuWTn6EFGuHng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--svv.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I3Q79zge;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5817606A321
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 02:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5817606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--svv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I3Q79zge
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-386b8624cf7so3149173eec.1
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 18:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795661024; x=1796265824; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2s/G/b1FYIMZ47gP2ccnxd5i0/ZdtDVq3vi7/8u2GaQ=;
        b=I3Q79zgevz8od4Zy8zC5TxpMo7/RmIZiDwU3YaqiOMMZd/dpImlc3sI3pkqJHxaPy3
         oX5OxMDtdGScCDcnIpvE+AvEEiUeST9bS08HqA+ggc0qSoL8MXHvt0KnG52vnmPAUwo8
         6ZWxR+MvCmPi61A8xOdN/59YICt3DGJbhq2OwMY7g6HElXP0LOCSOSCplQtnVMuVe4mj
         54KOFlI7/+7fXRtQU2X5puRvf5k4oFGFszl0c1rxFqYGuhj9RVsBXVoi4m0VXrRC72hc
         RUZE+PE5v1PJjSCfNkCHRwd1ryIhVk5op6xOnujMMOFiypHZlOYKEhAOdVhIYF11qYIK
         HEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661024; x=1796265824;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2s/G/b1FYIMZ47gP2ccnxd5i0/ZdtDVq3vi7/8u2GaQ=;
        b=pJPMSnrtxLpOSNshUS2mFALVL7sIZZzgdOiTz0OlxyKQCL32IudZnB7Ui6grWzgaHy
         h635XxkelN73+Zmn/YrZSSf6abEyFH+qCvnVIa9EzI1v2DpiQMR5uyGDTJ1b8BtQ1miL
         KV9sujzpqHPAC2UZTauk9ixuNZj1F6nd3obzfU3T6AC3hab+VMo2BARLO3R07mtqS+o7
         l5d6B2oNEKCJ9H5NqR15DtDjZeQaesI3x1C/jlcGW+RqiZ0CSB0OU1KwuvmpxY/tBNWT
         kvlrOarVYskoCU07jcUCeHCjkkjCRaYgREF3IBGRz9L0o8ryLSeVXCBL/fSexUa/Q294
         rWuw==
X-Forwarded-Encrypted: i=1; AL+hErFaQtqD/LwaVkcOlRWmlaDyL/FT9yJB0+3hTws4QMJHUAZBMj3awS6aI4to8N+OB3LFKzj+YZyRBgTvYA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Y0TpPcxhbaiSV5iz34yx9k+yF8MJWHTDo0th2kt5G8kPfaoL4
	0g8B17GyNn/j6jEXtf96gwqxZaX+gSFnITVZ+IykfEF5/PM6Ej22nPRn4QagrFbizD9HWQ==
X-Received: from dlbts17-n2.prod.google.com ([2002:a05:7022:b051:20b0:1b3:a015:cfb2])
 (user=svv job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:260e:b0:1a9:c52f:655c
 with SMTP id a92af1059eb24-1b556900476mr22230882c88.36.1795661023461; Wed, 25
 Nov 2026 18:43:43 -0800 (PST)
Date: Wed, 25 Nov 2026 18:43:34 -0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.911.g883d8bcb20-goog
Message-ID: <20261126024337.4168845-1-svv@google.com>
Subject: [PATCH v2 0/3] Input: add ABS_TWIST and support it in HID and Wacom
From: Siarhei Vishniakou <svv@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>
Cc: Jason Gerecke <killertofu@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siarhei Vishniakou <svv@google.com>
Content-Type: text/plain; charset="UTF-8"

Some styli can report rotation along their long ("barrel") axis,
commonly referred to as "twist". While the HID specification defines
this usage as HID_DG_TWIST (0x000d0041) in the Digitizers page, there is
currently no corresponding evdev axis code to expose it to userspace.

Because evdev has no MSC_SCAN equivalent for axes, drivers and OEMs
currently work around this by mapping stylus twist onto unrelated axes
such as ABS_Z or ABS_RZ. As a result, userspace input stacks must
maintain device-specific workarounds to know which axis carries twist.

This series introduces a dedicated ABS_TWIST (0x1d) axis for single-tool
devices such as styli and wires it up in the HID subsystem:

1. Input: Define ABS_TWIST (0x1d) in input-event-codes.h, add its name
   to hid-debug.c, and document its semantics in event-codes.rst.
2. HID: Map HID_DG_TWIST (0x000d0041) to ABS_TWIST in hid-input, compute
   its resolution in units/radian, and add KUnit test coverage.
3. HID: wacom: Report un-offset pen twist on ABS_TWIST (zero at top/-Y)
   while keeping the shifted ABS_Z axis (zero at left/-X) for backwards
   compatibility with existing applications.

v1: https://lore.kernel.org/linux-input/20261110020632.4003499-1-svv@google.com/

Changes in v2:
- Rebased onto v7.4-rc4 (8d7fe9885c62, including hid-for-linus-2026112301).
- Patch 1 (Dmitry):
  - Moved ABS_TWIST directly below ABS_SND_PROFILE in event-codes.rst.
  - Expanded event-codes.rst with precise value semantics: clockwise
    rotation when viewed down the barrel toward the surface, zero when
    the neutral reference faces the top (-Y, north) of the surface,
    support for both non-negative [0, 360) and signed [-180, 180)
    full-revolution ranges with wraparound, units/radian resolution,
    and the distinction from ABS_MT_ORIENTATION.
- Patch 2:
  - No changes.
- Patch 3 (Jason):
  - Added comments explaining the forced angular resolution_code in
    wacom_map_usage(), the order-dependent double-mapping in
    wacom_wac_pen_usage_mapping(), and explicit ABS_Z emission in
    wacom_wac_pen_event().
  - Emit un-offset twist (zero at top/-Y, matching ABS_TWIST
    documentation and HID_DG_TWIST) on ABS_TWIST across all three pen
    rotation paths, while preserving the +1/4 revolution offset (zero at
    left/-X) on legacy ABS_Z.

Testing:
Hardware-tested with a Wacom Intuos Pro and Art Pen 2 (HID_GENERIC
path): verified ABS_TWIST reports 0 when the barrel button points to the
top (-Y) edge, increases clockwise when viewed from eraser toward tip,
tracks ABS_Z with a constant +450 (+90 deg) offset, resets cleanly to 0
on proximity exit, and exposes min -900, max 899, resolution 287.

Siarhei Vishniakou (3):
  Input: add ABS_TWIST event code
  HID: input: map Digitizers Twist usage to ABS_TWIST
  HID: wacom: report ABS_TWIST alongside ABS_Z for pen twist

 Documentation/input/event-codes.rst    | 23 +++++++
 drivers/hid/hid-debug.c                |  1 +
 drivers/hid/hid-input-test.c           | 87 ++++++++++++++++++++++++
 drivers/hid/hid-input.c                |  5 ++
 drivers/hid/wacom_wac.c                | 94 ++++++++++++++++++++------
 include/uapi/linux/input-event-codes.h |  1 +
 6 files changed, 189 insertions(+), 22 deletions(-)

base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc

-- 
2.56.1.911.g883d8bcb20-goog

