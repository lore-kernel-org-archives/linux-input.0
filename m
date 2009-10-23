From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [RFC PATCH 0/1] Enabling/disabling separate gpio-keys buttons
Date: Fri, 23 Oct 2009 15:15:45 +0300
Message-ID: <cover.1256298993.git.ext-mika.1.westerberg@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61953 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbZJWMTr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Oct 2009 08:19:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Some embedded devices use gpio lines as keys/buttons through gpio-keys.
Current implementation doesn't allow one to enable/disable these buttons
separately.

Example use-case would be that when phone is locked in our pocket,
we don't want it to woken up when camera key gets accidentally pressed.

Following patch exports gpio-keys through sysfs to userland and allows
userland programs to control whether gpio line (button/key) is disabled
or enabled.

Thanks,
MW


Mika Westerberg (1):
  Input: gpio-keys: export gpio key information through sysfs

 drivers/input/keyboard/gpio_keys.c |  162 ++++++++++++++++++++++++++++++++++++
 1 files changed, 162 insertions(+), 0 deletions(-)

