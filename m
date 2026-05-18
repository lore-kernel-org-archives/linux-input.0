Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E835481FC8
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120417; cv=none; b=BtwX6JXVfGq4JD5FBxq/ANRXW6mVK8GpOROKCunYHKMX6neDrnVF/2pLGDEbQ7UFT88EZqcwwYc/bELT6iXOFY9OQzDFxhgcDKXeQ2Or7Q78uTDNMmy0hEuRViXKqRR8AFqebACHvUijQJX2LbsRdf2HTF1pgS/gPfcmA6Cz97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120417; c=relaxed/simple;
	bh=Sbm2LDmJokacuCWP0cQLYuqxxe3qmZXlvut8I/qOodk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oTwPj6lOyeLdpjeDUASxWrTcePGwiJWx3hxS9icgjtUOQHx7XCBkGSxqlnG2Jjdmu6GAWgUJxqdS5S5tMVcQ2/rAOjXrK4CvDU3aQXSR6eCE+nFbKS4vBdqdCymTm8n7TY/Rdp0Ieog5Pj6vA3DB4nmhD9alXz/SZPCnLoHm5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=c1iyVnXu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="c1iyVnXu"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48909558b3aso26600845e9.0
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1779120402; x=1779725202; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3cVAsYQ6S3NLWdjNLpjjTkkM7Zt2ga1BrL8eNbgjAyM=;
        b=c1iyVnXuIAGINXELg8BrHfcK7Z2CadvgSASuUnUOVS2wQ2GnExAs6jwI6CwbRptOnb
         vuR/EJjwXypwlB6ijvzfY/7wBsTYeifwx2oZmf82YmNJYvMh1XcK7wLZk+LeAl0zDiC/
         DLLcpr1ijJGjTLBfr8LMUWRVDaf+s8VzT0kDx1syl7ZzX7rHyVD4grzGU6uhu7AtqULo
         TEBsKwSZNUoYSoYFI05gPSnmmr2k4G+GZWhafxDTb9UtRtIM595kaXaHtfOXtxYWRFlO
         7veOhqaivG7Tt43s2RYfRnOkRpGtxuvmP93sjH+5gcMsx1ZeFamy7MxmrMdH1RQB2G66
         r9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120402; x=1779725202;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cVAsYQ6S3NLWdjNLpjjTkkM7Zt2ga1BrL8eNbgjAyM=;
        b=p3SGTUTcgdoO6X8z9olVM9oQVlDr9Dv4ShVeCxjfbtmnB/fy5Vl93+IkmX0eytGRWi
         68jCHUrY0fw0E1hQGD3KOlLVeiB5lnCIEs1Zh/O8M6VYCT6MaP3Bj+nsFEF7P6+nqI1e
         I7s/oj0vJBlwT5yJTpHHbw9uQIXEkKrn4GPAJcU9VYzLEKwqCFpObQQzueqo+XPtKymM
         jMNRanKVLtBEhe68kY4hyPP3WPobuloHe7VWMRqAkNPJDJcf2gsPTel+rn5rIwcIijjr
         8pXaOLlGCBopWHpHC87CLUdhyxNptGpHfYyVvtg6bVZiUdQTXvGDZ9SMXcHPNzxdAY+9
         IYBA==
X-Forwarded-Encrypted: i=1; AFNElJ/jJf5PRreACOwMm3y84oUjzo9r6WgFVO6L6WYA/3SXBE0tHtVUK8R+CAK09j3LCWhRjPe/1KLLUG95DA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfB0q/ga6JKu8MCAsTxxvA0RTK+QbFXhhXO3VaJqs65IlakjAU
	CnqhYkK/6oPIuGz2cMfU2P7kHMPyrxO0gwHikd1KHNCij1wXB8bE3qbT63wZuIGqr/0=
X-Gm-Gg: Acq92OHaqfmuaxX6JoBPh7PRYgR1Xh4TAUlfs00Xbj74CuZWVT18JhGC26j+CXZ0gyT
	yJCTz8eP1GqsRE5aXz2HZyBGcz/RP5VonrkFQpIkGpHuWceO75wdrlrQ70Kk9Nl32cerCwL6y1h
	Pip4zSjm/a0raEeRxfoao5VWo21xuiFXDFKkDk6y05yGHHPofxpLj+uGNfXJg6UeAP+Coog7e6E
	CVb42ULCQgjIZyXVC5eL4Hb91WawQ0YskHzW48du4rvMVsE+EOAHIutzu2elIpQVFXU7ysiwtQv
	Z9W9BjcpJOylLfKQzbJZE/lfjJ7SLIukpLl2XkW80fWG+c1xMDsN/aCMJdHLVUpIx1c+q116YD5
	/SKCgihnckHymPW46nEQL5Jwvh8HbUCU89NQtbL7Gn9axgh4WHo0G33phNhi/ZV8V5vvywkYBrZ
	Ysj/x8EVZqubIGd1pzBRZCmzzLqmQjRWpjHtq+na/p
