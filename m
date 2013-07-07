From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Input: cyttsp4 - Kill defined but not used compiler warnings
Date: Sun,  7 Jul 2013 21:08:31 +0200
Message-ID: <1373224111-16873-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jacques.telenet-ops.be ([195.130.132.50]:60855 "EHLO
	jacques.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999Ab3GGTJA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Jul 2013 15:09:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferruh Yigit <fery@cypress.com>, Javier Martinez Canillas <javier@dowhile0.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

If both CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME are unset:

drivers/input/touchscreen/cyttsp4_core.c:1556: warning: =E2=80=98cyttsp=
4_core_sleep=E2=80=99 defined but not used
drivers/input/touchscreen/cyttsp4_core.c:1634: warning: =E2=80=98cyttsp=
4_core_wake=E2=80=99 defined but not used

Move cyttsp4_core_sleep(), cyttsp4_core_wake(), and cyttsp4_core_wake_(=
)
(which is called from cyttsp4_core_wake() only) inside the existing sec=
tion
protected by #if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/input/touchscreen/cyttsp4_core.c |  200 +++++++++++++++-------=
--------
 1 file changed, 100 insertions(+), 100 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/t=
ouchscreen/cyttsp4_core.c
index edcf799..c49161c2 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -1552,106 +1552,6 @@ exit:
 	return rc;
 }
=20
-static int cyttsp4_core_sleep(struct cyttsp4 *cd)
-{
-	int rc;
-
-	rc =3D cyttsp4_request_exclusive(cd, cd->dev,
-			CY_CORE_SLEEP_REQUEST_EXCLUSIVE_TIMEOUT);
-	if (rc < 0) {
-		dev_err(cd->dev, "%s: fail get exclusive ex=3D%p own=3D%p\n",
-				__func__, cd->exclusive_dev, cd->dev);
-		return 0;
-	}
-
-	rc =3D cyttsp4_core_sleep_(cd);
-
-	if (cyttsp4_release_exclusive(cd, cd->dev) < 0)
-		dev_err(cd->dev, "%s: fail to release exclusive\n", __func__);
-	else
-		dev_vdbg(cd->dev, "%s: pass release exclusive\n", __func__);
-
-	return rc;
-}
-
-static int cyttsp4_core_wake_(struct cyttsp4 *cd)
-{
-	struct device *dev =3D cd->dev;
-	int rc;
-	u8 mode;
-	int t;
-
-	/* Already woken? */
-	mutex_lock(&cd->system_lock);
-	if (cd->sleep_state =3D=3D SS_SLEEP_OFF) {
-		mutex_unlock(&cd->system_lock);
-		return 0;
-	}
-	cd->int_status &=3D ~CY_INT_IGNORE;
-	cd->int_status |=3D CY_INT_AWAKE;
-	cd->sleep_state =3D SS_WAKING;
-
-	if (cd->cpdata->power) {
-		dev_dbg(dev, "%s: Power up HW\n", __func__);
-		rc =3D cd->cpdata->power(cd->cpdata, 1, dev, &cd->ignore_irq);
-	} else {
-		dev_dbg(dev, "%s: No power function\n", __func__);
-		rc =3D -ENOSYS;
-	}
-	if (rc < 0) {
-		dev_err(dev, "%s: HW Power up fails r=3D%d\n",
-				__func__, rc);
-
-		/* Initiate a read transaction to wake up */
-		cyttsp4_adap_read(cd, CY_REG_BASE, sizeof(mode), &mode);
-	} else
-		dev_vdbg(cd->dev, "%s: HW power up succeeds\n",
-			__func__);
-	mutex_unlock(&cd->system_lock);
-
-	t =3D wait_event_timeout(cd->wait_q,
-			(cd->int_status & CY_INT_AWAKE) =3D=3D 0,
-			msecs_to_jiffies(CY_CORE_WAKEUP_TIMEOUT));
-	if (IS_TMO(t)) {
-		dev_err(dev, "%s: TMO waiting for wakeup\n", __func__);
-		mutex_lock(&cd->system_lock);
-		cd->int_status &=3D ~CY_INT_AWAKE;
-		/* Try starting up */
-		cyttsp4_queue_startup_(cd);
-		mutex_unlock(&cd->system_lock);
-	}
-
-	mutex_lock(&cd->system_lock);
-	cd->sleep_state =3D SS_SLEEP_OFF;
-	mutex_unlock(&cd->system_lock);
-
-	cyttsp4_start_wd_timer(cd);
-
-	return 0;
-}
-
-static int cyttsp4_core_wake(struct cyttsp4 *cd)
-{
-	int rc;
-
-	rc =3D cyttsp4_request_exclusive(cd, cd->dev,
-			CY_CORE_REQUEST_EXCLUSIVE_TIMEOUT);
-	if (rc < 0) {
-		dev_err(cd->dev, "%s: fail get exclusive ex=3D%p own=3D%p\n",
-				__func__, cd->exclusive_dev, cd->dev);
-		return 0;
-	}
-
-	rc =3D cyttsp4_core_wake_(cd);
-
-	if (cyttsp4_release_exclusive(cd, cd->dev) < 0)
-		dev_err(cd->dev, "%s: fail to release exclusive\n", __func__);
-	else
-		dev_vdbg(cd->dev, "%s: pass release exclusive\n", __func__);
-
-	return rc;
-}
-
 static int cyttsp4_startup_(struct cyttsp4 *cd)
 {
 	int retry =3D CY_CORE_STARTUP_RETRY_COUNT;
@@ -1821,6 +1721,106 @@ static void cyttsp4_free_si_ptrs(struct cyttsp4=
 *cd)
 }
