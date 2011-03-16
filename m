From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 10/17] Input: tsc2005 - hide selftest attribute if we can't
 reset
Date: Wed, 16 Mar 2011 00:18:51 -0700
Message-ID: <20110316071851.25664.73652.stgit@hammer.corenet.prv>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43936 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1CPHS4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 03:18:56 -0400
Received: by yxs7 with SMTP id 7so546881yxs.19
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2011 00:18:56 -0700 (PDT)
In-Reply-To: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

If implementation to perform self-test/reset has not been provided by the
platform code hide 'selftest' sysfs attribute instead of returning error
when someone tries to use it.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/tsc2005.c |   46 +++++++++++++++++++++--------------
 1 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index d7ea906..4f1c041 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -411,13 +411,6 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
 	u16 temp_high_test;
 	unsigned int result;
 
-	if (!ts->set_reset) {
-		dev_warn(&ts->spi->dev,
-			 "unable to selftest: no reset function\n");
-		result = 0;
-		goto out;
-	}
-
 	mutex_lock(&ts->mutex);
 
 	/*
@@ -451,11 +444,38 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
 
 	mutex_unlock(&ts->mutex);
 
-out:
 	return sprintf(buf, "%u\n", result);
 }
+
 static DEVICE_ATTR(selftest, S_IRUGO, tsc2005_selftest_show, NULL);
 
+static struct attribute *tsc2005_attrs[] = {
+	&dev_attr_disable.attr,
+	&dev_attr_selftest.attr,
+	NULL
+};
+
+static mode_t tsc2005_attr_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct spi_device *spi = to_spi_device(dev);
+	struct tsc2005 *ts = spi_get_drvdata(spi);
+	mode_t mode = attr->mode;
+
+	if (attr == &dev_attr_selftest.attr) {
+		if (!ts->set_reset)
+			mode = 0;
+	}
+
+	return mode;
+}
+
+static const struct attribute_group tsc2005_attr_group = {
+	.is_visible	= tsc2005_attr_is_visible,
+	.attrs		= tsc2005_attrs,
+};
+
 static void tsc2005_esd_timer(unsigned long data)
 {
 	struct tsc2005 *ts = (struct tsc2005 *)data;
@@ -495,16 +515,6 @@ out:
 	mutex_unlock(&ts->mutex);
 }
 
-static struct attribute *tsc2005_attrs[] = {
-	&dev_attr_disable.attr,
-	&dev_attr_selftest.attr,
-	NULL
-};
-
-static struct attribute_group tsc2005_attr_group = {
-	.attrs = tsc2005_attrs,
-};
-
 static void __devinit tsc2005_setup_spi_xfer(struct tsc2005 *ts)
 {
 	tsc2005_setup_read(&ts->spi_x, TSC2005_REG_X, 0);

