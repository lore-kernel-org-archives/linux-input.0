From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH 0/3] touch tablet support for the w8001 serial driver
Date: Fri, 20 Aug 2010 14:55:32 +1000
Message-ID: <1282280135-15942-1-git-send-email-peter.hutterer@who-t.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:40667 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787Ab0HTEzF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Aug 2010 00:55:05 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pinglinux@gmail.com, rydberg@euromail.se


These patches add support for newer tablets to the wacom w8001 serial
driver. The first patch simply adds the support for the Pen/Eraser tool and
the stylus button.

The second patch detects touch-capable tablets and discard their packets.
Touch packets are interleaved with pen packets and their length depends on
the sensor model. Detect these packets and discard them silently.

The third patch adds MT slot support for two-finger touch devices.

Patches tested on a 2 finger touch device but i've had positive confirmation
that 1 finger devices don't break.

Cheers,
  Peter
