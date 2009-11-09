From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH 0/1] Polled input device: sysfs control for polling rate
Date: Mon,  9 Nov 2009 15:03:02 +0200
Message-ID: <1257771783-31210-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48070 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbZKINDJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2009 08:03:09 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>

Provide possibility to control polling rate from userspace.
When polled device is used for example for sensors, it might be
handy to adjust polling rate according to sensor use. It is also possible
to stop polling without closing the device. When the pollig is stopped and
device is still open, it is still possible to send events from device to
userspace if some special situation occurs.

Samu Onkalo (1):
  Input polldev: Sysfs interface for setting of polling interval

 drivers/input/input-polldev.c |   86 +++++++++++++++++++++++++++++++++++++++--
 include/linux/input-polldev.h |    3 +
 2 files changed, 85 insertions(+), 4 deletions(-)

