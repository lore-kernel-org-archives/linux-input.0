From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 17/17] Input: tsc2005 - remove 'disable' sysfs attribute
Date: Wed, 16 Mar 2011 00:19:28 -0700
Message-ID: <20110316071928.25664.46040.stgit@hammer.corenet.prv>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43936 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1CPHTd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 03:19:33 -0400
Received: by mail-yx0-f174.google.com with SMTP id 7so546881yxs.19
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2011 00:19:33 -0700 (PDT)
In-Reply-To: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

I believe that enable/disable functionality should not be implemented on
the individual driver level but rather in device core, potentially
reusing parts of PM framework. Therefore the driver-specific "disable"
attribute is removed from the mainline driver.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/tsc2005.c |   52 +++--------------------------------
 1 files changed, 4 insertions(+), 48 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 2e8c063..0e3c403 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -138,7 +138,6 @@ struct tsc2005 {
 
 	unsigned int		x_plate_ohm;
 
-	bool			disabled;
 	bool			opened;
 	bool			suspended;
 
@@ -365,48 +364,6 @@ static void __tsc2005_enable(struct tsc2005 *ts)
 
 }
 
-static ssize_t tsc2005_disable_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct spi_device *spi = to_spi_device(dev);
-	struct tsc2005 *ts = spi_get_drvdata(spi);
-
-	return sprintf(buf, "%u\n", ts->disabled);
-}
-
-static ssize_t tsc2005_disable_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct spi_device *spi = to_spi_device(dev);
-	struct tsc2005 *ts = spi_get_drvdata(spi);
-	unsigned long val;
-	int error;
-
-	error = strict_strtoul(buf, 10, &val);
-	if (error)
-		return error;
-
-	mutex_lock(&ts->mutex);
-
-	if (!ts->suspended && ts->opened) {
-		if (val) {
-			if (!ts->disabled)
-				__tsc2005_disable(ts);
-		} else {
-			if (ts->disabled)
-				__tsc2005_enable(ts);
-		}
-	}
-
-	ts->disabled = !!val;
-
-	mutex_unlock(&ts->mutex);
-
-	return count;
-}
-static DEVICE_ATTR(disable, 0664, tsc2005_disable_show, tsc2005_disable_store);
-
 static ssize_t tsc2005_selftest_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -489,7 +446,6 @@ out:
 static DEVICE_ATTR(selftest, S_IRUGO, tsc2005_selftest_show, NULL);
 
 static struct attribute *tsc2005_attrs[] = {
-	&dev_attr_disable.attr,
 	&dev_attr_selftest.attr,
 	NULL
 };
@@ -567,7 +523,7 @@ static int tsc2005_open(struct input_dev *input)
 
 	mutex_lock(&ts->mutex);
 
-	if (!ts->suspended && !ts->disabled)
+	if (!ts->suspended)
 		__tsc2005_enable(ts);
 
 	ts->opened = true;
@@ -583,7 +539,7 @@ static void tsc2005_close(struct input_dev *input)
 
 	mutex_lock(&ts->mutex);
 
-	if (!ts->suspended && !ts->disabled)
+	if (!ts->suspended)
 		__tsc2005_disable(ts);
 
 	ts->opened = false;
@@ -739,7 +695,7 @@ static int tsc2005_suspend(struct device *dev)
 
 	mutex_lock(&ts->mutex);
 
-	if (!ts->suspended && !ts->disabled && ts->opened)
+	if (!ts->suspended && ts->opened)
 		__tsc2005_disable(ts);
 
 	ts->suspended = true;
@@ -756,7 +712,7 @@ static int tsc2005_resume(struct device *dev)
 
 	mutex_lock(&ts->mutex);
 
-	if (ts->suspended && !ts->disabled && ts->opened)
+	if (ts->suspended && ts->opened)
 		__tsc2005_enable(ts);
 
 	ts->suspended = false;

