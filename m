From: Andreas Herrmann <aherrman@arcor.de>
Subject: [PATCH] xpad: fix Kconfig to avoid compile error
Date: Tue, 18 Sep 2007 11:00:33 +0200
Message-ID: <20070918090033.GB14882@devil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jan Kratochvil <honza@jikos.cz>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

With LEDS_CLASS=m && JOYSTICK_XPAD_LEDS=y I get following compile error:

    ...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `xpad_disconnect':
xpad.c:(.text+0xb3d6b): undefined reference to `led_classdev_unregister'
drivers/built-in.o: In function `xpad_probe':
xpad.c:(.text+0xb48a6): undefined reference to `led_classdev_register'
make: *** [.tmp_vmlinux1] Error 1
    ...

To avoid this kernel configuration, do auto-select LEDS_CLASS
for JOYSTCK_XPAD_LEDS.

Signed-off-by: Andreas Herrmann <aherrman@arcor.de>
---
 drivers/input/joystick/Kconfig |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index e2abe18..d765eb7 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -277,7 +277,9 @@ config JOYSTICK_XPAD_FF
 
 config JOYSTICK_XPAD_LEDS
 	bool "LED Support for Xbox360 controller 'BigX' LED"
-	depends on LEDS_CLASS && JOYSTICK_XPAD
+	depends on JOYSTICK_XPAD
+	select NEW_LEDS
+	select LEDS_CLASS
 	---help---
 	  This option enables support for the LED which surrounds the Big X on
 	  XBox 360 controller.
-- 
1.5.3
