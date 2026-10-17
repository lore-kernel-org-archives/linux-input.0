Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7538424C
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201221; cv=none; b=Q7Bz2N5pFz1n+AsMzTgtjl8Q1lMNO/nUMqBtyfYpUCqaJ448nxizoE8lxvorcoPjZxQu93KVPWwWRcS0+nwXP5CELHFyeRgp31+9Q66RB6cUjNEjknwHc8FJtYrk3PfboaHiBdCQvmhOeqU/DY4Qwg1TXP52hm6jD1YHcnrjmew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201221; c=relaxed/simple;
	bh=lYF78SligfbmmMBdJeZB+swrIY4S2bg5f6e58TpVnhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKLIWPzf3dyNj7gCuWc5eQeegR3eTxBB7xWViUmDbDeLZ+c17YofHXkGqXcTbM0e/YW/o7BKxDb03CXb0NdIQYyTFidoDYp1Aw8g1dIb0HhLGyrK9p7pdEVXbMmc612tlrFDuA3ZQpqRE8f0jopbzCEW2DxLObl6uAfp0g0cXmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENOcMR9w; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENOcMR9w"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35f1f76ea84so760419eec.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 18:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201218; x=1792806018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MprfhLJ+GeuB+aE+V/cNLxEtbCzCGvTLbPrUm1c9D0s=;
        b=ENOcMR9wCdsqwBHJQ0HhhlXCelZsiPI0JfK/1KgkGHtoSIFm32fbiJa/47wbng2RBB
         tpRGThKkIhiVj5s2dx+GujBd5NdAO7nuscTapMrPNCpgoqO4wGBRsIGPTBrfW5pI/aTV
         vTu9c5ZiyWU+mbeUwcQKfOcDD95dzoCnn6yIC76YfzH5UgtvC5TNYs9uw1Q+2Zf+hBbc
         61aucwOAhdLL5bYSPWcb0f9IqFYA1IE4f88wXfbGoKmQ8nNuXgGDlbqsYogH4+HQX9wl
         ljXjGLWOGFaX4ozVWL6/DdYhquBF1l/vBWhJh/T3TfItJhLYyhuOl5ZcAzDy5rWWkAEj
         2CVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201218; x=1792806018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MprfhLJ+GeuB+aE+V/cNLxEtbCzCGvTLbPrUm1c9D0s=;
        b=wCRmkN5cgimilCuR7GclNh/0Rkb0RYr5kjRJmLuXy79y0ZV2vAoPNbp2bYJyb3qIjT
         vARUtB5dafKQW6bbPX2ii2Xx7aoR1eJ5VvDoQZ1Dtwgzxa1Pp+wh6J8h8Q3XuC6OkxpA
         xFQLBmfPkmcC+VR7l8j30mQChy0/zq9jUbc5yPdDhQyUaI6olsPmFAI3N76mCgrGoM3K
         48gcT4R0QFy0km/212o85O7Lbn5Gp2y1LacDSP5iNANjOYj/JjLQAeXPjgStBOgqjAR0
         PHj+w0FwCnpt3Vx+Laz693UbWA8/dz2wfM8/CvFsv6pC8tsFYD3lhgw7C7RpFnoSf/jO
         ms8A==
X-Forwarded-Encrypted: i=1; AKwUvBxENRj/AkdoumZXPHgyHwQkANYsY0irC0VCI9E8t0cFB4UKgy0Eka9k7S1FskmZ6q7wq+7QjBV4knKXaQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLU9+uZ92zJRAnENyKv/tKL1QJRXYSC1xQbyHvQrjusRpYJwGZ6
	3Dbynw0rQSa310J7y+bt312XjOXiDup9xp5i9H28JLJz9dzqdHj+lYC8
X-Gm-Gg: AYBFou2pZgwGQkK5GU+xnJ1pKgvnnpE2z/M9VuTPMcnSZE8NSSbwWcChCoFdOL5Bq9C
	zQbPIe2dC/QxOBytVtitYHPxdK7KsEirTux2B/CI/4sARbJqfu3k3w5G/srruCxY632kbEzjcDd
	hukJwCGtX30J9bKKa7pwxL9YkR4E6f9mQu3iXAryGVIBpJWGAhZkHp/tnDfU6PbKeEDowSRk48i
	OEVhKdCteWT/J8ahBb9fS7OXJlhd1gVsT9F3UIonsQ7dcfNXvw1U+s1Kq5nbC6AjQUDcVO0Hl6b
	grU0B/04F7hI69JFiJzFYlaGgULgSEBQOuXwTMePzrMw2Qf0VvjvllsjdyJblkqvLvJ7wY34Y+8
	/IRiHdcoUSsNT1C3hKkrZmZH6wkFk6j7vRCF5iQjcW6Jv4RY5DraiOVpq6y7eUc0O76pKCy7j/d
	XJdn6JUGaQzFFNa/8K1OMGH+AEcKQMRDTXbBrb8dcxQkpQ7SO4EiVtkMK0tOHSowU49eOSDMsdT
	n4t2HrHFQPL3WN5sEj1ENcAdRK6/QI8xHCc9odiWA9kAiDcJ51iaLjxZ42/3oKsq9niXUGk1Hw=
X-Received: by 2002:a05:701b:454c:20b0:168:e942:4e62 with SMTP id a92af1059eb24-18515691e7amr1818692c88.40.1792201217543;
        Fri, 16 Oct 2026 18:40:17 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:17 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 11/11] HID: hid-lenovo-go-s: Stop and close device on probe failure
Date: Fri, 16 Oct 2026 18:39:56 -0700
Message-ID: <20261017013956.2440130-12-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If hid_gos_cfg_probe() fails, the HID device has already been started
and opened. Probe failure does not trigger the driver's remove
function, so the device is left open and running.

Close and stop the device on this error path.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 1a2b28e1bed1..694b329f30db 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1786,8 +1786,11 @@ static int hid_gos_probe(struct hid_device *hdev,
 	}
 
 	ret = hid_gos_cfg_probe(hdev, id);
-	if (ret)
+	if (ret) {
 		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interface");
+		hid_hw_close(hdev);
+		hid_hw_stop(hdev);
+	}
 
 	dev_dbg(&hdev->dev, "Started interface %x as Go S configuration interface\n", ep);
 	return ret;
-- 
2.55.0

