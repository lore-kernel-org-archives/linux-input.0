Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795324435;
	b=AOPQd5lJTD0XvmA9xCTGm1nTF5qbYFNxmXALpCr6zBYCsQ0qp1DO6C1Nvs+aO94jD2Rb
	 oqOOTFXnQ6AvReEMPR5NcH5+FX0GKrh2iWpAZx8ayepBUEPb/FfIPvvMEnuTvuYQwA4id
	 aspK0wzsDmb+xcyH2yEOQNtIroCVr36OwbeXBaDSGJEBI9HXGefKAoQBGwObQpiZ9VLUd
	 hH7ftJGJaN1GHCOmt4VZVRrScnfJCupkVVexQ3lUtWCpHgSAISz2HYVZjOZcp9btItq/V
	 eMW8il4yozR21oPcwIfuEaIqu/+qsYvxaesOhrJNzTvk6SbRsjHn0DVhFSmp5jgCXQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795324435;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/0MfodTOWvcCRRBLklKRkyiB27uJC+hG0tdB+pPZKJQ=;
	b=S+s5oVYTLW0E3kCvQdtFkAX9lVNafaZ3w0K2EiZ2oMR0VQB1Eotz8jryDbvQQYbr4KAQ
	 Qqg3lwBqvwbVHfBC/ylNZI+3mc3ya3Ka9l1JEac8+p6JZ28xiqHWFyRdd0vpz+oOUT780
	 bbmRQsyEL7jfuQF/aRvLzimtroyZG8KeHrJXaOxjOK8oHI8GyHWbIuqHAgn6UDDe5YTfI
	 d8QUB7C7RG5aEPU97K6aZXn+T7roOtsPJXBP1AecUPxuasqpkAGMpgrVo8tfbpsh0y3Zj
	 XLRbBMzOYZMmBVgb+OMInaVOY68uwBc6hbEPFgblO9h3EhlNxmrOd4GOiCv0sD/njqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oEeFWs/t";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43CB606A338;
	Sun, 22 Nov 2026 05:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oEeFWs/t
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795324435;
	b=oG3R+TKzEouybw/QaIrMA1gL/XvWctvcOs/W0YYFoO+KKVgaWyzmeSOmIukY/vIwKIKz
	 0/Q4738qRPrH38g30lUvglsR+wernqxpeFG1DvwJULeNM3t8AFmsldoQGQ/QBYWWx8PET
	 CSL8CLQhvS/JVHLTt3bXXeMLrswV6KIV/pTEkpmhU5/JvY3GLWRk+SonnSDU2dd0JLbRY
	 uu8KSN7NkfPbqHTUO8H2R6GY4ZbuHZNS4EcGx+y/ZGGxNytz6lRlcjfV8YN3c7pxWSc20
	 hsAFv2Wj6COJ3jQr/ndy2B+FDPCZz1OdJJNNvtHo7GZaKwm3W1sILkQ/+/e6UPnLZxA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795324435;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/0MfodTOWvcCRRBLklKRkyiB27uJC+hG0tdB+pPZKJQ=;
	b=v68nK7I+CHFPhnDYtMYfEfs7OR7+UB1YxFjauGIiDt0ai36WN1Zl83FYFZXRCzPVM/zV
	 fguAjPl1ydqkZMjTYBwCvC7btc84rk/hltJlv8Hn0XKEdcbjRwvnb+NGkpZbgUtrp8eZm
	 nExSxLk5u0iON6qvLSRHnQt5tnb1x2WDb6cjDED+wNDIQjDoIM/EM0zhPUvJxCawdv+oJ
	 xuV3Ezz4JAmgUS3wYbpIfVOaIDHuRuvgKdFGx9dXjJWhPH4/Ls5iIxl+QZ2rWSUd4nb9h
	 qBHka+Z9yQCfAydTZiD/9hKphAfokOGudXeKgqT1bcr55wKLJ6ODerpOb4H0kJXPRTw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 854881F000E6;
	Sun, 22 Nov 2026 05:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795324435;
	bh=/0MfodTOWvcCRRBLklKRkyiB27uJC+hG0tdB+pPZKJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=oEeFWs/tC1pKmVl0jT0a8Kunt1q+enDfOujZu6EO6b6mAiS1Zh8zP6Da7444PDzrA
	 ffqPTXrNWeC9VgJ8aFeQZ+Bj+dxMAu9Z4p+LgQM2mn5W3f2VhZLFe8vKl+1mNNMmfo
	 SsT5h9+oVYOv4OuMUcZbLJdCvXFeb2k8Z6GAhCHt08E528FBZXDhYlCtMOhhVLCT2D
	 rhtKbV/SZLuzf/jTXv283X8nF4NGcOYvzbxnF/3c/k0jHXg3Tndz6QdncR4ZtRjOq1
	 Q8aVsOjIb5Kq4HfaBRoeYa7slP952804VHpFvD8pnCLwIwObg3Q5VzE6EJGeL0APjz
	 866WXbKUIwb/w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 169F54BF59;
	Sun, 22 Nov 2026 05:13:54 +0000 (UTC)
