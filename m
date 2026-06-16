Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAD47D92C
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635497; cv=none; b=ESQSW40Ebwmw4RlShAanlgihv5foO5Djo7fPiYvOZxRqMAJEsDcfAA+TbpS/07hd25rJsZvnaCgVoMOCaUj+n7Z7oV7aL/9Cs9U6vwPQOl7TJWcdG5WVaaJgsZhiy5lTUmCqgNTXcrgaLVLfey+4t87EQCJSNtfKoLFZH5PD0uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635497; c=relaxed/simple;
	bh=FvoWcbbddD4jgmso8J9hYpa3VkcOXn0vZFfA02SfpCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SwUcya06JKrLE+64A00TfLpbez7LwDvfcDBxx/B4ANrAuXeH9F8M8LATPMq1D8Z0nVMXLkB7z+H0PT9ntfe/61cENi9R2LjHKvhM55Lmcp1KD4Plj77Mf7SpNVHSkvah/ZHOKtIsC1X4N5oh7rUSjja2OjYFHEZjyq+K1ocH+LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axnWD2ar; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axnWD2ar"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0c3543590so34134755ad.2
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 11:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781635495; x=1782240295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mP/ETRxCHugVKBwIg76pmWdXd7L4jCUa7fekho4yCsY=;
        b=axnWD2arbRHampZuS85ES/ArW+qwS/xATvuukOl0hv4kdDqmKGeXiqYNtoaz/YpbDd
         FxzqKqntacOzDWxXtJVk1PNLX1LVCYFgP8cOtYTtWgQLENMHjqYEylyAwbWDn8UK+3nY
         dJZbcJl439eLH7mEU2U8KmAd8h7Iz1xGMIZ23jCKOtryEaTF1HMfk3PCJ5eqCVvBPML2
         MWsNYKHn7w/WaXtmtHW0rvujrslenF8C1O+A2rzjTtxcIXDsMSJqkMG5ZE0gKe3ZEDbS
         iGoYdjJksAJ/9TuqIiXTfCfOz6IaftQvNmuJ5b5oaGph7oFSsEaeQ8F/vAULCalJH9WL
         L4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781635495; x=1782240295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mP/ETRxCHugVKBwIg76pmWdXd7L4jCUa7fekho4yCsY=;
        b=U5uEuMQ6dRJAlcy2ihhiOAg5CzXjLQ9sgFGsNDljWHVNwsQ19I38+l1USKBao/1yQf
         /ciCf7dQg/JT7nypgpv/1k0LFUTHH05eKTTj8zyka5scyY4lKYo7T4wi8kiBXMJu+mFH
         tXgIWgWSJWx1ISBdtsRiuqKUqQ6WjGcyJLt4yZ6r4qOQn50MOd6gCcy5dKg+qoeXmRZc
         3xnybbUg+Ug3BSFLcWwUTxoYFtK+tnpINuEPBwi5mMTcQlVpaJvWl4eDvHfLC9lWR6ku
         23G8q9B9p+BlVw8ymhZJ2/gcsfRm2s1GpTzfQR7wyzVM3b49HxGWOuUPRxPENW4XUWcf
         TduA==
X-Gm-Message-State: AOJu0Ywj8jIKrbkVKrXTAUGz3QS2J0e0LfpsPftYQFNkQkD1bzk6ZL0K
	TclroGi2EK/SrIAaEHZXpUtdwcYl7Dfz475EWp0X1jWANwQG2iZ0ObBL
X-Gm-Gg: AfdE7cl8oXkkhOViOLypnLJfpOBgFO8vANfBeNVdaqo0Qt6LYirSZxFkc00lUYNnX8P
	3tuYmfoJFZGAR4FOEOjHHzoMB+FFX/+cZBeQx44xKzuRSpCPg0Q+wz0p5rlMc9n5Nky5OLHjogo
	QrCqTEUShOpw5ArNuQSylJKNtbwHWkQDyWiQOTG7cOBdpHUqpzN8n1Ow62T1a9EotgZYmzzR0bt
	9g9UVOqhlAMFEOOc3KlbTv8iFfYJDlohWMGprAAHmW9AeP0djMU8KochQ8k6Q+NOxepXq1NTBAS
	TB9+A8t18YmbQ74eXIFW4uZ7r06uPPmJc2VbiT/CsXd3GsR7/vxEUuxo+cYUt+hRFJqzrTx0IgM
	m76ZEN6Ra2wtCxe/43D2qgZmZuJ5+EJhNRiiHG8HVjM4EDdh6FPgy5Mdi0uvlTWZ+UgwwJ09v4G
	71Tvsext2jATZ5AvdmOdGrwyR8P0fMt4N5BiIlPMNY+FPisqXM9gTbIbiSFj0POkpzWT/md+IVk
	1xodwVtdW7tgOWi1KU6CtPcBAlpQAPXdvt8zyRUg/4YryqiRjiqBmOX64CZ12lb9gPID+I25A==
X-Received: by 2002:a17:902:ce91:b0:2bc:b80f:677e with SMTP id d9443c01a7336-2c6bc23de79mr2256355ad.25.1781635494981;
        Tue, 16 Jun 2026 11:44:54 -0700 (PDT)
Received: from bloom.localdomain (S010680dac2bce256.cg.shawcable.net. [174.0.186.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6b3f65c27sm7128635ad.3.2026.06.16.11.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:44:54 -0700 (PDT)
From: Jack Lee <skunkolee@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jack Lee <skunkolee@gmail.com>
Subject: [PATCH] Input: xpad - replace symbolic permissions with octal
Date: Tue, 16 Jun 2026 11:44:43 -0700
Message-ID: <20260616184443.17342-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Symbolic permissions S_IRUGO and S_IWUSR are not preferred. Replace
with octal permissions 0444 and 0644 as recommended by checkpatch.

Signed-off-by: Jack Lee <skunkolee@gmail.com>
---
 drivers/input/joystick/xpad.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834..f6e02016a0c0 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -74,19 +74,19 @@
 #define FLAG_DELAY_INIT BIT(0)
 
 static bool dpad_to_buttons;
-module_param(dpad_to_buttons, bool, S_IRUGO);
+module_param(dpad_to_buttons, bool, 0444);
 MODULE_PARM_DESC(dpad_to_buttons, "Map D-PAD to buttons rather than axes for unknown pads");
 
 static bool triggers_to_buttons;
-module_param(triggers_to_buttons, bool, S_IRUGO);
+module_param(triggers_to_buttons, bool, 0444);
 MODULE_PARM_DESC(triggers_to_buttons, "Map triggers to buttons rather than axes for unknown pads");
 
 static bool sticks_to_null;
-module_param(sticks_to_null, bool, S_IRUGO);
+module_param(sticks_to_null, bool, 0444);
 MODULE_PARM_DESC(sticks_to_null, "Do not map sticks at all for unknown pads");
 
 static bool auto_poweroff = true;
-module_param(auto_poweroff, bool, S_IWUSR | S_IRUGO);
+module_param(auto_poweroff, bool, 0644);
 MODULE_PARM_DESC(auto_poweroff, "Power off wireless controllers on suspend");
 
 static const struct xpad_device {
-- 
2.54.0

