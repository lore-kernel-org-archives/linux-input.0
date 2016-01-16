From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: MOUSE_PS2_VMMOUSE and input/mice
Date: Sat, 16 Jan 2016 10:16:35 -0800
Message-ID: <20160116181635.GA9203@dtor-ws>
References: <20160115123928.d06e1fed.cand@gmx.com>
 <5698D343.3000606@vmware.com>
 <20160115132312.654ad5aa.cand@gmx.com>
 <56991418.1070701@vmware.com>
 <20160115175040.GA5664@dtor-ws>
 <569938E7.3090509@vmware.com>
 <20160116173945.cb1f14b9.cand@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33721 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbcAPSQi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Jan 2016 13:16:38 -0500
Received: by mail-pa0-f42.google.com with SMTP id cy9so411353560pac.0
        for <linux-input@vger.kernel.org>; Sat, 16 Jan 2016 10:16:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160116173945.cb1f14b9.cand@gmx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lauri Kasanen <cand@gmx.com>
Cc: Thomas Hellstrom <thellstrom@vmware.com>, linux-input@vger.kernel.org

On Sat, Jan 16, 2016 at 05:39:45PM +0200, Lauri Kasanen wrote:
> Hi,
> 
> Here's the /proc/bus/input/devices output. Also attaching the kernel
> config in case it'd be useful.
> 

...

> 
> I: Bus=0011 Vendor=0002 Product=0013 Version=0006
> N: Name="VirtualPS/2 VMware VMMouse"
> P: Phys=isa0060/serio1/input1
> S: Sysfs=/devices/platform/i8042/serio1/input/input4
> U: Uniq=
> H: Handlers=event2 
> B: PROP=0
> B: EV=b
> B: KEY=70000 0 0 0 0 0 0 0 0
>

So mousedev indeed did not bind to the absolute portion of the device.
Please try the patch below.

-- 
Dmitry


Input: vmmouse - fix absolute device registration

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

We should set device's capabilities first, and then register it, otherwise
various handlers already present in the kernel will not be able to connect
to the device.

Reported-by: Lauri Kasanen <cand@gmx.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/vmmouse.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
index e272f06..a3f0f5a 100644
--- a/drivers/input/mouse/vmmouse.c
+++ b/drivers/input/mouse/vmmouse.c
@@ -458,8 +458,6 @@ int vmmouse_init(struct psmouse *psmouse)
 	priv->abs_dev = abs_dev;
 	psmouse->private = priv;
 
-	input_set_capability(rel_dev, EV_REL, REL_WHEEL);
-
 	/* Set up and register absolute device */
 	snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
 		 psmouse->ps2dev.serio->phys);
@@ -475,10 +473,6 @@ int vmmouse_init(struct psmouse *psmouse)
 	abs_dev->id.version = psmouse->model;
 	abs_dev->dev.parent = &psmouse->ps2dev.serio->dev;
 
-	error = input_register_device(priv->abs_dev);
-	if (error)
-		goto init_fail;
-
 	/* Set absolute device capabilities */
 	input_set_capability(abs_dev, EV_KEY, BTN_LEFT);
 	input_set_capability(abs_dev, EV_KEY, BTN_RIGHT);
@@ -488,6 +482,13 @@ int vmmouse_init(struct psmouse *psmouse)
 	input_set_abs_params(abs_dev, ABS_X, 0, VMMOUSE_MAX_X, 0, 0);
 	input_set_abs_params(abs_dev, ABS_Y, 0, VMMOUSE_MAX_Y, 0, 0);
 
+	error = input_register_device(priv->abs_dev);
+	if (error)
+		goto init_fail;
+
+	/* Add wheel capability to the relative device */
+	input_set_capability(rel_dev, EV_REL, REL_WHEEL);
+
 	psmouse->protocol_handler = vmmouse_process_byte;
 	psmouse->disconnect = vmmouse_disconnect;
 	psmouse->reconnect = vmmouse_reconnect;
