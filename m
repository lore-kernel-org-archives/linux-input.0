Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4503DDDBD
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104298; cv=none; b=b8c5b82c/0cTUtWI6SqDsrxbBFqjupN9EmiW+jopc/eLhMvkArFvEv/MhlYtJl2d5hPQVj2sfXy4QN4ENFkyPY0z1f+q75ZNueUgPebSvp1ZTAsPekoTT+kII9acs6OVYVNKbjjrSFXcJjjP1ZWsneH7dphJmpwbAbA4EkqxzNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104298; c=relaxed/simple;
	bh=EgCZkceTCqk7Jq2mrOQ/kNNzO/TKYysM9cuWsolCFyU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b904sRNttGdcCfqG4lw+I/Jsw2IEoPHzYc+/IjhgdIyGIev3B/ELfUiESE+t5J3cxzmaNHWZC9/+CQBNrsK6gPsiITeQjKNSHUoNmtW01ym4fuK0ZZvbT/uSGBU09MgyqP5CyR5ZPgEWI10j2KRf3cYraCuQwF9fWrFS55sDPys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=S+w4nob0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="S+w4nob0"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45efa80e0afso5401672f8f.2
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1781104295; x=1781709095; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTtLZdA3ULuQ/xL/J9ZltVjlPPR+kxqruLxVyRJE7cc=;
        b=S+w4nob0nr6lzedAXzAME9q+KCKiWSynEh1uZKGDmNwj75pKHSLF//TlZg9RtkRo/N
         qz/yBOYjsPuDJVUEWGVlvXaihNZjEbQtqLJ1mHWvvR2rqRlVj28X1SR2oeQ+Ykom2twO
         ky1pSqiqxLl3tRK1ThRrx+LUaWfye4GpQ4Y+UPDU1qe+W3UqoBm92d3241A1B+3Cuzcn
         dE+X0BiRPAJaZy8gRt9Rof2vaPwe45IdY358fOu2xuQTRYlr0gJeSvatym60IUjQGv3z
         8SpqM99VIJxSn6oH3P0EOCdHXYrOglSpgqzKQDkm49PQyLTilqz+kRJbkfu783VYbkFz
         ybUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104295; x=1781709095;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTtLZdA3ULuQ/xL/J9ZltVjlPPR+kxqruLxVyRJE7cc=;
        b=PhuSpU8RHQrlwCKi7tQ8aqNhdiZHr90QWPIi3d/0j7sk1GKYjv98gOCT13BQU8wvZ0
         FigdkHj4v2O7wqzOaMFbEfKb7HfqWsFejOrzcExoVLsbnAS+7Z/MxFibgZ65RxSmIjoC
         BR08O5pZfw0SBRhqdweVITxbSdRhjb6wEEIhw74jI5ImPjpNnXrAeGWoqXzHhWzxa4lH
         iNYmdEphYbrFcXfMlVVLiWnkye/Q9EM+bOz8qYk/scGMYU3UUKLIxdkKTVk1tpF+IAfi
         OfsPBiI1x/LCtgT2GoPE31zY87wUK06+BHfgubPGc0UpueLBKoHoETkgYDhjk0UtoTCZ
         1HIw==
X-Forwarded-Encrypted: i=1; AFNElJ+j/IClFNyPMyX/kB0kOu3HXAbAyyzHJmt2TCvkqd3+uPLQNHWt+0nD2zaMpY6Pf92bv3Qi3INyY4HR+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeKFuS2MkNz1g2GW4brLtQZvb5GrhZjAeGanzkUy9dlBn/V/v5
	vES8Wp3Oc/1lvNgLXhVZgGr8MYLyqa8VbbUYKsguQsnZnncqS2tno7ZGiAecYduT7PZ3vi4qa7d
	5n1Ie
X-Gm-Gg: Acq92OFmKQdhrleGLpM2v83cnLwI82VbTJrowClGYDyP1D4xZbuYPB0YCBlJDD/XzwF
	BpuQj7UYENg9MtAfnCgGEjJg96WL43DGlTNup9kDMzlDPTEuPQjA3XJLEyNaWUaBIXkWTn8k1yd
	TccZp89QLtp7CAU7o89C+cLNGnElFtIAiRTNd9so90LkoJJAIx36gBXWkts5NsUROSIIpdi/MTA
	uEw5gYiIEwUxfp9mErzfmdcR37KwatiMgJ4zEUGW+BZG/EvMq58CNzQR/mZMqJh9R2TXIjeIuiH
	gz/3V2I/BEFnvQGUqZ7huAUQPDVbPr8vYurIcVkTIkd0zeQ3J+oUBaytjYfKzeTdxJslL6BgB/o
	SdCenJNsQQMIUa5javR4J+t/fgxfA10JzdiPlJkqhhqiABsLFPAVK+9/ZVH0p9W3dETujzNUzbB
	7nrg9bgAmWhq0zQ2J2loIEzP6ZkF7ejv8pFUQWlPQU4TsG/upTyzc=
