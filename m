From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 0/2] Input: xpad: fix wireless controller LEDs this picks up the work of "[PATCH 0/7] Input: xpad: Fix wireless controller connection and leds" and updates the patches as discussed in the thread, while leaving the conroversal parts out. Only the constantly blinking LED on the Xbox360 Wireless controller is fixed. So hopefully there is a better chance to merge this one. This also obsoletes my first attempt at this: "[PATCH] Xbox 360 wireless controller light continues blinking after sync with receiver."
Date: Sun,  7 Jun 2015 15:31:04 +0200
Message-ID: <1433683866-8785-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34884 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbbFGNdf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Jun 2015 09:33:35 -0400
Received: by wiga1 with SMTP id a1so60730749wig.0
        for <linux-input@vger.kernel.org>; Sun, 07 Jun 2015 06:33:34 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>


