Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FB1A6807
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201209; cv=none; b=gZboZIPwrHw3GEbo9D+H78++b1vK80cpyU+d0sdOxT7l0OZlBX52NioL5DprpbiaTbQ0GCPNTSFW7qr7ZpZ3JSlozrZz9n/OwlQBk8M7b0Pk7R3jSP3L/Pim9DL2oa7OyKn7IlXF0UBwSmTarzwNfUem+dTlBxDL/KSYP24MH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201209; c=relaxed/simple;
	bh=yvRP1u2Utq0xeeZaPJqudxqNo20F7ftY+jKRkqzUimY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krJkdHOlXYfw6USUZBse42IR6Ebop18O+z14pWYLLYTpCd4qJrakNpheCMNNih//ZONurYzeWAm3ci72EJ4qFrvUy3MK1rBiBpRPOrh/hQEEq7B/GjjIflc9QkcS5XHG2mjsz3ofIh9+023gg9ZFMvq8+TXClSDBlUPGEwfbhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKfag5dm; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKfag5dm"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35f036b17easo25357eec.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 18:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201208; x=1792806008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WyelgOLNhU1TGp2fbTGjic6AmzczPO+7QxOzuA4ZKMs=;
        b=EKfag5dmToJtaW6U0+QgD9qH3TD+804yWOfzSMFM+o579stX/3IB58r/zVfudFXOnC
         BTu4NO6qe46xQKSnq1EI0RvDzE9JBxnNv4TCu73Es1AZzySuvZgLlTBcxGSSv0Ru4dek
         7rnsrivLDwk2x8wnIlhFufCehlsUzsKTK7UAfaVqwKfSvgIFmdlrmCob/nM8s3dqnA+A
         X/OzgHfOSGajI0PMbGE9/nlce8JmNRijFgruKsHe7940VF1kmJpJNtSadEiIxgmURGJG
         hB25uRc0bt0tTwJl+64zw4kGdnT+Mr0XO6vVF1TGzB7MEfbZR2iy4PqlGCeIg1d7bx+t
         HxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201208; x=1792806008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WyelgOLNhU1TGp2fbTGjic6AmzczPO+7QxOzuA4ZKMs=;
        b=nA1CCRNuxGtfUZD3QLkWpnJMR4RNYwJYQBKCMiTp6c/LWl9ssCNGvPuhxvnqfvF324
         wG3Ym9EH3nO/LB007vxO57DEc6EBSbnhkEPiJtPmHKMsTagsIDrL7Nd2zvY5nDsuOcCm
         GiBHbyWdZbhRFi8/bMWTxAaPLB1aZHYIhOvsExnMPOGUorlJDM37m1swHd3Pp1fNhnu4
         KVIc8VkbkAixafzLcEZh3UdEFcdEUT6Uix51mDoWik6ihrPcvNIQ6hxylYoNdn91fLG1
         hacjnxTn82mbqzwZGrKKS/qQUDnbCYamJyps/5WPN3ocIKan6jvNhGjAM7K+hNqYH7bf
         /LXA==
X-Forwarded-Encrypted: i=1; AKwUvBx8FdHge4vrfc+kY3s5mVaLwxpmnSdwGkFrz3VoyS5++BnIjdYtPOFiCo8gYDijceJ1lDdWnz1ucKz8Jg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJXgPi4DKkfp+fGxk3JU/t7y1ZLv3RKgjybjKFIx+fTbxSW905o
	W4Kc9oQ1x6q45IM9lCf8RuW5RntcHkt/aOCh6fYo59Py++WciQbmrXyP
X-Gm-Gg: AYBFou3aihSRPopNsbEY631yjN0lptULdIEiBDnnZhOZmEE/Y13YpI14y3Uy9SlegFP
	z9E3mdpws0WkER/ob91G/c9xnRSd3M5aQb/u/lHTIVK+CUqE9URI6iIiq5TsyWb5qzTPrYUHPxb
	4zknScRIMYOgU7NupiC98XPaVpo/BBPWy9Q1BktruRVyz20k/nLueURR/AoXh2ewMmdn9mPk3x2
	hycOxgW0uaw99HM4pciNqwIJ/MtXzM1Ax/hPo0cNkapirdaAtBbpgwvw0tFqAguAhGFlo9JcEwq
	fV5/DnDdJnoWOgUPSyWCEkcDD+UxcEgJXrWSR2+OFmP8g6y06RpUZ1scnkXDhsz9jUjHxG3LryF
	WYvd5oz4pskAIT1cfmFjahgxjm45ByhZ25v42F++hkS8PXRQ5wD5DhWPF63kPSNsbm2YK5AcmyV
	ljs6tbWxQj6ksso34kKizcSeV1zWrmDgAuIu9oL+oTpZ3/XyJ9NDs+K3P8xZE3Bi+48euUdI5aK
	X8uE2rns2PVuXVecPv4fU4qiq/WkGkhcVjnJNqALnY9RBAq+EdFG6HjUq2lC6Nhcch6qXfQbf8d
	LTEFGDJPXsU=
X-Received: by 2002:a05:7022:fe06:b0:151:7831:e401 with SMTP id a92af1059eb24-185120a8c4fmr3099997c88.15.1792201207411;
        Fri, 16 Oct 2026 18:40:07 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:06 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org
Subject: [PATCH v2 00/11] HID: hid-lenovo-go-s: Fix various bugs
Date: Fri, 16 Oct 2026 18:39:45 -0700
Message-ID: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes various bugs in the hid-lenovo-go-s driver

Patch 1 fixes a dropped error on return from mcu_property_out().

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

Patch 8 reorganizes hid_gos_cfg and renames it to gos_cfg_drvdata in
preparation for later fixes.

Patch 9 moves the static led_classdev to become a member of the drvdata
struct.

Patch 10 moves drvdata from a static global to a device allocated
struct.

Patch 11 stops and closes the HID device when probe fails.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

---
v2:
 - Patch 2: Only mark the ack as orphaned when no reply was consumed,
   i.e. the wait timed out or was interrupted. An MCU error reply is
   fully consumed and does not need draining.
 - Patch 3: Re-take cfg_mutex in the remove path after stopping the
   setup work; the commit body documents why the re-take is safe.
 - Patch 6: Cancel instead of disable the delayed work on suspend so
   the work can be rescheduled again on reset-resume.
 - Patch 7: Bound the device query retry to 5 attempts at 50 ms. Register
   the LED classdev manually and unregister it on failure and in the
   remove path. The registered flags are set before the matching steps
   and cleared on any failure, so a failed setup run can be retried.
 - Patch 10: Fix stale work function name in the memory barrier
   pairing comments.
 - Add patch 11: Stop and close the HID device on probe failure.

v1: https://lore.kernel.org/linux-input/20260914225303.868569-1-derekjohn.clark@gmail.com/

Derek J. Clark (11):
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
  HID: hid-lenovo-go-s: Stop and close device on probe failure

 drivers/hid/hid-lenovo-go-s.c | 720 +++++++++++++++++++++++++---------
 1 file changed, 526 insertions(+), 194 deletions(-)

-- 
2.55.0

