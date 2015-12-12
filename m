From: Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH] touchscreen: edt-ft5x06: Prevent DMA driver from mapping an area on stack
Date: Sat, 12 Dec 2015 15:39:37 +0530
Message-ID: <e0311a5e79a315814e8678c9ef4a32563c01d1e0.1449913392.git.maitysanchayan@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32783 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbbLLKOR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Dec 2015 05:14:17 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, maxime.ripard@free-electrons.com, stefan@agner.ch, Sanchayan Maity <maitysanchayan@gmail.com>

This patch removes the use of i2c_msg locally inside the function.
Without this, having i2c_msg locally allocated on stack, being used
by i2c_transfer on a platform where the I2C driver uses DMA, results
in the debug stack trace being reported during kernel boot in case
CONFIG_DMA_API_DEBUG is selected. (See a little below).

This was observed while using a touchscreen with this controller on
Freescale Vybrid on Colibri Vybrid VF61 module. Vybrid uses the i2c-
imx driver which leverages DMA during I2C transfers.

[    1.496997] WARNING: CPU: 0 PID: 1 at lib/dma-debug.c:1169 check_for_stack+0xbc/0xf8()
[    1.508488] fsl-edma 40018000.dma-controller: DMA-API: device driver maps memory from stack [addr=8f44be38]
[    1.525379] Modules linked in:
[    1.531944] CPU: 0 PID: 1 Comm: swapper Not tainted 4.1.12-00004-g4167ee1-dirty #858
[    1.543485] Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
[    1.553782] [<80014af0>] (unwind_backtrace) from [<800123ec>] (show_stack+0x10/0x14)
[    1.565471] [<800123ec>] (show_stack) from [<8002339c>] (warn_slowpath_common+0x80/0xac)
[    1.577569] [<8002339c>] (warn_slowpath_common) from [<800233f8>] (warn_slowpath_fmt+0x30/0x40)
[    1.590370] [<800233f8>] (warn_slowpath_fmt) from [<80299eac>] (check_for_stack+0xbc/0xf8)
[    1.602843] [<80299eac>] (check_for_stack) from [<8029b050>] (debug_dma_map_page+0xd8/0xf8)
[    1.615573] [<8029b050>] (debug_dma_map_page) from [<803a8274>] (i2c_imx_dma_xfer+0xd0/0x25c)
[    1.628620] [<803a8274>] (i2c_imx_dma_xfer) from [<803a90d0>] (i2c_imx_xfer+0xc04/0xe78)
[    1.641318] [<803a90d0>] (i2c_imx_xfer) from [<803a552c>] (__i2c_transfer+0x140/0x27c)
[    1.653830] [<803a552c>] (__i2c_transfer) from [<803a56fc>] (i2c_transfer+0x94/0xc4)
[    1.666159] [<803a56fc>] (i2c_transfer) from [<8039c21c>] (edt_ft5x06_ts_readwrite+0x74/0x90)
[    1.679432] [<8039c21c>] (edt_ft5x06_ts_readwrite) from [<8039cea8>] (edt_ft5x06_ts_probe+0xc4/0x83c)
[    1.698292] [<8039cea8>] (edt_ft5x06_ts_probe) from [<803a4928>] (i2c_device_probe+0xf8/0x148)
[    1.712047] [<803a4928>] (i2c_device_probe) from [<802f0ef4>] (driver_probe_device+0x174/0x2ac)
[    1.725909] [<802f0ef4>] (driver_probe_device) from [<802f10fc>] (__driver_attach+0x8c/0x90)
[    1.739532] [<802f10fc>] (__driver_attach) from [<802ef494>] (bus_for_each_dev+0x68/0x9c)
[    1.752945] [<802ef494>] (bus_for_each_dev) from [<802f068c>] (bus_add_driver+0x148/0x1f0)
[    1.766495] [<802f068c>] (bus_add_driver) from [<802f16b8>] (driver_register+0x78/0xf8)
[    1.779823] [<802f16b8>] (driver_register) from [<803a5324>] (i2c_register_driver+0x30/0x7c)
[    1.793588] [<803a5324>] (i2c_register_driver) from [<80009634>] (do_one_initcall+0x8c/0x1d4)
[    1.807404] [<80009634>] (do_one_initcall) from [<80773d78>] (kernel_init_freeable+0x124/0x1c4)
[    1.821359] [<80773d78>] (kernel_init_freeable) from [<8055a674>] (kernel_init+0xc/0xe8)
[    1.834797] [<8055a674>] (kernel_init) from [<8000f2c8>] (ret_from_fork+0x14/0x2c)
[    1.847692] ---[ end trace b9ef4ceb9f47043b ]---

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
Hello,

Frankly speaking I do not know where the fix should actually be. I2C IMX
driver somehow taking care of this or the users of I2C, touchscreen drivers
in this case. In my opinion, the fix should be with the touchscreen driver
however I did like to have feedback or hear opinions on what is the accepted
solution to this.

I guess no one ever had the DMA Debug option enabled while using an I2C driver
that used DMA so somehow this never came up? I only noticed this since we had
a customer requesting for information on this driver and then while checking
as I had the DMA debug option enabled from my work on a separate driver, this
popped up. My colleague pointed me to [1] but anyways I am not sure and thought
I did report this.

[1]. http://lkml.iu.edu/hypermail/linux/kernel/1106.0/00237.html

Regards,
Sanchayan.
---
 drivers/input/touchscreen/edt-ft5x06.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 0b0f8c1..4391d6c 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -109,6 +109,7 @@ struct edt_ft5x06_ts_data {
 	char name[EDT_NAME_LEN];
 
 	struct edt_reg_addr reg_addr;
+	struct i2c_msg wrmsg[2];
 	enum edt_ver version;
 };
 
@@ -120,26 +121,26 @@ static int edt_ft5x06_ts_readwrite(struct i2c_client *client,
 				   u16 wr_len, u8 *wr_buf,
 				   u16 rd_len, u8 *rd_buf)
 {
-	struct i2c_msg wrmsg[2];
+	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
 	int i = 0;
 	int ret;
 
 	if (wr_len) {
-		wrmsg[i].addr  = client->addr;
-		wrmsg[i].flags = 0;
-		wrmsg[i].len = wr_len;
-		wrmsg[i].buf = wr_buf;
+		tsdata->wrmsg[i].addr  = client->addr;
+		tsdata->wrmsg[i].flags = 0;
+		tsdata->wrmsg[i].len = wr_len;
+		tsdata->wrmsg[i].buf = wr_buf;
 		i++;
 	}
 	if (rd_len) {
-		wrmsg[i].addr  = client->addr;
-		wrmsg[i].flags = I2C_M_RD;
-		wrmsg[i].len = rd_len;
-		wrmsg[i].buf = rd_buf;
+		tsdata->wrmsg[i].addr  = client->addr;
+		tsdata->wrmsg[i].flags = I2C_M_RD;
+		tsdata->wrmsg[i].len = rd_len;
+		tsdata->wrmsg[i].buf = rd_buf;
 		i++;
 	}
 
-	ret = i2c_transfer(client->adapter, wrmsg, i);
+	ret = i2c_transfer(client->adapter, tsdata->wrmsg, i);
 	if (ret < 0)
 		return ret;
 	if (ret != i)
-- 
2.6.4

