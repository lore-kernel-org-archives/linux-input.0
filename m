Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA2E272803
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 04:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775535239; cv=none; b=ZTRHE7OqEU90wIMOSI9vu3cPt2Gyw52MUihZ16RTKEVcqWHEoz6tBGuiMb+XofjwVV4H1ClBczAjRzLMT+3oZJjpmmuL+pornitQvWp+InATJdOEp/PGWl1U1Aq6uYOe/gErRSq3RS7YGWxMUJZsN2prIXC4RPtC/NGnmg3ZFrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775535239; c=relaxed/simple;
	bh=9a8DmApUDTCRmbn/EJgWGX9051OnV3aVstIiRC2e2DE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pA8Tv65BR9r8BNZdetPx59Ee8KS0B++ZoQFpZF8Dn4/lmvLrfKEqGCIrGnBN16qrzvxKGyr8HWd3tDQFRlxLzCeV1YYh6YRi8pcsnNHz5v/XHcaYqtYtoP7Bk4YfGIsG/nggsNzMf/Q8iCHc5488c2W6atP86Z3kn6G0hkcxW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDCAFTqT; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDCAFTqT"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12bfa7fe691so2090347c88.0
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 21:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775535237; x=1776140037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8lgOPiT00rpMCnbTFBagNZlQ4AYJdr+RiU/kRaXCOik=;
        b=gDCAFTqTCkGijMG64AvWeqOPjS/kUwkYNDOCER66s/OQ3kuqPG6qRC1KtDPT7hFZrO
         7Dr6GM2RlxOSJDS0PDU7kV/YRSxHKS2r1bgA92PPsui6IYopxd4TRecJMWSmIuCJjU4D
         aRroMrjwPqvPS1CmTjRg0Z7b/l8PGTeoTyJCn7TVeG4Nq2upE4uVduVFh76FXGXhapzJ
         lAee8+1rwlInZqT5t6fGaywkP6YnrCbOAW7A5LUANUq3dFYcjeRK5teba4VYoW0X2t+g
         gFw3GLc2ICXvrMPtGYIw6QCQOtD7K3ssZFmb3OMeguHaOtvkzduKiMNPuagu6WD1CFyJ
         KzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775535237; x=1776140037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lgOPiT00rpMCnbTFBagNZlQ4AYJdr+RiU/kRaXCOik=;
        b=O6E5HxXd3GLJTGN93VLkgbRnmmTLhl5J1Dhw3bGg3NLoW2MN2u5vSngZqUdn0tO3mO
         KThmbPBE4QKqsjQKrdYDl+rvap/XwtGy6aznJsR+tX7pkyE54iMt0TFJ1Sk/J1EBhqv7
         dyy+6G/VjUt6khWv28bqBwlDtF+bhKyIAbqGws6/g7c3lBdq4bVZip7fcI1cnmCR6IYH
         xk8ZZ3Nn34wcUFdkyl0lGPj6AnoIHcR8OwBRLU4OMdElJ9Q+mVSiSOj7wsNYRzQRxRkM
         bUguC8h6t+vXriAJfEzs2qZmMGU9H80OSpa2pIp40AUiVHjYsskgYsmSCAbDBwRsvJLH
         PfLA==
X-Forwarded-Encrypted: i=1; AJvYcCWAVuq9DGPaLcwJs/Nq3OUyBSCHfHnYI5TyZBBiEbTFKiAoKCwf3PrDHT9ndE1f2p73ekYPqSQwJBkXMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTseP1SAdyxTfT0ZuRWK4BRWM2Ozpob0jwtjtIDq5vntZoR87v
	4mnaj+20+gZdIJFQWfFqyCYGG/7i8dTUDJQKh5+n6x31k5wnBURTzQVL
