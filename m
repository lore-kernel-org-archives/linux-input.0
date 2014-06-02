From: Reyad Attiyat <reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCHv2 2/3] IIO: Add iio_chan modifier for True/Magnetic North HID usages
Date: Mon,  2 Jun 2014 18:14:49 -0500
Message-ID: <1401750890-31854-3-git-send-email-reyad.attiyat@gmail.com>
References: <1401750890-31854-1-git-send-email-reyad.attiyat@gmail.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401750890-31854-1-git-send-email-reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org
Cc: Reyad Attiyat <reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Updated iio modifier enum for compass north usages,
including magnetic/true north with tilt compensation.

Signed-off-by: Reyad Attiyat <reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iio/industrialio-core.c | 4 ++++
 include/linux/iio/types.h       | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index ede16aec..2f523b5 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -84,6 +84,10 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_RED] = "red",
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
+	[IIO_MOD_NORTH_MAGN] = "north_magnetic",
+	[IIO_MOD_NORTH_TRUE] = "north_true",
+	[IIO_MOD_NORTH_MAGN_TILT_COMP] = "north_magnetic_tilt_comp",
+	[IIO_MOD_NORTH_TRUE_TILT_COMP] = "north_true_tilt_comp",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 084d882..5bf8847 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -53,6 +53,10 @@ enum iio_modifier {
 	IIO_MOD_LIGHT_RED,
 	IIO_MOD_LIGHT_GREEN,
 	IIO_MOD_LIGHT_BLUE,
+	IIO_MOD_NORTH_MAGN,
+	IIO_MOD_NORTH_TRUE,
+	IIO_MOD_NORTH_MAGN_TILT_COMP,
+	IIO_MOD_NORTH_TRUE_TILT_COMP
 };
 
 enum iio_event_type {
-- 
1.9.3
