From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] dt-bindings: touchscreen: silead gsl1680: Document all
 compatibles
Date: Wed, 17 Aug 2016 10:59:00 +0200
Message-ID: <1471424340-4201-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

The silead gsl1680 driver / binding supports a whole series of devices,
list the compatibles for all of them in the binding.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Drop the "silead,mssl1680" compatible thing, the "mssl1680" name is an
 ACPI thing and does not belong in the dt bindings
---
 .../devicetree/bindings/input/touchscreen/silead_gsl1680.txt          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
index b0eca54..ad7f41a 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
@@ -2,6 +2,10 @@
 
 Required properties:
 - compatible		  : "silead,gsl1680"
+			or: "silead,gsl1688"
+			or: "silead,gsl3670"
+			or: "silead,gsl3675"
+			or: "silead,gsl3692"
 - reg			  : I2C slave address of the chip (0x40)
 - interrupt-parent	  : a phandle pointing to the interrupt controller
 			    serving the interrupt for this chip
-- 
2.7.4
