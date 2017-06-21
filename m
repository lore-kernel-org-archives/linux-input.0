From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RFC PATCH v3 5/6] input: cros_ec_keyb: report wakeup events
Date: Wed, 21 Jun 2017 18:01:52 +0800
Message-ID: <1498039313-24220-6-git-send-email-jeffy.chen@rock-chips.com>
References: <1498039313-24220-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.141]:45267 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752997AbdFUKEd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 21 Jun 2017 06:04:33 -0400
In-Reply-To: <1498039313-24220-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: briannorris@chromium.org, dmitry.torokhov@gmail.com, dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Gwendal Grignou <gwendal@chromium.org>, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Vic Yang <victoryang@google.com>, linux-input@vger.kernel.org, Enric Balletbo Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>

Report wakeup events when process events.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

---

Changes in v3:
Use wakeup-source property to enable wakeup.
  Suggested by Dmitry Torokhov <dmitry.torokhov@gmail.com>.

 drivers/input/keyboard/cros_ec_keyb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 79eb295..5dc387b 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -293,6 +293,9 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 		return NOTIFY_DONE;
 	}
 
+	if (device_may_wakeup(ckdev->dev))
+		pm_wakeup_event(ckdev->dev, 0);
+
 	return NOTIFY_OK;
 }
 
@@ -639,6 +642,9 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	if (device_property_read_bool(dev, "wakeup-source"))
+		device_init_wakeup(dev, true);
+
 	return 0;
 }
 
@@ -649,6 +655,8 @@ static int cros_ec_keyb_remove(struct platform_device *pdev)
 	blocking_notifier_chain_unregister(&ckdev->ec->event_notifier,
 					   &ckdev->notifier);
 
+	device_init_wakeup(&pdev->dev, false);
+
 	return 0;
 }
 
-- 
2.1.4


