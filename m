From: Denis Efremov <efremov@linux.com>
Subject: [PATCH] Input: synaptics-rmi4 - remove the exporting of rmi_2d_sensor_set_input_params
Date: Mon,  8 Jul 2019 20:21:38 +0300
Message-ID: <20190708172138.31009-1-efremov@linux.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Denis Efremov <efremov@linux.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The function rmi_2d_sensor_set_input_params is declared static and marked
EXPORT_SYMBOL_GPL, which is at best an odd combination. Because the
function is not used outside of the drivers/input/rmi4/rmi_2d_sensor.c
file it is defined in, this commit removes the EXPORT_SYMBOL_GPL() marking.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/input/rmi4/rmi_2d_sensor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
index ea549efe4bc4..b7fe6eb35a4e 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.c
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -204,7 +204,6 @@ static void rmi_2d_sensor_set_input_params(struct rmi_2d_sensor *sensor)
 	if (sensor->topbuttonpad)
 		set_bit(INPUT_PROP_TOPBUTTONPAD, input->propbit);
 }
-EXPORT_SYMBOL_GPL(rmi_2d_sensor_set_input_params);
 
 int rmi_2d_sensor_configure_input(struct rmi_function *fn,
 					struct rmi_2d_sensor *sensor)
-- 
2.21.0
