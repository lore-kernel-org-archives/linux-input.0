From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 3/3] HID: usbhid: defer LED setting to a workqueue
Date: Wed, 14 Dec 2011 09:01:34 +0100
Message-ID: <201112140901.35203.oneukum@suse.de>
References: <1321529030-7845-1-git-send-email-djkurtz@chromium.org> <1321529030-7845-4-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40613 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956Ab1LNIAJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Dec 2011 03:00:09 -0500
In-Reply-To: <1321529030-7845-4-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: jkosina@suse.cz, bleung@chromium.org, stern@rowland.harvard.edu, olofj@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

Am Donnerstag, 17. November 2011, 12:23:50 schrieb Daniel Kurtz:
> Defer LED setting action to a workqueue.
> This is more likely to send all LED change events in a single URB.

Hi,

I hope I am looking at the correct version of this patch.
But as far as I can see the work for handling LEDs is not delayed
while a reset is going on. That is wrong.

	Regards
		Oliver
