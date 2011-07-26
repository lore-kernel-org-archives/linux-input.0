From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] drivers:input:set driver data to NULL for pcap_keys
Date: Tue, 26 Jul 2011 09:29:59 +0800
Message-ID: <4E2E1897.9020808@cn.fujitsu.com>
References: <1311176068-9934-1-git-send-email-wanlong.gao@gmail.com> <20110725083048.GD22937@core.coreip.homeip.net> <4E2D33E3.9090408@cn.fujitsu.com> <20110725152106.GB23356@suse.de> <1311608069.3262.8.camel@Allen> <20110725181916.GB6876@core.coreip.homeip.net> <20110725182928.GB1175@sirena.org.uk> <20110725183746.GD6876@core.coreip.homeip.net>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:58517 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752496Ab1GZBbE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 21:31:04 -0400
In-Reply-To: <20110725183746.GD6876@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Wanlong Gao <wanlong.gao@gmail.com>, Greg KH <gregkh@suse.de>, linux-input@vger.kernel.org

On 07/26/2011 02:37 AM, Dmitry Torokhov wrote:
> On Mon, Jul 25, 2011 at 07:29:28PM +0100, Mark Brown wrote:
>> On Mon, Jul 25, 2011 at 11:19:16AM -0700, Dmitry Torokhov wrote:
>>
>>> Right, like i2c bus we could just have platform core clean up platform
>>> drvdata pointer after calling ->remove() and also if ->probe() errors
>>> out.
>>
>> I2C doesn't do this (at least not any more).
>>
>
> Sure does. See drivers/i2c/i2c-core.c::i2c_device_probe() and
> i2c_device_remove().
Yeah, I see it. Sure i2c does.
Let the Core to do the pointer's clean up is very good idea.

So, Dmitry, do you means this ?

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
  drivers/base/platform.c |   30 ++++++++++++++++++++++++++++--
  1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 6040717..349e71b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -405,8 +405,21 @@ static int platform_drv_probe(struct device *_dev)
  {
  	struct platform_driver *drv = to_platform_driver(_dev->driver);
  	struct platform_device *dev = to_platform_device(_dev);
+	int status;

-	return drv->probe(dev);
+	if (!dev)
+		return 0;
+
+	if (!drv->probe)
+		return -ENODEV;
+
+	dev_dbg(_dev, "probe\n");
+
+	status = drv->probe(dev);
+	if (status)
+		platform_set_drvdata(dev, NULL);
+
+	return status;
  }

  static int platform_drv_probe_fail(struct device *_dev)
@@ -418,8 +431,21 @@ static int platform_drv_remove(struct device *_dev)
  {
  	struct platform_driver *drv = to_platform_driver(_dev->driver);
  	struct platform_device *dev = to_platform_device(_dev);
+	int status;
+
+	if (!dev)
+		return 0;
+
+	if (drv->remove) {
+		dev_dbg(_dev, "remove\n");
+		status = drv->remove(dev);
+	} else {
+		status = 0;
+	}
+	if (status == 0)
+		platform_set_drvdata(dev, NULL);

-	return drv->remove(dev);
+	return status;
  }

  static void platform_drv_shutdown(struct device *_dev)
-- 
1.7.6



-- 
Thanks
Best Regards
Wanlong Gao
