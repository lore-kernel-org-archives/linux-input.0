From: Marc Reilly <marc@cpdesign.com.au>
Subject: mc13892 touchscreen support
Date: Mon, 30 Jan 2012 09:51:00 +1100
Message-ID: <1327877464-23526-1-git-send-email-marc@cpdesign.com.au>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46564 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab2A2Wvc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jan 2012 17:51:32 -0500
Received: by pbaa10 with SMTP id a10so3264234pba.19
        for <linux-input@vger.kernel.org>; Sun, 29 Jan 2012 14:51:32 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: s.hauer@pengutronuix.de, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de

Hi,

This patch series adds touchscreen support for the mc13892 to the
mc13873 driver. The driver is renamed to mc13xxx_ts to reflect this.

The first 3 patches apply cleanly to v3.2.

The fourth patch allows setting the ATO and ATOX registers with each
conversion. It requires another series I just posted [1].

Cheers,
Marc

[1] http://lists.arm.linux.org.uk/lurker/message/20120129.223322.722b7424.en.html

