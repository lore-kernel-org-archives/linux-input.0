From: "DusonLin" <dusonlin@emc.com.tw>
Subject: [PATCH 5/5] Input: elan_i2c - Correct the x and y trace number.
Date: Wed, 15 Apr 2015 09:55:43 +0800
Message-ID: <000401d0771f$4b7f9b90$e27ed2b0$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: =?big5?B?J7bApUDEUCc=?= <phoenix@emc.com.tw>
List-Id: linux-input@vger.kernel.org

The trace number does not need to subtract 1 now.

Signed-off-by: Duson Lin <dusonlin@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_i2c.c   |    4 ++--
 drivers/input/mouse/elan_i2c_smbus.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_i2c.c
b/drivers/input/mouse/elan_i2c_i2c.c
index 029941f..550f905 100644
--- a/drivers/input/mouse/elan_i2c_i2c.c
+++ b/drivers/input/mouse/elan_i2c_i2c.c
@@ -356,8 +356,8 @@ static int elan_i2c_get_num_traces(struct i2c_client
*client,
 		return error;
 	}
 
-	*x_traces = val[0] - 1;
-	*y_traces = val[1] - 1;
+	*x_traces = val[0];
+	*y_traces = val[1];
 
 	return 0;
 }
diff --git a/drivers/input/mouse/elan_i2c_smbus.c
b/drivers/input/mouse/elan_i2c_smbus.c
index 06a2bcd..0b04151 100644
--- a/drivers/input/mouse/elan_i2c_smbus.c
+++ b/drivers/input/mouse/elan_i2c_smbus.c
@@ -268,8 +268,8 @@ static int elan_smbus_get_num_traces(struct i2c_client
*client,
 		return error;
 	}
 
-	*x_traces = val[1] - 1;
-	*y_traces = val[2] - 1;
+	*x_traces = val[1];
+	*y_traces = val[2];
 
 	return 0;
 }
