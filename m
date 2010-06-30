From: Alan Ott <alan@signal11.us>
Subject: [PATCH 0/1] HID: Send Report ID when numbered reports are sent over the control endpoint.
Date: Wed, 30 Jun 2010 09:50:35 -0400
Message-ID: <1277905836-3949-1-git-send-email-alan@signal11.us>
References: <alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:48564 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592Ab0F3Nus (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 09:50:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id CBC7E10406C
	for <linux-input@vger.kernel.org>; Wed, 30 Jun 2010 09:50:47 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@suse.de>, Marcel Holtmann <marcel@holtmann.org>, Anton
Cc: Alan Ott <alan@signal11.us>

This patch relies on:
  [PATCH 1/1] hidraw: Use Interrupt Endpoint for OUT Transfers if Available

Alan Ott (1):
  HID: Send Report ID when numbered reports are sent over the control
    endpoint.

 drivers/hid/usbhid/hid-core.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)


