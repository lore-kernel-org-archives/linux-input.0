From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [hid:for-4.10/i2c-hid 7/8] drivers/hid/i2c-hid/i2c-hid.c:772:19:
 error: 'struct i2c_hid' has no member named 'irq'
Date: Sat, 10 Dec 2016 22:06:18 +0100
Message-ID: <20161210210618.GD1919@mail.corp.redhat.com>
References: <201612110449.vUI7nclV%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752094AbcLJVGX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 10 Dec 2016 16:06:23 -0500
Content-Disposition: inline
In-Reply-To: <201612110449.vUI7nclV%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: =?utf-8?B?Sm/Do28=?= Paulo Rechi Vita <jprvita@gmail.com>, kbuild-all@01.org, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Dec 11 2016 or thereabouts, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-4.10/i2c-hid
> head:   d4c9be33182718e3dbdd5834a415899949187a5b
> commit: de3c99488609284e454cf2b4420a789038a4cfa8 [7/8] HID: i2c-hid: Disable IRQ before freeing buffers
> config: x86_64-rhel (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout de3c99488609284e454cf2b4420a789038a4cfa8
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/hid/i2c-hid/i2c-hid.c: In function 'i2c_hid_start':
> >> drivers/hid/i2c-hid/i2c-hid.c:772:19: error: 'struct i2c_hid' has no member named 'irq'
>       disable_irq(ihid->irq);
>                       ^~
>    drivers/hid/i2c-hid/i2c-hid.c:776:18: error: 'struct i2c_hid' has no member named 'irq'
>       enable_irq(ihid->irq);
>                      ^~
>    drivers/hid/i2c-hid/i2c-hid.c: In function 'i2c_hid_probe':
>    drivers/hid/i2c-hid/i2c-hid.c:1050:23: error: implicit declaration of function 'devm_regulator_get' [-Werror=implicit-function-declaration]
>      ihid->pdata.supply = devm_regulator_get(&client->dev, "vdd");
>                           ^~~~~~~~~~~~~~~~~~
>    drivers/hid/i2c-hid/i2c-hid.c:1050:21: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>      ihid->pdata.supply = devm_regulator_get(&client->dev, "vdd");
>                         ^
>    drivers/hid/i2c-hid/i2c-hid.c:1059:8: error: implicit declaration of function 'regulator_enable' [-Werror=implicit-function-declaration]
>      ret = regulator_enable(ihid->pdata.supply);
>            ^~~~~~~~~~~~~~~~
>    drivers/hid/i2c-hid/i2c-hid.c:1141:2: error: implicit declaration of function 'regulator_disable' [-Werror=implicit-function-declaration]
>      regulator_disable(ihid->pdata.supply);
>      ^~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +772 drivers/hid/i2c-hid/i2c-hid.c
> 
>    766	
>    767		i2c_hid_find_max_report(hid, HID_INPUT_REPORT, &bufsize);
>    768		i2c_hid_find_max_report(hid, HID_OUTPUT_REPORT, &bufsize);
>    769		i2c_hid_find_max_report(hid, HID_FEATURE_REPORT, &bufsize);
>    770	
>    771		if (bufsize > ihid->bufsize) {
>  > 772			disable_irq(ihid->irq);
>    773			i2c_hid_free_buffers(ihid);
>    774	
>    775			ret = i2c_hid_alloc_buffers(ihid, bufsize);
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Ouch. Sorry, I should have spotted this during review.

Jiri, could you apply the following simple fix:

>From 3c3bff3c6d36b3a9b2aac5993da1345f3b12e6ac Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Sat, 10 Dec 2016 21:58:55 +0100
Subject: [PATCH] HID: fix missing irq field

commit ba18a9314a94 ("Revert "HID: i2c-hid: Add support for ACPI GPIO
interrupts"") removed the need for storing the irq in struct i2c_hid.

But then commit de3c99488609 ("HID: i2c-hid: Disable IRQ before freeing
buffers") forgot to update the location of the irq.

Fix this by using the actual I2C client irq.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 3e6386e..844662c 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -770,11 +770,11 @@ static int i2c_hid_start(struct hid_device *hid)
 	i2c_hid_find_max_report(hid, HID_FEATURE_REPORT, &bufsize);
 
 	if (bufsize > ihid->bufsize) {
-		disable_irq(ihid->irq);
+		disable_irq(client->irq);
 		i2c_hid_free_buffers(ihid);
 
 		ret = i2c_hid_alloc_buffers(ihid, bufsize);
-		enable_irq(ihid->irq);
+		enable_irq(client->irq);
 
 		if (ret)
 			return ret;
-- 
2.9.3

Cheers,
Benjamin
