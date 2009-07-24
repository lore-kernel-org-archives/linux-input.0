From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors.ext@mocean-labs.com>
Subject: [PATCH 1/2] tsc2007: IRQ balancing when stopping work during removal
Date: Fri, 24 Jul 2009 18:13:22 +0200
Message-ID: <4A69DDA2.80902@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:41910 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbZGXQNX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jul 2009 12:13:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kwangwoo.lee@gmail.com, Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>

The implementation is proposed by Dmitry Torokhov, I have just made som=
e=20
changes so it applied to my previous patches, and I tried it out.

The idea is to balance the IRQ:s in the case where the poll worker is=20
running, so it won't get disabled twice.

Also using __devinit/__devexit macros on probe/remove functions.

Signed-off-by: Richard R=F6jfors <richard.rojfors.ext@mocean-labs.com>
---
Index: linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c	(revision 997)
+++ linux-2.6.31-rc2/drivers/input/touchscreen/tsc2007.c	(revision 1040=
)
@@ -61,7 +61,7 @@

  #define PEN_STATE_UP	0x00
  #define PEN_STATE_DOWN	0x01
-#define PEN_STATE_IRQ	0x01
+#define PEN_STATE_IRQ	0x02

  struct ts_event {
  	u16	x;
@@ -141,8 +141,6 @@
  	 */
  	if (rt > MAX_12BIT) {
  		dev_dbg(&ts->client->dev, "ignored pressure %d\n", rt);
-
-		schedule_delayed_work(&ts->work, TS_POLL_PERIOD);
  		return;
  	}

@@ -178,8 +176,6 @@
  	} else if (!ts->get_pendown_state)
  		/* no callback to check pendown state, use pressure */
  		ts->penstate =3D PEN_STATE_UP;
-
-	schedule_delayed_work(&ts->work, TS_POLL_PERIOD);
  }

  static int tsc2007_read_values(struct tsc2007 *tsc)
@@ -228,6 +224,7 @@

  		tsc2007_read_values(ts);
  		tsc2007_send_event(ts);
+		schedule_delayed_work(&ts->work, TS_POLL_PERIOD);
  	}
  }

@@ -238,7 +235,7 @@
  	if (!ts->get_pendown_state || likely(ts->get_pendown_state())) {
  		disable_irq_nosync(ts->irq);
  		ts->penstate =3D PEN_STATE_IRQ;
-		schedule_delayed_work(&ts->work, 0);
+		schedule_delayed_work(&ts->work, TS_POLL_PERIOD);
  	}

  	if (ts->clear_penirq)
@@ -247,15 +244,25 @@
  	return IRQ_HANDLED;
  }

-static int tsc2007_probe(struct i2c_client *client,
+static void tsc2007_free_irq(struct tsc2007 *ts)
+{
+	free_irq(ts->irq, ts);
+	if (cancel_delayed_work_sync(&ts->work))
+		/* Work was pending, therefore we need to enable IRQ here to
+		 * balance the disable done in the interrupt handler.
+		 */
+		enable_irq(ts->irq);
+}
+
+static int __devinit tsc2007_probe(struct i2c_client *client,
  			const struct i2c_device_id *id)
  {
  	struct tsc2007 *ts;
-	struct tsc2007_platform_data *pdata =3D pdata =3D client->dev.platfor=
m_data;
+	struct tsc2007_platform_data *pdata =3D client->dev.platform_data;
  	struct input_dev *input_dev;
  	int err;

-	if (!pdata || !pdata->get_pendown_state) {
+	if (!pdata) {
  		dev_err(&client->dev, "platform data is required!\n");
  		return -EINVAL;
  	}
@@ -320,25 +327,24 @@
  	return 0;

   err_free_irq:
-	free_irq(ts->irq, ts);
+	tsc2007_free_irq(ts);
   err_free_mem:
+	if (pdata->exit_platform_hw)
+		pdata->exit_platform_hw();
  	input_free_device(input_dev);
  	kfree(ts);
  	return err;
  }

-static int tsc2007_remove(struct i2c_client *client)
+static int __devexit tsc2007_remove(struct i2c_client *client)
  {
  	struct tsc2007	*ts =3D i2c_get_clientdata(client);
-	struct tsc2007_platform_data *pdata;
+	struct tsc2007_platform_data *pdata =3D client->dev.platform_data;

-	cancel_delayed_work_sync(&ts->work);
-
-	pdata =3D client->dev.platform_data;
+	tsc2007_free_irq(ts);
  	if (pdata->exit_platform_hw)
  		pdata->exit_platform_hw();

-	free_irq(ts->irq, ts);
  	input_unregister_device(ts->input);
  	kfree(ts);

@@ -359,7 +365,7 @@
  	},
  	.id_table	=3D tsc2007_idtable,
  	.probe		=3D tsc2007_probe,
-	.remove		=3D tsc2007_remove,
+	.remove		=3D __devexit_p(tsc2007_remove),
  };

  static int __init tsc2007_init(void)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
