Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464662E7165
	for <linux-input@vger.kernel.org>; Tue, 27 Jan 2026 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510459; cv=none; b=Jn+uKHu+4nNHcYeSOgORtKMMUNSdh0p9rh8lEvhOeBy6PQn0Er6nSwS6NTc9oHaNetgrBt0jd30TR63cG+VmgqXZavcxLitZKCawqh0+UN/NSa3T/eXttNeJlwc+hGOML9Jqe7heaX9I/zQuKWyAAF9Si/1zfETxLqmm4b8ilcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510459; c=relaxed/simple;
	bh=xPVSlWvaet9868GsCY1jJthXsfYn5a7/fBimRT/J9Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kh8e7dVddlzdilmMfMZpr720lPnviCuhaMi9xre99hHZaGg8K/qepDY2d2fYg7jNfNhfrE0BuoYRV4kv4IWtt+HsfOMM59znwoAB/I2hdpU5FnEu+HEmZXUcG94sTU2btHSQMrxc0XsnOGtGbPOKHvNwc9b0lbTHVx7eQDB1o54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8BUvbNC; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8BUvbNC"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso2889380b3a.1
        for <linux-input@vger.kernel.org>; Tue, 27 Jan 2026 02:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769510457; x=1770115257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxx+6jRrhPvMg9VlbKNlTg2M9XXacffYRgMnxqmD5m4=;
        b=S8BUvbNC6fJMujm94XxufNP6OjQFaaVvrmBArsfyIJFnRtOK0h1KnJbrnUWX8xbYgI
         7fTCBlqjpw5rUHbJ74creJ85wKvrsJcRx3jsoQ/ehGU3WzCxbNuvaFvD9cmf40AKb2Ba
         9r+3p5X1Q+WrCqwMiET7hwMzidemcUu79aSdKjcDvC6AMz7n4KeOavp+yU7zTv8rwJ8o
         urCDI21HovFCJnwThY1QcfsJmF3yimUI9X4ZN5pA47Jjh1JnzQAa273gP7JmxGLBQdYV
         2xIZIqfr+l24ADML+J7VLzSiC65GQhWIuChWimo9Fvhs++AFFPob3Y+zi74FOvv07EjE
         eA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769510457; x=1770115257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mxx+6jRrhPvMg9VlbKNlTg2M9XXacffYRgMnxqmD5m4=;
        b=PeNg0o0bjcby4/LT8N1dyRbU8P/FLibqPUQ7pZxQT5xB6DANkMg7NHCEXcWOJhF9yK
         uSJtOgaAYJsxDH8qTQmtJBEfU+ty58tvw+THELSXfSOlZk8N1vg8oSUn/eZuVDcMDXPy
         fbrQfcvwbOLbjhLOPdhpMh26SP9OVCKR1oYw7OR8/vxnGAoH5rq1mfGDaggnhp3N8mE6
         /QdY8TWsqJQZ7GtLTstwoGT1CelhSiHrIW++rlRewiLWJquIiiUeZpNXBo0SiWWkjAWd
         Ia9PzkOHcu2zK06RIJTToFelHGm9Fgm80N6gFxymeX1Sw7wuzigep8Cv5yT0f0Gx5EgP
         m4eQ==
X-Gm-Message-State: AOJu0Yz9IBuoIFalob8NjUdsG+oOAAVIROct40RdrDCr5x7hXlEo2G+5
	BAWuHTwblF+VsfNWF3T0x+Un/Dp2HkmUJNr4mjwmYdh6V8g0ZrhAH9RN
X-Gm-Gg: AZuq6aJzTJs2tpvrVFaVkHh9ozjHy5g02ZtrTKH91bA6SsG7tAcUG0wQ7si3no3erNI
	yrzGDmkk/LWqhjQLC2HDhgn7dhAR5zDpZDwhUGGtek1r9+RSwKJnp9WKO1zkr89u4QLRYCdYkYS
	Rjr6TOLu/Y1C0CGQD4IAPZNb4/Rxk3f/ldzyWMNjBIybWiC3IbpktMEd1L1hv3Ze8DrjTOIjOZN
	8eApDgVSk3z3e9Kzp9t2DU6E7t2/tMlpbUXKegvr/fKfw4blBhZzBT6fiJsewO88stipRzZkSvV
	aEWdhHXJVRQYNLkaL2VqWD5eGa5G+f/0x4g75rBBFf/W2mG7Av4DlIkb2010yH597vrnC6j+BZk
	MJm0RXlEqI1+KuzDFUDnjX2qi0QjLtJi7zN34KdHcFkY9gwFw50ZpGRQMYyxRa/XcbdqKJbMVBc
	2g4/4pm5MDS14osHxEjs9wziCLYSOUjF3lNsHsVg==
X-Received: by 2002:a05:6a00:1495:b0:822:abcd:db0f with SMTP id d2e1a72fcca58-823692c3b99mr1577151b3a.52.1769510456609;
        Tue, 27 Jan 2026 02:40:56 -0800 (PST)
Received: from c12-ThinkPad-X1-Carbon-Gen-12 ([2400:2410:5f2b:700:38fe:3edc:7f99:7e99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82339095c85sm7218907b3a.67.2026.01.27.02.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:40:55 -0800 (PST)
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
Subject: [PATCH v6 3/3] Documentation: thinkpad-acpi - Document doubletap_enable attribute
Date: Tue, 27 Jan 2026 19:39:07 +0900
Message-ID: <20260127103907.20269-4-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127103907.20269-1-vishnuocv@gmail.com>
References: <20260127103907.20269-1-vishnuocv@gmail.com>
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

