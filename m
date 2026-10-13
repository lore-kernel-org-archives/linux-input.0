Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7659A3932E1
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 03:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862946; cv=none; b=Y4f2OqhTjn2Yk4oH9yilmM+wUYlVE+1qbkt2hSa10UMi8Ga5irYSwyW06R/gRoMUC0Oe4Narg5npCsziJ60xnJS2UJ/nwpQ9uFspu6YCrh/0yUY4m81MAxge6wsqMJ2UiVDz186E8EZ7eYkOUaeftKDlBfvB4D5zgySwEB3B/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862946; c=relaxed/simple;
	bh=r+0rEvl16tl5MFS7IvaIWOTr/Pw7YJ+JGqq+rLFp9v0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P+rXJezffA73grwfYHhyGfeYZ3qFVNqXaGS3uN487UJna6v2Z/W860ZDy26IYLOHvJOZMum/8B6aQDyDEEXFb3FTjWAX7AwX8r7Z9CSGHHgN01E3eogtq4y/ifDJuHwydR6Gnef3WI9JH+wDP2zFkLorXO5k/vmuP0KAWl7X++k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSTvWEGG; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSTvWEGG"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35c76e9614aso224177eec.0
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 20:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862943; x=1792467743; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FcWhYyMaObwSepUpV7jMJrwtLJljkaTCoJTBVFoTJKo=;
        b=SSTvWEGGy+9t+x43ncKuQSN+1W/Mmf6qGJgTVIcQWn3hBDHT6eaWSx/kKyU1HvwGLO
         GbW0rzpiuIHU+5wG1ohOfQIvFH1paE6VUtcHd8IC+XQjrK0SA/Hf0u2U6waAhP95FiI/
         8nEbfsS4cihUFXupVXEDofG6ZW+9YHxgERFl2z15e23f5EOB72eLKEW0BUXOWsEMBbbb
         GU8t+mK+jEEpwPDAbnR4CbAq7BlquaYuoFkgDaiok5gHS0feosILKNW7GVGfMuRpLnOP
         xCd2CU3l4eYrBG5rzRvuAaEDV2B2aqJk+G023onWsVpZXVesNOeSVva3cvBSFt5QU5fa
         jDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862943; x=1792467743;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FcWhYyMaObwSepUpV7jMJrwtLJljkaTCoJTBVFoTJKo=;
        b=E0/7nsNhK+8w6ruofwotIKv1z9/uoX9zVaf3I9Cw8Ko9k8nQ+uvqg1Bvlt5aSUHA6a
         cyctvvLYWPL6GLw3/tGdrbs4yFBv2pqBTuaCQ2YxNUEyVhd7bIEL7VtFwV4JJq17uU2W
         dec2F5n+YZXk6gy2gY4XVpLYr8IjVdUiTmp5VFmRoAA1j8AbqWPqE/07eUB/StCCG9cD
         3SroSuv0LaPveaA7sGPTjHhOk+qYmT1BnwvnifGYHdIIaMd6H+63oNpeBeK1ya0dmmyF
         MBf/olC4zX7aab6uNsF9JlE+JIsVwYWADtN6+TRejsapQqQxmvVv4Eyh3xWhyXDV2b8b
         EgWg==
X-Forwarded-Encrypted: i=1; AKwUvBzYRbRKzsHyyYHNW737Z0sIXzTBAkpaCh3UlL0LDaOfmPyEcnVbRKopthauVV7w+sG6TbrEmNfOkjmy3A==@vger.kernel.org
X-Gm-Message-State: AFq9FYLXKYFq+CT+1M9VGd4Nq6ED7ISbp/k2sKAiYxw5rjz/TEx7M2WX
	wnIIvU1M+2WIrszt7PLBJZmZufBeFSSnU3k2jBr0Evd7DObiFxNn27Wn
