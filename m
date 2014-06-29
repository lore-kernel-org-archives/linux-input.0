From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v7 4/6] input: misc: Add ABI docs for AXP20x PEK
Date: Sun, 29 Jun 2014 20:23:55 +0200
Message-ID: <1404066237-20234-5-git-send-email-carlo@caione.org>
References: <1404066237-20234-1-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDWJTUUC5UCBBSFTYGOQKGQEWLRHOSY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1404066237-20234-1-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add ABI entries for the PEK found on PMU X-Powers AXP202 and AXP209.

Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
---
 Documentation/ABI/testing/sysfs-driver-input-axp-pek | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-input-axp-pek

diff --git a/Documentation/ABI/testing/sysfs-driver-input-axp-pek b/Documentation/ABI/testing/sysfs-driver-input-axp-pek
new file mode 100644
index 0000000..080563b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-input-axp-pek
@@ -0,0 +1,11 @@
+What:		/sys/class/input/input(x)/startup
+Date:		March 2014
+Contact:	Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
+Description:	Startup time in us. Board is powered on if the button is pressed
+		for more than <startup_time>
+
+What:		/sys/class/input/input(x)/shutdown
+Date:		March 2014
+Contact:	Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
+Description:	Shutdown time in us. Board is powered off if the button is pressed
+		for more than <shutdown_time>
-- 
1.9.1
