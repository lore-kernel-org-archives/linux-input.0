From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: ACRUX - activate the device immediately after
 binding
Date: Sat, 12 Mar 2011 21:49:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103122148270.19969@pobox.suse.cz>
References: <20110311082734.GF10807@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:60713 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755266Ab1CLUtH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Mar 2011 15:49:07 -0500
In-Reply-To: <20110311082734.GF10807@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Sergei Kolzun <x0r@dv-life.ru>

On Fri, 11 Mar 2011, Dmitry Torokhov wrote:

> This device does not tolerate delayed opening and goes into a coma if
> we try to that. Ubuntu even has a crutch for udev that opened the device
> upon seeing it for the first time, but it did not work if we happened to
> boot with the device attached, since by the time userspace got around
> opening the device it was too late. Let's start the device immediately
> to deal with this issue.
> 
> Reported-by: Sergei Kolzun <x0r@dv-life.ru>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
> Jiri,
> 
> Sergei reports that his friend was able to test the patch and it fixes
> the issue for him so I believe we can now apply the patch.

Applied, thanks guys.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
