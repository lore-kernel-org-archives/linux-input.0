From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch] hid: fix autocentering of PID devices
Date: Wed, 13 Jun 2007 15:00:17 +0300
Message-ID: <466FDC51.5030703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Diogo Kastrup <dk@bighost.com.br>
List-Id: linux-input@vger.kernel.org

From: Diogo Kastrup <dk@bighost.com.br>

When setting the autocentering of PID devices, PID_DIRECTION_ENABLE is 
not being explicitely set to 1. This results in autocentering working 
only on the vertical axis when this field is preset to 0. This seems to 
happen since 2.6.21.

Fix that by setting it explicitely to 1 when preparing the set_effect 
report for autocentering spring effect.

Signed-off-by: Diogo Kastrup <dk@bighost.com.br>
Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---

--- linux/drivers/hid/usbhid/hid-pidff.bkp	2007-06-12 20:39:23.000000000 
-0300
+++ linux/drivers/hid/usbhid/hid-pidff.c	2007-06-12 19:19:57.000000000 -0300
@@ -738,6 +738,7 @@
  	pidff->set_effect[PID_TRIGGER_BUTTON].value[0] = 0;
  	pidff->set_effect[PID_TRIGGER_REPEAT_INT].value[0] = 0;
  	pidff_set(&pidff->set_effect[PID_GAIN], magnitude);
+	pidff->set_effect[PID_DIRECTION_ENABLE].value[0] = 1;
  	pidff->set_effect[PID_START_DELAY].value[0] = 0;

  	usbhid_submit_report(pidff->hid, pidff->reports[PID_SET_EFFECT],

-- 
Anssi Hannula
