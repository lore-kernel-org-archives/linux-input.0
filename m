From: Alan Stern <stern@rowland.harvard.edu>
Subject: [RFC] Wakeup for PNP
Date: Tue, 2 Mar 2010 15:13:30 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003021505130.1910-100000@iolanthe.rowland.org>
References: <20100223214920.GA14313@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100223214920.GA14313@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 23 Feb 2010, Dmitry Torokhov wrote:

> Yes, I agree, we need a genric mechanism for PNP to emable wakups. It
> was discussed a bit here:
> 
> 	http://bugzilla.kernel.org/show_bug.cgi?id=8286
> 
> but David was too hung up on the fact that number of devices in ACPI
> does not map directly onto number of serio ports when i8042 is in active
> multiplexing mode that it id not go anywhere.

Does this look reasonable?  I don't know anything about PNPBIOS or 
ISAPNP, so it handles only PNPACPI.  But at least it's a starting 
point -- and it does enable my system to wake up in response to 
hitting a key.

(This combines changes to the PNP core with changes to the i8042 
drivers.  For submission they can be broken out into separate patches.)

Alan Stern


Index: usb-2.6/drivers/input/serio/i8042-x86ia64io.h
===================================================================
--- usb-2.6.orig/drivers/input/serio/i8042-x86ia64io.h
+++ usb-2.6/drivers/input/serio/i8042-x86ia64io.h
@@ -625,6 +625,7 @@ static int i8042_pnp_kbd_probe(struct pn
 	}
 
 	i8042_pnp_kbd_devices++;
+	device_set_wakeup_enable(&dev->dev, true);
 	return 0;
 }
 
@@ -646,6 +647,7 @@ static int i8042_pnp_aux_probe(struct pn
 	}
 
 	i8042_pnp_aux_devices++;
+	device_set_wakeup_enable(&dev->dev, true);
 	return 0;
 }
 
@@ -656,7 +658,7 @@ static struct pnp_device_id pnp_kbd_devi
 };
 
 static struct pnp_driver i8042_pnp_kbd_driver = {
-	.name           = "i8042 kbd",
+	.name           = "i8042-kbd",
 	.id_table       = pnp_kbd_devids,
 	.probe          = i8042_pnp_kbd_probe,
 };
@@ -676,7 +678,7 @@ static struct pnp_device_id pnp_aux_devi
 };
 
 static struct pnp_driver i8042_pnp_aux_driver = {
-	.name           = "i8042 aux",
+	.name           = "i8042-aux",
 	.id_table       = pnp_aux_devids,
 	.probe          = i8042_pnp_aux_probe,
 };
Index: usb-2.6/drivers/pnp/core.c
===================================================================
--- usb-2.6.orig/drivers/pnp/core.c
+++ usb-2.6/drivers/pnp/core.c
@@ -164,6 +164,9 @@ int __pnp_add_device(struct pnp_dev *dev
 	list_add_tail(&dev->global_list, &pnp_global);
 	list_add_tail(&dev->protocol_list, &dev->protocol->devices);
 	spin_unlock(&pnp_lock);
+	device_set_wakeup_capable(&dev->dev,
+			dev->protocol->can_wakeup &&
+			dev->protocol->can_wakeup(dev));
 	return device_register(&dev->dev);
 }
 
Index: usb-2.6/drivers/pnp/pnpacpi/core.c
===================================================================
--- usb-2.6.orig/drivers/pnp/pnpacpi/core.c
+++ usb-2.6/drivers/pnp/pnpacpi/core.c
@@ -121,12 +121,27 @@ static int pnpacpi_disable_resources(str
 }
 
 #ifdef CONFIG_ACPI_SLEEP
+static bool pnpacpi_can_wakeup(struct pnp_dev *dev)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+
+	return handle && acpi_bus_can_wakeup(handle);
+}
+
 static int pnpacpi_suspend(struct pnp_dev *dev, pm_message_t state)
 {
 	struct acpi_device *acpi_dev = dev->data;
 	acpi_handle handle = acpi_dev->handle;
 	int power_state;
 
+	if (device_can_wakeup(&dev->dev)) {
+		int ret;
+
+		ret = acpi_pm_device_sleep_wake(&dev->dev,
+				device_may_wakeup(&dev->dev));
+		if (ret)
+			return ret;
+	}
 	power_state = acpi_pm_device_sleep_state(&dev->dev, NULL);
 	if (power_state < 0)
 		power_state = (state.event == PM_EVENT_ON) ?
@@ -140,6 +155,8 @@ static int pnpacpi_resume(struct pnp_dev
 	struct acpi_device *acpi_dev = dev->data;
 	acpi_handle handle = acpi_dev->handle;
 
+	if (device_can_wakeup(&dev->dev))
+		acpi_pm_device_sleep_wake(&dev->dev, false);
 	return acpi_bus_set_power(handle, ACPI_STATE_D0);
 }
 #endif
@@ -150,6 +167,7 @@ struct pnp_protocol pnpacpi_protocol = {
 	.set	 = pnpacpi_set_resources,
 	.disable = pnpacpi_disable_resources,
 #ifdef CONFIG_ACPI_SLEEP
+	.can_wakeup = pnpacpi_can_wakeup,
 	.suspend = pnpacpi_suspend,
 	.resume = pnpacpi_resume,
 #endif
Index: usb-2.6/include/linux/pnp.h
===================================================================
--- usb-2.6.orig/include/linux/pnp.h
+++ usb-2.6/include/linux/pnp.h
@@ -414,6 +414,7 @@ struct pnp_protocol {
 	int (*disable) (struct pnp_dev *dev);
 
 	/* protocol specific suspend/resume */
+	bool (*can_wakeup) (struct pnp_dev *dev);
 	int (*suspend) (struct pnp_dev * dev, pm_message_t state);
 	int (*resume) (struct pnp_dev * dev);
 
