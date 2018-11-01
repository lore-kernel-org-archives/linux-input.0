From: "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
Subject: [PATCH 1/3] asus-wmi: Tell the EC the OS will handle the display off hotkey
Date: Wed, 31 Oct 2018 17:21:26 -0700
Message-ID: <20181101002128.28884-2-jprvita@endlessm.com>
References: <20181101002128.28884-1-jprvita@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181101002128.28884-1-jprvita@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
Cc: hadess@hadess.net, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com, =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
List-Id: linux-input@vger.kernel.org

In the past, Asus firmwares would change the panel backlight directly
through the EC when the display off hotkey (Fn+F7) was pressed, and
only notify the OS of such change, with 0x33 when the LCD was ON and
0x34 when the LCD was OFF. These are currently mapped to
KEY_DISPLAYTOGGLE and KEY_DISPLAY_OFF, respectively.

Most recently the EC on Asus most machines lost ability to toggle the
LCD backlight directly, but unless the OS informs the firmware it is
going to handle the display toggle hotkey events, the firmware still
tries change the brightness through the EC, to no effect. The end result
is a long list (at Endless we counted 11) of Asus laptop models where
the display toggle hotkey does not perform any action. Our firmware
engineers contacts at Asus were surprised that there were still machines
out there with the old behavior.

Calling WMNB(ASUS_WMI_DEVID_BACKLIGHT==0x00050011, 2) on the _WDG device
tells the firmware that it should let the OS handle the display toggle
event, in which case it will simply notify the OS of a key press with
0x35, as shown by the DSDT excerpts bellow.

 Scope (_SB)
 {
     (...)

     Device (ATKD)
     {
         (...)

         Name (_WDG, Buffer (0x28)
         {
             /* 0000 */  0xD0, 0x5E, 0x84, 0x97, 0x6D, 0x4E, 0xDE, 0x11,
             /* 0008 */  0x8A, 0x39, 0x08, 0x00, 0x20, 0x0C, 0x9A, 0x66,
             /* 0010 */  0x4E, 0x42, 0x01, 0x02, 0x35, 0xBB, 0x3C, 0x0B,
             /* 0018 */  0xC2, 0xE3, 0xED, 0x45, 0x91, 0xC2, 0x4C, 0x5A,
             /* 0020 */  0x6D, 0x19, 0x5D, 0x1C, 0xFF, 0x00, 0x01, 0x08
         })
         Method (WMNB, 3, Serialized)
         {
             CreateDWordField (Arg2, Zero, IIA0)
             CreateDWordField (Arg2, 0x04, IIA1)
             Local0 = (Arg1 & 0xFFFFFFFF)

             (...)

             If ((Local0 == 0x53564544))
             {
                 (...)

                 If ((IIA0 == 0x00050011))
                 {
                     If ((IIA1 == 0x02))
                     {
                         ^^PCI0.SBRG.EC0.SPIN (0x72, One)
                         ^^PCI0.SBRG.EC0.BLCT = One
                     }

                     Return (One)
                 }
             }
             (...)
         }
         (...)
     }
     (...)
 }
 (...)

 Scope (_SB.PCI0.SBRG.EC0)
 {
     (...)

     Name (BLCT, Zero)

     (...)

     Method (_Q10, 0, NotSerialized)  // _Qxx: EC Query
     {
         If ((BLCT == Zero))
         {
             Local0 = One
             Local0 = RPIN (0x72)
             Local0 ^= One
             SPIN (0x72, Local0)
             If (ATKP)
             {
                 Local0 = (0x34 - Local0)
                 ^^^^ATKD.IANE (Local0)
             }
         }
         ElseIf ((BLCT == One))
         {
             If (ATKP)
             {
                 ^^^^ATKD.IANE (0x35)
             }
         }
     }
     (...)
 }

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
---
 drivers/platform/x86/asus-wmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index b52b192a4f16..c25b946bb602 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2150,7 +2150,8 @@ static int asus_wmi_add(struct platform_device *pdev)
 		err = asus_wmi_backlight_init(asus);
 		if (err && err != -ENODEV)
 			goto fail_backlight;
-	}
+	} else
+		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
 
 	status = wmi_install_notify_handler(asus->driver->event_guid,
 					    asus_wmi_notify, asus);
-- 
2.19.1
