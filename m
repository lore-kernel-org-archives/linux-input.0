From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [RFC PATCH 2/3] radio-keene: add a driver for the Keene FM Transmitter.
Date: Mon, 16 Jan 2012 14:15:54 +0100
Message-ID: <201201161415.54592.oneukum@suse.de>
References: <1326716960-4424-1-git-send-email-hverkuil@xs4all.nl> <201201161346.46474.oneukum@suse.de> <201201161403.07867.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51113 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752944Ab2APNOF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jan 2012 08:14:05 -0500
In-Reply-To: <201201161403.07867.hverkuil@xs4all.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Hans Verkuil <hans.verkuil@cisco.com>

Am Montag, 16. Januar 2012, 14:03:07 schrieb Hans Verkuil:
> > Oh, I forgot. You have no guarantee the hid driver is already loaded.
> > This driver needs to also gracefully handle being called for a HID
> > device.
> 
> And how do I do that? Do you have a pointer to another driver for me?

As you've tested that rejecting the device in usbhid works, I suggest you do
it as usbhid does it. Which reminds me, have you tested that it works the
second time also? The behavior is different if both drivers are resident
in memory.

	Regards
		Oliver
