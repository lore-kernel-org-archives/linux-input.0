Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683863A1CE3
	for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834104; cv=none; b=PMF3hYA0tsBsjmJ/mKcXn0cBKromlBQsnPQDuYBDdT7pWGEOpW9CgyC+bCBzCrnClgbTsDV/7onSMExedygLICLt/AZSirImSQ35VZOnnNFiH5A+qwtXI0xUpv7tSrO+Fd9I8UiGgL/Y/hHE/eCGvsdgAc+Dp4V5V3L33tpBS3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834104; c=relaxed/simple;
	bh=quUw0qXf+yO70m3HzDPI6K/U1swHmMR7Y9YPq2TlPCc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bD50dkVhwEPcsr9iYkrCSLciQbbzOrHNe6H8rSDjsEtTP1q5x+xekQjIrgQ2hsrCkM901bTlRqflDJ9aUAKxU5Xm0YRnIkMuQpkghjyrILG+hh2JbKIrMtYxKkY87z93CvEhW1NmgnerM46scql6IhQkkNg+2jvPU0BbYJGCl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1w2pHR-0001h8-NY; Wed, 18 Mar 2026 12:41:41 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH v2 0/2] Input: st1232 - add support for firmware version
Date: Wed, 18 Mar 2026 12:41:29 +0100
Message-Id: <20260318-input-st1232-firmware-version-v2-0-e844ee340d36@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGmPumkC/42NQQ6CMBBFr0Jm7ZhSRI0r72FYEDqFWdg201Ixh
 LtbOIG7/37y318hkjBFeFQrCGWO7F0BfapgmHo3ErIpDFrpq6p1g+zCnDCmkjValvenF8JMsi9
 RtYOxqjH3drhAcQQhy8vhf3WFJ47Jy/e4y/Xe/mvONSpstLE3Imt6S89AbpyTeMfL2RB027b9A
 HaFCqHPAAAA
X-Change-ID: 20260123-input-st1232-firmware-version-05cdf03d85c4
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kernel@pengutronix.de, 
 Michael Tretter <m.tretter@pengutronix.de>, 
 Khalid Talash <ktalash@topcon.com>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org

The st1332 runs a firmware and reports the version and revision of the
firmware via the registers of the device.

Read the firmware version and revision from the respective registers,
print it to the log and report it via sysfs.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
Changes in v2:
- replace get_unaligned_le32() by le32_to_cpup
- Link to v1: https://patch.msgid.link/20260123-input-st1232-firmware-version-v1-0-32df7eefdafe@pengutronix.de

---
Michael Tretter (2):
      Input: st1232 - read firmware version and revision
      Input: st1232 - expose firmware version via sysfs

 drivers/input/touchscreen/st1232.c | 66 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
---
base-commit: 2d1373e4246da3b58e1df058374ed6b101804e07
change-id: 20260123-input-st1232-firmware-version-05cdf03d85c4

Best regards,
-- 
Michael Tretter <m.tretter@pengutronix.de>

