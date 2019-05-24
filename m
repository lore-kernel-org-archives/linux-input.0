From: =?big5?B?ufmxUrph?= <kt.liao@emc.com.tw>
Subject: RE: [PATCH v2 09/10] Input: elan_i2c - correct the width/size base value
Date: Fri, 24 May 2019 11:13:10 +0800
Message-ID: <003d01d511de$9da229c0$d8e67d40$@emc.com.tw>
References: <20190521132712.2818-1-benjamin.tissoires@redhat.com> <20190521132712.2818-10-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521132712.2818-10-benjamin.tissoires@redhat.com>
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
To: 'Benjamin Tissoires' <benjamin.tissoires@redhat.com>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Rob Herring' <robh+dt@kernel.org>, 'Aaron Ma' <aaron.ma@canonical.com>, 'Hans de Goede' <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

Thanks so much for all you do for Elan touchpad.

For the width_*, I have a question for it.
Our antenna sensors fully occupied the whole touchpad PCB.

The Gap between 2 sensors are 7.5 mil (0.19mm).
That's why we did not minus one trace.


Thanks
KT
-----Original Message-----
From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com] 
Sent: Tuesday, May 21, 2019 9:27 PM
To: Dmitry Torokhov; KT Liao; Rob Herring; Aaron Ma; Hans de Goede
Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org;
devicetree@vger.kernel.org; Benjamin Tissoires
Subject: [PATCH v2 09/10] Input: elan_i2c - correct the width/size base
value

*_traces are the number of antennas. width_* is thus the space between 2
antennas. Which means, we should subtract 1 to the number of antennas to
divide the touchpad by the number of holes between each antenna.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

--

new in v2
---
 drivers/input/mouse/elan_i2c_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c
b/drivers/input/mouse/elan_i2c_core.c
index 6f4feedb7765..3375eaa9a72e 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -398,8 +398,8 @@ static int elan_query_device_parameters(struct
elan_tp_data *data)
 		if (error)
 			return error;
 	}
-	data->width_x = data->max_x / x_traces;
-	data->width_y = data->max_y / y_traces;
+	data->width_x = data->max_x / (x_traces - 1);
+	data->width_y = data->max_y / (y_traces - 1);
 
 	if (device_property_read_u32(&client->dev,
 				     "touchscreen-x-mm", &x_mm) ||
--
2.21.0
