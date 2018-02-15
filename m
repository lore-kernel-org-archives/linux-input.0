From: Paul Menzel <pmenzel+linux-input@molgen.mpg.de>
Subject: [PATCH] input/mouse/synaptics: Add SYN1217 to PNP detection list
Date: Thu, 15 Feb 2018 14:50:34 +0100
Message-ID: <a157ea03-b7ca-9a20-308d-70b0504d0c83@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, it+linux-input@molgen.mpg.de
List-Id: linux-input@vger.kernel.org

Date: Wed, 14 Feb 2018 18:16:43 +0100

On the TUXEDO Book BU1406, since Linux 4.12, the Linux kernel logs the 
message
below.

```
kernel: psmouse serio1: synaptics: Your touchpad (PNP: SYN1217 PNP0f13) 
says it can support a different bus. If i2c-hid and hid-rmi are not 
used, you might want to try setting psmouse.synaptics_intertouch to 1 
and report this to linux-input@vger.kernel.org.
```

Booting with `psmouse.synaptics_intertouch=1`, the touchpad continues to
work, so add the ID of the device to the list of IDs, whose devices
support I2C mode.

CC: stable@vger.kernel.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
  drivers/input/mouse/synaptics.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c 
b/drivers/input/mouse/synaptics.c
index 3d2e23a0ae39..80ddbb966d83 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -178,6 +178,7 @@ static const char * const smbus_pnp_ids[] = {
  };

  static const char * const forcepad_pnp_ids[] = {
+	"SYN1217",
  	"SYN300D",
  	"SYN3014",
  	NULL
-- 
2.14.1
