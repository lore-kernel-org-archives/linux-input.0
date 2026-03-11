Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA0366563
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239705; cv=none; b=P7yNd3ELSX8VjNLcH7Z2TXv3pWSCaxChlbHnucSdPE3RZCviAxl7/ASS7ZbcLACD+8Q+DU+0pibHzL0oZVHjbxkUtaCKGY78KsTe4ysHUCBVYD5lcBsic2y/gHotyoNCnG5nZycF/GIApFOs2ODG9hO7HV4/VoN/p5HrXK3n+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239705; c=relaxed/simple;
	bh=i2XhmUiYnFer9xzDmhFquJehlBBmC6H0pTBvtA42ATw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PL2WQuZvfdYU2HwWsE8Jm2TFFyKRJltaiRiV8lZ9+p/Ibu5LIWA7rJuADWGChzsNLAfL+NvN8SoWAf88c8gx1eeFOwDHKM9VyldnujB+SXsXTbCwYDzPQOQzKzzbJrmpSjnMK7PC70oMwsjUQVWzZsz0xUDF0Byf696iHh9UeZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd0WzJfU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd0WzJfU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aaf43014d0so104081065ad.2
        for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 07:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773239703; x=1773844503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ha4kqWoqYsblto5PQkRWralkYomP/+jWSwYzX2+nEmg=;
        b=bd0WzJfU2YhgV/2QtHlDLHeJxmJKHuWmrW6vO3qt0i9/PQVdOaJaw90O3ufkWnWSCw
         452DraZfM+bPkqN/dn4N7C3dU33ZbarYrEeTb1mYgOmcYQkgYz5hbGN59+Hn9ZEMPf76
         eLNKVP2bDvKIwhWtW1UWkSlWOnh5kC53S5S1k6t/1l/oycoRrBIl7yavw+hSfevv0NSH
         ALuKPxkG1D+2S85MGA+gWQ3yHGmq5Soi4PkcDnSmDLAEPLH3zWDeW9y0z9VSyeAFhDVT
         EhIOBiqVa8R02IlJcrwXasJDlONIe9lURmtHEucdIEL5OmHrHwQxfEYi12wJnVQcEKd/
         z9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773239703; x=1773844503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ha4kqWoqYsblto5PQkRWralkYomP/+jWSwYzX2+nEmg=;
        b=UTNRxjQ5PMxW3umQBGKWCzvU8ObzNwLjatOgol9Zbwt1ani0F4fg3R3dmjoGTEalVp
         KOGWpxgjaFbfwzudWU3cLqLEb8nMVETLDZl9iIMxjC2lGk5JtSFeNv+V7ZxRxdwuUTot
         KfwvvvHb109BKhDtlnGifkdoXQpPxfDFN6HAW+IAFJV6VlpMNR/i6KlN3dqJftGqLZ/g
         wCbUEMKSqtikcc3IfRiMh4CZfAPGoeNZTBmxQ5pnmi0Tq1F2IRoYouYYm50dzwA+IleC
         9w3EkfHCGb0bP+I5K0tgA+MiMmhQXuJufrlvIzw0R8n2mvgsN3B1Ztn+hwiC8+yOvfdL
         GpZA==
X-Gm-Message-State: AOJu0YxxP2s7/KA+1w08kGPXhCs1Ci2HkPHKcFG3GoWAljpoJeVGQrjm
	J7y40GPu2oQKjnLHuNH55sA+R7JzXEnudqjo7Sqo0V/X6qAR62GM8nWZ
X-Gm-Gg: ATEYQzwtzcaUOvtBEAvP3Bqsqk/kECWTu8yJun6mKUyNYzqHo6/X6XngvrX1dt2GJ2K
	i95109xZfpOBEU8AxMOj6pM0ausiCPj4NL05YjtFxxLM1xQSp41G5LterV2Ut0YJVlGwQmHJCEB
	jctsrZl3eKiViuXclnVirtZOvHs+0LJVfWlbBelU/wFkYqjjKAj7xInBcsNhd6ptxp9o53UplE+
	ku0FzTgKfSAHtEUp6p2jj3jamhJ9f/k9BKpHq5Vx5KIB4lmGty2b6P03rzAvyY3Nn1O3V7sbDkn
	K3PTpxvP341sc4/mmZjqMq6n2P5Fv/Q3zCCAnePDmRTWv5L8WgQ0FPN8ka2RrsE/inAUXC2n/cL
	+WAvTWRKoMMQWjj08jKco6lH5xHxskqpmzoVp/Kv1LVwX/BHQBYohw06hzM/ijY9Tb3wsTJB5OJ
	lF+C3OjC7dv3V4/KC3KduLEhvLk+4tjaw3+8KBxdsQLhJelUn/
X-Received: by 2002:a17:902:e744:b0:2ae:7f7e:93a8 with SMTP id d9443c01a7336-2aeae904128mr28551575ad.51.1773239702933;
        Wed, 11 Mar 2026 07:35:02 -0700 (PDT)
Received: from c12-ThinkPad-X1-Carbon-Gen-12 ([2400:2410:5f2b:700:dd5:d7ff:1c94:3624])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34e070sm26399235ad.48.2026.03.11.07.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 07:35:02 -0700 (PDT)
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
Subject: [PATCH v8 3/3] Documentation: thinkpad-acpi - Document doubletap_enable attribute
Date: Wed, 11 Mar 2026 23:31:44 +0900
Message-ID: <20260311143144.482145-4-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260311143144.482145-1-vishnuocv@gmail.com>
References: <20260311143144.482145-1-vishnuocv@gmail.com>
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
Changes in v8:
- Fixes indentation

Changes in v7:
- Fix formatting

Changes in v6:
- Fix formatting of doubletap_enable sysfs documentation (separate Values list)
---
 .../admin-guide/laptops/thinkpad-acpi.rst     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
index 03951ed6b628..f874db31801d 100644
--- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
+++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
@@ -1522,6 +1522,27 @@ Currently 2 antenna types are supported as mentioned below:
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
+	* 1 - doubletap events are processed (default)
+	* 0 - doubletap events are filtered out (ignored)
+
+	This setting can also be toggled via the Fn+doubletap hotkey.
+
 Auxmac
 ------
 
-- 
2.51.0

