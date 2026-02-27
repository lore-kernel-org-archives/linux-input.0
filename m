Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC357477E3E
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225710; cv=none; b=CY/nWvOipqW/JPj/HrJJOYJJ6GCuLtzpyQ0h9krUN2FJSoGvQZtaDxtnZ/2qROa/jgIxp0qAXFIok3KUxijkcHVvVZigsuWJ+qcAHQSFcqhu2bBESR468hinifmc2IGHxNLA+3fgvPSMEXXKg3nzkouy8i6VnYXFJVDiQ37Cq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225710; c=relaxed/simple;
	bh=9NIt0LDmVzP8O4boMraBtvrv5bDGxJ2VZ6TZ9AQn3+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPSEF1yIb1ICi/E1pjMRfJImpl3x7o9tbk3hBXUwnXZ2ECAyNIFzvokmChSLUGWVMoHPOzYsMZKwwEwtYV7ZfIcHtBZyd7AtgszCIL0+ZnBkCZ9iTgOm0buzyGC4b+Qt4PQPyXsZxH7AlaYLmt4egzCvou+HiLzGDAY00WuXOWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzW3jGAJ; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzW3jGAJ"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64937edbc9eso2386019d50.2
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 12:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772225706; x=1772830506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZ1hJ+pNn6Hb2WoHwRCbFIjmlbpk468+7oSIaJffrks=;
        b=YzW3jGAJz5eus3ptBKiMVASuQOgFwaeM9jFF8aWePmzkzJmZX4L7cv0OPEC1c8PfKP
         /Ihpd1ZM8X54SadIAhEaKes8g6EZZHeSgXqu+ZnQPo4dBJ6ruSewsMiO93CsfGnAh8mu
         nQBfN4hsW2EBIgATHBX3ZfsCMl2gTdHbtwWCfdyad5su3VukpySu4mRESLMAEMyg/nwt
         MbboF74rINnmV2NWpRX4nDDqwh1/WAFt+9S/5HuA0AsJ77IRA+yRJEdhkXZKf+wbzItm
         977WvXacEoQ3lASF8keONPp4Rwygf3bbt6Ukp2Q+/wFwp58H4qlqG7QqxvyOIgz9pqZT
         0fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772225706; x=1772830506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CZ1hJ+pNn6Hb2WoHwRCbFIjmlbpk468+7oSIaJffrks=;
        b=BGcDQg3pveqnQX3Pk45sv8g1yLz+bPs7MTZNODkuIEURiOnHUx78lBz3nYvlqTLzKD
         fk5P63znsfLNX5kyKdK2OSPeuNRXaSZnqiib2BGxxBTXMAGgsFKDB+csiaxMPzOKf0RN
         8o2DZ5PHFDpFy4O5C2/3ruraGF5bX3GmS3NeshpFvSuI/jCMfWAYkNy0XSX7Zi4jPp+x
         neyfZBDhnKe7tJxCzW+JOlT0LukmPqv/fBakbfwHgMIsivy9SCULozS2QKVvoCBF9TjL
         N8QBX+N5OGxZRtnYBl+WKJPIquLkusDKNnrMJ0HPRyDsW/dP4DTN2O18pmV/OjOnndbM
         FvlA==
X-Forwarded-Encrypted: i=1; AJvYcCWOz6Ilvi3UGMUoqw34TYnHxbbiwEMVvv/tEAhZd0KT1gB0G91NtbsqN7vhd7uu+RJyyqlGzgCiwBk63Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm2eThOVhVO+Pd8GicwsbIQau5AwWdGMNH4fr749iItJcXCVVz
	ccxJsIsdZ9jF5Zsy/cTDjMbZO11fOBv6Iw1l8/+xQEK3W7dBYXQBa264
X-Gm-Gg: ATEYQzyx/eC8B1AgK1tAJpl3GHeuzpxIxSNULeq2/Yy84pqs2lyT7xXuee46FSLAtYX
	J+yA2HTsYRRnSHxercSM6a3DPqm7VXY31nZAM0EwFzunrjlAI/NF4b8bMWDxNSAGyC4IwTJaonC
	8tvIXhMLc+XamXmWU+9OxY2yUX5zZCu2NgSdjBETpuh5Ng7vYMGbzCPdBiIp0i9yjGQD6/gpJIM
	XOx9gtH7odWMwOgOK01VEizIHhUDLngzf0aYfchWkZo5O78RpqK50YmCxegELEYDrg8iU5yS60W
	/M1GtS9Q0uKv034XeCHrekdt7fcVCY/BSTv9vN84e6PZn16vCEdqM5v1wrTAT3ZTzRA4Le+xc7Y
	KGt9EzCn1KP/NgcgTe6Yj7rP+yv68/JAXKj7G0ubx9Q4OnBR7Gs4bG5uQZ3OE5LcRIhkmxAl2sH
	pKKiGddryGpGi+LrOKLMw2+6tTu/SP9u5D8SIqpdDTBdc37MMXyTjqOQiHucD4S7pb+lA/UttwT
	UvEYQsmSdLnXs7KZWIzJ4yO
X-Received: by 2002:a53:ee68:0:b0:64c:98f2:272f with SMTP id 956f58d0204a3-64cc23701bdmr3319500d50.74.1772225705759;
        Fri, 27 Feb 2026 12:55:05 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb7571e00sm2805811d50.3.2026.02.27.12.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:55:05 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 2/3] HID: hid-lenovo-go-s: Remove impossible condition
Date: Fri, 27 Feb 2026 14:54:43 -0600
Message-ID: <20260227205444.1083103-3-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227205444.1083103-1-ethantidmore06@gmail.com>
References: <20260227205444.1083103-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable val is of type u8, so it can only be 0-255.

Remove this condition.

Detected by Smatch:
drivers/hid/hid-lenovo-go-s.c:508 gamepad_property_store() warn:
impossible condition '(val > 255) => (0-255 > 255)'

Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 0ef98ba68d86..a24737170f83 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -504,9 +504,6 @@ static ssize_t gamepad_property_store(struct device *dev,
 		ret = kstrtou8(buf, 10, &val);
 		if (ret)
 			return ret;
-
-		if (val < 0 || val > 255)
-			return -EINVAL;
 		break;
 	case FEATURE_IMU_ENABLE:
 		ret = sysfs_match_string(feature_enabled_text, buf);
-- 
2.53.0