X-Received: by 2002:a05:600c:8906:b0:48a:5501:7995 with SMTP id 5b1f17b1804b1-48fe63270f0mr195799235e9.18.1779120402253;
        Mon, 18 May 2026 09:06:42 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:de11:5404:1c7b:7b76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm38867318f8f.28.2026.05.18.09.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:06:41 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Subject: [PATCH 00/11] HID: storing pointers in
 'hid_device_id::driver_data'
Date: Mon, 18 May 2026 17:06:19 +0100
Message-Id: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPs4C2oC/yXM0QqDMAxA0V+RPC/QVTGyX5Eh2kSNbCqtG4L47
 1Z9PHC5GwTxKgFeyQZe/hp0GiOejwRcX4+doHI0WGNzk1nC78TIMXSy1M1HsFeublfKSG1quCB
 KC3IQH7OXVtfrX75vh18ziFvOKez7AX6GxAKBAAAA
X-Change-ID: 20260427-mod-devicetable-hid_device_id-7f30d877387c
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, 
 "Christian A. Ehrhardt" <lk@c--e.de>, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779120401; l=4843;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=Sbm2LDmJokacuCWP0cQLYuqxxe3qmZXlvut8I/qOodk=;
 b=hYYryERo8Vhk0g3qc2bAZjLBTyPe8RxsK73DlnmFO0tVhbSfQw+cN6LAx9O0MO1UYqhvo2flY
 UaliEY35cchC85jaXLdErXGiLp4+RWwjf7GeXf8sF9r0T092bkEwAAk
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
 
One of the ways to fixing this duality and improve code readability
and type-safety a bit is to use a '{kernel_ulong_t, const void *}'
union. That way the current drivers that treat 'hid_device_id::driver_data'
as an integer value for storing metadata are unaffected. The drivers
that actually store pointers in there benefit from a removed cast
(and more clear intent) at the cost of using the new 'const void *'
field instead.

With the union in place, some of the existing initializers for static
const data now need a named field for the 'driver_data' - this is
also addressed in the series as part of the pre-clean up in 
patches 1-4. 

It was found that some modules use a bit of a type-unsafe way of storing
integers in the 'void *driver_data' pointer of the 'struct hid_device'
- this required a cast during storage via 'hid_set_drvdata' and a cast
during retrieval when using 'hid_get_drvdata'. I can see why this was 
done - as we potentially save on an allocation - but really code is
more readable and better quality without resorting to this. This issue
is also addressed in this patch series in patches 5-8 as part of the
pre-clean up.

The actual implementation and post-clean up can be found in 
patches 9-11.

The change also makes the code more portable on architecture 
like CHERI [1], where a pointer is replaced with a new primitive
(called the capability) at the architecture level and is as twice as
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
configs set to Y) on arm64.

This series is part of a larger effort led by Uwe [2]

[1] https://cheri-alliance.org/discover-cheri/
[2] https://lore.kernel.org/all/cover.1776429984.git.u.kleine-koenig@baylibre.com/ 

---
Pawel Zalewski (The Capable Hub) (11):
      HID: hid-input: use named initializer for 'hid_battery_quirks[]'
      HID: hid-quirks: use named initializer in 'hid_quirks[]'
      HID: hid-asus: use named initializer for 'asus_devices[]'
      HID: i2c-hid-dmi-quirks: use named initializer for 'i2c_hid_elan_flipped_quirks[]'
      HID: hid-belkin: clean up usage of 'driver_data'
      HID: hid-cypress: clean up usage of 'driver_data'
      HID: hid-gfrm: clean up usage of 'driver_data'
      HID: hid-ite: clean up usage of 'driver_data'
      HID: mod_devicetable: 'hid_device_id::driver_data' add union
      HID: hid-tmff: use 'hid_device_id::driver_data_ptr'
      HID: wacom: use 'hid_device_id::driver_data_ptr'

 drivers/hid/hid-asus.c                   |  46 ++-
 drivers/hid/hid-belkin.c                 |   5 +-
 drivers/hid/hid-cypress.c                |  32 +-
 drivers/hid/hid-gfrm.c                   |   8 +-
 drivers/hid/hid-input.c                  |  38 +-
 drivers/hid/hid-ite.c                    |   9 +-
 drivers/hid/hid-quirks.c                 | 575 ++++++++++++++++++++-----------
 drivers/hid/hid-tmff.c                   |  22 +-
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c |   2 +-
 drivers/hid/wacom_sys.c                  |  14 +-
 drivers/hid/wacom_wac.c                  |  10 +-
 include/linux/mod_devicetable.h          |   5 +-
 12 files changed, 496 insertions(+), 270 deletions(-)
---
base-commit: 25ccf4586bead3fe3cf2c57ff0480f31a0e335ad
change-id: 20260427-mod-devicetable-hid_device_id-7f30d877387c

Best regards,
--  
Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>

