From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 1/2] input: cros_ec_keyb: Report wakeup events
Date: Thu, 30 Mar 2017 17:50:49 +0800
Message-ID: <1490867450-31765-2-git-send-email-jeffy.chen@rock-chips.com>
References: <1490867450-31765-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490867450-31765-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: briannorris@chromium.org, dmitry.torokhov@gmail.com, dbasehore@google.com, dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Gwendal Grignou <gwendal@chromium.org>, Vic Yang <victoryang@google.com>, linux-input@vger.kernel.org, Enric Balletbo Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-input@vger.kernel.org

Report wakeup events when process events.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/input/keyboard/cros_ec_keyb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 6a250d6..a93d55f 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -286,6 +286,9 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 		return NOTIFY_DONE;
 	}
 
+	if (device_may_wakeup(ckdev->dev))
+		pm_wakeup_event(ckdev->dev, 0);
+
 	return NOTIFY_OK;
 }
 
@@ -632,6 +635,12 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = device_init_wakeup(dev, 1);
+	if (err) {
+		dev_err(dev, "cannot init wakeup: %d\n", err);
+		return err;
+	}
+
 	return 0;
 }
 
-- 
2.1.4
