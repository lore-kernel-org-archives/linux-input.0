From: Sylvain Rochet <sylvain.rochet@finsecur.com>
Subject: [PATCH v4 1/2] Documentation: input: rotary encoder: Add wakeup-source property
Date: Mon, 12 Oct 2015 21:13:31 +0200
Message-ID: <1444677212-9590-2-git-send-email-sylvain.rochet@finsecur.com>
References: <1444677212-9590-1-git-send-email-sylvain.rochet@finsecur.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-guillaumet.finsecur.com ([91.217.234.131]:51945 "EHLO
	guillaumet.finsecur.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbbJLTNg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2015 15:13:36 -0400
In-Reply-To: <1444677212-9590-1-git-send-email-sylvain.rochet@finsecur.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Johan Hovold <jhovold@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sylvain Rochet <sylvain.rochet@finsecur.com>, devicetree@vger.kernel.org

This patch adds property wakeup-source to GPIO rotary encoders.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
Cc: <devicetree@vger.kernel.org>
---
 Documentation/devicetree/bindings/input/rotary-encoder.txt | 1 +
 Documentation/input/rotary-encoder.txt                     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
index 3315495..2c643a3 100644
--- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
+++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
@@ -15,6 +15,7 @@ Optional properties:
 - rotary-encoder,rollover: Automatic rollove when the rotary value becomes
   greater than the specified steps or smaller than 0. For absolute axis only.
 - rotary-encoder,half-period: Makes the driver work on half-period mode.
+- wakeup-source: Boolean, rotary encoder can wake-up the system.
 
 See Documentation/input/rotary-encoder.txt for more information.
 
diff --git a/Documentation/input/rotary-encoder.txt b/Documentation/input/rotary-encoder.txt
index 5737e35..bddbee1 100644
--- a/Documentation/input/rotary-encoder.txt
+++ b/Documentation/input/rotary-encoder.txt
@@ -109,6 +109,7 @@ static struct rotary_encoder_platform_data my_rotary_encoder_info = {
 	.inverted_a	= 0,
 	.inverted_b	= 0,
 	.half_period	= false,
+	.wakeup_source	= false,
 };
 
 static struct platform_device rotary_encoder_device = {
-- 
2.5.1

