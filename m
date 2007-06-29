From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] Input: document the proper usage of EV_KEY and KEY_UNKNOWN (v2)
Date: Fri, 29 Jun 2007 01:04:52 -0400
Message-ID: <200706290104.53909.dtor@insightbb.com>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <20070531222814.GB4076@khazad-dum.debian.net> <20070606165509.GB18984@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070606165509.GB18984@khazad-dum.debian.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Henrique,

On Wednesday 06 June 2007 12:55, Henrique de Moraes Holschuh wrote:
> We have most of the pieces needed to have sane, generic userland keyboard
> handling in place for a while now, but it is not sufficiently documented.
> 
> This patch documents the requirements and best practices for EV_KEY input
> drivers.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Richard Hughes <hughsient@gmail.com>
> ---
> 
>  I have changed the KEY_UNKNOWN preference over positional keycodes around,
>  and also added a small paragraph on the expected behaviour of userland
>  applications re. EV_MSC MSC_SCAN events.
> 
>  Comments?

Finally gottent to the patch. It seems a little long-winded, how about
the patch below instead?

-- 
Dmitry

Subject: Input: document the proper usage of EV_KEY and KEY_UNKNOWN
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>


We have most of the pieces needed to have sane, generic userland keyboard
handling in place for a while now, but it is not sufficiently documented.

This patch documents the requirements and best practices for EV_KEY input
drivers.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 Documentation/input/input-programming.txt |   36 ++++++++++++++++++++++++++++--
 1 files changed, 34 insertions(+), 2 deletions(-)

Index: work/Documentation/input/input-programming.txt
===================================================================
--- work.orig/Documentation/input/input-programming.txt
+++ work/Documentation/input/input-programming.txt
@@ -263,7 +263,38 @@ getkeycode() and setkeycode() callbacks 
 keycode/keycodesize/keycodemax mapping mechanism provided by input core
 and implement sparse keycode maps.
 
-1.8 Key autorepeat
+1.8 Keymaps and KEY_UNKNOWN
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Follow these rules when creating a default keymap for an input device:
+
+- If a key has a specific function that is known to the driver, it should
+  generate keycode corresponding to that function. FOr example, in a laptop
+  where FN+F1 key combination is always marked "HELP" the driver should
+  generate KEY_HELP and not KEY_FN_F1.
+
+- If a positional keycode for a key already exists in input.h (e.g. KEY_FN_F1
+  for FN+F1), it should be used instead of KEY_UNKNOWN. When such a code
+  doesn't exist KEY_UNKNOWN should be used.
+
+- Non-positional keycodes like KEY_PROG1 should be avoided.
+
+Input drivers that generate EV_KEY events should always support either
+dev->getkeycode()/dev->setkeycode(), or keycode, keycodemax and keycodesize
+methods of reprogramming their keymaps. Drivers that do not allow changing
+keycode map should not genrate KEY_UNKNOWN events.
+
+In addition to EV_KEY events drivers should also generate EV_MSC/MSC_SCAN
+events. This event provides assistance to a generic userspace keyboard helper
+in remapping keys and assigning them specific function.
+
+MSC_SCAN event should be sent in the same event block (marked by
+EV_SYN/SYN_REPORT event) as corresponding EV_KEY event. The scan code
+reported must be a valid index in the keycode map, as implemented by
+dev->getkeycode()/dev->setkeycode(), or keycode, keycodemax and keycodesize
+for the device.
+
+1.9 Key autorepeat
 ~~~~~~~~~~~~~~~~~~
 
 ... is simple. It is handled by the input.c module. Hardware autorepeat is
@@ -272,7 +303,8 @@ present, it is broken sometimes (at keyb
 autorepeat for your device, just set EV_REP in dev->evbit. All will be
 handled by the input system.
 
-1.9 Other event types, handling output events
+
+1.10 Other event types, handling output events
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The other event types up to now are:
