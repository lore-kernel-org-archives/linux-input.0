From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH] Input: document the proper usage of EV_KEY and KEY_UNKNOWN
Date: Thu, 31 May 2007 19:28:14 -0300
Message-ID: <20070531222814.GB4076@khazad-dum.debian.net>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <d120d5000705301325yf76d062vefbc79873d23e602@mail.gmail.com> <20070531005305.GC6883@khazad-dum.debian.net> <200705310033.51230.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <200705310033.51230.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We have all the pieces needed to have sane, generic userland keyboard handling
in place for a while now, but it was not sufficiently documented (or used!).

If EV_KEY input drivers always generate scan codes that can be used to
reprogram their keycode maps, and always generate EV_MSC MSC_SCAN events when
they output an EV_KEY KEY_UNKNOWN event, userspace can trap those and feed it
to a generic helper that can ask the user to assign a key code and function to
that key.

This patch documents the requirements and best practices for EV_KEY input
drivers.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

 Dmitry, how is that as a first approximation of the text?

 Documentation/input/input-programming.txt |   53 ++++++++++++++++++++++++++++-
 1 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/Documentation/input/input-programming.txt b/Documentation/input/input-programming.txt
index d9d5230..836f0bb 100644
--- a/Documentation/input/input-programming.txt
+++ b/Documentation/input/input-programming.txt
@@ -272,7 +272,58 @@ present, it is broken sometimes (at keyboards: Toshiba notebooks). To enable
 autorepeat for your device, just set EV_REP in dev->evbit. All will be
 handled by the input system.
 
-1.9 Other event types, handling output events
+1.9 Being friendly to userspace when implementing EV_KEY drivers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Input drivers that generate EV_KEY events should always support either
+dev->getkeycode()/dev->setkeycode(), or keycode, keycodemax and keycodesize,
+so as to allow userspace to reprogram the keycodes as needed.  They should
+also either always generate EV_MSC MSC_SCAN events along with every EV_KEY
+event, or special case EV_KEY KEY_UNKNOWN as described below.
+
+If the input driver doesn't support any of the generic methods to manipulate
+the keycode map, it must never issue a EV_KEY KEY_UNKNOWN event.  If you
+need to issue EV_KEY KEY_UNKNOWN events, please implement the code in your
+driver to manipulate its keycode map.  KEY_UNKNOWN is meant to be something
+that can be replaced by the user with a functional keycode.
+
+If the input driver generates an EV_KEY KEY_UNKNOWN event, it should also
+generate *in the same event block* (i.e. before it issues an EV_SYN) an
+EV_MSC MSC_SCAN event, with the scan code for the "unknown key".  This
+should be done both in "press" and "release" EV_KEY events.  The EV_MSC
+MSC_SCAN event allows a generic userspace keyboard helper daemon to ask the
+user if he would like to map a key in a input device to a valid keycode, and
+assign a function to it.
+
+The scan code of a key (as informed in a EV_MSC MSC_SCAN event) must be its
+index in the keycode map, as implemented by dev->getkeycode() /
+dev->setkeycode(), or keycode, keycodemax and keycodesize for the device.
+
+If a key has a specific function that is known to the driver, it should
+generate the appropriate keycode for that function by default.  E.g., in a
+laptop where the FN+F1 key combination is always marked "HELP" in the
+keyboard, the driver is to generate KEY_HELP and not KEY_FN_F1.
+
+Unmarked keys that do not have a set function, or whose functions are
+unknown, should usually generate by default an EV_KEY KEY_UNKNOWN event.  If
+a positional keycode for that key already exists in input.h (e.g. KEY_FN_F1
+for FN+F1), it can also be used for backwards compatibility.  KEY_UNKNOWN is
+preferred for all new drivers, however.
+
+Non-positional keycodes like KEY_PROG1 should never be used by default.
+
+As an example, a ThinkPad T43 laptop hot key keyboard has FN+F1 unmarked,
+and FN+F5 marked with a "RF transmitter" symbol.  The driver for this
+keyboard is to generate EV_KEY KEY_UNKNOWN (plus EV_MSC MSC_SCAN <fn+f1
+scancode>) if the user presses or releases FN+F1.  It could generate EV_KEY
+KEY_FN_F1 *instead* of EV_KEY KEY_UNKNOWN as well.
+
+If the ThinkPad T43 user presses FN+F5, however, the driver is to generate
+EV_KEY KEY_WLAN, and not KEY_FN_F5 or KEY_UNKNOWN (this assumes the driver
+does know it is running on a ThinkPad T43, and that it has a model-specific
+key table for the T43).
+
+1.10 Other event types, handling output events
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The other event types up to now are:
-- 
1.5.1.6


-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