X-Gm-Gg: AeBDiesOtpsAqL7SsDO5rRcHuOFc89WUQ7f5GrB1s4GJfhA/1xkP4Qn3dtnnJrSDhmw
	CT/465EXffxLuRzC8raCcOei8hAZpE+/5z2dQnlJK4hkT5Z8zCeQA8XcHuf8kUWktle25qrgRS6
	L2uhOCiDQuEZTHadgoIPckYhkskC90TXO52g3fGvsNLOzQmRgEhlEnd5rjLqes78z/zITL86XsF
	5wK2hql4Bi4Kxpjz2taCy2bq2wgrKnCkZ3S45YeoQPUZhEIjzMW9/+uuP5gNWe/hVwJWH46HHT/
	C47kPlR94xN2GxMl+BU4OqJ/8M7u14DlWuQJo3uAFToGwhs3IfNTYAM/wF5To7b1sd6SotDkl3s
	Ph28AUZo/J15Tb9Lew/i/vOI/CDb/ybKV9Bz6IPmHBSNEq45Tla8dmJhrZlajmKCQMBxr4OsgmQ
	Bw4482KMOFfP9P/YxLKYlpIGTagEtby6QkHVtZmCNGFN99oD6E0hDAv+ODzyU8mRJ/r4OKflOsR
	JXm
X-Received: by 2002:a05:7022:6613:b0:127:5cda:fb7d with SMTP id a92af1059eb24-12bfb6e999amr8794388c88.6.1775535237329;
        Mon, 06 Apr 2026 21:13:57 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm18523808c88.0.2026.04.06.21.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:13:56 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Lambert Fan <fanzhaoming@anopc.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Add OneXPlayer Configuration HID Driver
Date: Tue,  7 Apr 2026 04:13:49 +0000
Message-ID: <20260407041354.2283201-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds an HID driver for OneXPlayer HID configuration devices. There are
currently 2 generations of OneXPlayer HID protocol. The first (OneXPlayer
F1 series) only provides an RGB control interface over HID. The Second
(X1 mini series, G1 series, AOKZOE A1X) also includes a hardware level
button mapping interface, vibration intensity settings, and the ability
to switch output between xinput and a debug mode that can be used to debug
the button mapping. Some devices (G1 Series, APEX) use a hybrid of Gen1
RGB control and Gen 2 controller settings. To ensure there is no conflicts
when the driver is loaded, we skip creating the RGB interface for Gen 2
devices if there is a DMI match.

I'll also add a note that Gen 1 devices also have an interface for
setting the key map and debug mode, but that is done entirely over a
serial TTY device so it is not able to be added to this driver. There
are also some "Gen 0" devices (OneXPlayer 2 Series) also use it, but
the TTY interface also handles the RGB control so no support is
provided by this driver for those devices.

Signed-off-by: Derel J. Clark <derekjohn.clark@gmail.com>
---
v2:
  - Add DMI quirks for certain devices that ship with both GEN1 and GEN2
    MCU to avoid clashing when initializing the RGB interface.
  - Add left & right vibration intensity attributes.
  - Add additional mappings for keyboard inputs.
  - Add a delayed work trigger to re-apply settings after the MCU
    completes initializing after a suspend/resume cycle.
v1: https://lore.kernel.org/linux-input/20260322031615.1524307-1-derekjohn.clark@gmail.com/
Derek J. Clark (5):
  HID: hid-oxp: Add OneXPlayer configuration driver
  HID: hid-oxp: Add Second Generation RGB Control
  HID: hid-oxp: Add Second Generation Gamepad Mode Switch
  HID: hid-oxp: Add Button Mapping Interface
  HID: hid-oxp: Add Virbation Intenstity Attributes

 MAINTAINERS           |    6 +
 drivers/hid/Kconfig   |   13 +
 drivers/hid/Makefile  |    1 +
 drivers/hid/hid-ids.h |    6 +
 drivers/hid/hid-oxp.c | 1595 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1621 insertions(+)
 create mode 100644 drivers/hid/hid-oxp.c

-- 
2.53.0

