From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v4 7/7] MAINTAINERS: Add Intel ISH
Date: Sun,  7 Aug 2016 02:25:39 -0700
Message-ID: <1470561939-14278-8-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1470561939-14278-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1470561939-14278-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Add maintainer entry for Intel Integrated Sensor Hub

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20bb1d0..68cbb2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6077,6 +6077,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
 S:	Supported
 F:	drivers/idle/intel_idle.c
 
+INTEL INTEGRATED SENSOR HUB DRIVER
+M:	Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
+M:	Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
+L:	linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Maintained
+F:	drivers/hid/intel-ish-hid/
+
 INTEL PSTATE DRIVER
 M:	Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
 M:	Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
-- 
2.7.4