X-Gm-Gg: AYBFou0dVvTvftSKH4zK3JezwtwHp2FJvYzEzWV2b2+KlDkPsm/O92ARfWQ+vw8wHjp
	e12eGQL/ELm0atiyABCHb1Ufa7NNn7CfIdk4V95ot41dUSQHJYe4Vq3tJsPLm6GJLbISgyeJ0BB
	gLNgosIkOyvj91QB3uWZ0vjCxtSWIwocjEfp0SJN2Pv2QxK6HTwykURWf9gstTULo343AzPOvb/
	+bbrIgWfWOTcx/1aJyRCz2fx/X8edgnQBhkvxOBfn8uzY13653CJROhjweFLUi6gOfQ8VAxScYJ
	kmyXEuGPxeuA0z/rDta9rDNmzeKxdjYvnmJObxzN0+l6vRRVri2boyIEmyZu1aGPr6Q4OghppIN
	3h6J6CZLVgVESirZk7uHPAqw38WeIZdQiAcjKyGjOxuKc9mahxa7T+Gizisb4V0KM7202uzwxeM
	jO8bmrsaYM/czYFLaq5NRwBhw0qiq/ML8ugnTHhOPEHcGdlE38/77LweaRpygol5TALxwkLBkR4
	8Ad09/0tRxw486JbKBAUfgawJWn5lXOM3iKT/WRScKwvA3vb20KnddsRRVJ8O0/X6/6WxBxZQ==
X-Received: by 2002:a05:693c:87c8:20b0:358:90dd:78d with SMTP id 5a478bee46e88-35890dd07bemr11938388eec.19.1791862943383;
        Mon, 12 Oct 2026 20:42:23 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:679a:f35b:7c29:e0f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm35268677eec.29.2026.10.12.20.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:42:22 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/9] HID: Hardening report validation and unnumbered report
 handling
Date: Mon, 12 Oct 2026 20:42:16 -0700
Message-Id: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJiozWoC/yXMwQrCMAyA4VcZORtYK3PFVxEPMY1bxlhHWocw9
 u5WPX6H/98hi6lkuDY7mGyaNS0V7tQAj7QMghqrwbf+4lrncdSInEzQZE1WcKNZI5WaYWAKXTy
 HjqmHOlhNnvr+zW/3v/PrMQmX7xGO4wMYWcr+fgAAAA==
X-Change-ID: 20261012-hid-core-report-validation-8ca85d385ca7
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, 
 Frank Praznik <frank.praznik@oh.rr.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Even Xu <even.xu@intel.com>, 
 Xinpeng Sun <xinpeng.sun@intel.com>, 
 Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Shashikirana H K <shashikiranah@chromium.org>
X-Mailer: b4 0.17-dev-e56a4

This series improves validation and consistency across HID core,
transport drivers, and individual device drivers for numbered and
unnumbered reports.

Bluetooth HIDP and HID core report retrieval handling are updated to
properly respect the kernel convention where raw report request buffers
reserve the first byte for the report ID, using 0 for unnumbered
reports.

Report descriptors mixing numbered and unnumbered reports within the
same report enumeration are rejected in accordance with the HID
specification.

Report ID verification for successful report retrieval transfers is
centralized in the HID core, with a new device quirk to accommodate
buggy firmware (such as the ASUS ROG Flow Z13 touchpad). Redundant
report ID checks are removed across the I2C-HID, Goodix SPI, Intel
QuickI2C, multitouch, and PlayStation drivers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (9):
      Bluetooth: HIDP: Fix GET_REPORT and SET_REPORT for unnumbered reports
      HID: core: Fix GET_REPORT input processing for unnumbered reports
      HID: core: Reject mixing numbered and unnumbered reports
      HID: core: Validate GET_REPORT report ID centrally
      HID: i2c-hid: Drop redundant report ID validation
      HID: goodix-spi: Drop redundant report ID validation
      HID: intel-thc-hid: Drop redundant report ID validation in quicki2c
      HID: multitouch: Drop redundant report ID validation in mt_get_feature
      HID: playstation: Drop redundant report ID validation in ps_get_report

 drivers/hid/hid-core.c                             | 26 ++++++++++++++++--
 drivers/hid/hid-goodix-spi.c                       |  5 ----
 drivers/hid/hid-multitouch.c                       | 32 ----------------------
 drivers/hid/hid-playstation.c                      |  5 ----
 drivers/hid/hid-quirks.c                           |  2 ++
 drivers/hid/i2c-hid/i2c-hid-core.c                 |  7 -----
 .../intel-quicki2c/quicki2c-protocol.c             |  6 ++--
 include/linux/hid.h                                |  2 ++
 net/bluetooth/hidp/core.c                          | 29 ++++++++++++++++----
 9 files changed, 53 insertions(+), 61 deletions(-)
---
base-commit: b018686719706a781c45a874ed51374a2dc4b767
change-id: 20261012-hid-core-report-validation-8ca85d385ca7

Thanks.

-- 
Dmitry

