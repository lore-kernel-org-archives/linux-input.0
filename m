From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] Input: Convert timers to use timer_setup()
Date: Mon, 16 Oct 2017 16:15:34 -0700
Message-ID: <20171016231534.GA100079@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Ben Gamari <ben@smart-cactus.org>, Paul Donohue <linux-kernel@PaulSD.com>, Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly. Adds a pointer back to input device
in byd driver.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Pali Rohár" <pali.rohar@gmail.com>
Cc: Ben Gamari <ben@smart-cactus.org>
Cc: Paul Donohue <linux-kernel@PaulSD.com>
Cc: Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/input/ff-memless.c |  8 ++++----
 drivers/input/mouse/alps.c |  8 ++++----
 drivers/input/mouse/byd.c  | 10 ++++++----
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index fcc6c3368182..2743ed4656e4 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -412,10 +412,10 @@ static void ml_play_effects(struct ml_device *ml)
 	ml_schedule_timer(ml);
 }
 
-static void ml_effect_timer(unsigned long timer_data)
+static void ml_effect_timer(struct timer_list *t)
 {
-	struct input_dev *dev = (struct input_dev *)timer_data;
-	struct ml_device *ml = dev->ff->private;
+	struct ml_device *ml = from_timer(ml, t, timer);
+	struct input_dev *dev = ml->dev;
 	unsigned long flags;
 
 	pr_debug("timer: updating effects\n");
@@ -526,7 +526,7 @@ int input_ff_create_memless(struct input_dev *dev, void *data,
 	ml->private = data;
 	ml->play_effect = play_effect;
 	ml->gain = 0xffff;
-	setup_timer(&ml->timer, ml_effect_timer, (unsigned long)dev);
+	timer_setup(&ml->timer, ml_effect_timer, 0);
 
 	set_bit(FF_GAIN, dev->ffbit);
 
diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 850b00e3ad8e..579b899add26 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1587,10 +1587,10 @@ static psmouse_ret_t alps_handle_interleaved_ps2(struct psmouse *psmouse)
 	return PSMOUSE_GOOD_DATA;
 }
 
-static void alps_flush_packet(unsigned long data)
+static void alps_flush_packet(struct timer_list *t)
 {
-	struct psmouse *psmouse = (struct psmouse *)data;
-	struct alps_data *priv = psmouse->private;
+	struct alps_data *priv = from_timer(priv, t, timer);
+	struct psmouse *psmouse = priv->psmouse;
 
 	serio_pause_rx(psmouse->ps2dev.serio);
 
@@ -2702,7 +2702,7 @@ static int alps_set_protocol(struct psmouse *psmouse,
 {
 	psmouse->private = priv;
 
-	setup_timer(&priv->timer, alps_flush_packet, (unsigned long)psmouse);
+	timer_setup(&priv->timer, alps_flush_packet, 0);
 
 	priv->proto_version = protocol->version;
 	priv->byte0 = protocol->byte0;
diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index b64b81599f7e..f2aabf7f906f 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -227,6 +227,7 @@
 
 struct byd_data {
 	struct timer_list timer;
+	struct psmouse *psmouse;
 	s32 abs_x;
 	s32 abs_y;
 	typeof(jiffies) last_touch_time;
@@ -251,10 +252,10 @@ static void byd_report_input(struct psmouse *psmouse)
 	input_sync(dev);
 }
 
-static void byd_clear_touch(unsigned long data)
+static void byd_clear_touch(struct timer_list *t)
 {
-	struct psmouse *psmouse = (struct psmouse *)data;
-	struct byd_data *priv = psmouse->private;
+	struct byd_data *priv = from_timer(priv, t, timer);
+	struct psmouse *psmouse = priv->psmouse;
 
 	serio_pause_rx(psmouse->ps2dev.serio);
 	priv->touch = false;
@@ -478,7 +479,8 @@ int byd_init(struct psmouse *psmouse)
 	if (!priv)
 		return -ENOMEM;
 
-	setup_timer(&priv->timer, byd_clear_touch, (unsigned long) psmouse);
+	priv->psmouse = psmouse;
+	timer_setup(&priv->timer, byd_clear_touch, 0);
 
 	psmouse->private = priv;
 	psmouse->disconnect = byd_disconnect;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