From: EMCP333 via B4 Relay <devnull+emcp.enser.io@kernel.org>
Date: Sun, 22 Nov 2026 05:13:51 +0000
Subject: [PATCH 2/3] Input: synaptics-rmi4 - keep an I2C device that may
 wake the system powered
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-rmi4-wakeup-v1-2-1b662be4a9d6@enser.io>
References: <20261122-b4-rmi4-wakeup-v1-0-1b662be4a9d6@enser.io>
In-Reply-To: <20261122-b4-rmi4-wakeup-v1-0-1b662be4a9d6@enser.io>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Abel Vesa <abelvesa@kernel.org>, Casey Connolly <casey.connolly@linaro.org>, 
 linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 EMCP333 <emcp@enser.io>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795324430; l=2971;
 i=emcp@enser.io; s=ultron; h=from:subject:message-id;
 bh=fDiPq/3r00nNm505fcLFxoFfTTgnQj9aL2qnPW//aiY=;
 b=WMSeGpwj6CI4Ce+yTljfHteDbAQCrDI7K/Sw6bk1eLeytA/E5e1Og22BqTMx09kKkI4lREWko
 YX2rRQNMYXCDdQb8qMeHZhLnhpOp9H/HpHsgeY3PjZKkg2VR0LeTzGX
X-Developer-Key: i=emcp@enser.io; a=ed25519;
 pk=5sG48Lul+Vn7OzXu3VZrCWk5uvEFPYMXYnAV0TZR/tY=
X-Endpoint-Received: by B4 Relay for emcp@enser.io/ultron with auth_id=1598
X-Original-From: EMCP333 <emcp@enser.io>
Reply-To: emcp@enser.io
Content-Transfer-Encoding: 7bit

From: EMCP333 <emcp@enser.io>

rmi_i2c_suspend() arms the attention interrupt for wakeup through
rmi_driver_suspend(..., true) and then disables the vdd and vio supplies.
Unpowered, the controller cannot report a touch, so the wakeup it has just
armed can never come from the user. Where the attention line is pulled up
from the switched I/O supply, cutting that supply also pulls the line
low, and that falling edge ends the suspend by itself.

On a OnePlus 6T (S3706B, attention on a falling-edge GPIO, vio from a
GPIO-controlled fixed regulator) with the touchscreen marked as a wakeup
source, every s2idle ended within 3 to 4 seconds with nobody touching the
phone, with one attention interrupt per suspend.

Keep the supplies on in system suspend when the device may wake the
system, as edt-ft5x06 does, and skip the matching re-enable and startup
delay on resume. A device that may not wake is powered down as before.

Tested on a OnePlus 6T on v7.4-rc3 with 'wakeup-source' on the
touchscreen node. With wakeup enabled and nothing touching the phone,
"rtcwake -m freeze -s 30" slept the full 30 seconds with no attention
interrupt (2 of 2), and a double-tap woke it (2 of 2, 120 second RTC
fallback). With wakeup disabled the supplies are cut as before and it
slept until the RTC (2 of 2).

The code and this changelog were prepared with the help of an AI coding
assistant. The submitter has reviewed both and takes responsibility for
them.

Signed-off-by: EMCP333 <emcp@enser.io>
---
 drivers/input/rmi4/rmi_i2c.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index b0b36ddb27..315d203056 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -296,8 +296,14 @@ static int rmi_i2c_suspend(struct device *dev)
 	if (ret)
 		dev_warn(dev, "Failed to resume device: %d\n", ret);
 
-	regulator_bulk_disable(ARRAY_SIZE(rmi_i2c->supplies),
-			       rmi_i2c->supplies);
+	/*
+	 * A device that may wake the system has to stay powered: cutting its
+	 * supplies drops the attention line, which is a wake event of its own,
+	 * and leaves the controller unable to report a touch.
+	 */
+	if (!device_may_wakeup(dev))
+		regulator_bulk_disable(ARRAY_SIZE(rmi_i2c->supplies),
+				       rmi_i2c->supplies);
 
 	return ret;
 }
@@ -308,12 +314,14 @@ static int rmi_i2c_resume(struct device *dev)
 	struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies),
-				    rmi_i2c->supplies);
-	if (ret)
-		return ret;
+	if (!device_may_wakeup(dev)) {
+		ret = regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies),
+					    rmi_i2c->supplies);
+		if (ret)
+			return ret;
 
-	msleep(rmi_i2c->startup_delay);
+		msleep(rmi_i2c->startup_delay);
+	}
 
 	ret = rmi_driver_resume(rmi_i2c->xport.rmi_dev, true);
 	if (ret)

-- 
2.47.3


