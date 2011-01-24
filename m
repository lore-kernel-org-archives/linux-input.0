From: Andy Ross <andy.ross@windriver.com>
Subject: [PATCH 0/4] Pegatron Lucid tablet acceleromter/ALS
Date: Mon, 24 Jan 2011 14:48:04 -0800
Message-ID: <1295909288-32650-1-git-send-email-andy.ross@windriver.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Corentin Chary <corentincj@iksaif.net>, linux-input@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Resubmission and update of the Pegatron Lucid tablet accelerometer and
ambient light sensor drivers.

Patches 1-3 are against asus-laptop, and apply in order.

Patch 4 is against input, and can be commited separately (obviously
relies on the detection code in asus-laptop at runtime, but will build
and load independently).

Andy
