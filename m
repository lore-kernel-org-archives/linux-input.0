From: NeilBrown <neilb@suse.de>
Subject: [PATCH 2/2] Input: twl4030-pwrbutton: report a wakeup_event on button
 press.
Date: Mon, 30 Jul 2012 11:09:02 +1000
Message-ID: <20120730010902.22579.94791.stgit@notabene.brown>
References: <20120730010746.22579.52841.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120730010746.22579.52841.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, NeilBrown <neilb@suse.de>
List-Id: linux-input@vger.kernel.org

As the power button causes a wake from suspend, we need to register
the event with the pm sustem to avoid racing with suspend.

As the input event is reported in the interrupt handler, as simple
pm_wakeup_event() is sufficient.

Signed-off-by: NeilBrown <neilb@suse.de>
---

 drivers/input/misc/twl4030-pwrbutton.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index 38e4b50..b3dd96d 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -42,6 +42,7 @@ static irqreturn_t powerbutton_irq(int irq, void *_pwr)
 	err = twl_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &value,
 				STS_HW_CONDITIONS);
 	if (!err)  {
+		pm_wakeup_event(pwr->dev.parent, 0);
 		input_report_key(pwr, KEY_POWER, value & PWR_PWRON_IRQ);
 		input_sync(pwr);
 	} else {
