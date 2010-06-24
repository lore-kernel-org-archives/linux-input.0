From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [0000/0003]full power management for usb touchscreens
Date: Thu, 24 Jun 2010 08:56:16 +0200
Message-ID: <201006240856.16402.oneukum@suse.de>
References: <201006071513.29478.oneukum@suse.de> <201006221524.25084.oliver@neukum.org> <201006221543.27169.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QGwIMRHg9dYONe0"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201006221543.27169.linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ondrej Zary <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--Boundary-00=_QGwIMRHg9dYONe0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Am Dienstag, 22. Juni 2010, 15:43:24 schrieb Ondrej Zary:
> On Tuesday 22 June 2010, Oliver Neukum wrote:

> > This is a violation of the spec. Can you give me the IDs so that I can
> > put the devices into the quirks file? Or can I take this from the driver?
> > Do all devices that marked as always needing an irq transfer behave
> > this way?
> 
> This is not a bug surprise as this device is broken in many ways. It takes 
> ages to detect and identify and looks like cdc_acm. The pseudo-multitouch 
> capable protocol is pretty bad too. Also there are some reports about devices 
> using the same ID but different protocol.
> 
> I have only one - 1870:0001, don't know anything about the other.

OK, it seems like those devices are hopeless. Could you test this series form
harmlessness on a broken device and functionality on a non-broken device?

	Regards
		Oliver

--Boundary-00=_QGwIMRHg9dYONe0
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-usbtouchscreen-Implement-basic-suspend-resume.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-usbtouchscreen-Implement-basic-suspend-resume.patch"

=46rom 0f28efab0c7c48dc02f728f57d4a89a203bac986 Mon Sep 17 00:00:00 2001
=46rom: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Date: Thu, 24 Jun 2010 08:20:34 +0200
Subject: [PATCH 1/3] usbtouchscreen: Implement basic suspend/resume

This implements basic support for suspend & resume

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
=2D--
 drivers/input/touchscreen/usbtouchscreen.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/tou=
chscreen/usbtouchscreen.c
index 567d572..f51d2fd 100644
=2D-- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1291,6 +1291,27 @@ static void usbtouch_close(struct input_dev *input)
 		usb_kill_urb(usbtouch->irq);
 }
=20
+static int usbtouch_suspend
+(struct usb_interface *intf, pm_message_t message)
+{
+	struct usbtouch_usb *usbtouch =3D usb_get_intfdata(intf);
+=09
+	usb_kill_urb(usbtouch->irq);
+	return 0;
+}
+
+static int usbtouch_resume(struct usb_interface *intf)
+{
+	struct usbtouch_usb *usbtouch =3D usb_get_intfdata(intf);
+	struct input_dev *input =3D usbtouch->input;
+	int result =3D 0;
+=09
+	mutex_lock(&input->mutex);
+	if (input->users || usbtouch->type->irq_always)
+		result =3D usb_submit_urb(usbtouch->irq, GFP_NOIO);
+	mutex_unlock(&input->mutex);
+	return result;
+}
=20
 static void usbtouch_free_buffers(struct usb_device *udev,
 				  struct usbtouch_usb *usbtouch)
@@ -1481,6 +1502,8 @@ static struct usb_driver usbtouch_driver =3D {
 	.name		=3D "usbtouchscreen",
 	.probe		=3D usbtouch_probe,
 	.disconnect	=3D usbtouch_disconnect,
+	.suspend	=3D usbtouch_suspend,
+	.resume		=3D usbtouch_resume,
 	.id_table	=3D usbtouch_devices,
 };
=20
=2D-=20
1.7.1


--Boundary-00=_QGwIMRHg9dYONe0
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0002-usbtouchscreen-Implement-runtime-power-management.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-usbtouchscreen-Implement-runtime-power-management.patch"

=46rom 71b07110871d7b9e754a3b56f3e914745c329be6 Mon Sep 17 00:00:00 2001
=46rom: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Date: Thu, 24 Jun 2010 08:38:57 +0200
Subject: [PATCH 2/3] usbtouchscreen: Implement runtime power management

