From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC] [PATCH] HID: Fix race condition between driver core and
 ll-driver
Date: Tue, 26 Jul 2011 11:51:32 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1107261150410.7300@pobox.suse.cz>
References: <1310567061-2679-1-git-send-email-dh.herrmann@googlemail.com> <CANq1E4QLsSezP-pSFsNWPT924Xc9y=j8jHi2R-k4ieZzewO5PA@mail.gmail.com> <CANq1E4Q2E+VmCVjnonw8gmnB7MJ6_Csw3XY5=G722qwW2qFZWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48778 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087Ab1GZJve (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jul 2011 05:51:34 -0400
In-Reply-To: <CANq1E4Q2E+VmCVjnonw8gmnB7MJ6_Csw3XY5=G722qwW2qFZWg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, padovan@profusion.mobi, dmitry.torokhov@gmail.com

On Mon, 25 Jul 2011, David Herrmann wrote:

> Although this race condition seems to be quite obvious, I have lots of
> trouble to trigger it. So I don't know whether you actually care to
> fix it, but just to keep it up: *ping*

Hi David,

yes, I am planning to look into this. But as you say -- it's not 
triggering in the real world apparently, so I haven't taken it for current 
merge window due to other high-priority things pending.

I am planning to look into your patch this week still. Thanks for patience 
:)

-- 
Jiri Kosina
SUSE Labs
