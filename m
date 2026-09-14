Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0889D366567
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 22:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426391; cv=none; b=RiqLPndJ2SAUqrEM2Uf1dqD5bFSj6WxJYPj+5R86a3FT2oWFR1sBQ36AOkVIEfRL0lY5oE98EiNXOLUM/P2OrUPNGUBkYqUDXvoAyI/4LuQ9lZBwBjKFHAm6EB8+uW+YEb8l7F8dCS0k68KqW+fLoYxUmjrsmm4by51st1uuP5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426391; c=relaxed/simple;
	bh=KlxV2Pj0K5nL5vnXASHLfOrdYtgNJknFNJmAfAcO8Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=smD/D05b3mxre6G2UibO8OBdBrC/wkZmGPb/VG5iHcKBsNzhgvsIIROpcuF3D5IJZBi8T19s6XytSTJl3fq9Ua9aE2iiRMpNi7o4A7/e0lcUauq5gbAZVsw3/ubPxdEkWqjbdqeUYJIYPamEiojHnd355ULgm5NbYNHf01nLXgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mu/LWdBk; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu/LWdBk"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso1665197a91.2
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 15:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789426389; x=1790031189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jhhKoo70grDYRK8Pz7Zy3Z2uy/lwES5xu5hc5Ox6dio=;
        b=Mu/LWdBkrqSdDnYbgqMxcUDYuXO0B9969fWjTLrUu2VPS7Ex/eWo8SilBeWRpYe9Ta
         6zjWtzZWKuJY5e4gZLg0zu2H/Ox1TqRwMIW+CArybIyEkCMgE36pBi2NTBYHLz785mFs
         w+7zxZUyofXt4muDlsrZvvxr/DO63OIJRfOZj67NJQPBo4EXas6p3rg22KlPzj0CI7gq
         lQM26g+9P1QuU1TFztDTYdvGLupaYO+MK4tCZsm/GI95drYM303BxMApEofpXtqV/pP8
         Jj1fT35SD63YSbrciabGneWgaf3laZpP7bkwUVEoUvcfHTB2Jr06Voa8b8tPrLL2Cndo
         lPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426389; x=1790031189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jhhKoo70grDYRK8Pz7Zy3Z2uy/lwES5xu5hc5Ox6dio=;
        b=g+GCBvf6q3HW75no2CF7TzXOpso7LZ3H6nxfjaYV1U5wphFx5VpIGUK1QpVLTPJWjJ
         +8MgPaDNFSMrmWqfeT8ggjLFX2zw0otul6W4TsjJ0Mz2KhYRJh341IeUllI7NkjRsY+g
         C6IlTm3ffg35uA46UnFk1bV2sKtYaAlrs261pAt2aOtB2lpwhQYxhM/6R6jVZPOA6FdX
         qnVr5/T1ulE9QUte9z+5ivTR/jGHwyuVg60r9Nmy6lS66LoGYbSWEoG/U3y784PXWmwr
         tm6ORCHbQqyklE7K919hBudmv5SCwlj4rCu9wJRvgmuaYXOpHfdjDcFGdqYWFkHK6RQq
         C6ew==
X-Forwarded-Encrypted: i=1; AKwUvBzGpvvILhkgNcdk44nK5u2QY5+7/S1v6vMwXsf4LUYmW0UpozGHlOCBo/X/udmJezvI29mhiLgOlzsgvQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m1GHWsI8QsynDRNKTGQIE9H218FVaQo2JRSRb/BXwlsiEs1gKO
	c5E2PAd3mNRentiA7PDoeYoLfQkoKdXmCi8u7ewbQtAeYWuEkgx54Mt5
X-Gm-Gg: AYBFou0UEQnr5eQxy6stNokJu9OyYw8mMUjqMr23Rq0v0b7dtrQEMrJj0s4rOFMQSBf
	pT2tQGs0LWRYmox9QoWJFwvBd9dKDd+OZURkiMmMyrg3CtLJU19xfJpFF8vfkSG1a1+hgUoYI3E
	9thL13tldCufzPAnctm9/NYDn2ATbaBHD5lSYJXWX601VUFzEyjMqIlSpKPrgAjSEEpKwy8kAfO
	rBY3YsdJRFimRxo6E8Xl0vnN1Y4vezfmbygeZjrV8s408M/pDrmTRDACS7nhcpMb1SwYRDbErL2
	02q1y58HdmyyaPBqk96v8sbYnF2oPWp9obIjj/PCgSIVF1SVaUenZ5HJ1hy2IXmLM8M7bYukQJO
	AIS6B/OlU1gnHv7Rnnq7OC1E50isnwDQBXILYQJoQLahV0y40sR3vXYOrvsk2xbt7R4pm+GHhnz
	n164vmpilwFAFGziKt7lJ3RExp5AFDGge15qPZHdkso7OzfeOsosYNfz+W0v44pYL5inS6uas3X
	G+jJ8y5g1hzygrv1XFTuXcqJIhdzpLsJy0Ph3pImGwZ0E85+x9s
X-Received: by 2002:a17:90b:35ca:b0:39d:fb87:569f with SMTP id 98e67ed59e1d1-39dfb8757a9mr4035491a91.12.1789426389288;
        Mon, 14 Sep 2026 15:53:09 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bbeb053a5sm14924296eec.27.2026.09.14.15.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:53:08 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org
Subject: [PATCH 00/10] HID: hid-lenovo-go-s: Fix various bugs
Date: Mon, 14 Sep 2026 15:52:53 -0700
Message-ID: <20260914225303.868569-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes various bugs in the hid-lenovo-go-s driver

Patch 1 fixes a dropped error on return from mcu_property_out()

Patch 2 creates a mechanism to ignore stale responses if they timed out
in the previous command.

Patch 3 fixes a deadlock if the device is removed while cfg_setup() is
running.

Patch 4 adds missing pm_ptr to the reset_resume function pointer.

Patch 5 adds a kobject_uevent notify during reset-resume to ensure the
os_mode return is caught by udev.

Patch 6 adds a suspend callback to cancel delayed work and re-queue the
cfg_setup if the device was suspended prior to or during the work.

Patch 7 moves attribute init to the end of cfg_setup, ensuring the
attributes can only be used once the MCU is ready.

Patch 8 reorganizes hid_gos_cfg and renamed it to gos_cfg_drvdata in
preparation for later fixes.

Patch 9 moves the static led_classdev to become a member of the drvdata
struct.

Patch 10 moved drvdata from a static global to a device allocated
struct.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

Derek J. Clark (10):
  HID: hid-lenovo-go-s: Return ret instead of 0 in mcu_property_out()
  HID: hid-lenovo-go-s: Bound stale reply window before reusing
    send_cmd_complete
  HID: hid-lenovo-go-s: Prevent deadlock if device removed during setup
  HID: hid-lenovo-go-s: Use pm_ptr for reset_resume callback
  HID: hid-lenovo-go-s: Add kobject_uevent notify during reset-resume
  HID: hid-lenovo-go-s: Add suspend function and gate access under bool.
  HID: hid-lenovo-go-s: Move attribute init to after device query
  HID: hid-lenovo-go-s: Reorganize and rename hid_gos_cfg
  HID: hid-lenovo-go-s: Move static led_classdev_mc to drvdata struct
  HID: hid-lenovo-go-s: Use devm_kzalloc for drvdata

 drivers/hid/hid-lenovo-go-s.c | 655 ++++++++++++++++++++++++----------
 1 file changed, 473 insertions(+), 182 deletions(-)

-- 
2.55.0

