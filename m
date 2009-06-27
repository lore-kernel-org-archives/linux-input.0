From: =?utf-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>
Subject: [PATCH 1/2] ACPI: reintroduce acpi_device_ops .shutdown method
Date: Sat, 27 Jun 2009 07:18:31 +0200
Message-ID: <1246079912-17619-2-git-send-email-david@hardeman.nu>
References: <1246079912-17619-1-git-send-email-david@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1246079912-17619-1-git-send-email-david@hardeman.nu>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, =?utf-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>
List-Id: linux-input@vger.kernel.org

This reintroduces the .shutdown method which is used by the
winbond-cir driver. A normal revert wasn't possible since there
had been other changes to include/acpi/acpi_bus.h since.

Signed-off-by: David H=C3=A4rdeman <david@hardeman.nu>
---
 drivers/acpi/scan.c     |   12 ++++++++++++
 include/acpi/acpi_bus.h |    2 ++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 781435d..c94ab13 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -464,10 +464,22 @@ static int acpi_device_remove(struct device * dev=
)
 	return 0;
 }
=20
+static void acpi_device_shutdown(struct device *dev)
+{
+	struct acpi_device *acpi_dev =3D to_acpi_device(dev);
+	struct acpi_driver *acpi_drv =3D acpi_dev->driver;
+
+	if (acpi_drv && acpi_drv->ops.shutdown)
+		acpi_drv->ops.shutdown(acpi_dev);
+
+	return ;
+}
+
 struct bus_type acpi_bus_type =3D {
 	.name		=3D "acpi",
 	.suspend	=3D acpi_device_suspend,
 	.resume		=3D acpi_device_resume,
+	.shutdown	=3D acpi_device_shutdown,
 	.match		=3D acpi_bus_match,
 	.probe		=3D acpi_device_probe,
 	.remove		=3D acpi_device_remove,
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c65e4ce..52da89a 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -96,6 +96,7 @@ typedef int (*acpi_op_resume) (struct acpi_device * d=
evice);
 typedef int (*acpi_op_bind) (struct acpi_device * device);
 typedef int (*acpi_op_unbind) (struct acpi_device * device);
 typedef void (*acpi_op_notify) (struct acpi_device * device, u32 event=
);
+typedef int (*acpi_op_shutdown) (struct acpi_device * device);
=20
 struct acpi_bus_ops {
 	u32 acpi_op_add:1;
@@ -112,6 +113,7 @@ struct acpi_device_ops {
 	acpi_op_bind bind;
 	acpi_op_unbind unbind;
 	acpi_op_notify notify;
+	acpi_op_shutdown shutdown;
 };
=20
 #define ACPI_DRIVER_ALL_NOTIFY_EVENTS	0x1	/* system AND device events =
*/
--=20
1.6.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
