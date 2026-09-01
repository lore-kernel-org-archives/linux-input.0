Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7507A3FCC
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244576; cv=none; b=TNRLxD7TPIOjRJuHn5sLKuSUO/DbEt1fe8GMte+0X1WgV+43WIhI6Bj220g7fsZLINbzvS/ejDcKWu9QLX3Q1lUCHnp5D24XH6I1aRl87MWk0Pepj3bvHlyIy/xH3ZwOCphMsBrlWcshbuaE2GXZ68ZXTc2onJh/JYZmJ3Bmr8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244576; c=relaxed/simple;
	bh=P6MeT8W7qtZhiqChdyIm/E7LrwCHu6XwLN9XJu1c7vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6fo7Pav9BfZn8hhYYiEzfWtlsFBGsRXnSFCec/feH8iaAoD75QBeJyTDfGPla2vc2gHUjC/4RKS/9Tn6gQc3cb1aEcRX1jnIbP3B5NR99CAD7G1J6d9ztWQUvdVVayfxvtinJgFl8pNqvmdDbQ0i/RTEQcmR9d9VXK+ihzUhUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJk3TrV4; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJk3TrV4"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-39927410578so212738a91.1
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 23:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788244575; x=1788849375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8vuUnYwdPlWQZL61wKlADov8uSdQzUztFQCSWnijrRI=;
        b=bJk3TrV4CkOeS74KQirafpyU0cNlgmo7dkZTrHbLp4niNREcKgzbsaED+Dz+NdqVkB
         e7sVNEgMR04LvXK2ASebcns9vBevBtUpYq95Taxg0+kXbbQiSk5GzJmruV1p06A23BiU
         +0tzt2AF60acjqjQPKgteSrA7kVIeZNTgUSbvM0Jlhv2APOB9xSX9lmVLVznH4so68XY
         l+QegFjVesZrJGhTfrOAl+hkqMPu3yBaABjVkx/sasIIly1sDnyMQ+NHW9FWTkVYWAQQ
         QFWAXedqX/sh3nJlsK3LggYdrJ0S6Due65ObMHG+ClOm7bHJNlt+Lm+vqgIkUcmCABR9
         /iLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788244575; x=1788849375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8vuUnYwdPlWQZL61wKlADov8uSdQzUztFQCSWnijrRI=;
        b=cny3LD17F5Y+w7JTms6rAFOHQXWUieYFtV1iwOyKjlJssEenWZBRVdjhspAYy5WHnz
         1YGnnq/JQzYSUDNHzuoWwmdz55e3D0cvUszfApRyjpn08GpnbM35qI//x3FiQGVL6CE+
         Cxh5GMmKyOIDbGTI80I8QJSYTZJH3HENtKG8crICK00rH9dSn1R40dZa6S7/PuVdZxFA
         l9C4YSRdVsmOqniG6Qwlru034rJq4a3SWJRtork+xVNRJiNbwFtHopRqHbCmLCpW7HZy
         6SGQenPHnIDmNMVEGOr6iUfxPtoXtiO8FyfqI44PACKlqLKcx7qffG3IImY5x29VufIO
         20Zg==
X-Gm-Message-State: AFuF++mBrYin87JMzcj6xvPw63EnvJ7C/suf7GyUPyRlP2MnR29/d1or
	u1kszYs+xpIOgUKgSKoEHiJfEEN3Rh5WnUfq4lgT8/tBKp30tcNNk4yt
X-Gm-Gg: AYBFou3UPcOQuVcELdTKob7iV8sQY9Z5ZtLmrtoVaYCKGu4m6FUXac2oDgICa98TAlP
	OPatRsfksquC4FZBIWJywxyAjeGjwbFv5YclhoPOsZXzfWFdFGse2jBCqNijDbvTzPsLHqV4Ho5
	WnGVIuhhcEWNKhDX1hGg8hBOI3oysWu6cU6W+sVWu2sR3a+O9jIEBpd+xeeVtH8Vtl+sJyk0c1y
	lDl4LwC/sd3TZaTYcnSLRWpQSPXtK/LYalotYji/07zVZm+qi5gT4/iykB1t0NtnPsQUeF7Nfnx
	Y28TgOGdYSTmGFhkri+MDrirFVR9dzcep2vNecGFYD266KcXIqQOsxXQYp8irYwlAvFgnRYPylD
	DBkMO96gGg4YO9aNdGamthjCVZaoU4bhElL5ZvZ5UZh2XUD09wl/Rvst2X73abKTbZB+Ki36e+U
	Ow6E32gI6tT3EmaXx52WNygh1NRwAVWqmTXpGJp68egLk7aiITdnKMLMoRq/OyxKj952eHskZtO
	XyV90J75l/vjg==
