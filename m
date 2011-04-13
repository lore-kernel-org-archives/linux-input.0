From: Mohan Pallaka <mpallaka-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 1/2] pwm: Add __weak attributed functions for pwm operations
Date: Wed, 13 Apr 2011 17:55:32 +0530
Message-ID: <1302697533-20456-2-git-send-email-mpallaka@codeaurora.org>
References: <1302697533-20456-1-git-send-email-mpallaka@codeaurora.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1302697533-20456-1-git-send-email-mpallaka-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Mohan Pallaka <mpallaka-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWNrRvHsEVmBkkB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

For chip drivers that support both pwm and non-pwm modes
would encounter compilation errors if the platform doesn't
have support for pwm though the chip is programmed to work
in non-pwm mode. Add __weak attributed pwm functions to avoid
compilation issues in these scenarios.

Change-Id: Ia507bf659d4d67d71f135012e7d919aca6c45c6c
Signed-off-by: Mohan Pallaka <mpallaka-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 include/linux/pwm.h |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 7c77575..3a8c3df 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -3,29 +3,40 @@
 
 struct pwm_device;
 
+/* Add __weak functions to support PWM */
+
 /*
  * pwm_request - request a PWM device
  */
-struct pwm_device *pwm_request(int pwm_id, const char *label);
+struct pwm_device __weak *pwm_request(int pwm_id, const char *label)
+{
+	return NULL;
+}
 
 /*
  * pwm_free - free a PWM device
  */
-void pwm_free(struct pwm_device *pwm);
+void __weak pwm_free(struct pwm_device *pwm) { }
 
 /*
  * pwm_config - change a PWM device configuration
  */
-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);
+int __weak pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+{
+	return -ENODEV;
+}
 
 /*
  * pwm_enable - start a PWM output toggling
  */
-int pwm_enable(struct pwm_device *pwm);
+int __weak pwm_enable(struct pwm_device *pwm)
+{
+	return -EINVAL;
+}
 
 /*
  * pwm_disable - stop a PWM output toggling
  */
-void pwm_disable(struct pwm_device *pwm);
+void __weak pwm_disable(struct pwm_device *pwm) { }
 
 #endif /* __LINUX_PWM_H */
-- 
1.7.1.1
