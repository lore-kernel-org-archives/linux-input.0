From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/7] Input: psmouse - add support for 2nd wheel on A4Tech Dual-Scroll wheel mice
Date: Fri, 19 Jan 2018 15:06:27 -0800
Message-ID: <20180119230629.49428-6-dmitry.torokhov@gmail.com>
References: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: Stephen Lyons <slysven@virginmedia.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Stephen Lyons <slysven@virginmedia.com>

This Far-Eastern company's PS/2 mice use a deviant format for the data
relating to movement of the scroll wheels for, at least, their dual wheel
mice, such as their "Optical GreatEye Wheelmouse" model "WOP-35".  This
product has five "buttons" (one of which is the click action on the first
wheel) and TWO scroll wheels.  However for a byte comprising d0-d7 instead
of setting one of d6-7 in the forth byte of the mouse data packet and a
twos complement number of scroll steps in the remaining d5-d0 (or d3-d0
should there be a fourth (BTN_SIDE - d4) or fifth (BTN_EXTRA - d5) button
to report; they only report a single +/- event for each wheel and use a bit
pattern that corresponds to +/-1 for the first wheel and +/- 2 for the
second in the lower nibble of the fourth byte.

The effect with existing code is that the second mouse wheel merely repeats
the effect of the first but providing two steps per click rather than the
one of the first wheel - so there is no HORIZONTAL scroll wheel movement
detected from the device as far as the rest of the kernel sees it.

This patch, if enabled by the "a4tech_workaround" module parameter modifies
the handling just for mice of type PSMOUSE_IMEX so that the second scroll
wheel movement gets correctly reported as REL_HWHEEL events.  Should this
module parameter be activated for other mice of the same PSMOUSE_IMEX type
then it is possible that at the point where the mouse reports more than a
single movement step the user may start seeing horizontal rather than
vertical wheel events, but should the movement steps get to be more than
two at a time the hack will get immediately deactivated and the behaviour
will revert to the past code.

This was discussed around *fifteen* *years* *ago* on the LKML and the best
summary is in post https://lkml.org/lkml/2002/7/18/111 "Re: PS2 Input Core
Support" by Vojtech Pavlik. I was not able to locate any discussion later
than this on this topic.

Given that most users of the "psmouse" module will NOT want this additional
feature enabled I have taken the apparently erroneous step of defaulting
the module parameter that enables it to be "disabled" - this functionality
may interfere with the operation of "normal" mice of this type (until a
large enough scroll wheel movement is detected) so I cannot see how it
would want to be enabled for "normal" users - i.e.  everyone without this
brand of mouse.

I am using this patch at the moment and I can confirm that it is working
for me as both a module and compiled into the kernel for my mouse that is
of the type (WOP-35) described - I note that it is still available from
certain on-line retailers and that the manufacturers site does not list
GNU/Linux as being supported on the product page - this patch however does
enable full use of this product:
http://www.a4tech.com/product.asp?cid=3D1&scid=3D8&id=3D22

Signed-off-by: Stephen Lyons <slysven@virginmedia.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index cbca668bb931f..d0e45124e7f43 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -70,6 +70,10 @@ static bool psmouse_smartscroll = true;
 module_param_named(smartscroll, psmouse_smartscroll, bool, 0644);
 MODULE_PARM_DESC(smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
 
+static bool psmouse_a4tech_2wheels;
+module_param_named(a4tech_workaround, psmouse_a4tech_2wheels, bool, 0644);
+MODULE_PARM_DESC(a4tech_workaround, "A4Tech second scroll wheel workaround, 1 = enabled, 0 = disabled (default).");
+
 static unsigned int psmouse_resetafter = 5;
 module_param_named(resetafter, psmouse_resetafter, uint, 0644);
 MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets (0 = never).");
@@ -150,6 +154,7 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
 {
 	struct input_dev *dev = psmouse->dev;
 	u8 *packet = psmouse->packet;
+	int wheel;
 
 	if (psmouse->pktcnt < psmouse->pktsize)
 		return PSMOUSE_GOOD_DATA;
@@ -175,8 +180,18 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
 			break;
 		case 0x00:
 		case 0xC0:
-			input_report_rel(dev, REL_WHEEL,
-					 -sign_extend32(packet[3], 3));
+			wheel = sign_extend32(packet[3], 3);
+
+			/*
+			 * Some A4Tech mice have two scroll wheels, with first
+			 * one reporting +/-1 in the lower nibble, and second
+			 * one reporting +/-2.
+			 */
+			if (psmouse_a4tech_2wheels && abs(wheel) > 1)
+				input_report_rel(dev, REL_HWHEEL, wheel / 2);
+			else
+				input_report_rel(dev, REL_WHEEL, -wheel);
+
 			input_report_key(dev, BTN_SIDE,  BIT(4));
 			input_report_key(dev, BTN_EXTRA, BIT(5));
 			break;
-- 
2.16.0.rc1.238.g530d649a79-goog
