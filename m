From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v3 05/10] input: misc: Add ABI docs for AXP20x PEK
Date: Thu, 27 Mar 2014 22:29:19 +0100
Message-ID: <1395955764-18103-6-git-send-email-carlo@caione.org>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:58870 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757391AbaC0V2R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Mar 2014 17:28:17 -0400
In-Reply-To: <1395955764-18103-1-git-send-email-carlo@caione.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com, maxime.ripard@free-electrons.com, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: Carlo Caione <carlo@caione.org>

Add ABI entries for the PEK found on PMU X-Powers AXP202 and AXP209.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 Documentation/ABI/testing/sysfs-driver-input-axp-pek | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-input-axp-pek

diff --git a/Documentation/ABI/testing/sysfs-driver-input-axp-pek b/Documentation/ABI/testing/sysfs-driver-input-axp-pek
new file mode 100644
index 0000000..f8cdad2
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-input-axp-pek
@@ -0,0 +1,11 @@
+What:		/sys/class/input/input(x)/startup
+Date:		March 2014
+Contact:	Carlo Caione <carlo@caione.org>
+Description:	Startup time. Board is powered on if the button is pressed
+		for more than <startup_time>
+
+What:		/sys/class/input/input(x)/shutdown
+Date:		March 2014
+Contact:	Carlo Caione <carlo@caione.org>
+Description:	Shutdown time. Board is powered off if the button is pressed
+		for more than <shutdown_time>
-- 
1.8.3.2

