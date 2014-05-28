From: Reyad Attiyat <reyad.attiyat@gmail.com>
Subject: [PATCH 2/3] IIO: Add iio_chan modifier for True/Magnetic North HID usages
Date: Wed, 28 May 2014 16:06:14 -0500
Message-ID: <1401311175-12784-3-git-send-email-reyad.attiyat@gmail.com>
References: <1401311175-12784-1-git-send-email-reyad.attiyat@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401311175-12784-1-git-send-email-reyad.attiyat@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org, jkosina@suse.cz
Cc: Reyad Attiyat <reyad.attiyat@gmail.com>
List-Id: linux-input@vger.kernel.org

Updated iio_chan_info_enum for compass north sensor usages,
including magnetic/true north and tilt compensation.

Signed-off-by: Reyad Attiyat <reyad.attiyat@gmail.com>
---
 drivers/iio/industrialio-core.c | 4 ++++
 include/linux/iio/types.h       | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index ede16aec..41bd377 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -84,6 +84,10 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_RED] = "red",
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
+	[IIO_MOD_MAGN_NORTH] = "north",
+	[IIO_MOD_MAGN_NORTH_TRUE] = "north_true",
+	[IIO_MOD_MAGN_NORTH_TILT_COMP] = "north_tilt_comp",
+	[IIO_MOD_MAGN_NORTH_TRUE_TILT_COMP] = "north_true_tilt_comp",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 084d882..f1e8be6 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -53,6 +53,10 @@ enum iio_modifier {
 	IIO_MOD_LIGHT_RED,
 	IIO_MOD_LIGHT_GREEN,
 	IIO_MOD_LIGHT_BLUE,
+	IIO_MOD_MAGN_NORTH,
+	IIO_MOD_MAGN_NORTH_TRUE,
+	IIO_MOD_MAGN_NORTH_TILT_COMP,
+	IIO_MOD_MAGN_NORTH_TRUE_TILT_COMP
 };
 
 enum iio_event_type {
-- 
1.9.3