X-Received: by 2002:a05:600c:8518:b0:490:a298:3859 with SMTP id 5b1f17b1804b1-490c4993bdbmr449545855e9.24.1781104295098;
        Wed, 10 Jun 2026 08:11:35 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:1a6e:6004:a565:d3cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm585537575e9.7.2026.06.10.08.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:11:34 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Subject: [PATCH v2 00/12] HID: storing pointers in
 'hid_device_id::driver_data'
Date: Wed, 10 Jun 2026 16:11:23 +0100
Message-Id: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJt+KWoC/4WOWw6DIBQFt9LwXQxCW7Bf3UdjjMJVbx9gAE0b4
 96LuoB+TjKZc2YSwCMEcj3MxMOEAZ1NwI8HovvadkDRJCac8Qs7cUnfzlCTRA2xbl5AezTVzhU
 aKlvBjJJSKKlJagweWvxs/Xu5cxibB+i4RlejxxCd/24Hpnz19q1zrv5sTTlltGYKRKEKzZW4x
 R4658wAthvRZtpl45OUy7L8ABaoTT3nAAAA
X-Change-ID: 20260427-mod-devicetable-hid_device_id-7f30d877387c
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781104294; l=7279;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=EgCZkceTCqk7Jq2mrOQ/kNNzO/TKYysM9cuWsolCFyU=;
 b=io43eI3K3FL3Ws598y0p7hUlF1U3Y9kS9mjahw3R06RWxTpozQ9OQGy7EKEJRUk9AbJqsVt2P
 Hke0cuIDkL6DbOK+JKiGlY4W5VHi9Eb8uqBvWBZNk+aHs4nLNcUi+V5
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

The <linux/mod_devicetable.h> has multiple structs that follow
the pattern of having either 'driver_data' or 'driver_info'
fields which are of the 'kernel_ulong_t' type. Then how to 
interpret that field is user defined, some users will treat
the value as an actual integer, others as a valid pointer to
dereference. 

One of instances of the above is the 'hid_device_id::driver_data'
field, for the most part it is used for setting HID quirks and
treated as an integer value for storing metadata in the subsystem
drivers. But in a few instances it is used as a valid pointer to
dereference, namely in:
- hid-tmff
- wacom
 
Additionally this field can be set from the userspace via the
'hid_core::new_id_store' function - which is not memory safe and
could lead to OOB memory access in the above two cases. 

This series is addressing the issue by making the usage of the field
consistent, all drives treat the value as an integer and if the
driver has a need for dereferencing a pointer - it stores and 
index to a table of pointers. The index is bounded by a named enum
and checked at runtime at the module level to avoid developer bugs.

Furthermore a user-input sanitizer was added in the 'hid_core' module
that restricts injecting arbitrary values for 'hid_device_id::driver_data'
that are not defined and matched within the driver already.

It was found that some modules that use the field do not use a named
initializers for the field - which is inconsistent with rest of the
modules within the HID subsystem. This is also addressed in the series
as part of the pre-clean up to increase clarity in patches 1-4. 

It was found that some modules use a bit of a type-unsafe way of storing
integers in the 'void *driver_data' pointer of the 'struct hid_device'
- this required a cast during storage via 'hid_set_drvdata' and a cast
during retrieval when using 'hid_get_drvdata'. I can see why this was 
done - as we potentially save on an allocation - but really code is
more readable and better quality without resorting to this. This issue
is also addressed in this patch series in patches 5-8 as part of the
pre-clean up.

The actual implementation of the table of pointers approach 
can be found in patches 9-11. In case of wacom driver the sad thing
about it is that it requires a bit of macro magic for sanity. 

However, in doing so it was discovered that in the wacom driver
there is a 1:1 mapping between the 'driver_data' field and the 
product id - therefore patch 12 shows that the lookup can be
simplified as there is no need for using 'driver_data' at all
(it also does not require macro magic) - but it was left in a 
separate patch to show the working - happy to squash in v3 if
this would be accepted.

