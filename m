From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: psmouse - disable automatic probing of BYD touchpads
Date: Sat, 12 Nov 2016 11:15:45 -0800
Message-ID: <20161112191545.GA19531@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Chris Diamand <chris@diamand.org>, phonesyfreakies@gmail.com, Michael Shell <list1@michaelshell.org>, Eric Wong <normalperson@yhbt.net>, Ondrej Zary <linux@rainbow-software.org>, Christophe TORDEUX <christophe@tordeux.net>, Richard Pospesel <pospeselr@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

BYD automatic protocol detection is extremely unreliable and is often
triggers false positives on regular mice, Sentelic touchpads, and other
devices. BYD has several documents that have recommended detection
sequence, but they conflict with each other and, as far as I can see, still
would not produce unique enough output to reliably differentiate BYD from
other PS/2 devices.

OEMs sourcing BYD devices also do not do us any favors by not supplying any
reasonable DMI data and instead leaving turds like "To Be Filled By O.E.M."
in place of vendor data, or "System Serial Number" as serial number.

On top of that BYD is not truly modern multitouch controller, but rather a
single-touch transitional device that only reports absolute coordinates at
the beginning of finger contact and then reverts to reporting
displacements, and thus not very precise; the only benefit from using BYD
mode vs the legacy PS/2 mode is possibility of edge scrolling.

Given the above, and the fact that BYD devices are somewhat uncommon, let's
disable automatic detection of BYD devices. Users who know they have BYD
trackpads or want to experiment can attempt to activate BYD protocol via
sysfs:

	echo -n "byd" > /sys/bus/serio/devices/serio1/drvctl

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=151691
Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=175421
Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=120781
Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=121281
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index fb4b185..bee2674 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1115,10 +1115,6 @@ static int psmouse_extensions(struct psmouse *psmouse,
 		if (psmouse_try_protocol(psmouse, PSMOUSE_TOUCHKIT_PS2,
 					 &max_proto, set_properties, true))
 			return PSMOUSE_TOUCHKIT_PS2;
-
-		if (psmouse_try_protocol(psmouse, PSMOUSE_BYD,
-					 &max_proto, set_properties, true))
-			return PSMOUSE_BYD;
 	}
 
 	/*
-- 
2.8.0.rc3.226.g39d4020


-- 
Dmitry
