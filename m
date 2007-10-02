From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] input: move gameports out of SERIO menu
Date: Tue, 2 Oct 2007 14:12:25 -0700
Message-ID: <20071002141225.d503cdbb.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: lkml <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com
Cc: linux-input@atrey.karlin.mff.cuni.cz, akpm <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Move the gameport support menu out of the SERIO menu and put it
between touchscreens and misc. devices in the main input layer menu.
Change it to use menuconfig instead of config.

Or was it meant to be listed under Hardware I/O ports?
It sure seems odd there to me.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/input/Kconfig          |    4 ++--
 drivers/input/gameport/Kconfig |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.23-rc8-mm1.orig/drivers/input/Kconfig
+++ linux-2.6.23-rc8-mm1/drivers/input/Kconfig
@@ -171,6 +171,8 @@ source "drivers/input/tablet/Kconfig"
 
 source "drivers/input/touchscreen/Kconfig"
 
+source "drivers/input/gameport/Kconfig"
+
 source "drivers/input/misc/Kconfig"
 
 endif
@@ -179,8 +181,6 @@ menu "Hardware I/O ports"
 
 source "drivers/input/serio/Kconfig"
 
-source "drivers/input/gameport/Kconfig"
-
 endmenu
 
 endmenu
--- linux-2.6.23-rc8-mm1.orig/drivers/input/gameport/Kconfig
+++ linux-2.6.23-rc8-mm1/drivers/input/gameport/Kconfig
@@ -1,8 +1,8 @@
 #
 # Gameport configuration
 #
-config GAMEPORT
-	tristate "Gameport support"
+menuconfig GAMEPORT
+	bool "Gameport support"
 	---help---
 	  Gameport support is for the standard 15-pin PC gameport. If you
 	  have a joystick, gamepad, gameport card, a soundcard with a gameport
