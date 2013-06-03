From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 01/26] HID: wiimote: extend driver description
Date: Mon, 3 Jun 2013 11:19:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1306031117561.6750@pobox.suse.cz>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com> <1367788390-29835-2-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49599 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180Ab3FCJTT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Jun 2013 05:19:19 -0400
In-Reply-To: <1367788390-29835-2-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org

On Sun, 5 May 2013, David Herrmann wrote:

> The hid-wiimote driver supports more than the Wii Remote. Nintendo
> produced many devices based on the Wii Remote, which have extension
> devices built-in. It is not clear to many users, that these devices have
> anything in common with the Wii Remote, so fix the driver description.
> 
> This also updates the copyright information for the coming hotplugging
> rework.

I have now applied the whole patchset, with these two exceptions:

1) [RFC 24/26] HID: wiimote: support Nintendo Wii U Pro Controller

   - It's not completely clear to me whether you have reached conclusion 
     with Todd on this one or not

2) [RFC 26/26] HID/ALSA: wiimote: add speaker support

   - It'd be nice to get Ack from sound people on this one.

Thanks a lot, David. Good work.

-- 
Jiri Kosina
SUSE Labs