This implement USB autosuspend while the device is opened for
devices that do remote wakeup with a fallback to open/close for
those devices that don't. Devices that require the host to
constantly poll them are never autosuspended.

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
=2D--
 drivers/input/touchscreen/usbtouchscreen.c |   27 ++++++++++++++++++++++++=
=2D--
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/tou=
chscreen/usbtouchscreen.c
index f51d2fd..3c57df8 100644
=2D-- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1263,6 +1263,7 @@ static void usbtouch_irq(struct urb *urb)
 	usbtouch->type->process_pkt(usbtouch, usbtouch->data, urb->actual_length);
=20
 exit:
+	usb_mark_last_busy(interface_to_usbdev(usbtouch->interface));
 	retval =3D usb_submit_urb(urb, GFP_ATOMIC);
 	if (retval)
 		err("%s - usb_submit_urb failed with result: %d",
@@ -1272,23 +1273,39 @@ exit:
 static int usbtouch_open(struct input_dev *input)
 {
 	struct usbtouch_usb *usbtouch =3D input_get_drvdata(input);
+	int r;
=20
 	usbtouch->irq->dev =3D interface_to_usbdev(usbtouch->interface);
=20
+	r =3D usb_autopm_get_interface(usbtouch->interface) ? -EIO : 0;
+	if (r < 0)
+		goto out;
+=09
 	if (!usbtouch->type->irq_always) {
=2D		if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
=2D		  return -EIO;
+		if (usb_submit_urb(usbtouch->irq, GFP_KERNEL)) {
+			r =3D -EIO;
+			goto out_put;
+		}
 	}
=20
=2D	return 0;
+	usbtouch->interface->needs_remote_wakeup =3D 1;
+out_put:
+	usb_autopm_put_interface(usbtouch->interface);
+out:
+	return r;
 }
=20
 static void usbtouch_close(struct input_dev *input)
 {
 	struct usbtouch_usb *usbtouch =3D input_get_drvdata(input);
+	int r;
=20
 	if (!usbtouch->type->irq_always)
 		usb_kill_urb(usbtouch->irq);
+	r =3D usb_autopm_get_interface(usbtouch->interface);
+	usbtouch->interface->needs_remote_wakeup =3D 0;
+	if (!r)
+		usb_autopm_put_interface(usbtouch->interface);
 }
=20
 static int usbtouch_suspend
@@ -1450,8 +1467,11 @@ static int usbtouch_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, usbtouch);
=20
 	if (usbtouch->type->irq_always) {
+		/* this can't fail */
+		usb_autopm_get_interface(intf);
 		err =3D usb_submit_urb(usbtouch->irq, GFP_KERNEL);
 		if (err) {
+			usb_autopm_put_interface(intf);
 			err("%s - usb_submit_urb failed with result: %d",
 			    __func__, err);
 			goto out_unregister_input;
@@ -1505,6 +1525,7 @@ static struct usb_driver usbtouch_driver =3D {
 	.suspend	=3D usbtouch_suspend,
 	.resume		=3D usbtouch_resume,
 	.id_table	=3D usbtouch_devices,
+	.supports_autosuspend =3D 1,
 };
=20
 static int __init usbtouch_init(void)
=2D-=20
1.7.1


--Boundary-00=_QGwIMRHg9dYONe0
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0003-usbtouchscreen-Implement-reset_resume.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0003-usbtouchscreen-Implement-reset_resume.patch"

=46rom c12539f30d0585056be37227a8d65976db49241f Mon Sep 17 00:00:00 2001
=46rom: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Date: Thu, 24 Jun 2010 08:50:25 +0200
Subject: [PATCH 3/3] usbtouchscreen: Implement reset_resume()

This implements reset_resume() by splitting init into allocations
of private data structures and device initializations. Device initializatio=
ns
are repeated upon reset_resume.

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
=2D--
 drivers/input/touchscreen/usbtouchscreen.c |  108 +++++++++++++++++++-----=
=2D--
 1 files changed, 76 insertions(+), 32 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/tou=
chscreen/usbtouchscreen.c
index 3c57df8..9c21707 100644
=2D-- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -95,6 +95,7 @@ struct usbtouch_device_info {
 	int  (*get_pkt_len) (unsigned char *pkt, int len);
=20
 	int  (*read_data)   (struct usbtouch_usb *usbtouch, unsigned char *pkt);
+	int  (*alloc)       (struct usbtouch_usb *usbtouch);
 	int  (*init)        (struct usbtouch_usb *usbtouch);
 	void (*exit)	    (struct usbtouch_usb *usbtouch);
 };
@@ -507,7 +508,7 @@ static int dmc_tsc10_init(struct usbtouch_usb *usbtouch)
 	int ret =3D -ENOMEM;
 	unsigned char *buf;
=20
=2D	buf =3D kmalloc(2, GFP_KERNEL);
+	buf =3D kmalloc(2, GFP_NOIO);
 	if (!buf)
 		goto err_nobuf;
 	/* reset */
@@ -732,11 +733,43 @@ static void nexio_ack_complete(struct urb *urb)
 {
 }
=20
+static int nexio_alloc(struct usbtouch_usb *usbtouch)
+{
+	struct nexio_priv *priv;
+	int ret =3D -ENOMEM;
+
+	usbtouch->priv =3D kmalloc(sizeof(struct nexio_priv), GFP_KERNEL);
+	if (!usbtouch->priv)
+		goto out_buf;
+
+	priv =3D usbtouch->priv;
+
+	priv->ack_buf =3D kmemdup(nexio_ack_pkt, sizeof(nexio_ack_pkt),
+				GFP_KERNEL);
+	if (!priv->ack_buf)
+		goto err_priv;
+
+	priv->ack =3D usb_alloc_urb(0, GFP_KERNEL);
+	if (!priv->ack) {
+		dbg("%s - usb_alloc_urb failed: usbtouch->ack", __func__);
+		goto err_ack_buf;
+	}
+
+	return 0;
+
+err_ack_buf:
+	kfree(priv->ack_buf);
+err_priv:
+	kfree(priv);
+out_buf:
+	return ret;
+}
+
 static int nexio_init(struct usbtouch_usb *usbtouch)
 {
 	struct usb_device *dev =3D interface_to_usbdev(usbtouch->interface);
 	struct usb_host_interface *interface =3D usbtouch->interface->cur_altsett=
ing;
=2D	struct nexio_priv *priv;
+	struct nexio_priv *priv =3D usbtouch->priv;
 	int ret =3D -ENOMEM;
 	int actual_len, i;
 	unsigned char *buf;
@@ -755,7 +788,7 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
 	if (!input_ep || !output_ep)
 		return -ENXIO;
=20
=2D	buf =3D kmalloc(NEXIO_BUFSIZE, GFP_KERNEL);
+	buf =3D kmalloc(NEXIO_BUFSIZE, GFP_NOIO);
 	if (!buf)
 		goto out_buf;
=20
@@ -787,11 +820,11 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
 		switch (buf[0]) {
 		case 0x83:	/* firmware version */
 			if (!firmware_ver)
=2D				firmware_ver =3D kstrdup(&buf[2], GFP_KERNEL);
+				firmware_ver =3D kstrdup(&buf[2], GFP_NOIO);
 			break;
 		case 0x84:	/* device name */
 			if (!device_name)
=2D				device_name =3D kstrdup(&buf[2], GFP_KERNEL);
+				device_name =3D kstrdup(&buf[2], GFP_NOIO);
 			break;
 		}
 	}
@@ -802,36 +835,11 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
 	kfree(firmware_ver);
 	kfree(device_name);
=20
=2D	/* prepare ACK URB */
=2D	ret =3D -ENOMEM;
=2D
=2D	usbtouch->priv =3D kmalloc(sizeof(struct nexio_priv), GFP_KERNEL);
=2D	if (!usbtouch->priv)
=2D		goto out_buf;
=2D
=2D	priv =3D usbtouch->priv;
=2D
=2D	priv->ack_buf =3D kmemdup(nexio_ack_pkt, sizeof(nexio_ack_pkt),
=2D				GFP_KERNEL);
=2D	if (!priv->ack_buf)
=2D		goto err_priv;
=2D
=2D	priv->ack =3D usb_alloc_urb(0, GFP_KERNEL);
=2D	if (!priv->ack) {
=2D		dbg("%s - usb_alloc_urb failed: usbtouch->ack", __func__);
=2D		goto err_ack_buf;
=2D	}
=2D
 	usb_fill_bulk_urb(priv->ack, dev, usb_sndbulkpipe(dev, output_ep),
 			  priv->ack_buf, sizeof(nexio_ack_pkt),
 			  nexio_ack_complete, usbtouch);
 	ret =3D 0;
=2D	goto out_buf;
=20
=2Derr_ack_buf:
=2D	kfree(priv->ack_buf);
=2Derr_priv:
=2D	kfree(priv);
 out_buf:
 	kfree(buf);
 	return ret;
@@ -1120,6 +1128,7 @@ static struct usbtouch_device_info usbtouch_dev_info[=
] =3D {
 		.rept_size	=3D 1024,
 		.irq_always	=3D true,
 		.read_data	=3D nexio_read_data,
+		.alloc		=3D nexio_alloc,
 		.init		=3D nexio_init,
 		.exit		=3D nexio_exit,
 	},
@@ -1330,6 +1339,31 @@ static int usbtouch_resume(struct usb_interface *int=
f)
 	return result;
 }
=20
+static int usbtouch_reset_resume(struct usb_interface *intf)
+{
+	struct usbtouch_usb *usbtouch =3D usb_get_intfdata(intf);
+	struct input_dev *input =3D usbtouch->input;
+	int err =3D 0;
+=09
+	/* reinit the device */
+	if (usbtouch->type->init) {
+		err =3D usbtouch->type->init(usbtouch);
+		if (err) {
+			dbg("%s - type->init() failed, err: %d",
+			    __func__, err);
+			return err;
+		}
+	}
+
+	/* restart IO if needed */
+	mutex_lock(&input->mutex);
+	if (input->users)
+		err =3D usb_submit_urb(usbtouch->irq, GFP_NOIO);
+	mutex_unlock(&input->mutex);
+=09
+	return err;
+}
+
 static void usbtouch_free_buffers(struct usb_device *udev,
 				  struct usbtouch_usb *usbtouch)
 {
@@ -1449,12 +1483,21 @@ static int usbtouch_probe(struct usb_interface *int=
f,
 	usbtouch->irq->transfer_dma =3D usbtouch->data_dma;
 	usbtouch->irq->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
=20
=2D	/* device specific init */
+	/* device specific allocations */
+	if (type->alloc) {
+		err =3D type->alloc(usbtouch);
+		if (err) {
+			dbg("%s - type->alloc() failed, err: %d", __func__, err);
+			goto out_free_urb;
+		}
+	}
+=09
+	/* device specific initialisation*/=20
 	if (type->init) {
 		err =3D type->init(usbtouch);
 		if (err) {
 			dbg("%s - type->init() failed, err: %d", __func__, err);
=2D			goto out_free_urb;
+			goto out_do_exit;
 		}
 	}
=20
@@ -1524,6 +1567,7 @@ static struct usb_driver usbtouch_driver =3D {
 	.disconnect	=3D usbtouch_disconnect,
 	.suspend	=3D usbtouch_suspend,
 	.resume		=3D usbtouch_resume,
+	.reset_resume	=3D usbtouch_reset_resume,
 	.id_table	=3D usbtouch_devices,
 	.supports_autosuspend =3D 1,
 };
=2D-=20
1.7.1


--Boundary-00=_QGwIMRHg9dYONe0--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
