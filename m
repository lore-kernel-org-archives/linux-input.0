From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 1/2] mfd: cros-ec: Update cros_ec_commands.h for buttons and switches
Date: Fri, 20 Jan 2017 11:14:14 +0100
Message-ID: <20170120101415.26028-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Douglas Anderson <dianders@chromium.org>
List-Id: linux-input@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

Add the defines for the new buttons and switches connected to the CrosEC.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 include/linux/mfd/cros_ec_commands.h | 73 +++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 23619b2..a01dde4 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1865,18 +1865,69 @@ struct ec_response_tmp006_get_raw {
  *
  * Returns raw data for keyboard cols; see ec_response_mkbp_info.cols for
  * expected response size.
+ *
+ * NOTE: This has been superseded by EC_CMD_MKBP_GET_NEXT_EVENT.  If you wish
+ * to obtain the instantaneous state, use EC_CMD_MKBP_INFO with the type
+ * EC_MKBP_INFO_CURRENT and event EC_MKBP_EVENT_KEY_MATRIX.
  */
 #define EC_CMD_MKBP_STATE 0x60
 
-/* Provide information about the matrix : number of rows and columns */
+/*
+ * Provide information about various MKBP things.  See enum ec_mkbp_info_type.
+ */
 #define EC_CMD_MKBP_INFO 0x61
 
 struct ec_response_mkbp_info {
 	uint32_t rows;
 	uint32_t cols;
-	uint8_t switches;
+	/* Formerly "switches", which was 0. */
+	uint8_t reserved;
 } __packed;
 
+struct ec_params_mkbp_info {
+	uint8_t info_type;
+	uint8_t event_type;
+} __packed;
+
+enum ec_mkbp_info_type {
+	/*
+	 * Info about the keyboard matrix: number of rows and columns.
+	 *
+	 * Returns struct ec_response_mkbp_info.
+	 */
+	EC_MKBP_INFO_KBD = 0,
+
+	/*
+	 * For buttons and switches, info about which specifically are
+	 * supported.  event_type must be set to one of the values in enum
+	 * ec_mkbp_event.
+	 *
+	 * For EC_MKBP_EVENT_BUTTON and EC_MKBP_EVENT_SWITCH, returns a 4 byte
+	 * bitmask indicating which buttons or switches are present.  See the
+	 * bit inidices below.
+	 */
+	EC_MKBP_INFO_SUPPORTED = 1,
+
+	/*
+	 * Instantaneous state of buttons and switches.
+	 *
+	 * event_type must be set to one of the values in enum ec_mkbp_event.
+	 *
+	 * For EC_MKBP_EVENT_KEY_MATRIX, returns uint8_t key_matrix[13]
+	 * indicating the current state of the keyboard matrix.
+	 *
+	 * For EC_MKBP_EVENT_HOST_EVENT, return uint32_t host_event, the raw
+	 * event state.
+	 *
+	 * For EC_MKBP_EVENT_BUTTON, returns uint32_t buttons, indicating the
+	 * state of supported buttons.
+	 *
+	 * For EC_MKBP_EVENT_SWITCH, returns uint32_t switches, indicating the
+	 * state of supported switches.
+	 */
+	EC_MKBP_INFO_CURRENT = 2,
+};
+
 /* Simulate key press */
 #define EC_CMD_MKBP_SIMULATE_KEY 0x62
 
@@ -2009,6 +2060,12 @@ enum ec_mkbp_event {
 	/* New Sensor FIFO data. The event data is fifo_info structure. */
 	EC_MKBP_EVENT_SENSOR_FIFO = 2,
 
+	/* The state of the non-matrixed buttons have changed. */
+	EC_MKBP_EVENT_BUTTON = 3,
+
+	/* The state of the switches have changed. */
+	EC_MKBP_EVENT_SWITCH = 4,
+
 	/* Number of MKBP events */
 	EC_MKBP_EVENT_COUNT,
 };
@@ -2018,6 +2075,9 @@ union ec_response_get_next_data {
 
 	/* Unaligned */
 	uint32_t  host_event;
+
+	uint32_t   buttons;
+	uint32_t   switches;
 } __packed;
 
 struct ec_response_get_next_event {
@@ -2026,6 +2086,15 @@ struct ec_response_get_next_event {
 	union ec_response_get_next_data data;
 } __packed;
 
+/* Bit indices for buttons and switches.*/
+/* Buttons */
+#define EC_MKBP_POWER_BUTTON	0
+#define EC_MKBP_VOL_UP		1
+#define EC_MKBP_VOL_DOWN	2
+
+/* Switches */
+#define EC_MKBP_LID_OPEN	0
+
 /*****************************************************************************/
 /* Temperature sensor commands */
 
-- 
2.9.3
