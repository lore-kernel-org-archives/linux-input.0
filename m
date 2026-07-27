Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98287412C1E
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164140; cv=none; b=eDEaY4D2f3C0M0IdWbZ0FziDsfElgwdbbzw32E+Mg1h/BqJ4dL3uPXq6poyJiBV72hEyTk83htDJe6EdxehiEUv2v405O99sHhiUYkpktbbCmNyt0DmokdYHg6boUBZHgG1pclSwTrlnrJrbdJphCvsxLaS5IhKbfxdxv+KN8m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164140; c=relaxed/simple;
	bh=fBGzroUl9DZUUI0G/dlKzBWg4ngBtea66SdA+H9JaL4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qX/WO/NCyOdoOhTkTRtxB+RusfLhal78nGOvQNhjH9u7v4tg4XXUPMSAhJzc19REeeOVfFVz3GKRSIV09omujJoh5tB4oEcp3VuGAHGRkmvUdM6hIaobTgQMidpKVjhk0oa/1PKDM+aybEZsWtfUXPVFdq6v7UQCawlzpaoKpgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=iKa2sDz8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="iKa2sDz8"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so12938455e9.2
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785164136; x=1785768936; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kXWsFGU0nwv8TM901U64C2gCELsZ+gdx/YY9ao46jPA=;
        b=iKa2sDz8QMfcuuhgKP3wOJuZUfkW+HHa7D6ir3J1IVeZFL5TskrGuhrltaXXinxnF5
         V+7YBl3XTjU0jh9OXTq1NU7Bv/bFniqyEEbnRlaDEuHJxj9UZIIItxpac8HncOS3UCGH
         HZaxe3VmnvXB4hLDu8uge3tW1edQ9o3aQcSJNikqjYNqthBs+9PkzGKqrvUg//H0NOVo
         Xu45rCPnkry6T1tUDWUcvkIU627fTVNs9iQ9IJXffUalvsjUrD4osQEbhW4lI9Gs8j7c
         Gz2LkEWTn01u9owmuzn521h6PeFDwUs5RqaBjPK5/pq9Eu4pJ8W8oHvZHiU/W6CgcrvS
         Ebfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785164136; x=1785768936;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kXWsFGU0nwv8TM901U64C2gCELsZ+gdx/YY9ao46jPA=;
        b=Tkz9xuRgLonF/3Y/4zzqJpAq/bbUbNV9aZo0oIjxxs4Ityv3/t6u7AMqP/+Ol0Qdtj
         0DU/MiBfHEXl5HQ0mvBRI3FUoLW/eh4AUy/xjZ5l+EuN36IsJ2ctTbq0EKyDldrKUH8x
         nCiO5+JcttX5kukrc9X5cVS4Ti3l1dGgTo+dxtsxgP/BwRcGrgx5K1I5heirCFs88dcs
         U1DSDXJgUNmjLdr5kwljoA3hSWppCrC2e7YnFnGy6G4gDryG9ryUmNSZ+u/ogY37V5Uo
         /uQb8DE09bmD3eX7QKdYol44CXylduk3t/O/DnwbkzIJRJJlU+huNaCWIm0cTvYhCBTv
         z7LQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJqB6VbpKEy3AcZksOsXYw8FUitkl6VTBwtNbtClQsNZcH6jtBfz+DiZfAJ7x8fgjXrMYNmDVemV0zAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfYNiL8+jiA4BT1iy/Ika/K3t47B7fUxeUHct25lzME20ofqAd
	sRmIO2IuGmW2ofniqGLZDrJqhTt5yRrvm+7830G6eG6yvT7bhyBP9AnkwevXeDllee4qNwIJo/G
	4i6FuJx8=
X-Gm-Gg: AR+sD13KlTwLLP/jJ9GSsJ7RbW7eOC1cTExoPaSeyFSR7E7KpAyMIvay0D/FY88t3nw
	hHQbRItpmCpRgVDVe9O2G3mWSru9VECsDKryEvrDXF5J/403Xu9aH753Nd9XTh2GcByoEzYV01q
	6rgHaq3+toGd6BYV00vnm+DG8freIgvF14j67owK0fvGOPldPnAOOYewx6eA1W+0BkYh1A2Pvnb
	AcW6ifFAjiZ+szrNPZML6N0FMRVED9LTGJZ3Sn9o7uAX292nG1QIDCN1BybyIzlenHzA5ughtGp
	K+hzbdL0O8mXfJz78RRALYpEBDucUqe1dStCzn7qIt6/UYFtYtRu+qEkc5yeIEo27V8N5osoKDL
	7tN0qweYHjN9JMWO+8wKAT9Magyf0h9lSTSg+1GiLrq6l0mua04zwEIP0gJ1XqWyzwjOXlejnFg
	XwgoLOyKobqg0LNZN75QU=
