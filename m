From: Mark Laws <mdl@60hz.org>
Subject: [PATCH] Input: i8042 - Fix console keyboard support on Gen2 Hyper-V
 VMs
Date: Fri, 22 Apr 2016 22:01:00 +0900
Message-ID: <1461330060-35567-2-git-send-email-mdl@60hz.org>
References: <CADemMPMSYfdbt5U6mgj=kdbBQKP_nWrah3M5ZuyZZk6soWJGjg@mail.gmail.com>
 <1461330060-35567-1-git-send-email-mdl@60hz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1461330060-35567-1-git-send-email-mdl@60hz.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: haiyangz@microsoft.com
Cc: devel@linuxdriverproject.org, linux-input@vger.kernel.org, Mark Laws <mdl@60hz.org>
List-Id: linux-input@vger.kernel.org

As explained in 1407814240-4275-1-git-send-email-decui@microsoft.com:

> hyperv_keyboard invokes serio_interrupt(), which needs a valid serio
> driver like atkbd.c.  atkbd.c depends on libps2.c because it invokes
> ps2_command().  libps2.c depends on i8042.c because it invokes
> i8042_check_port_owner().  As a result, hyperv_keyboard actually
> depends on i8042.c.
>
> For a Generation 2 Hyper-V VM (meaning no i8042 device emulated), if a
> Linux VM (like Arch Linux) happens to configure CONFIG_SERIO_I8042=m
> rather than =y, atkbd.ko can't load because i8042.ko can't load(due to
> no i8042 device emulated) and finally hyperv_keyboard can't work and
> the user can't input: https://bugs.archlinux.org/task/39820
> (Ubuntu/RHEL/SUSE aren't affected since they use CONFIG_SERIO_I8042=y)

The transitive dependency on i8042.c is non-trivial--there appears to be
no obvious way to untangle it other than by duplicating much of atkbd.c
within hyperv-keyboard--so we employ a simple workaround: keep i8042.ko
loaded even if no i8042 device is detected, but set a flag so that any
calls into the module simply return (since we don't want to try to
interact with the non-existent i8042).  This allows atkbd.c and libps2.c
to load, solving the problem.

Signed-off-by: Mark Laws <mdl@60hz.org>
---
 drivers/input/serio/i8042.c | 50 ++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 4541957..00f73d3 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -132,6 +132,7 @@ struct i8042_port {
 
 static struct i8042_port i8042_ports[I8042_NUM_PORTS];
 
+static bool i8042_present;
 static unsigned char i8042_initial_ctr;
 static unsigned char i8042_ctr;
 static bool i8042_mux_present;
@@ -163,6 +164,9 @@ int i8042_install_filter(bool (*filter)(unsigned char data, unsigned char str,
 	unsigned long flags;
 	int ret = 0;
 
+	if (!i8042_present)
+		return 0;
+
 	spin_lock_irqsave(&i8042_lock, flags);
 
 	if (i8042_platform_filter) {
@@ -184,6 +188,9 @@ int i8042_remove_filter(bool (*filter)(unsigned char data, unsigned char str,
 	unsigned long flags;
 	int ret = 0;
 
+	if (!i8042_present)
+		return 0;
+
 	spin_lock_irqsave(&i8042_lock, flags);
 
 	if (i8042_platform_filter != filter) {
@@ -313,6 +320,9 @@ int i8042_command(unsigned char *param, int command)
 	unsigned long flags;
 	int retval;
 
+	if (!i8042_present)
+		return 0;
+
 	spin_lock_irqsave(&i8042_lock, flags);
 	retval = __i8042_command(param, command);
 	spin_unlock_irqrestore(&i8042_lock, flags);
@@ -1380,6 +1390,9 @@ bool i8042_check_port_owner(const struct serio *port)
 {
 	int i;
 
+	if (!i8042_present)
+		return false;
+
 	for (i = 0; i < I8042_NUM_PORTS; i++)
 		if (i8042_ports[i].serio == port)
 			return true;
@@ -1493,6 +1506,10 @@ static int __init i8042_probe(struct platform_device *dev)
 {
 	int error;
 
+	error = i8042_controller_check();
+	if (error)
+		return error;
+
 	i8042_platform_device = dev;
 
 	if (i8042_reset) {
@@ -1569,38 +1586,39 @@ static int __init i8042_init(void)
 
 	dbg_init();
 
+	i8042_present = false;
+
 	err = i8042_platform_init();
 	if (err)
 		return err;
 
-	err = i8042_controller_check();
-	if (err)
-		goto err_platform_exit;
-
 	pdev = platform_create_bundle(&i8042_driver, i8042_probe, NULL, 0, NULL, 0);
-	if (IS_ERR(pdev)) {
-		err = PTR_ERR(pdev);
-		goto err_platform_exit;
-	}
+	if (IS_ERR(pdev))
+		return 0; /* load anyway since some modules depend on our symbols */
 
 	bus_register_notifier(&serio_bus, &i8042_kbd_bind_notifier_block);
 	panic_blink = i8042_panic_blink;
+	i8042_present = true;
 
 	return 0;
-
- err_platform_exit:
-	i8042_platform_exit();
-	return err;
 }
 
 static void __exit i8042_exit(void)
 {
-	platform_device_unregister(i8042_platform_device);
-	platform_driver_unregister(&i8042_driver);
+	if (i8042_present) {
+		platform_device_unregister(i8042_platform_device);
+		platform_driver_unregister(&i8042_driver);
+	}
+
 	i8042_platform_exit();
 
-	bus_unregister_notifier(&serio_bus, &i8042_kbd_bind_notifier_block);
-	panic_blink = NULL;
+	if (i8042_present) {
+		bus_unregister_notifier(&serio_bus,
+					&i8042_kbd_bind_notifier_block);
+		panic_blink = NULL;
+	}
+
+	i8042_present = false;
 }
 
 module_init(i8042_init);
-- 
2.8.0
