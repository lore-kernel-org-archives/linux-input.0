Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8B4374A1F
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783206663; cv=none; b=JsITSETae4CqB5mzm4CL8Ftttfq/IZfZWUjYqFEcpcFlwdDlBnxvDqOIGZKgGDuwHq8AZybqhUthpwO5jQiUV+PiAmAlA+ZYJ+WiOFAnoh6tfeU32V0PNfjliceP1RDEy3gXApDVhhIhsi42INSzIo1+vJI0Ld7XjEeg//DQ6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783206663; c=relaxed/simple;
	bh=4SHRITdJ+E8ERHl4tYeb/fpaAXFttTz1gdxMpqep6Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpxQXRBlq3XarNtUUJ3bCkfKAUrfVWdwg06jrFlWRT/6E5D+tSUInQQaSd3pFvhZKD6/FPlwjxaixcy0QeHSQYGxjMFCQ3FQx2lhTrIrrOknxdj8OGg4FJutECC11wJ7QqeoxxyOl6DPjxd453xGzaZTIqfOz023EJpe+yc9y7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5PjvCLB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5PjvCLB"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c733f15aso17473035e9.0
        for <linux-input@vger.kernel.org>; Sat, 04 Jul 2026 16:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783206659; x=1783811459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQL/wLs/lLoZGfe8vHL9xziadNwKDFjsT7zcpW3VdRc=;
        b=W5PjvCLBr+4NPSU+qnmYXkK4krKHNi4TxF7nMqld56UIl5+rghUMphTW2+hD27e96W
         XaRsLdd+tctXrLIa55x4nJVhUvbJj9h5LyBXcANVx6y2UrqjiJEBouDcQxWNKjmuMQed
         gRGlRTZRejUnbwlAfkny3jSddtBYKiN5h2iOMGTXV4OjgiMy83mzZScwTSB4oyLmEITh
         zb0ubfN831kLLsFPKFBYvKS5a6QNHOFjtkq0akOE8XrzeZ4hQQ+0PAPu5e5r2MbZNCeB
         iyKhqjlOpi9Ec3jav/S7ntovnvCNo0n+rPPKMdtTZI6XNQnT1L2sl/WZSSwOojpnlm4w
         4toA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783206659; x=1783811459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AQL/wLs/lLoZGfe8vHL9xziadNwKDFjsT7zcpW3VdRc=;
        b=AtEEHlSgtpZfLtYff5LvtJDzpr5ZR0DsPGqDgBSw3EBM9bUrvKTLKjFHqLGXf0eZ6D
         EB06D7Wp13HAjQJaKuMRRGpgyYrrYHEAn0L2PUVVfiB8FLelSRXXq05YaSztjve8WVis
         CG+nCQxnTDGA44qjJKhykes83kloDq30G/JRuQ1926u53+03cR77GuCV/kyj4qADf88M
         6v6gWrf9EQaA2ito9VeOVaYybueLWCWlI4dZPY9+z+OtJK+NbR0WYQBtIquQNYZe0J3b
         yofphyhRhtam76qmDpeIVAse0Lbi9wBSLYOTf4vDVvg23+ebPZLEpFJOEMp01iOlMS52
         hZRQ==
X-Gm-Message-State: AOJu0Yys3rY1niOZkz/sms0+cyG3LQlTdy5n6wvfjQwyn3SGY9TGVkLO
	SnmKobaYGtyF17pkg/t5uAYfUKNUWqlDUOrb9BMXL85PxSUJ4yGjVo340+E/BNNcrGY=
X-Gm-Gg: AfdE7ckFgbkfPajYnds4JS4rIsIGpTQyNMyJAcI4dkSq2apkv+fyaJ0ryIqFFM7CZzo
	0O3o6kq+BoYgsmfPj06SyR7uvN764cTOc1faOCO7JQ391OS4kL5L0sEdzr+oRzxA4gKKT2eFdpo
	y1vZUkuwFQdfHELOp2YOKeQhqvYrpH4VEOaNic818XxeaoBdZ5w/gZlBxZ2ffTZDEJjWoiKYzYp
	rPk2ZEAKHe35sPQy7j99g2ToOwL+sNM5qzOhxwS0Bd8yEya2waJDTxqcxu7W/Oh975vuW/vrRJ4
	m/9cqQqr+77O6GAMA942v0Wgj27+ZZ6JecUUdKxZOtZFDw7/EW9/wb6InxfVkPp9JhY8Wluzke5
	SZbr+ecTFH3Rdk0OtdJdhTOCMxoq7zH8/y7lBgK6MdU+e/FTg3dgDcMNn7lAgR0pj2LAx08oFds
	lHqOYDiikXq13KvegG3uH4iwv674mQHa1KJIfONbaHBQ4/4QtIl9sL
