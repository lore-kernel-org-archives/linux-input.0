From: S Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V3 1/3] mfd: da9062: Support for the DA9063 OnKey in the
 DA9062 core
Date: Thu, 23 Jul 2015 17:17:41 +0100
Message-ID: <983c3fe61ca732985f70c7d77bdb146860daf467.1437668261.git.stwiss.opensource@diasemi.com>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437668261.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: DEVICETREE <devicetree@vger.kernel.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, RTCLINUX <rtc-linux@googlegroups.com>, S Twiss <stwiss.opensource@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

From: S Twiss <stwiss.opensource@diasemi.com>

Add MFD core driver support for a OnKey component

- MFD core adds the resource da9062_onkey_resources[] for the OnKey
- An appropriate value has been added into mfd_cell da9062_devs[] to
  support component .name = "da9062-onkey" and
  .of_compatible  = "dlg,da9062-onkey"

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Acked-by: Lee Jones <lee.jones@linaro.org>

---
Changes in V3:
 - Added Ack from Lee Jones
Changes in V2:
 - No change

This patch applies against linux-next and next-20150708 


 drivers/mfd/da9062-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 4cf0643..0732977 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -118,6 +118,10 @@ static struct resource da9062_wdt_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_WDG_WARN, 1, "WD_WARN", IORESOURCE_IRQ),
 };
 
+static struct resource da9062_onkey_resources[] = {
+	DEFINE_RES_NAMED(DA9062_IRQ_ONKEY, 1, "ONKEY", IORESOURCE_IRQ),
+};
+
 static const struct mfd_cell da9062_devs[] = {
 	{
 		.name		= "da9062-core",
@@ -141,6 +145,13 @@ static const struct mfd_cell da9062_devs[] = {
 		.resources	= da9062_thermal_resources,
 		.of_compatible  = "dlg,da9062-thermal",
 	},
+	{
+		.name		= "da9062-onkey",
+		.num_resources	= ARRAY_SIZE(da9062_onkey_resources),
+		.resources	= da9062_onkey_resources,
+		.of_compatible = "dlg,da9062-onkey",
+	},
+
 };
 
 static int da9062_clear_fault_log(struct da9062 *chip)
-- 
end-of-patch for PATCH V3
