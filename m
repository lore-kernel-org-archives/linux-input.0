Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A753234B1B0
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023966; cv=none; b=U21y2pkkxQoAUkNsZP6Hynrm7zBqlYU/0HkV8T8ie42woVpYzowAEQU/3EkRQb/Dvj4NXD1iceMKCG0ERGcGceu6w26qRmnFrP6Wul/0l/AwfRVR7AvzAKkaJ6o2W9DQq61/E2dx44RDyhCeQniHFIbTWdQwgFBDWdytu4p5Ku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023966; c=relaxed/simple;
	bh=u/T9HwF475h8G5NygkEKCoQSP1f90u86IK13PlHmt0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYgbkPZQqhveLza4rtJo/m5sza3BCgHiIwr8pgowMr2k8j0nrzpJVct/Vx5QZp7qleSRFycLXa5lcJTF2oezqs3gdxHiMQ2/vk3uTGshQT9U6qghmoPsw2sWqm0q1SNyovLIqQ7R1aixVKmrr4povpQiANJunGiG7O1Q/7X+JKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uoi0Qzxx; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uoi0Qzxx"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92eafc94c9cso297488785a.0
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 03:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784023963; x=1784628763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6X1/WLn79/CUgV4H/rMT3E22JluSKjkUFHRz/amWYjQ=;
        b=Uoi0Qzxx7+pzfw4ji7YmqO0zY7u7DhWcwGdhTfLlVeVGKKcwU+5x7tFVKIVRp88nq/
         /tOMyYj1X1eozuaBBf1tw1wSRB7q4Y29YHKrY/FCzUNZzFvAu5CEHAzoT6MJKvVJE/Id
         B9bOr20IuSFysb3dsAAxcfwAMQeACOi2hGJ34VJpugZfzvGZoIvRKXELrSckobGHpGwY
         koGoEyP+4/Ql2iQ4Q6njrZftVA8sUDPbMYsPqxfrJ4PR7ukA2OXVEV1CUmWBGF8k0F/V
         +Jn2n4BCaKWRJvTQ1uzXnYYm3jvWy1vSxOWxuAHAFSj6lqJECC72NyKrEMpLutOCluMt
         sB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784023963; x=1784628763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6X1/WLn79/CUgV4H/rMT3E22JluSKjkUFHRz/amWYjQ=;
        b=MKOFh7EobScFtCNZreAtidWCYBsWfx8y6TxOnadTjD+Z3SV0IQlXwZxKwhIMFAK05s
         j9OJb5bHgBz5q0ocdrNMR1RETUsmOShGp+6BcxtO0RXcCaBL+MvR78FUuOHwvDs3pVid
         pC9MqNJ58PEjGvuTV/TAvjzQouMiV8VGe+hT33/sQVitxl4UNOvAcyTJ3qhJxvvJaC0c
         1SE9dL20OctF8Z8xuFPgWY9uITPL9DOfRRzp2VfTfN2QgrNqea7GZQk2204jx1KyYB6p
         ye+iefmaHj0LLqImracLzfJd/YGauPpQYFFVsj4DjoFBcCdMOBdDXqrObggpNuDSjwJZ
         6KJA==
X-Forwarded-Encrypted: i=1; AHgh+RooKjjOH+aSOUElFJaaSUAfSqxDTGUa77GnMiKp6i7YZgPPwOTLB7laOQIRwNYKwo9bAxKrqM2LyzITzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBR5u5Uae9nADVVFVPPzt2IbNbEY7UeuNBYJmb6IQAZWWrJgmN
	maZdzdrxC8xXBEy+CiUqQ8yYG9NcHt3fbOzTS6UEdJOM9O3GmCYZfL4F
X-Gm-Gg: AfdE7clgfNEeqjzCLH5CvY2LmnKXq1Z//dJ5rQfpVymih6Fh0HUWMDCYf9xWzeiPG3g
	+ppdCW7ietXJSYsCkTbA2poxgztLdIb389/Mg5zEA4HJg0zBpv6lN3pVBCIeHnRjKts/FTG7oQv
	w7cBu7aBKelEqNSrgLBvia3AfUGaJq48Wxdu+9aJIqGF3wM+w3btpO6LwHOuCXtscL4z9VfJkFW
	27OaLpVgn8MIi7VAkSmATjUcoo9tI3Z8lOJaH6kCqCMCxZS6jKU5Dkux7GeywlNRGqLPlQ4WjpL
	VMWMDrnpv1+UDKhtsj1XBxuzbgKakCNLa/o9eSDedV8Rv+IPI+EqmYyWrZ1H3ugEZt/W64F+Fhl
	a91k2IOAGUDfqse4F39Q5AjS2XbLaI8UCIHJ+K7ejgEJ6xgFatttHAg/P43wtGZqu1qW7aA+N3l
	umR0l1H3391j51DbsSrxd1ORIpCPhx5XDIkg==
X-Received: by 2002:a05:620a:1a15:b0:92e:62e3:3b55 with SMTP id af79cd13be357-93086c2251fmr143532485a.64.1784023963391;
        Tue, 14 Jul 2026 03:12:43 -0700 (PDT)
Received: from FairplayBox ([2601:5cf:837e:d920::f9a2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfcb0dsm1463056185a.25.2026.07.14.03.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:12:43 -0700 (PDT)
From: Alec Hall <signshop.alec@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alec Hall <signshop.alec@gmail.com>
Subject: [PATCH 0/3] HID: Apple Magic Keyboard/Trackpad battery over Bluetooth
Date: Tue, 14 Jul 2026 06:12:32 -0400
Message-ID: <20260714101235.99447-1-signshop.alec@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apple's Magic Keyboard and Magic Trackpad 2 / Magic Mouse 2 report their
battery to the host, but the kernel only surfaces it over USB; over
Bluetooth the power_supply is stuck at 0%, even though these devices are
used over Bluetooth nearly all the time.

Both drivers already fetch the battery (a GET_REPORT for input report
0x90) but only over USB. Enabling it over Bluetooth naively hard-locks the
machine: the fetch runs from a timer callback (atomic context) and the
uhid transport sleeps inside hid_hw_request(). Each driver's patch
therefore moves the fetch to a workqueue before enabling it over
Bluetooth. The last patch teaches hid-magicmouse to report charge status
from the device's status byte.

Patch 3 interprets a vendor status byte whose bit meanings were determined
empirically; I can rework it as a report-descriptor fixup exposing
HID_BAT_CHARGING instead if reviewers prefer.

Tested on a Magic Keyboard 2021 and a Magic Trackpad 2 over BlueZ (uhid).

Alec Hall (3):
  HID: apple: report Magic Keyboard battery over Bluetooth
  HID: magicmouse: report battery over Bluetooth
  HID: magicmouse: report charge status over Bluetooth

 drivers/hid/hid-apple.c      | 36 ++++++-------
 drivers/hid/hid-magicmouse.c | 99 ++++++++++++++++++++++++++----------
 2 files changed, 92 insertions(+), 43 deletions(-)


base-commit: b7556c8e713c88596046a906c7c4385218d44736
-- 
2.55.0

