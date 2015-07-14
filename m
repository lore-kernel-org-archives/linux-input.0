From: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH RFC V1 1/3] mfd: da9062: Support for the DA9063 OnKey in the
 DA9062 core
Date: Tue, 14 Jul 2015 14:07:50 +0100
Message-ID: <70bb99452b0b38623ab1c25b2912eafa92d1826d.1436879270.git.stwiss.opensource@diasemi.com>
References: <cover.1436879270.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1436879270.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

Add MFD core driver support for a OnKey component

- MFD core adds the resource da9062_onkey_resources[] for the OnKey
- An appropriate value has been added into mfd_cell da9062_devs[] to
  support component .name = "da9062-onkey" and
  .of_compatible  = "dlg,da9062-onkey"

Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>

---
Checks performed with linux-next/next-20150708/scripts/checkpatch.pl
 da9062-core.c             total: 0 errors, 0 warnings, 523 lines checked
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
end-of-patch for PATCH RFC V1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
