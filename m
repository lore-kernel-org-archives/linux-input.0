Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB94C9010
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689980; cv=none; b=PaL6Ebz/ENuenolgUGBdzaaPpybLXfZlAbCyGZpMBIW8an1YCCJ/d126lBo0mAbURoAeP+/VAJMdFgEWIR7jxko6JL+uCGINf1849/+vvG/Jt7qM8y6KiaWlRxZ84bpNphR6h8KlD53N7J2PX1wI82VaK2cV5G0Ibu3ZHmjYpGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689980; c=relaxed/simple;
	bh=RXKqAF7NACWant2x46XcA38zp1Twa8tEEs6+YiJF5lE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3trlMFZBjr5YljdXi/nPCNE94qMy9cNHjaTX6sCf3I+EvgbacOWUY009AM7C6xPL5SpG+IwsRrgNpxILtqy6VaOtcvk3PCZegOCqpzEzFMcvwyOLfmBtJDc56DyNleV1xztjp0JgrBGFBypObEhiaFv63pPBqAdX9FFXTChNy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk0MN5kG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk0MN5kG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891f625344so64193395e9.0
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689978; x=1779294778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+E3pHdpCC8si9eqo2CHi9ZSS8Tic6LvaRP1Yqyk6oA=;
        b=Gk0MN5kGfYQj61ABbE7AofYYVY7kBiGV5ru9RZgahDP4bpIaUGGiD+k+ktRDR/JyJt
         jn2/k16hzzqYf5nsl62UQBKMtadVOKZVcqkLJSvyeKFU9OVHx+/Cx3wMJ3BCsnB8ivYG
         n80trnKFpPKtJ7HCnO08Mlbc4oXzbFH/xwM7t5f3RQLoiZ08qT6SwMQNXYtiJaSYkCIN
         qnvA3iYezb5Qh0t+B9RCNKcggxJGtvsbpNg2CPVNwH5cX4H6HADOEG3i33K0Q4Hcw5UQ
         Nafstzc8d2oy5YIY5G1ndDcHZuEsiMWfWYrR3dzyZz8Mp0dDgC5E8MbpQWHzHb2fWqDJ
         3HCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689978; x=1779294778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U+E3pHdpCC8si9eqo2CHi9ZSS8Tic6LvaRP1Yqyk6oA=;
        b=ZsckR6QKk7tu4CJNBerO93DS4EQh9RGMJE8R2UVXEuqE0Dsy+JAmnWuEfUvmUyAoHc
         acvbZJA7Ne69wIYLWj7fkA7QE7dMMyBWUU4DErKfHARyUr4Rz2uvZg48TXvMqxLVFVey
         YTdG7M9opvLwiW+BWb4zIpUbhONdxZEfRqohFoRMAQwZoHYNst0sCpGaXLJASuGuwMnI
         oFRyyDDiFCl338u/SRwKC4b1c21fBo3kQtBz1/bdiyPay5cmfBml6F9I6c5d9538YEgr
         iyONfUALElewQThO5UTblNffXhkzXpi3TZg1zEVqhjJO5uSAQRnw/vcLL4lOVsga9iOv
         MgnQ==
X-Forwarded-Encrypted: i=1; AFNElJ8iCwp5oiM6THPGiCYdZMYLFt+hOEzFE1e9Rot61uBtgFAf4ZjWIpdcNAZS0sHTr7AWiAuT1oq/NxQ/5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPSKWeXQUHoD3vu6Zd/PkL9um1U3xJfyqKSGG095BQYKuDH0ee
	B0oabKb8J5iOChXXjf2nv5Pwjhr8g5F0LtjXNIiXc8A5Ps3WXTottgrV
X-Gm-Gg: Acq92OHcA0/XkqBQZ41lBl6t4ZrImvmX0cuCZljnwQyXW0tnrtMBV73MPlR7rpMJAqQ
	NgGDYtkwVK3Rg3CLjOs8sF0LmsxNZOqcVkeLhLbTtYYeCtkL+KlRBO00HzgwV/SzzKLDyuqxPNn
	1k48gGY1cDWLxhDPCEJJgpsMTYd6XoqO/ZrApC+ersi1hJvFkg1DgHhQIV5ELLjgynxxWup+2mr
	FR1FnVc0xt9dNESZlo3sVlELjJ/1OuF/dLUyQbJW5RhUSz6kgYTL4RyQw+c8oxE1+bshMpZwHjc
	5Gp5kT9eXhdV44eVHOpLUcMfvDEI3Vn77TkwSkqV+PfKBeq/VA8gNFA/IOUhPxfW50M0SflXSOx
	TOWVTuLVvzNueIdwkYtNuKEQKcZpFvgeriFN0jt0c4oqhVBXsIp/SUmHICDDP/wllBYnX/GsUFL
	DFuOsLSdmm9aGubT7BgFPQnujqZovYWDjV0UEPDpSE8c2ysJ0cWkBrPoeHBeckyBd5b8NtzIaSp
	TuUy0o=
X-Received: by 2002:a05:600d:3:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48fd6341118mr2492845e9.6.1778689977482;
        Wed, 13 May 2026 09:32:57 -0700 (PDT)
Received: from gmail.com ([91.126.139.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd62b4c56sm1232785e9.15.2026.05.13.09.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:32:57 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH 6/7] hid-asus: Allow adding custom hotkey handler logic
Date: Wed, 13 May 2026 18:32:47 +0200
Message-ID: <20260513163248.16483-7-p.pisati@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513163248.16483-1-p.pisati@gmail.com>
References: <20260513163248.16483-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Leivenzon <hacker1024@users.sourceforge.net>

Respond to platform profile cycle key:
Fn + F on UX8406MA.

May vary across devices.

Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
---
 drivers/hid/hid-asus.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index fe52fd63d61c6..37e3aec612b6d 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -29,6 +29,7 @@
 #include <linux/input/mt.h>
 #include <linux/usb.h> /* For to_usb_interface for T100 touchpad intf check */
 #include <linux/power_supply.h>
+#include <linux/platform_profile.h>
 #include <linux/leds.h>
 
 #include "hid-ids.h"
@@ -362,8 +363,21 @@ static int asus_event(struct hid_device *hdev, struct hid_field *field,
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ASUSVENDOR &&
 	    (usage->hid & HID_USAGE) != 0x00 &&
 	    (usage->hid & HID_USAGE) != 0xff && !usage->type) {
-		hid_warn(hdev, "Unmapped Asus vendor usagepage code 0x%02x\n",
-			 usage->hid & HID_USAGE);
+
+		/*
+		 * Some reports do not map directly to standard keys, and need special
+		 * handling.
+		 */
+		switch (usage->hid & HID_USAGE) {
+			case 0x9d:
+				if (!value)
+					break;
+				return platform_profile_cycle();
+				break;
+			default:
+				hid_warn(hdev, "Unmapped Asus vendor usagepage code 0x%02x\n",
+					 usage->hid & HID_USAGE);
+		}
 	}
 
 	if (usage->type == EV_KEY && value) {
-- 
2.53.0

