From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 0/3] mpu3050 updates
Date: Thu, 15 Dec 2011 22:18:18 +0000
Message-ID: <20111215221732.8657.63987.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:58665 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759349Ab1LOWU1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Dec 2011 17:20:27 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Support polling mode, sampling configuration and make sure we are robustly
enabling interrupts when needed
---

Heikki Krogerus (3):
      input: mpu3050: Ensure we enable interrupts
      input: mpu3050: Configure the sampling method
      input: mpu3050: Support for polled input device


 drivers/input/misc/mpu3050.c |  296 +++++++++++++++++++++++++++++++++++-------
 1 files changed, 244 insertions(+), 52 deletions(-)

