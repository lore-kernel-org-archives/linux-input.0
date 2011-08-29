From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 14/14] HID: wiimote: Read wiimote battery charge level
Date: Mon, 29 Aug 2011 16:28:59 +0200
Message-ID: <201108291628.59839.oneukum@suse.de>
References: <1314625091-1405-1-git-send-email-dh.herrmann@googlemail.com> <1314625091-1405-15-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58438 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753752Ab1H2OZm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Aug 2011 10:25:42 -0400
In-Reply-To: <1314625091-1405-15-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, padovan@profusion.mobi

Am Montag, 29. August 2011, 15:38:11 schrieb David Herrmann:
> This adds a new sysfs file for wiimotes which returns the current battery charge
> level of the device. Since this information is not sent by the wiimote
> continously, we need to explicitely request it.

Again I need to ask whether you really want a specific interface for
a functionality which is common to many devices.

	Regards
		Oliver
