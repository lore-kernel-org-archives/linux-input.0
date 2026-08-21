Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D24B379998
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 21:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348913; cv=none; b=lDX4wRHMhYZkjV6Mt+Hau+MaZhnyCZDtSPSAe65QnHnI4wNH3aSgA4jWPPFi5WB5/eaXpafpHMO54cuEPQXZLUhlexpoizj+aAZpcvddyUIszL1U/UmDjvMuN3c0iYbGyxQYs34U1r9uOrU8nTlmf2YEHmlQLJ4Bewjt2n+9cn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348913; c=relaxed/simple;
	bh=9tTCiBsEdE1dnHRkaKwHZ7kfO8yZ8iy3I5fruJqkqPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUHkDwgwfb9L8Oiiuw5QiFAYLTbHulu8BPvKD9NVYVLddjjddyyAV2ESER2B26gJ2BIyRnipSwJ3UzdXuQVecQeKYs9FzH3vDeHlbJN9kUr/jNfAJD8NrY0JTm/GgEvBcapnyzrQUPrj9/5y941/vdcBLVVjScYn/bsxNab52T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCrtFZ66; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCrtFZ66"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ce7d2adef4so21115765ad.3
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 14:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787348912; x=1787953712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8EgesNwgmXg6jThwtN+Qswez/+1KXP6V1AeHyV0DsAA=;
        b=OCrtFZ66QmJBobrZim4TdCELaMJAsquZLD4frrn6Sc87qW2WRsPOkQxb+CAlqE5Td6
         wwCBTmmgTHFJGzRdG19pjoiL3wGDpeHSaO/94Qh0mO2tx0Tw+PPevJtuTbOLP5P3xTIU
         pC+6k+TOJodUEFoo5rSJyaGqnDvViuACsYcsHbzdyg/T75S6q1TKi2zUydbSchv6+zpd
         mT4mcHHQSjArb+XfE4lcIWqVbBQbHSJ/yp44VrBzykdqbaa+dVqKBu/E64vXVsQ1c5dD
         hAXSgJqK5seNkwVglQFIEO++loIkJBvaM7UeseX17VUDNpnqp7UZ75TueS6f8R8dbpJJ
         b9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787348912; x=1787953712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8EgesNwgmXg6jThwtN+Qswez/+1KXP6V1AeHyV0DsAA=;
        b=mun5beGPQ3mYxVwAXvLse3PTKAACEZFImTEfMj8hKrIDnyHANQHbq8a7GBhI401YDT
         v/FbJ9UFufOpx62h6OhBY5HJ9loKumM8Y/jWORq8j06aA31skYkjE8qmDbrbwLN/zuHZ
         WNugIXzTcyTduyjt3DDy1dDy0tfIDrXnODi/8rPOZEeI0tRStw8fmEnhg4Kjtg0SfERF
         hkO++iqFCCRpbJPCJXn8BKYyOjDxhwsHKO54u0dyjO7zsnv/wdAqnXegmJfFUX9YSs8+
         UIRBHJr5NkSR0TJ4Yp1vpoRGihjsa4EnNMAzyw85DF7FK4oltcsyz+ltrbqqY6tixIOZ
         /jAg==
X-Gm-Message-State: AFuF++ln5CI+7WMF1p2Wx09QlFtsdby3FFGln5L1/FKltIdkeEHmqTnD
	+uR0f+lk1iGz3Un3mUpiLmOZRB/k+hFuLbMEoABOvu4j+UO1E+dZT8do
X-Gm-Gg: AR+sD11AhoFDJ6d0r0w7C9MoagkISs8s+1+oiOlBc2Jy8pwvEpM4AstPLmH7Du8IIhd
	09VTT0ZbjA8Ob5U++QVwZ4Tyj5x6mntQl/EpGx69i/U49kdV7azoub+rWGhmyfmZQVrgGUKnbyl
	Y0ArbRrioBzZKZXQEtxJ4Zt96az3RsPhWZz9CTnWArPUBT8gvAZdQXwx/I21Oh9A5GGKTctl4eE
	QpehUe1UrJ6nWcuAVBVsU76cph/+4/bRB3Bn1vT55MsIUY6q7NuUC4oi8zkuLgE44GZeBtWcbgv
	gfm9xW26V1zH4x2ok1DwUE/sET99QjwjHqLBnix/zkzV5WeaKLAL31gzCE+2MPhBJ3oBkRFiGeH
	xhjHYZHWKahofNSsSkCvthHyrqT+796S6EcIGiqEA9ZoJKTvkhH/OSgpyGCRNeOIkMvqvXO0WRz
	1kr3xvdVEj6kFSn/en5rSwjEFuE3GCij1yL7DPlqhsaREpcnaDrTlOsvI/DfxHx7/J3oaaXphsf
	WiefhSg/cQzZim6F1s=
X-Received: by 2002:a17:902:da82:b0:2ca:61bc:317c with SMTP id d9443c01a7336-2d64b17b564mr162561685ad.13.1787348911614;
        Fri, 21 Aug 2026 14:48:31 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3bb46sm27276942eec.3.2026.08.21.14.48.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 14:48:31 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] HID: hid-lenovo-go: use the right controller selectors
Date: Sat, 22 Aug 2026 03:18:09 +0530
Message-ID: <20260821214810.87826-5-mradityadash@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821214810.87826-1-mradityadash@gmail.com>
References: <20260821214810.87826-1-mradityadash@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The right imu_enabled attribute selects FEATURE_IMU_BYPASS, and the right
reset attribute targets the left controller.

Select FEATURE_IMU_ENABLE for the right imu_enabled attribute. Target the
right controller for a right reset.

Fixes: 82cd9bc866e1 ("HID: hid-lenovo-go: Add Feature Status Attributes")
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Aditya Dash <mradityadash@gmail.com>
---
The corrected right reset and right IMU writes were not tested on
hardware.

 drivers/hid/hid-lenovo-go.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index d2d134873dd1..1e6915c969d8 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -2006,13 +2006,13 @@ LEGO_DEVICE_ATTR_RW(imu_bypass_right, "imu_bypass_enabled", RIGHT_CONTROLLER,
 		    index, feature_status);
 static DEVICE_ATTR_RO_NAMED(imu_bypass_right_index, "imu_bypass_enabled_index");
 
-static struct go_cfg_attr imu_enabled_right = { FEATURE_IMU_BYPASS };
+static struct go_cfg_attr imu_enabled_right = { FEATURE_IMU_ENABLE };
 LEGO_DEVICE_ATTR_RW(imu_enabled_right, "imu_enabled", RIGHT_CONTROLLER, index,
 		    feature_status);
 static DEVICE_ATTR_RO_NAMED(imu_enabled_right_index, "imu_enabled_index");
 
 static struct go_cfg_attr reset_right = { FEATURE_RESET_GAMEPAD };
-LEGO_DEVICE_ATTR_WO(reset_right, "reset", LEFT_CONTROLLER, feature_status);
+LEGO_DEVICE_ATTR_WO(reset_right, "reset", RIGHT_CONTROLLER, feature_status);
 
 static struct go_cfg_attr rumble_mode_right = { RUMBLE_MODE };
 LEGO_DEVICE_ATTR_RW(rumble_mode_right, "rumble_mode", RIGHT_CONTROLLER, index,
-- 
2.55.0

