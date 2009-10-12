From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [RFC][PATCH 0/1] Closing indication for polled input device
Date: Mon, 12 Oct 2009 11:09:40 +0300
Message-ID: <1255334981-24118-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51306 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbZJLILP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 04:11:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>

Some small sensors uses polled input device interface. When the device is
closed, it would be nice to turn off the HW if the sensor supports that.
This patch adds optional closing indication support to the polled
input device driver.

Samu Onkalo (1):
  Polled input device: Add closing indication

 drivers/input/input-polldev.c |    3 +++
 include/linux/input-polldev.h |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

