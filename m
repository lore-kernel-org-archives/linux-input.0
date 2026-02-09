Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0028F50F
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 06:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770618894; cv=none; b=GOQpO9pGC6VNwxJlnw7ptA+Ko2qDg4bD0l/IqywGQ0Wyg2egYGQfCjXlVuGZK0P5ycXpHejoihVuDQvqEtCWYHA6lXqoauPvK+m8w1dMZ/MpTi1508/I7L+B+NxkIOJPFdy4WT0hs/M5Ke/jHyIvDqKDBF8JKPlEKe0Td8ZMCVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770618894; c=relaxed/simple;
	bh=xPVSlWvaet9868GsCY1jJthXsfYn5a7/fBimRT/J9Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDDpqM60/xbDDVXzLBI54z1oD+LIaqEu4FZCyHVNvBvgmLyuu8uW18F9OfMtP2CTd6nbskOjMfWhyKlftD9Kjl3OTRNGdyzOLfpmN4AbxIb3CIOkg6z6CRssjFm/2Jn9x2+6k+Xiq5wpZ3KWAB4c3qs1oEv+RXPTa72PVx2REo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIrtZYCt; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIrtZYCt"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso1761433b3a.0
        for <linux-input@vger.kernel.org>; Sun, 08 Feb 2026 22:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770618894; x=1771223694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxx+6jRrhPvMg9VlbKNlTg2M9XXacffYRgMnxqmD5m4=;
        b=kIrtZYCt+ntZFLk8+m/5/ZGUGU0smEuVFkc7WEKr7raz3CxztMaozeDtXPo6Xskg44
         NUjUwU5Pe6zC2MW4xtNwri58qJPj+io8AU5a0k25VYBeD4uYLakDBF5CCesl9y4ZEBet
         T7K0vRAobHdBS++Z8gfYjUnBXhu+lKsRxXMr5V2iVfRovFoHm6GcI+o/XCgMqo83Ac2H
         BjPcC98698KZX1dOuKMdzVJJYWsUfYw+kKjFAOJhNNl0UWbuFGM4TkU6HEnxcLI7C/0v
         cCkdsEBF5RUZbZ/pldzFu+9CFqc2sk1owb+fHv14YuYOdpMeVUxtbyg931RuvPH45WuX
         wWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770618894; x=1771223694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mxx+6jRrhPvMg9VlbKNlTg2M9XXacffYRgMnxqmD5m4=;
        b=cAM69+vJK6fkO6+QwkMyEDL2EklpybDlUw9K+mJp5mGIZtcy5QjM4Scvq926h5rWt5
         MjMbqxg/moBAay3tXIr2P/JYYjcNlGmby1DksZOO3lQk7hE4HncO9gHMBrCCu87jCgdY
         efE6Rp2eQPqqfSV0ecVqOIlaMxUazXn8gBDkxTbHxKrOjyLDbBpUMHijJyxgHorhYs2e
         AMSSBnWvoJn6xTbAw2xIQbMcfdJGY1da9Aw8BtEyTbmAEZmXLs2Dr6f5z1LED+6AJIUf
         mleac05siNkszlmFdNYrihN/ZIRq+ZC5yGz4a0JTb6adySVGtPKaB2yI25ILIIZwh5mt
         nJYw==
X-Gm-Message-State: AOJu0YyA3P9TtcQK4MLTSGHD8kCKuFObwgM9snGX/FC9FF3K+ATVQDu0
	mDS+ELoT3x2o8y9aeWva4c/dcfubwcxczZb/vnvkgzmnZLzU3N01uIf7
X-Gm-Gg: AZuq6aLp7V++FOkN30fRfVxLXZvHyz7lWNe+kjbV9KLmOVb3IRmAh3MFJnahJM1ols5
	xShodPQyejtYluwP2AF5dTFPtTqNJ04bxZwd6HWLhH2bUslivWZEIVr5+6eB8qCHEGxU3qCA9qV
	Z3vJjMklupci89WbNnaHjzcbpCChRzp8p5LnOGvZISI0k45Omwg1dCd+y9F/Y5+xQ961oAeTmw1
	8RUMxi0oMNZ8usua8CAdT+mEpg1Y8zPF6V8cS8dTaHnpFaQqWYnWoWmw7bvsNiYgv5ARrkZwZFY
	OnfuoxbC2+H7Gdd6c4iK36VcDdJHFwwM97hCnTaQXMev0BjsJ1NUEgZfn2fFe2zcTUXwcWHzMY4
	Qjodxkb8Rk5VJUNe0oGo1ss1LGLFcVHKiPfzMlDWWriehBRgC0et5q/7USWfidRo2AwEpeIun41
	JCTTtQe064b2/XNpKlgDJTN8h3+vZzxwP6vnbyVg==
X-Received: by 2002:a05:6a20:d703:b0:361:4ca3:e17d with SMTP id adf61e73a8af0-393acf882e8mr9701322637.13.1770618893792;
        Sun, 08 Feb 2026 22:34:53 -0800 (PST)
Received: from c12-ThinkPad-X1-Carbon-Gen-12 ([2400:2410:5f2b:700:e705:6ccd:6241:6a0a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aa3ec42e2asm83440455ad.53.2026.02.08.22.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 22:34:53 -0800 (PST)
From: Vishnu Sankar <vishnuocv@gmail.com>
To: mpearson-lenovo@squebb.ca,
	dmitry.torokhov@gmail.com,
	hmh@hmh.eng.br,
	hansg@kernel.org,
	corbet@lwn.net,
	derekjohn.clark@gmail.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	linux-doc@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	vsankar@lenovo.com,
	Vishnu Sankar <vishnuocv@gmail.com>
Subject: [PATCH v7 3/3] Documentation: thinkpad-acpi - Document doubletap_enable attribute
Date: Mon,  9 Feb 2026 15:33:55 +0900
Message-ID: <20260209063355.491189-4-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209063355.491189-1-vishnuocv@gmail.com>
References: <20260209063355.491189-1-vishnuocv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the doubletap_enable sysfs attribute for ThinkPad ACPI driver.

Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
---
Changes in v6:
- Fix formatting of doubletap_enable sysfs documentation (separate Values list)
---
 .../admin-guide/laptops/thinkpad-acpi.rst     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
index 4ab0fef7d440..9a660724648b 100644
--- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
+++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
@@ -1521,6 +1521,27 @@ Currently 2 antenna types are supported as mentioned below:
 The property is read-only. If the platform doesn't have support the sysfs
 class is not created.
 
+doubletap_enable
+----------------
+
+sysfs: doubletap_enable
+
+Controls whether TrackPoint doubletap events are filtered out. Doubletap is a
+feature where quickly tapping the TrackPoint twice triggers a special function key event.
+
+The available commands are::
+
+                cat /sys/devices/platform/thinkpad_acpi/doubletap_enable
+                echo 1 | sudo tee /sys/devices/platform/thinkpad_acpi/doubletap_enable
+                echo 0 | sudo tee /sys/devices/platform/thinkpad_acpi/doubletap_enable
+
+Values:
+
+        * 1 - doubletap events are processed (default)
+	* 0 - doubletap events are filtered out (ignored)
+
+	This setting can also be toggled via the Fn+doubletap hotkey.
+
 Auxmac
 ------
 
-- 
2.51.0

