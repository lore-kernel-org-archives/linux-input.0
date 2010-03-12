From: Oliver Neukum <oliver@neukum.org>
Subject: [RFC/RFT 0/5]power management for the touchscreen driver
Date: Fri, 12 Mar 2010 15:40:31 +0100
Message-ID: <201003121540.31876.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:47986 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750Ab0CLOkh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Mar 2010 09:40:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: linux-input@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

Hi,

this patch set implements all features of (runtime) power management
in the USB touchscreen driver. It does

-ordinary suspend/resume
- reset_resume
- simple autosuspend
- autosuspend for active devices

Testers are needed.

	Regards
		Oliver
