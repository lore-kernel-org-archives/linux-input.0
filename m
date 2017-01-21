From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 12/13] Input: serio - drop unnecessary calls to
 device_init_wakeup
Date: Sat, 21 Jan 2017 10:46:04 -0800
Message-ID: <1485024365-3368-13-git-send-email-linux@roeck-us.net>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devel@linuxdriverproject.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

Calling device_init_wakeup in the remove function is unnecessary since the
device is going away, and thus won't be able to cause any wakeups under any
circumstances. Besides, the driver cleanup code already handles the
necessary cleanup.

Similar, disabling wakeup in the probe error path is unnecessary, as is
disabling wakeup in the probe function in the first place.

Changes were done automatically using the following coccinelle script.

@probe@
identifier p, probefn;
declarer name module_platform_driver_probe;
position pos;
@@
(
  module_platform_driver_probe(p, probefn@pos);
|
  struct platform_driver p = {
    .probe = probefn@pos,
  };
|
  struct i2c_driver p = {
    .probe = probefn@pos,
  };
|
  struct spi_driver p = {
    .probe = probefn@pos,
  };
)

@remove@
identifier p, removefn;
@@

  struct
(
  platform_driver
|
  i2c_driver
|
  spi_driver
|
  hv_driver
)
  p = {
    .remove = \(__exit_p(removefn)\|removefn\),
  };

@depends on remove@
identifier remove.removefn;
@@

removefn(...) {
<+...
- device_init_wakeup(...);
...+>
}

@depends on probe@
identifier probe.probefn;
expression dev;
@@

probefn(...) {
<+...
- device_init_wakeup(..., \(false\|0\));
  ...+>
}

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/serio/hyperv-keyboard.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index c948866edf87..25151d9214e0 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -402,7 +402,6 @@ static int hv_kbd_remove(struct hv_device *hv_dev)
 {
 	struct hv_kbd_dev *kbd_dev = hv_get_drvdata(hv_dev);
 
-	device_init_wakeup(&hv_dev->device, false);
 	serio_unregister_port(kbd_dev->hv_serio);
 	vmbus_close(hv_dev->channel);
 	kfree(kbd_dev);
-- 
2.7.4
