From: Karsten Merker <merker@debian.org>
Subject: [PATCH V4 3/3] Input: goodix - update dt bindings documentation (axis swapping/inversion)
Date: Sat, 21 Nov 2015 14:30:22 +0100
Message-ID: <1448112622-2062-4-git-send-email-merker@debian.org>
References: <1448112622-2062-1-git-send-email-merker@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448112622-2062-1-git-send-email-merker@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Karsten Merker <merker@debian.org>
List-Id: linux-input@vger.kernel.org

The goodix touchscreen driver has gained support for the
optional touchscreen-inverted-x, touchscreen-inverted-y
and touchscreen-swapped-x-y properties as described in
Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt.

Document these properties in the goodix bindings description.

Signed-off-by: Karsten Merker <merker@debian.org>
Reviewed-by: Irina Tirdea <irina.tirdea@intel.com>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index a8492e3..ef5f42d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -23,6 +23,11 @@ Optional properties:
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
