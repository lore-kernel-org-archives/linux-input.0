From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] remove dead MAC_ADBKEYCODES
Date: Thu, 15 Nov 2007 16:53:29 +0100
Message-ID: <1195142010.14001.21.camel__3222.64467035911$1195170036$gmane$org@hammer.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
List-Id: linux-input@vger.kernel.org

It seems, that current kernel source code contains no traces of
MAC_ADBKEYCODES and no reference to keyboard_sends_linux_keycodes any
more.

Attached patch removes them from configuration files.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>

--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -582,20 +582,6 @@ config MAC_HID
 	depends on INPUT_ADBHID
 	default y
 =

-config MAC_ADBKEYCODES
-	bool "Support for ADB raw keycodes"
-	depends on INPUT_ADBHID
-	help
-	  This provides support for sending raw ADB keycodes to console
-	  devices.  This is the default up to 2.4.0, but in future this may be
-	  phased out in favor of generic Linux keycodes.  If you say Y here,
-	  you can dynamically switch via the
-	  /proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes
-	  sysctl and with the "keyboard_sends_linux_keycodes=3D" kernel
-	  argument.
-
-	  If unsure, say Y here.
-
 config ADB_KEYBOARD
 	bool "Support for ADB keyboard (old driver)"
 	depends on MAC && !INPUT_ADBHID
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -678,7 +678,6 @@ CONFIG_LOGO_MAC_CLUT224=3Dy
 #
 CONFIG_MAC_SCC=3Dy
 CONFIG_MAC_HID=3Dy
-CONFIG_MAC_ADBKEYCODES=3Dy
 CONFIG_SERIAL_CONSOLE=3Dy
 =

 #


-- =

Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarsk=E1 1060/12                            tel: +420 284 028 966
190 00 Praha 9                                fax: +420 284 028 951
Czech Republic                                http://www.suse.cz/
