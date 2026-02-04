Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0632236F7
	for <linux-input@vger.kernel.org>; Wed,  4 Feb 2026 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211903; cv=none; b=gXo/HR5RsSebhNVyAe4ToA5q/eTvMo9eYk8OEByjO5481jvvrPwzvVbfKvPnQOxL9/KruWV00A9yQlkOMROKNdMd6O+NuM2IW36nEV2A4iY25lM/XBQJkfIX5x966EBbMZJ0r7S4H0/Q3Id5ZKd3D7jtf8wBBH0Spwv4pscouHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211903; c=relaxed/simple;
	bh=ofTePwhQvxc1sldT2RNrKsJSDIWp+FzXTAMKALZ3ywo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gGNbLZaGCY5E3qgxG2/+bYffuev/piloAVPmFNrNsXKgnBBknS5MBBBuzMvPlQ23yXD713FixMn5O5qZ/in5winwAE4jqGNMIPYNbkNnZ8tSQTuUb9f/uWJSLcd2469fZ+Gh6QV/2gkSTl6D5m5qds4sg1UwvYtz9YbBzK3snjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K71PhePR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K71PhePR"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4358e24d3c2so475564f8f.1
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2026 05:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770211901; x=1770816701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ2iqW0pbEB/NBB0tS21N/N2tYmqwzVrEmtDuIx4ZgI=;
        b=K71PhePRZSVhIOMp1FKSifrfLRQyLo0d8Chr8cDiDaKozI1VE9jVdQ55SMVMdVwccv
         Bhq8FGsgzGsskn5s0rQRaSIOEs9oKZPndqJaLTGrB8O8cX/NsmDFkb0iWDY8Q1pEQHuy
         udzTLUjVitSxWUKQn4/c7DsGe4G0LvXsG1H5pYEANaz8Lkw9jFVpYT5DaZDZnKDV05hX
         oL9ZZcMeV6PgGEY3O7ORN4/Ext6QAPUcfX8LqL4ZJDQuW3JFPD34ccyzDrmOVZVXeBCF
         ess19P5MH6QmwrkrXt70ngV7wEABuXmEzMYqyP3Q9KeWTi7apgzWnWzb+f5DSavVGWyw
         4SOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770211901; x=1770816701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ2iqW0pbEB/NBB0tS21N/N2tYmqwzVrEmtDuIx4ZgI=;
        b=ruNzopeKePP9abfGmkB9XWGspcajzuJ4eAUojtWsqF3t/QgiyhZs4kJl9KLlFwNqNM
         b3WpN1slxDFDsVC2Cqu5HwiGd0fffsEsuXe3Q9iRhvIrH3MSzF/GCLpxOJQXDuQH+Doe
         4oep8YPvrwE+uFV2KiRPTZT/u0PvNf08Z50Dc9G9vc/Pt1GdeGDHP9QuzN1SzexSWJ/R
         nRY7ev90dueGjsUENzukNm9iX+iohSt+nTDwUAL5sW5WGVqPXGKLdVvq1VrUnOmj3H1l
         cnx9uvCyTRZSrNz0B2MLIbr09/a1b14BcwtOttXFmhDjZtJ2tCkJdp1ADyWfbBNNNOk9
         pdvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBZdJkRBUQXRRA1vWafWDalXE8Kz7kCInc92SvPG1IwJ6cNM62tUqxeE5fYtULCLl6Jwq8acdIyfConQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsMve0soml6cdnMoCtTfTlwA48PzKHVetrvOdMq8ztsxMOUbgc
	bVhYXjtAsBcJnAHDYCxU2U+d/3o4cyIJZZ6jiIKj+5J5saQwG4srMfJF
X-Gm-Gg: AZuq6aKk7+3zdqwSBOOD6A4+8Qhm8ro5RbTQsm0uQfXEmw/yZ0v9l+8SZKjoULWVodp
	rFs7F+9br+tCJ7kFU8Gv4nwGhUieM3yhiEHitiGfhgGr0qOrLc5lk3XTpX7M9Qcvd9Dtry50lmH
	7V77oU0R2GFyBFPvxcZ8SgclgwCdU2zs8LC0Ru9wGhVDzYYNVUwBT91KLzfhdq45huJm8GDd5r0
	58egI7ZKeS0xIRUt0oic319iycIQtD8+esq8hqFpmfp1DXtDr/kOKRRCT6IJVMURI0V8f5j1IMr
	WeGunX4pXTjYElXjq+AD0vRFEEQ82BKswt1e0wxBP3mHlFPWjchovAIimQ7w6fw6igKOP5Brk4x
	YfUXvtWtJQjDjnwdtgzLpKa/SzUiqmB8w+7LzWJT85M3+42EqC/LESKNVzP9l/NxYQU7AFa0Mob
	acq1br6/ZpsKpubJXm1wqcxi7ezQ==
X-Received: by 2002:a05:6000:240f:b0:435:d7b1:9cf1 with SMTP id ffacd0b85a97d-43618061b43mr2431992f8f.7.1770211901323;
        Wed, 04 Feb 2026 05:31:41 -0800 (PST)
Received: from laptok ([2a00:f41:4842:718a:3ac6:8cea:3b72:7d9d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e3a546sm7614237f8f.17.2026.02.04.05.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 05:31:40 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: oleg@makarenk.ooo,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tomasz.pakula.oficjalny@gmail.com
Subject: [PATCH v2] HID: pidff: Fix condition effect bit clearing
Date: Wed,  4 Feb 2026 14:31:38 +0100
Message-ID: <20260204133138.475880-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As reported by MPDarkGuy on discord, NULL pointer dereferences were
happening because not all the conditional effects bits were cleared.

Properly clear all conditional effect bits from ffbit

Fixes: 7f3d7bc0df4b ("HID: pidff: Better quirk assigment when searching for fields")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
Urgent for 6.19 rc period
V1 -> V2: Simplify by using bitwise or operator

 drivers/hid/usbhid/hid-pidff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index a4e700b40ba9..792992c69837 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -1452,9 +1452,10 @@ static int pidff_init_fields(struct pidff_device *pidff, struct input_dev *dev)
 		hid_warn(pidff->hid, "unknown ramp effect layout\n");
 
 	if (PIDFF_FIND_FIELDS(set_condition, PID_SET_CONDITION, 1)) {
-		if (test_and_clear_bit(FF_SPRING, dev->ffbit)   ||
-		    test_and_clear_bit(FF_DAMPER, dev->ffbit)   ||
-		    test_and_clear_bit(FF_FRICTION, dev->ffbit) ||
+		/* Bitwise to ensure all the bits will be cleared */
+		if (test_and_clear_bit(FF_SPRING, dev->ffbit)   |
+		    test_and_clear_bit(FF_DAMPER, dev->ffbit)   |
+		    test_and_clear_bit(FF_FRICTION, dev->ffbit) |
 		    test_and_clear_bit(FF_INERTIA, dev->ffbit))
 			hid_warn(pidff->hid, "unknown condition effect layout\n");
 	}
-- 
2.52.0

