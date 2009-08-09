From: david@hardeman.nu
Subject: [patch 1/2] Add a shutdown method to pnp drivers
Date: Sun, 09 Aug 2009 11:56:46 +0200
Message-ID: <20090809095743.926828201@hardeman.nu>
References: <20090809095645.198777507@hardeman.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753801AbZHIJ5v@vger.kernel.org>
Content-Disposition: inline; filename=add-pnp-shutdown-method
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, akpm@linux-foundation.org, bjorn.helgaas@hp.com, randy.dunlap@oracle.com, david@hardeman.nu
List-Id: linux-input@vger.kernel.org

The shutdown method is used by the winbond cir driver to setup the
hardware for wake-from-S5.

Changes since last version: the previous patch added a shutdown method
to acpi drivers, the winbond cir driver is now a pnp driver so the
shutdown method is added to pnp drivers instead. Patch by
Bjorn Helgaas <bjorn.helgaas@hp.com>.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: David H=C3=A4rdeman <david@hardeman.nu>

Index: linux-2.6/drivers/pnp/driver.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/pnp/driver.c	2009-07-25 19:53:32.000000000 +=
0200
+++ linux-2.6/drivers/pnp/driver.c	2009-07-25 19:54:21.000000000 +0200
@@ -135,6 +135,15 @@
 	return 0;
 }
=20
+static void pnp_device_shutdown(struct device *dev)
+{
+	struct pnp_dev *pnp_dev =3D to_pnp_dev(dev);
+	struct pnp_driver *drv =3D pnp_dev->driver;
+
+	if (drv && drv->shutdown)
+		drv->shutdown(pnp_dev);
+}
+
 static int pnp_bus_match(struct device *dev, struct device_driver *drv=
)
 {
 	struct pnp_dev *pnp_dev =3D to_pnp_dev(dev);
@@ -203,6 +212,7 @@
 	.match   =3D pnp_bus_match,
 	.probe   =3D pnp_device_probe,
 	.remove  =3D pnp_device_remove,
+	.shutdown =3D pnp_device_shutdown,
 	.suspend =3D pnp_bus_suspend,
 	.resume  =3D pnp_bus_resume,
 	.dev_attrs =3D pnp_interface_attrs,
Index: linux-2.6/include/linux/pnp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/include/linux/pnp.h	2009-07-25 19:53:32.000000000 +0=
200
+++ linux-2.6/include/linux/pnp.h	2009-07-25 19:54:21.000000000 +0200
@@ -360,6 +360,7 @@
 	unsigned int flags;
 	int (*probe) (struct pnp_dev *dev, const struct pnp_device_id *dev_id=
);
 	void (*remove) (struct pnp_dev *dev);
+	void (*shutdown) (struct pnp_dev *dev);
 	int (*suspend) (struct pnp_dev *dev, pm_message_t state);
 	int (*resume) (struct pnp_dev *dev);
 	struct device_driver driver;

--=20
David H=C3=A4rdeman
