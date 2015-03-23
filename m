From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] HID: input: Fix NULL pointer dereference when
 power_supply_register fails
Date: Mon, 23 Mar 2015 16:34:51 +0100
Message-ID: <1427124891-30540-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:24672 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbbCWPfA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Mar 2015 11:35:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Do not call power_supply_powers() if power_supply_register() failed
earlier. This fixes possible NULL pointer dereference by
power_supply_powers() in such case.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

---

The patch was prepared on top of next-20150323. It depends on changes in
power supply core (battery-2.6.git) so probably it should be applied to
the battery tree.
---
 drivers/hid/hid-input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index a70fa4d7f8f9..008e89bf6f3c 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -452,10 +452,10 @@ static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 		kfree(psy_desc->name);
 		kfree(psy_desc);
 		dev->battery = NULL;
+	} else {
+		power_supply_powers(dev->battery, &dev->dev);
 	}
 
-	power_supply_powers(dev->battery, &dev->dev);
-
 out:
 	return true;
 }
-- 
1.9.1

