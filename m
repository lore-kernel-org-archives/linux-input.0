From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: build #315 failed for 2.6.23-rc6-gd017464 in linux/./drivers/input/joystick/xpad.c
Date: Tue, 18 Sep 2007 01:13:18 -0400
Message-ID: <200709180113.19085.dtor@insightbb.com>
References: <200709161846.37585.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200709161846.37585.toralf.foerster@gmx.de>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Toralf,

On Sunday 16 September 2007 12:46, Toralf F=C3=B6rster wrote:
> Hello,
>=20
> the build with the attached .config failed, make ends with:
> ...
>   CC      arch/i386/lib/strstr.o
>   CC      arch/i386/lib/usercopy.o
>   AR      arch/i386/lib/lib.a
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `xpad_disconnect':
> xpad.c:(.text+0x18ba72): undefined reference to `led_classdev_unregister'
> drivers/built-in.o: In function `xpad_probe':
> xpad.c:(.text+0x18c565): undefined reference to `led_classdev_register'
> make: *** [.tmp_vmlinux1] Error 1
>=20

Thank you for the report. I believe the patch below should fix the problem.

=2D-=20
Dmitry

Subject: Input: xpad - fix dependancy on LEDS class

Input: xpad - fix dependancy on LEDS class

The driver can not be built-in when LEDS class is a module.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
=2D--
 drivers/input/joystick/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/input/joystick/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux.orig/drivers/input/joystick/Kconfig
+++ linux/drivers/input/joystick/Kconfig
@@ -277,7 +277,7 @@ config JOYSTICK_XPAD_FF
=20
 config JOYSTICK_XPAD_LEDS
 	bool "LED Support for Xbox360 controller 'BigX' LED"
=2D	depends on LEDS_CLASS && JOYSTICK_XPAD
+	depends on JOYSTICK_XPAD && (LED_CLASS=3Dy || LED_CLASS=3DJOYSTICK_XPAD)
 	---help---
 	  This option enables support for the LED which surrounds the Big X on
 	  XBox 360 controller.
