From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH 0/1] Open / close for polled input device
Date: Tue, 13 Oct 2009 09:24:47 +0300
Message-ID: <1255415088-31845-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30668 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014AbZJMG00 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2009 02:26:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>

Small sensors could utilise polled input device. Sometimes there is
a need to prepare or close the HW. This patch adds optional 
open / close functionality to the polled input device driver.

Samu Onkalo (1):
  Polled input device: add device open and close methods

 drivers/input/input-polldev.c |    6 ++++++
 include/linux/input-polldev.h |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)