X-Received: by 2002:a05:600c:4f0d:b0:495:5d5b:7533 with SMTP id 5b1f17b1804b1-496b6a31f12mr114624565e9.13.1785164135208;
        Mon, 27 Jul 2026 07:55:35 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9928fdsm254241585e9.1.2026.07.27.07.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:55:34 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Subject: [PATCH v3 0/8] HID: storing pointers in
 'hid_device_id::driver_data'
Date: Mon, 27 Jul 2026 15:55:25 +0100
Message-Id: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF1xZ2oC/4WOyw6CMBBFf8V0bU0faIsr/8MYgzMjjA9qKBAN4
 d+lsnBlXJ7k5pw7iEgNUxTbxSAa6jlyqCewy4WAqqhLkowTC6PMRmXGyXtAidMQqC1ON5IV43H
 mI6N0Z6vQO2e9AzE5Hg2d+fnx7w8zx+50IWiTNC0qjm1oXp8DvU67ubXW/k+r11LJQnmyuc/Be
 LtrKypDwAfVZcf1CsKqu4qU7c1XvNHqn9gksUaXOQuAOfwQj+P4Bn54E5JAAQAA
X-Change-ID: 20260427-mod-devicetable-hid_device_id-7f30d877387c
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785164134; l=6207;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=fBGzroUl9DZUUI0G/dlKzBWg4ngBtea66SdA+H9JaL4=;
 b=GLvkcvANNyRBypT9JiLzz4ksxR3VKIMW2Y1/tyiljy6AY80H+6mESXJyAqXhf0HMasjRjDTt4
 I5txnaSu82WANLSEVC1tD6eYuYLaROeYHMwlwf2/flwgdmzmNkGxXPg
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

The 'hid_device_id::driver_data' defined in <linux/device-id/hid.h> 
for the most part it is used for setting HID quirks and
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
that are not defined and matched within the driver already - which 
should be the case.

It was found that some modules that use the field do not use a named
initializers for the field - which is inconsistent with rest of the
modules within the HID subsystem. This is also addressed in the series
as part of the pre-clean up to increase clarity in patches 1-4. 

The actual implementation of the table of pointers approach 
can be found in patches 6-8. In case of wacom driver the sad thing
about it is that it requires a bit of macro magic for sanity. 

However, in doing so it was discovered that in the wacom driver
there is a 1:1 mapping between the 'driver_data' field and the 
product id - therefore patch 9 shows that the lookup can be
simplified as there is no need for using 'driver_data' at all
(it also does not require macro magic) - but it was left in a 
separate patch to show the two solution - happy to squash in v4
if this would be accepted.

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
Changes in v3:
- rebased the series on top ov v7.2
- Link to v2: https://patch.msgid.link/20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk

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
Pawel Zalewski (The Capable Hub) (8):
      HID: hid-input: use named initializer for 'hid_battery_quirks[]'
      HID: hid-quirks: use named initializer in 'hid_quirks[]'
      HID: hid-asus: use named initializer for 'asus_devices[]'
      HID: i2c-hid-dmi-quirks: use named initializer for 'i2c_hid_elan_flipped_quirks[]'
      HID: hid-tmff: clean up usage of 'driver_data'
      HID: wacom: cleanup usage of 'driver_data'
      HID: hid-core: sanitize user input in 'new_id_store'
      HID: wacom: do not use 'driver_data'

 drivers/hid/hid-asus.c                   |  46 ++-
 drivers/hid/hid-core.c                   |  18 +
 drivers/hid/hid-input.c                  |  40 ++-
 drivers/hid/hid-quirks.c                 | 578 ++++++++++++++++++++-----------
 drivers/hid/hid-tmff.c                   |  48 ++-
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c |   2 +-
 drivers/hid/wacom.h                      |   1 +
 drivers/hid/wacom_sys.c                  |  25 +-
 drivers/hid/wacom_wac.c                  | 194 ++++++++++-
 drivers/hid/wacom_wac.h                  |   5 +
 10 files changed, 696 insertions(+), 261 deletions(-)
---
base-commit: 474951e8ec09da4e12d80503063793237ce121a5
change-id: 20260427-mod-devicetable-hid_device_id-7f30d877387c

Best regards,
--  
Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>

