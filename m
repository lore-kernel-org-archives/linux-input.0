From: Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: [PATCH RFC V3 3/3] Input: goodix - update dt bindings documentation (axis swapping/inversion)
Date: Sun, 18 Oct 2015 17:52:59 +0200
Message-ID: <1445183579-29176-4-git-send-email-merker@debian.org>
References: <1445183579-29176-1-git-send-email-merker@debian.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445183579-29176-1-git-send-email-merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The goodix touchscreen driver has gained support for the
optional touchscreen-inverted-x, touchscreen-inverted-y
and touchscreen-swapped-x-y properties as described in
Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt.

Document these properties in the goodix bindings description.

Signed-off-by: Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Reviewed-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 4db3393..4ecd0e1 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -14,6 +14,7 @@ Required properties:
  - interrupts		: Interrupt to which the chip is connected
  - irq-gpio		: GPIO pin used for IRQ
  - reset-gpio		: GPIO pin used for reset
+
 Optional properties:
 
  - esd-recovery-timeout-ms : ESD poll time (in milli seconds) for the driver to
@@ -21,6 +22,11 @@ Optional properties:
                             device. ESD is disabled if this property is not set
                             or is set to 0.
 
+ - touchscreen-inverted-x  : X axis is inverted (boolean)
+ - touchscreen-inverted-y  : Y axis is inverted (boolean)
+ - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
+                             (swapping is done after inverting the axis)
+
 Example:
 
 	i2c@00000000 {
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