The change also makes the code more portable on architecture 
like CHERI [1], where a pointer is replaced with a new primitive
(called the capability) at the architecture level and is twice as
wide as the greatest representable address, ie. for 64 bit address
space capabilities are 128 bits wide (the other 64 bits are used to
store meta-data relating to the 64 bit address). So you can not store 
valid pointers inside 'unsigned long' as effectively a different set of
instructions is being generated by the compiler based on the data-type
that was used in C (ie. capabilities have their own set of load/store
that also copy over the meta-data which are orthogonal to the load/store
instructions used for plain integers that would invalidate the meta-data).
There is slightly more detail to this, but the above is enough to
explain the motivation - the proposed changes make the code a bit
better even without considering CHERI at all - as it is more readable 
and type-safe.

The series was built and tested under QEMU (boots with relevant 
configs set to Y) on arm64. Additionally the operation of the input 
sanitizer was tested via the following:

```

modprobe wacom
echo "0x0003 0x056a 0x0001 0x00000" > /sys/bus/hid/drivers/wacom/new_id

echo "0x0003 0x056a 0x0000 0x000A1" > /sys/bus/hid/drivers/wacom/new_id

echo "0x0003 0x056a 0x0000 0x000A2" > /sys/bus/hid/drivers/wacom/new_id
-sh: echo: write error: Invalid argument

modprobe wacom
echo "0x0003 0x056a 0x0001 0x00000" > /sys/bus/hid/drivers/wacom/new_id

echo "0x0003 0x056a 0x0001 0x00001" > /sys/bus/hid/drivers/wacom/new_id
-sh: echo: write error: Invalid argument
echo "0x0003 0x056a 0x0001 0x00010" > /sys/bus/hid/drivers/wacom/new_id
-sh: echo: write error: Invalid argument
```

The 'hid-tmff' and other randomly picked modules were also tested as 
above. Furthermore the './hid-wacom.sh' test was run from the user space
and all tests (except the expected to-do's) passed as required.

This series is part of a larger effort led by Uwe [2]

[1] https://cheri-alliance.org/discover-cheri/
[2] https://lore.kernel.org/all/cover.1776429984.git.u.kleine-koenig@baylibre.com/ 

---
Changes in v2:
- Patches 1-4: No change
- Patches 5-8: Additional signed-off-by as patches were applied.
- Patches 9-12: Rewritten and new.
- Link to v1: https://patch.msgid.link/20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk

To: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
To: Ping Cheng <ping.cheng@wacom.com>
To: Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Pawel Zalewski (The Capable Hub) (12):
      HID: hid-input: use named initializer for 'hid_battery_quirks[]'
      HID: hid-quirks: use named initializer in 'hid_quirks[]'
      HID: hid-asus: use named initializer for 'asus_devices[]'
      HID: i2c-hid-dmi-quirks: use named initializer for 'i2c_hid_elan_flipped_quirks[]'
      HID: hid-belkin: clean up usage of 'driver_data'
      HID: hid-cypress: clean up usage of 'driver_data'
      HID: hid-gfrm: clean up usage of 'driver_data'
      HID: hid-ite: clean up usage of 'driver_data'
      HID: hid-tmff: clean up usage of 'driver_data'
      HID: wacom: cleanup usage of 'driver_data'
      HID: hid-core: sanitize user input in 'new_id_store'
      HID: wacom: do not use 'driver_data'

 drivers/hid/hid-asus.c                   |  46 ++-
 drivers/hid/hid-belkin.c                 |   5 +-
 drivers/hid/hid-core.c                   |  18 +
 drivers/hid/hid-cypress.c                |  32 +-
 drivers/hid/hid-gfrm.c                   |   8 +-
 drivers/hid/hid-input.c                  |  38 +-
 drivers/hid/hid-ite.c                    |   9 +-
 drivers/hid/hid-quirks.c                 | 578 ++++++++++++++++++++-----------
 drivers/hid/hid-tmff.c                   |  48 ++-
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c |   2 +-
 drivers/hid/wacom.h                      |   1 +
 drivers/hid/wacom_sys.c                  |  25 +-
 drivers/hid/wacom_wac.c                  | 194 ++++++++++-
 drivers/hid/wacom_wac.h                  |   5 +
 14 files changed, 731 insertions(+), 278 deletions(-)
---
base-commit: c1f7d1aa16a4f3b5d9476bf3716ca6bb8271c910
change-id: 20260427-mod-devicetable-hid_device_id-7f30d877387c

Best regards,
--  
Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>