X-Received: by 2002:a17:90b:2e48:b0:398:e969:87ef with SMTP id 98e67ed59e1d1-39907ec6baamr9073478a91.24.1788244574741;
        Mon, 31 Aug 2026 23:36:14 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.192])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0dc854dsm32694425c88.10.2026.08.31.23.36.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 23:36:14 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] HID: hid-lenovo-go: fix controller configuration
Date: Tue,  1 Sep 2026 12:06:01 +0530
Message-ID: <cover.1788222001.git.mradityadash@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes several issues in the controller configuration and
calibration paths in hid-lenovo-go.

1/7 fixes the calibration attributes, where the command and sub-command
are swapped. 2/7 fixes two right-controller attributes: imu_enabled
selects the bypass feature, and reset targets the left controller.

The configuration interface initializes its command completion after the
HID hardware starts and opens. 3/7 moves that initialization before both
hardware operations.

Before 4/7, any decoded configuration reply completes the shared
completion. The driver then ignores the result of the wait, so an
unrelated reply, a firmware error, an interrupted wait, or a timeout can
still be reported as success.

4/7 tracks one pending request in the driver data and matches replies by
command ID, command, sub-command, and device. It initializes the new
completion and spinlock at the pre-hardware point established by 3/7. It
also returns request errors to the caller.

The firmware has no sequence number, so a late reply with the same tuple
can still match a newer request.

The remaining patches fix calibration status handling.

The calibration status table defines 0x00 as unknown, 0x01 as success,
and 0x02 as failure. A Legion Go 1 returned 0x08 after a Stop was sent
while no calibration was active. The driver stores the raw value as a
status-text index, so a later read returns -EINVAL.

5/7 preserves the defined values and maps larger status values to
failure.

6/7 rejects 'unknown' as an action. The action table contains it at index
zero, but the options attribute advertises only 'start' and 'stop'.

A previous result can also hide a new calibration attempt:

failure -> start -> failure

The status appears unchanged for the whole operation. 7/7 clears the
selected status to unknown before submitting a Start. Stop leaves the
status unchanged.

I built every patch against kernel 7.2.1-ogc3.1.fc44.x86_64 with
W=1 and KCFLAGS=-Werror. I tested the exact final module on an Original
Legion Go. The configuration interface bound without a kernel fault.
An idle Stop result of 0x08 was reported as failure. Writing 'unknown'
returned -EINVAL without an output report or status change. A later Start
produced failure -> unknown -> failure; the final report contained result
0x02 and error 0x0007. The five unselected statuses stayed unchanged.

---
Changes in v3:
- Initialize command completion state before hid_hw_start() and
  hid_hw_open().
- Remove the unreachable zero-length calibration action path after
  rejecting 'unknown'.

v2 review:
https://lore.kernel.org/all/CAFqHKTnQiTQc6joz-Y6tmjR=C5giF-MuHeBwu3rw+bmFVMQtqw@mail.gmail.com/

v2:
https://lore.kernel.org/all/cover.1788096666.git.mradityadash@gmail.com/

Changes in v2:
- Drop the FPS DPI patch; the existing request is correct.
- Drop the v1 Boolean calibration-result mapping. Preserve values 0x00
  through 0x02 and map only larger failure values.
- Move the existing pending command state into the driver data and
  initialize it in cfg_probe().
- Use scoped IRQ-save guards and validate the report size and ID together.
- Drop the v1 no-wait calibration path. Correct requests receive their
  matching SET replies within the existing 50 ms timeout.
- Reject 'unknown' and clear only the selected status on Start.

v1:
https://lore.kernel.org/all/20260821214810.87826-1-mradityadash@gmail.com/


Aditya Dash (7):
  HID: hid-lenovo-go: use the correct calibration commands
  HID: hid-lenovo-go: use the right controller selectors
  HID: hid-lenovo-go: initialize command completion before hardware
  HID: hid-lenovo-go: return configuration request errors
  HID: hid-lenovo-go: normalize calibration failure status
  HID: hid-lenovo-go: reject unknown calibration action
  HID: hid-lenovo-go: clear calibration status on start

 drivers/hid/hid-lenovo-go.c | 191 +++++++++++++++++++++++++++---------
 1 file changed, 142 insertions(+), 49 deletions(-)


base-commit: 1292bca0f8d835d2ad96d309595b2e97f3106d3d
-- 
2.55.0

