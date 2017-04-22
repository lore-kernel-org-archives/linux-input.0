From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v2] Input: synaptics-rmi4 - handle orientation in F54 data
Date: Sat, 22 Apr 2017 10:22:45 +0100
Message-ID: <1492852965-15215-1-git-send-email-nick@shmanahar.org>
References: <CAFXsbZoMABHUKn14q754UJnbaCbn4xGbyN_54byyNuPV2khRXg@mail.gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:39558 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1043710AbdDVJXC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 22 Apr 2017 05:23:02 -0400
In-Reply-To: <CAFXsbZoMABHUKn14q754UJnbaCbn4xGbyN_54byyNuPV2khRXg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Nick Dyer <nick@shmanahar.org>

The RMI driver has support for flipping and swapping axes to make the
reported X and Y positions consistent with the touchscreen
orientation.

Add support to the F54 code to apply the same conversion to the debug
data.

Signed-off-by: Nick Dyer <nick@shmanahar.org>
Tested-by: Chris Healy <cphealy@gmail.com>
---
 drivers/input/rmi4/rmi_f11.c |  2 ++
 drivers/input/rmi4/rmi_f12.c |  2 ++
 drivers/input/rmi4/rmi_f54.c | 55 ++++++++++++++++++++++++++++++++++++++------
 include/linux/rmi.h          |  1 +
 4 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index bc5e37f..a3e2673 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -1137,6 +1137,8 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 
 	sensor->axis_align =
 		f11->sensor_pdata.axis_align;
+	drvdata->axis_align =
+		f11->sensor_pdata.axis_align;
 
 	sensor->topbuttonpad = f11->sensor_pdata.topbuttonpad;
 	sensor->kernel_tracking = f11->sensor_pdata.kernel_tracking;
diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 8b0db08..c34c13a 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -388,6 +388,8 @@ static int rmi_f12_probe(struct rmi_function *fn)
 
 	sensor->axis_align =
 		f12->sensor_pdata.axis_align;
+	drvdata->axis_align =
+		f12->sensor_pdata.axis_align;
 
 	sensor->x_mm = f12->sensor_pdata.x_mm;
 	sensor->y_mm = f12->sensor_pdata.y_mm;
diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index dea63e2..d45f386 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -76,7 +76,7 @@ enum rmi_f54_report_type {
 	F54_MAX_REPORT_TYPE,
 };
 
-const char *rmi_f54_report_type_names[] = {
+static const char * const rmi_f54_report_type_names[] = {
 	[F54_REPORT_NONE]		= "Unknown",
 	[F54_8BIT_IMAGE]		= "Normalized 8-Bit Image",
 	[F54_16BIT_IMAGE]		= "Normalized 16-Bit Image",
@@ -295,10 +295,44 @@ static int rmi_f54_queue_setup(struct vb2_queue *q, unsigned int *nbuffers,
 	return 0;
 }
 
+static void rmi_f54_handle_report_data_orient(struct f54_data *f54, void *ptr)
+{
+	struct rmi_device *rmi_dev = f54->fn->rmi_dev;
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
+	u8 width = drv_data->num_tx_electrodes ? : f54->num_tx_electrodes;
+	u8 height = drv_data->num_rx_electrodes ? : f54->num_rx_electrodes;
+	int x, y;
+	int rx, ry;
+	unsigned int offset;
+	bool use_8bit = rmi_f54_get_reptype(f54, f54->input) == F54_8BIT_IMAGE;
+
+	if (drv_data->axis_align.swap_axes)
+		swap(width, height);
+
+	for (x = 0; x < width; x++) {
+		for (y = 0; y < height; y++) {
+			rx = drv_data->axis_align.flip_x ? (width - 1 - x) : x;
+			ry = drv_data->axis_align.flip_y ? (height - 1 - y) : y;
+
+			if (drv_data->axis_align.swap_axes)
+				offset = ry*width + rx;
+			else
+				offset = rx*height + ry;
+
+			if (use_8bit)
+				((u8 *)ptr)[y*width + x] =
+					((u8 *)f54->report_data)[offset];
+			else
+				((u16 *)ptr)[y*width + x] =
+					((u16 *)f54->report_data)[offset];
+		}
+	}
+}
+
 static void rmi_f54_buffer_queue(struct vb2_buffer *vb)
 {
 	struct f54_data *f54 = vb2_get_drv_priv(vb->vb2_queue);
-	u16 *ptr;
+	void *plane_addr;
 	enum vb2_buffer_state state;
 	enum rmi_f54_report_type reptype;
 	int ret;
@@ -337,14 +371,14 @@ static void rmi_f54_buffer_queue(struct vb2_buffer *vb)
 		mutex_lock(&f54->data_mutex);
 	}
 
-	ptr = vb2_plane_vaddr(vb, 0);
-	if (!ptr) {
+	plane_addr = vb2_plane_vaddr(vb, 0);
+	if (!plane_addr) {
 		dev_err(&f54->fn->dev, "Error acquiring frame ptr\n");
 		state = VB2_BUF_STATE_ERROR;
 		goto data_done;
 	}
 
-	memcpy(ptr, f54->report_data, f54->report_size);
+	rmi_f54_handle_report_data_orient(f54, plane_addr);
 	vb2_set_plane_payload(vb, 0, rmi_f54_get_report_size(f54));
 	state = VB2_BUF_STATE_DONE;
 
@@ -422,8 +456,8 @@ static int rmi_f54_set_input(struct f54_data *f54, unsigned int i)
 
 	f54->input = i;
 
-	f->width = rx;
-	f->height = tx;
+	f->width = drv_data->axis_align.swap_axes ? rx : tx;
+	f->height = drv_data->axis_align.swap_axes ? tx : rx;
 	f->field = V4L2_FIELD_NONE;
 	f->colorspace = V4L2_COLORSPACE_RAW;
 	f->bytesperline = f->width * sizeof(u16);
@@ -668,6 +702,7 @@ static int rmi_f54_detect(struct rmi_function *fn)
 static int rmi_f54_probe(struct rmi_function *fn)
 {
 	struct f54_data *f54;
+	struct rmi_driver_data *drvdata = dev_get_drvdata(&fn->rmi_dev->dev);
 	int ret;
 	u8 rx, tx;
 
@@ -733,6 +768,12 @@ static int rmi_f54_probe(struct rmi_function *fn)
 		goto remove_v4l2;
 	}
 
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+		"Axis align swap_axes:%d flip_x:%d flip_y:%d\n",
+		drvdata->axis_align.swap_axes,
+		drvdata->axis_align.flip_x,
+		drvdata->axis_align.flip_y);
+
 	return 0;
 
 remove_v4l2:
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 64125443..bc2dfd9 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -358,6 +358,7 @@ struct rmi_driver_data {
 
 	u8 num_rx_electrodes;
 	u8 num_tx_electrodes;
+	struct rmi_2d_axis_alignment axis_align;
 
 	bool enabled;
 	struct mutex enabled_mutex;
-- 
2.7.4

