From: Mohan Pallaka <mpallaka@codeaurora.org>
Subject: [PATCH 1/2] pwm: Add __weak attributed functions for pwm operations
Date: Fri, 13 May 2011 18:13:21 +0530
Message-ID: <1305290602-29859-2-git-send-email-mpallaka@codeaurora.org>
References: <1305290602-29859-1-git-send-email-mpallaka@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1305290602-29859-1-git-send-email-mpallaka@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.intradead.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, rmk@dyn-67.arm.linux.org.uk, Mohan Pallaka <mpallaka@codeaurora.org>
List-Id: linux-input@vger.kernel.org

For chip drivers that support both pwm and non-pwm modes
would encounter compilation errors if the platform doesn't
have support for pwm though the chip is programmed to work
in non-pwm mode. Add __weak attributed pwm functions to avoid
compilation issues in these scenarios.

Change-Id: Ia507bf659d4d67d71f135012e7d919aca6c45c6c
Signed-off-by: Mohan Pallaka <mpallaka@codeaurora.org>
---
 include/linux/pwm.h |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 7c77575..e0c8c3f 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -3,29 +3,31 @@
 
 struct pwm_device;
 
+/* Add __weak functions to support PWM */
+
 /*
  * pwm_request - request a PWM device
  */
-struct pwm_device *pwm_request(int pwm_id, const char *label);
+struct pwm_device __weak *pwm_request(int pwm_id, const char *label);
 
 /*
  * pwm_free - free a PWM device
  */
-void pwm_free(struct pwm_device *pwm);
+void __weak pwm_free(struct pwm_device *pwm);
 
 /*
  * pwm_config - change a PWM device configuration
  */
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);
+int __weak pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);
 
 /*
  * pwm_enable - start a PWM output toggling
  */
-int pwm_enable(struct pwm_device *pwm);
+int __weak pwm_enable(struct pwm_device *pwm);
 
 /*
  * pwm_disable - stop a PWM output toggling
  */
-void pwm_disable(struct pwm_device *pwm);
+void __weak pwm_disable(struct pwm_device *pwm);
 
 #endif /* __LINUX_PWM_H */

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
