From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/2] Winbond: convert from ACPI to PNP driver
Date: Thu, 9 Jul 2009 15:40:27 -0600
Message-ID: <200907091540.28283.bjorn.helgaas@hp.com>
References: <1246079912-17619-1-git-send-email-david@hardeman.nu> <200907081052.20142.bjorn.helgaas@hp.com> <200907091538.21685.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:18696 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511AbZGIVkc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 17:40:32 -0400
In-Reply-To: <200907091538.21685.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David =?utf-8?q?H=C3=A4rdeman?= <david@hardeman.nu>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, Len Brown <lenb@kernel.org>

diff --git a/drivers/input/misc/winbond-cir.c b/drivers/input/misc/winb=
ond-cir.c
index f97271b..9b5c985 100644
--- a/drivers/input/misc/winbond-cir.c
+++ b/drivers/input/misc/winbond-cir.c
@@ -45,7 +45,7 @@
  */
=20
 #include <linux/module.h>
-#include <linux/acpi.h>
+#include <linux/pnp.h>
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/input.h>
@@ -161,7 +161,6 @@ enum wbcir_protocol {
=20
 /* Misc */
 #define WBCIR_ACPI_NAME	"Winbond CIR"
-#define WBCIR_ACPI_CLASS	"CIR"
 #define WBCIR_ID_FAMILY          0xF1 /* Family ID for the WPCD376I	*/
 #define	WBCIR_ID_CHIP            0x04 /* Chip ID for the WPCD376I	*/
 #define IR_KEYPRESS_TIMEOUT       250 /* FIXME: should be per-protocol=
? */
@@ -937,8 +936,8 @@ wbcir_parse_nec(struct device *dev, struct wbcir_da=
ta *data)
 static irqreturn_t
 wbcir_irq_handler(int irqno, void *cookie)
 {
-	struct acpi_device *device =3D cookie;
-	struct wbcir_data *data =3D acpi_driver_data(device);
+	struct pnp_dev *device =3D cookie;
+	struct wbcir_data *data =3D pnp_get_drvdata(device);
 	struct device *dev =3D &device->dev;
 	u8 status;
 	unsigned long flags;
@@ -1021,11 +1020,11 @@ out:
  *
  *********************************************************************=
********/
=20
-static int
-wbcir_shutdown(struct acpi_device *device)
+static void
+wbcir_shutdown(struct pnp_dev *device)
 {
 	struct device *dev =3D &device->dev;
-	struct wbcir_data *data =3D acpi_driver_data(device);
+	struct wbcir_data *data =3D pnp_get_drvdata(device);
 	int do_wake =3D 1;
 	u8 match[11];
 	u8 mask[11];
@@ -1197,20 +1196,19 @@ finish:
=20
 	/* Disable interrupts */
 	outb(WBCIR_IRQ_NONE, data->sbase + WBCIR_REG_SP3_IER);
-
-	return 0;
 }
=20
 static int
-wbcir_suspend(struct acpi_device *device, pm_message_t state)
+wbcir_suspend(struct pnp_dev *device, pm_message_t state)
 {
-	return wbcir_shutdown(device);
+	wbcir_shutdown(device);
+	return 0;
 }
=20
 static int
-wbcir_resume(struct acpi_device *device)
+wbcir_resume(struct pnp_dev *device)
 {
-	struct wbcir_data *data =3D acpi_driver_data(device);
+	struct wbcir_data *data =3D pnp_get_drvdata(device);
=20
 	/* Clear BUFF_EN, Clear END_EN, Clear MATCH_EN */
 	wbcir_set_bits(data->wbase + WBCIR_REG_WCEIR_EV_EN, 0x00, 0x07);
@@ -1237,8 +1235,8 @@ static ssize_t
 wbcir_show_last_scancode(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	struct acpi_device *device =3D container_of(dev, struct acpi_device, =
dev);
-	struct wbcir_data *data =3D acpi_driver_data(device);
+	struct pnp_dev *device =3D container_of(dev, struct pnp_dev, dev);
+	struct wbcir_data *data =3D pnp_get_drvdata(device);
 	return sprintf(buf, "0x%08X\n", data->last_scancode);
 }
=20
@@ -1261,56 +1259,6 @@ static struct attribute_group wbcir_attribute_gr=
oup =3D {
 	.attrs =3D wbcir_attributes,
 };
=20
-static acpi_status
-wbcir_walk_resources(struct acpi_resource *resource, void *context)
-{
-	struct wbcir_data *data =3D context;
-
-	switch (resource->type) {
-
-	case ACPI_RESOURCE_TYPE_IO:
-		if (!data->ebase) {
-			if (resource->data.io.address_length !=3D
-			    EHFUNC_IOMEM_LEN)
-				goto error;
-			data->ebase =3D resource->data.io.minimum;
-		} else if (!data->wbase) {
-			if (resource->data.io.address_length !=3D
-			    WAKEUP_IOMEM_LEN)
-				goto error;
-			data->wbase =3D resource->data.io.minimum;
-		} else if (!data->sbase) {
-			if (resource->data.io.address_length !=3D
-			    SP_IOMEM_LEN)
-				goto error;
-			data->sbase =3D resource->data.io.minimum;
-		} else {
-			goto error;
-		}
-		break;
-
-	case ACPI_RESOURCE_TYPE_IRQ:
-		if (resource->data.irq.interrupt_count !=3D 1)
-			goto error;
-		else if (!data->irq)
-			data->irq =3D resource->data.irq.interrupts[0];
-		else
-			goto error;
-		break;
-
-	case ACPI_RESOURCE_TYPE_END_TAG:
-		break;
-
-	default:
-		goto error;
-	}
-
-	return AE_OK;
-
-error:
-	return AE_ERROR;
-}
-
 static void
 wbcir_cfg_ceir(struct wbcir_data *data)
 {
@@ -1345,28 +1293,36 @@ wbcir_cfg_ceir(struct wbcir_data *data)
 }
=20
 static int
-wbcir_add(struct acpi_device *device)
+wbcir_probe(struct pnp_dev *device, const struct pnp_device_id *dev_id=
)
 {
 	struct device *dev =3D &device->dev;
 	struct wbcir_data *data;
-	acpi_status status;
 	int err;
=20
+	if (!(pnp_port_len(device, 0) =3D=3D EHFUNC_IOMEM_LEN &&
+	      pnp_port_len(device, 1) =3D=3D WAKEUP_IOMEM_LEN &&
+	      pnp_port_len(device, 2) =3D=3D SP_IOMEM_LEN)) {
+		dev_err(dev, "Invalid resources\n");
+		return -ENODEV;
+	}
+
 	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		err =3D -ENOMEM;
 		goto exit;
 	}
=20
-	device->driver_data =3D data;
+	pnp_set_drvdata(device, data);
=20
-	status =3D acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-				     wbcir_walk_resources, data);
+	data->ebase =3D pnp_port_start(device, 0);
+	data->wbase =3D pnp_port_start(device, 1);
+	data->sbase =3D pnp_port_start(device, 2);
+	data->irq =3D pnp_irq(device, 0);
=20
-	if (ACPI_FAILURE(status) || data->wbase =3D=3D 0 || data->ebase =3D=3D=
 0 ||
+	if (data->wbase =3D=3D 0 || data->ebase =3D=3D 0 ||
 	    data->sbase =3D=3D 0 || data->irq =3D=3D 0) {
 		err =3D -ENODEV;
-		dev_err(dev, "Invalid ACPI resources\n");
+		dev_err(dev, "Invalid resources\n");
 		goto exit_free_data;
 	}
=20
@@ -1579,15 +1535,15 @@ exit_release_wbase:
 	release_region(data->wbase, WAKEUP_IOMEM_LEN);
 exit_free_data:
 	kfree(data);
-	device->driver_data =3D NULL;
+	pnp_set_drvdata(device, NULL);
 exit:
 	return err;
 }
=20
-static int
-wbcir_remove(struct acpi_device *device, int type)
+static void
+wbcir_remove(struct pnp_dev *device)
 {
-	struct wbcir_data *data =3D acpi_driver_data(device);
+	struct wbcir_data *data =3D pnp_get_drvdata(device);
 	struct wbcir_keyentry *key;
 	struct wbcir_keyentry *keytmp;
=20
@@ -1631,29 +1587,23 @@ wbcir_remove(struct acpi_device *device, int ty=
pe)
=20
 	kfree(data);
=20
-	device->driver_data =3D NULL;
-
-	return 0;
+	pnp_set_drvdata(device, NULL);
 }
=20
-static const struct acpi_device_id wbcir_ids[] =3D {
+static const struct pnp_device_id wbcir_ids[] =3D {
 	{ "WEC1022", 0 },
 	{ "", 0 }
 };
-MODULE_DEVICE_TABLE(acpi, wbcir_ids);
-
-static struct acpi_driver wbcir_driver =3D {
-	.name  =3D WBCIR_ACPI_NAME,
-	.class =3D WBCIR_ACPI_CLASS,
-	.ids   =3D wbcir_ids,
-	.ops =3D {
-		.add      =3D wbcir_add,
-		.remove   =3D wbcir_remove,
-		.suspend  =3D wbcir_suspend,
-		.resume   =3D wbcir_resume,
-		.shutdown =3D wbcir_shutdown
-	},
-	.owner =3D THIS_MODULE
+MODULE_DEVICE_TABLE(pnp, wbcir_ids);
+
+static struct pnp_driver wbcir_driver =3D {
+	.name     =3D WBCIR_ACPI_NAME,
+	.id_table =3D wbcir_ids,
+	.probe    =3D wbcir_probe,
+	.remove   =3D wbcir_remove,
+	.suspend  =3D wbcir_suspend,
+	.resume   =3D wbcir_resume,
+	.shutdown =3D wbcir_shutdown
 };
=20
 static int __init
@@ -1671,7 +1621,7 @@ wbcir_init(void)
 		return -EINVAL;
 	}
=20
-	ret =3D acpi_bus_register_driver(&wbcir_driver);
+	ret =3D pnp_register_driver(&wbcir_driver);
 	if (ret)
 		printk(KERN_ERR DRVNAME ": Unable to register driver\n");
=20
@@ -1681,7 +1631,7 @@ wbcir_init(void)
 static void __exit
 wbcir_exit(void)
 {
-	acpi_bus_unregister_driver(&wbcir_driver);
+	pnp_unregister_driver(&wbcir_driver);
 }
=20
 MODULE_AUTHOR("David H=E4rdeman <david@hardeman.nu>");
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
