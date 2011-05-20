From: Mohan Pallaka <mpallaka@codeaurora.org>
Subject: [PATCH 1/2] pwm: Add stubs for pwm operations
Date: Fri, 20 May 2011 10:29:44 +0530
Message-ID: <1305867584-31929-1-git-send-email-mpallaka@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux@arm.linux.org.uk, rmk+kernel@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, rmk@dyn-67.arm.linux.org.uk, Mohan Pallaka <mpallaka@codeaurora.org>
List-Id: linux-input@vger.kernel.org

Chip drivers that support both pwm and non-pwm modes
would encounter compilation errors if the platform doesn't
have support for pwm, even though the chip is programmed
to work in non-pwm mode. Add stubs for pwm functions to
avoid compilation errors in these scenarios.

Signed-off-by: Mohan Pallaka <mpallaka@codeaurora.org>
---
 include/linux/pwm.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 7c77575..54877f6 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -3,6 +3,7 @@
 
 struct pwm_device;
 
+#if defined(CONFIG_HAVE_PWM)
 /*
  * pwm_request - request a PWM device
  */
@@ -28,4 +29,26 @@ int pwm_enable(struct pwm_device *pwm);
  */
 void pwm_disable(struct pwm_device *pwm);
 
+#else
+
+struct pwm_device *pwm_request(int pwm_id, const char *label)
+{
+	return NULL;
+}
+
+void pwm_free(struct pwm_device *pwm) { }
+
+int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+{
+	return -EINVAL;
+}
+
+int pwm_enable(struct pwm_device *pwm)
+{
+	return -EINVAL;
+}
+
+void pwm_disable(struct pwm_device *pwm) { }
+
+#endif /* CONFIG_HAVE_PWM */
 #endif /* __LINUX_PWM_H */
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
