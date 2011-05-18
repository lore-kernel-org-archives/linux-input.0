From: Mohan Pallaka <mpallaka@codeaurora.org>
Subject: [PATCH 1/2] pwm: Add stubs for pwm operations
Date: Wed, 18 May 2011 10:48:45 +0530
Message-ID: <1305695926-25855-2-git-send-email-mpallaka@codeaurora.org>
References: <1305695926-25855-1-git-send-email-mpallaka@codeaurora.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:6226 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932585Ab1ERFTy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 May 2011 01:19:54 -0400
In-Reply-To: <1305695926-25855-1-git-send-email-mpallaka@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux@arm.linux.org.uk, rmk+kernel@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, rmk@dyn-67.arm.linux.org.uk, Mohan Pallaka <mpallaka@codeaurora.org>

Chip drivers that support both pwm and non-pwm modes
would encounter compilation errors if the platform doesn't
have support for pwm, even though the chip is programmed
to work in non-pwm mode. Add stubs for pwm functions to
avoid compilation errors in these scenarios.

Signed-off-by: Mohan Pallaka <mpallaka@codeaurora.org>
---
 include/linux/pwm.h |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 7c77575..f0bc51f 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -3,6 +3,7 @@
 
 struct pwm_device;
 
+#if defined(CONFIG_PWM)
 /*
  * pwm_request - request a PWM device
  */
@@ -28,4 +29,27 @@ int pwm_enable(struct pwm_device *pwm);
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
+
+#endif /* CONFIG_PWM */
 #endif /* __LINUX_PWM_H */
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
