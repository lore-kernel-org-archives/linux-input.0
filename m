From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/3] HID: magicmouse: More scroll improvements
Date: Thu, 24 Jun 2010 10:50:21 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006241050040.13809@pobox.suse.cz>
References: <1277083951-29137-1-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44285 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714Ab0FXIuW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jun 2010 04:50:22 -0400
In-Reply-To: <1277083951-29137-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Michael Poole <mdpoole@troilus.org>, linux-input@vger.kernel.org

On Sun, 20 Jun 2010, Chase Douglas wrote:

> The following three patches improve scrolling for Apple Magicmouse
> devices. The first two were sent as a set of four patches. Two were
> applied while two were reviewed later. They are now ready for
> application. The last patch is new, but is rather simple.
> 
> I have been running with these patches for a few weeks and have been
> very happy with the results :).
> 
> HID: magicmouse: properly account for scroll movement in state
> HID: magicmouse: add param for scroll speed
> HID: magicmouse: enable horizontal scrolling
> --
>  drivers/hid/hid-magicmouse.c |   63 ++++++++++++++++++++++++++++++------------
>  1 files changed, 45 insertions(+), 18 deletions(-)

I have applied all three patches into my 'magicmouse' branch. Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
