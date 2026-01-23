Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884A43115BD
	for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185743; cv=none; b=WpS+7AVfZ6jD0yVRuSVSfNDKpYt8/iOMxRvKhKwmFQonOTLa+hbco2mkaegxNvUZnvqlDyD2opN4RCrnpNPXFaTwpyk2mYg4cFIKIAiIlt+6AO6xq7Mwj0LEkgN//kQ8uYqoVXsa8C4HNekq9OlClNSa1JLYLxcjtphx+u2jQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185743; c=relaxed/simple;
	bh=v0T7kMkrLlYzXF8KmR4cTjpSetE+kKgRej77Wi5XPXs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LrBBv01xMlsQgt+umHv6FdSJV8yiuGsXbb7x3U+bWMFpESm/IgD8Is30QvOfcDslPTmnsUB5bqsCA+TVBpxoGPSiWFG4OFcZDxcfS6NOcc4ydnuKbeLmysn4Ps1BYI+DsDmv68UnB3dDmtvRRagnw4te9JOuTKALRJiFRlnSpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vjK1p-0000Ip-H3; Fri, 23 Jan 2026 17:28:57 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH 0/2] Input: st1232 - add support for firmware version
Date: Fri, 23 Jan 2026 17:28:54 +0100
Message-Id: <20260123-input-st1232-firmware-version-v1-0-32df7eefdafe@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMahc2kC/x2MSQqAMAwAvyI5G6h1QfyKeChtqjlYJXUD8e9Wb
 zOHmRsiCVOELrtB6ODIS0hS5BnYyYSRkF1y0Eo3qtAlclj3DeOWWKNnmU8jhAfJV6KqrfOqdG1
 tK0iPVcjz9f/74XlePyphIW8AAAA=
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
Michael Tretter (2):
      Input: st1232 - read firmware version and revision
      Input: st1232 - expose firmware version via sysfs

 drivers/input/touchscreen/st1232.c | 66 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
---
base-commit: c072629f05d7bca1148ab17690d7922a31423984
change-id: 20260123-input-st1232-firmware-version-05cdf03d85c4

Best regards,
-- 
Michael Tretter <m.tretter@pengutronix.de>

