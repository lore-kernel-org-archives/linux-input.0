From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] Input: silead - list all supported compatible strings in binding document
Date: Wed, 29 Mar 2017 14:25:31 -0400
Message-ID: <20170329182531.17349-1-javier@osg.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:43707
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752264AbdC2SZo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Mar 2017 14:25:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, devicetree@vger.kernel.org, Robert Dolca <robert.dolca@intel.com>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>

The driver contains compatible strings for different models, but the DT
binding doc only lists one of them. Add the remaining to the document.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 .../devicetree/bindings/input/touchscreen/silead_gsl1680.txt       | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
index ce85ee508238..6aa625e0cb8d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
@@ -1,7 +1,12 @@
 * GSL 1680 touchscreen controller
 
 Required properties:
-- compatible		  : "silead,gsl1680"
+- compatible		  : Must be one of the following, depending on the model:
+			    "silead,gsl1680"
+			    "silead,gsl1688"
+			    "silead,gsl3670"
+			    "silead,gsl3675"
+			    "silead,gsl3692"
 - reg			  : I2C slave address of the chip (0x40)
 - interrupt-parent	  : a phandle pointing to the interrupt controller
 			    serving the interrupt for this chip
-- 
2.9.3