X-Received: by 2002:a05:600c:1554:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-493d11f0598mr54878215e9.19.1783206658578;
        Sat, 04 Jul 2026 16:10:58 -0700 (PDT)
Received: from localhost (97-115-81-230.ptld.qwest.net. [97.115.81.230])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493bef11338sm292210155e9.1.2026.07.04.16.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2026 16:10:58 -0700 (PDT)
From: Elliot Douglas <edouglas7358@gmail.com>
To: linux-input@vger.kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	edouglas7358@gmail.com
Subject: [PATCH v2 0/2] HID: logitech-hidpp: fix Signature M650 side button timing
Date: Sat,  4 Jul 2026 16:10:33 -0700
Message-ID: <cover.1783094954.git.edouglas7358@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613175109.44365-1-edouglas7358@gmail.com>
References: <20260613175109.44365-1-edouglas7358@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Logitech Signature M650 over Bluetooth exposes its side buttons in the
normal mouse report, but the reported BTN_SIDE/BTN_EXTRA events are short
click-like events emitted around button release rather than physical
press/release events with the real hold duration. The device appears to reserve
the held side-button state for a built-in gesture mode: holding a side button
long enough, or holding it while using the wheel for horizontal scrolling, can
mean the normal mouse report never emits a usable side-button press at all.
That makes the buttons unusable for standard Linux hold actions such as
push-to-talk, drag modifiers, or remapping rules that depend on key-up timing.

When HID++ 2.0 feature 0x1b04, SpecialKeysMseButtons /
REPROG_CONTROLS_V4, temporarily diverts the same controls, the device sends
diverted-control notifications with real press and release timing. This series
adds quirk-gated support for those notifications and enables it for the
Bluetooth Signature M650.

Before enabling diversion, the driver verifies that each mapped control is
present in the device's HID++ control table and is advertised as a divertable
mouse control.

The kernel only programs temporary diversion when the device connects. It
does not continuously force the setting. A userspace HID++ tool such as
Solaar can still issue HID++ commands through hidraw; if Solaar changes the
reporting mode for the same controls afterwards, the last writer wins. That
means Solaar can still take over those controls for custom actions, but the
kernel will no longer receive the diverted button notifications for normal
evdev reporting until the kernel diverts the controls again, for example after
reconnect. While the controls remain diverted, hidraw clients should still
receive the raw reports and the kernel reports the matching evdev state.

The diverted M650 controls are reported as BTN_BACK and BTN_FORWARD. Logitech's
Signature M650 getting-started page labels these physical controls as
Back/Forward buttons and describes their default page-navigation behavior:
https://support.logi.com/hc/en-nz/articles/4414473810583-Getting-Started-Signature-M650

The reprogrammable-control support is per-product and parses the full HID++
divertedButtonsEvent pressed-control list, so it can support devices with more
buttons without relying on a single last-control release heuristic. Only the
Signature M650 opts in for now. Other Logitech devices should only be enabled
after their HID++ control IDs and divertedButtonsEvent behavior are captured
and verified.

There is evidence that this is not unique to the M650. A prior MX Anywhere 3
patch used the same HID++ feature to fix thumb buttons that only activated on
release, and Logitech documents side-button + wheel horizontal scrolling for
both the MX Anywhere 3/3S and Signature M650. Solaar's device reports and rules
documentation also show HID++ divertable back/forward controls on MX Master 3
and MX Master 3S class devices. This series remains conservative and only
enables the device tested here.

Tested with a Logitech Signature M650 L over Bluetooth, HID ID
0005:046D:B02A. Baseline evtest showed short release-time BTN_SIDE/BTN_EXTRA
events. Earlier local testing of the same HID++ diversion path showed real
hold-duration press/release events, including holds longer than 4 seconds for
both buttons.

Changes in v2:
- Replace the profile/count wrapper with NULL-terminated mapping arrays.
- Cache the selected reprogrammable-control mapping in struct hidpp_device.
- Add a named constant for the M650 Bluetooth product ID.
- Use common Back/Forward names for the 0x0053/0x0056 HID++ control IDs.

Elliot Douglas (2):
  HID: logitech-hidpp: add HID++ 2.0 reprogrammable button support
  HID: logitech-hidpp: enable reprogrammable buttons on Signature M650

 drivers/hid/hid-logitech-hidpp.c | 225 ++++++++++++++++++++++++++++++-
 1 file changed, 224 insertions(+), 1 deletion(-)

base-commit: f0866517be9345d8245d32b722574b8aecccb348

-- 
2.54.0
