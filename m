From: "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
Subject: [PATCH 0/3] Fix display off hotkey on Asus machines
Date: Wed, 31 Oct 2018 17:21:25 -0700
Message-ID: <20181101002128.28884-1-jprvita@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
Cc: hadess@hadess.net, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com, =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
List-Id: linux-input@vger.kernel.org

Asus laptops have a hotkey function on the F7 key to turn the display
backlight OFF, labeled with a screen with a X inside, as shown on
https://dlcdnimgs.asus.com/websites/global/products/Xep1ZcSY8dyWXK11/images/keyboard.png

This hotkey worked on very few Asus models, where the EC acts on the
backlight and input events are generated only to notify userspace of the
backlight status. On these machines the first hotkey press turns the
display backlight OFF and notifies the OS with 0x34, which asus-nb-wmi
forwards to userspace as KEY_DISPLAY_OFF, and a second press turns it
back ON and notifies the OS with 0x33, which asus-nb-wmi forwards to
userspace as KEY_DISPLAYTOGGLE. No other keys turn the display backlight
back ON, but their input is forwarded normally to the application under
focus.

But for the majority of models, the EC actually does not act on the
backlight and we simply get a 0x33 notification every time the key is
pressed, or alternating values of 0x33 / 0x34. We have confirmed this
behavior on the following models: E203NAS, GL553VE, X441NC, X441UVK,
X541UVK, X555DG, X555UB, X555UQ, X560UD, X570ZD and X705FD, and the DSDT
on these machines and the working one (only confirmed on N552VW) is the
same for the query involved here.

After trying to get information from Asus for quite some time on how
this works on Windows, we finally recently got a contact that was able
to give us a definitive answer and a specification for this feature.
According this contact the 0x33 / 0x34 is an old behavior and all newer
machines should only be notifying the OS with 0x35 instead, as newer ECs
don't control the backlight anymore. When a 0x35 notification is
received the OS should act on the display backlight. From the spec
(machine-translated from Chinese):

  1.4 Fn+F7
  Function introduction

  After the user presses Fn + F7, the screen will be closed through the
  Windows API. The user will immediately open the screen with the mouse
  and keyboard.
  The API used can be found in the Sample URL:
  https://code.msdn.microsoft.com/windowsdesktop/Coalescable-Timer-Sample-d9da954c
  BIOS implementation
  Increase Notify code
  LCD On: 0x33 (display OSD)
  LCD Off: 0x34 (display OSD)
  LCD Switch: 0x35 (using API switch)

The behavior on Windows with the ATKACPI driver from Asus installed
matches what is described above, with the hotkey turning OFF the
backlight of all connected displays with a fading effect, and any cursor
input or key press turning the backlight back ON. The key press or
cursor input is passed through to the application under focus or under
the cursor.

With this information from the spec, a simple analysis of the DSDT
(pasted on the first commit of this series) shows that in order to have
the firmware notify the OS with 0x35 and have the OS act on the
backlight, we need to call WMNB(ASUS_WMI_DEVID_BACKLIGHT==0x00050011, 2)
on the _WDG device. Then we can simply map that scan code to the
appropriate key code in the driver.

In include/uapi/linux/input-event-codes.h KEY_DISPLAY_OFF is defined as
"display device to off state", but it is not actually handled by
userspace on a GNOME+Xorg stack. There are also KEY_SCREENSAVER and
KEY_SCREENLOCK / KEY_COFFEE. The former seems to be ignored by userspace
as well (and its value is higher than 255 so it can't be handled by Xorg
IIUC), and the later is mapped to XF86ScreenSaver by Xorg and triggers
the lock screen action on GNOME. KEY_SCREENLOCK seems to be what closest
matches the behavior described above in a Xorg world. I am not sure if
any of this changes with Wayland, so any clarifications in that regard
would be greatly appreciated.

João Paulo Rechi Vita (3):
  asus-wmi: Tell the EC the OS will handle the display off hotkey
  asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
  asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes

 drivers/platform/x86/asus-nb-wmi.c | 3 +--
 drivers/platform/x86/asus-wmi.c    | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.19.1
