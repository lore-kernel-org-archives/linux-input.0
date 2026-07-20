Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C913D3D10
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542506; cv=none; b=RIemXK3RHVconm+9dF4WSec2iZc1ye8S9ad5w57PqxP7MFCaCgeWujENDxZzPkSYDHFo+wZNBtZTnbtkBB2BeUFxtQeGGNT2OeQApfaWoba2cMJO562PYEIgXrETyYSSmcPdOjyFXqj2OI82d6RthBmrPezXqsJWTpaXL0kNYeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542506; c=relaxed/simple;
	bh=NhumDAPtVfA/+OxCt91N4vf3hIjURO6jz1ij/AUKMFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fs+7lgsEJrQJ70GHx0u+Ha7OSAEXzMLbJsaoh8LjtA+MqUtoCZdj3R3NHJNoim28S+NRX+aY2n/lXIZtaoid4QmnuoQw0vebBajrTCVB10mMB9WDfrJ5lAGiNIP+zOgSXbTQwNSZLLEN1XIo5mPWTK+1r2nLD/q/XRXdkcLfEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c95d0a54ea5so7274455a12.0
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 03:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542488; x=1785147288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TnC4sF8YJwzUoevHGn/VBk+2Onx+uhb+pGRw5Dnqm7g=;
        b=NcsnO4MFY3H24wxDzsvSHYklS25/cCQgTvH59ltKBnGmjB02Rq8eDiLxwqmLEnw7FB
         e+/J9kyjuq4MNQHoT+nAJH9QZ6AY3SGQLnwzaVw6PliA5wlIZipvG0v1n9sX8GQhWRAr
         RY+6S4ImFGujaI7uyp53gPUq43cvrnrrsz+w2ybiKlV1LE3ziZtvESS48cfpAf/05QVT
         4kxlxkxDaY9c7DqegHHnooX7mmUhmb4Iy2tab/VfCgegrZtLU1+ewdoLDbNA578B41I9
         VP9+Kby1f6Beo6rhOIVtMPA5DwDK1eRVohQouQ6gcKW5f2P9zvY9NtAkgxNBdJR2xzRI
         qx9A==
X-Forwarded-Encrypted: i=1; AHgh+RoaMQfQgNWLJY8s7ea1NCZlqTMDUEzRM0DFatJyqEphP7VtyeMZoZsVJenZCMDVehdALj/Ki7yJ0k7rvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzFO0mri3DZIp00esGZewEwUI3ERM5pmQRCY1nbbliSnJDoQPj
	AuX0KTqNVMC0DFujMPp0D/Ya0tToeLyCGB/+ujOmxIXnRLQXut7szCtmIl5d6FtXMA==
X-Gm-Gg: AfdE7cn9Q98ZiWDbBc/rMZsmbL7MCljiH8kOdOlmaXFfX0nA34JpiiWMhCu8qPmY8Tk
	MTLxmqkhOAw5XoktfJDWx4iie8wU+PpA8Jo27vc8/P95YArCH/zPKx76omQawAob9IdwutJWxcW
	4yTGMz0YSoJH6+FaxsR6LV9LDTGTr998G9IYro/UdhgnsnGAWNPU6pBqTfkPgyT7D0HDtJ5debC
	MdFpTKF46Xf3Gsbw4dkfbiIlowy2v84fkZoFtuzfE3Hwe+a9LlpYZkPw8tVSfgrNSdO0FwQYREG
	r9yt3Thvx5KOBwQWRX7bAs1mSOQXF48uWeeQtbanCWXtSLyq1oulkytA533X/Z79pCJDvh16tHZ
	t3Ar05SbsDgHNt0/7vcvi5kUM3C1ibZfsE0fhAHTHjkByrwcd2XU2TW8OGbw+WbuRy+3TWetzRA
	4kWTB9x8hfGbE0KdGvaAzmoAD1AkxkhBo/CNEHB1p5vVpxneTt+SgzqojzJgV43UBddPd/A9TL2
	I3vAiwFOdjJBE1HUA==
X-Received: by 2002:a05:6a20:a103:b0:3c0:9c1a:8941 with SMTP id adf61e73a8af0-3c3ada59cd5mr13875315637.73.1784542488359;
        Mon, 20 Jul 2026 03:14:48 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb517f94c31sm4411321a12.13.2026.07.20.03.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:14:47 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v2 4/5] Input: applespi - prefer asynchronous driver probing
Date: Mon, 20 Jul 2026 18:14:34 +0800
Message-Id: <20260720101435.13612-5-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720101435.13612-1-fourdollars@debian.org>
References: <20260720101435.13612-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set probe_type to PROBE_PREFER_ASYNCHRONOUS to allow the driver core
to run applespi_probe() asynchronously. This improves system boot speeds by
avoiding blocking the main kernel thread during the 3-second touchpad
detection wait.

Additionally, clean up applespi_tp_dim_open() by simplifying product ID
retrieval and avoiding dereferencing touchpad_input_dev without a helper
variable.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index 42b7f87ef2cd..95a8f790eaff 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1027,12 +1027,13 @@ static void applespi_debug_update_dimensions(struct applespi_data *applespi,
 static int applespi_tp_dim_open(struct inode *inode, struct file *file)
 {
 	struct applespi_data *applespi = inode->i_private;
+	struct input_dev *touchpad = applespi->touchpad_input_dev;
 
 	file->private_data = applespi;
 
 	snprintf(applespi->tp_dim_val, sizeof(applespi->tp_dim_val),
 		 "0x%.4x %dx%d+%u+%u\n",
-		 applespi->touchpad_input_dev->id.product,
+		 touchpad->id.product,
 		 applespi->tp_dim_min_x, applespi->tp_dim_min_y,
 		 applespi->tp_dim_max_x - applespi->tp_dim_min_x,
 		 applespi->tp_dim_max_y - applespi->tp_dim_min_y);
@@ -2015,6 +2016,7 @@ static struct spi_driver applespi_driver = {
 		.name			= "applespi",
 		.acpi_match_table	= applespi_acpi_match,
 		.pm			= pm_sleep_ptr(&applespi_pm_ops),
+		.probe_type		= PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= applespi_probe,
 	.remove		= applespi_remove,
-- 
2.39.5