=20
 #if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
+static int cyttsp4_core_sleep(struct cyttsp4 *cd)
+{
+	int rc;
+
+	rc =3D cyttsp4_request_exclusive(cd, cd->dev,
+			CY_CORE_SLEEP_REQUEST_EXCLUSIVE_TIMEOUT);
+	if (rc < 0) {
+		dev_err(cd->dev, "%s: fail get exclusive ex=3D%p own=3D%p\n",
+				__func__, cd->exclusive_dev, cd->dev);
+		return 0;
+	}
+
+	rc =3D cyttsp4_core_sleep_(cd);
+
+	if (cyttsp4_release_exclusive(cd, cd->dev) < 0)
+		dev_err(cd->dev, "%s: fail to release exclusive\n", __func__);
+	else
+		dev_vdbg(cd->dev, "%s: pass release exclusive\n", __func__);
+
+	return rc;
+}
+
+static int cyttsp4_core_wake_(struct cyttsp4 *cd)
+{
+	struct device *dev =3D cd->dev;
+	int rc;
+	u8 mode;
+	int t;
+
+	/* Already woken? */
+	mutex_lock(&cd->system_lock);
+	if (cd->sleep_state =3D=3D SS_SLEEP_OFF) {
+		mutex_unlock(&cd->system_lock);
+		return 0;
+	}
+	cd->int_status &=3D ~CY_INT_IGNORE;
+	cd->int_status |=3D CY_INT_AWAKE;
+	cd->sleep_state =3D SS_WAKING;
+
+	if (cd->cpdata->power) {
+		dev_dbg(dev, "%s: Power up HW\n", __func__);
+		rc =3D cd->cpdata->power(cd->cpdata, 1, dev, &cd->ignore_irq);
+	} else {
+		dev_dbg(dev, "%s: No power function\n", __func__);
+		rc =3D -ENOSYS;
+	}
+	if (rc < 0) {
+		dev_err(dev, "%s: HW Power up fails r=3D%d\n",
+				__func__, rc);
+
+		/* Initiate a read transaction to wake up */
+		cyttsp4_adap_read(cd, CY_REG_BASE, sizeof(mode), &mode);
+	} else
+		dev_vdbg(cd->dev, "%s: HW power up succeeds\n",
+			__func__);
+	mutex_unlock(&cd->system_lock);
+
+	t =3D wait_event_timeout(cd->wait_q,
+			(cd->int_status & CY_INT_AWAKE) =3D=3D 0,
+			msecs_to_jiffies(CY_CORE_WAKEUP_TIMEOUT));
+	if (IS_TMO(t)) {
+		dev_err(dev, "%s: TMO waiting for wakeup\n", __func__);
+		mutex_lock(&cd->system_lock);
+		cd->int_status &=3D ~CY_INT_AWAKE;
+		/* Try starting up */
+		cyttsp4_queue_startup_(cd);
+		mutex_unlock(&cd->system_lock);
+	}
+
+	mutex_lock(&cd->system_lock);
+	cd->sleep_state =3D SS_SLEEP_OFF;
+	mutex_unlock(&cd->system_lock);
+
+	cyttsp4_start_wd_timer(cd);
+
+	return 0;
+}
+
+static int cyttsp4_core_wake(struct cyttsp4 *cd)
+{
+	int rc;
+
+	rc =3D cyttsp4_request_exclusive(cd, cd->dev,
+			CY_CORE_REQUEST_EXCLUSIVE_TIMEOUT);
+	if (rc < 0) {
+		dev_err(cd->dev, "%s: fail get exclusive ex=3D%p own=3D%p\n",
+				__func__, cd->exclusive_dev, cd->dev);
+		return 0;
+	}
+
+	rc =3D cyttsp4_core_wake_(cd);
+
+	if (cyttsp4_release_exclusive(cd, cd->dev) < 0)
+		dev_err(cd->dev, "%s: fail to release exclusive\n", __func__);
+	else
+		dev_vdbg(cd->dev, "%s: pass release exclusive\n", __func__);
+
+	return rc;
+}
+
 static int cyttsp4_core_suspend(struct device *dev)
 {
 	struct cyttsp4 *cd =3D dev_get_drvdata(dev);
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
