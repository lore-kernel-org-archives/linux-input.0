From: Derek Foreman <derek.foreman@collabora.co.uk>
Subject: [PATCH 0/4] Some synaptics tweaks
Date: Fri, 10 Jun 2011 15:55:00 -0400
Message-ID: <1307735704-30673-1-git-send-email-derek.foreman@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.128.226]:37425 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757861Ab1FJUCi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jun 2011 16:02:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

This patch series (against next) is intended to improve synaptics 
trackpad input by passing real two-finger data to userspace for newer 
devices that can do better than just a bounding box.

Some of these devices have variable report rates that can drop below the 
screen refresh rate when more than one finger is on the pad, so new 
behavior has been added to help userspace compensate for this.

Thanks,
Derek

Daniel Stone (1):
  Input: Synaptics: Some touchpads can sense the complete locations of
    two fingers rather than just the bounding box, so for these pads,
    report the co-ordinates directly.

Derek Foreman (3):
  Input: New property to indicate that a device's report rate may not
    be consistent
  Input: Report defuzzed event once before filtering for devices with
    the INCONSISTENT_RATE property
  Input: Synaptics: Add INPUT_PROP_SYNAPTICS_T3R2 property

 drivers/input/input.c           |   22 +++++++++++++++++++---
 drivers/input/mouse/synaptics.c |   39 ++++++++++++++++++++++++++++++---------
 drivers/input/mouse/synaptics.h |    2 ++
 include/linux/input.h           |    6 ++++++
 4 files changed, 57 insertions(+), 12 deletions(-)

-- 
1.7.5.3

