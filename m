From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: input: fix confusion on conflicting mappings
Date: Tue, 6 Jan 2015 22:19:02 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1501062218200.25732@pobox.suse.cz>
References: <1419862886-1319-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49683 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752765AbbAFVTE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jan 2015 16:19:04 -0500
In-Reply-To: <1419862886-1319-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Adam Goode <adam@spicenitz.org>, Fredrik Hallenberg <megahallon@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, stable@vger.kernel.org

On Mon, 29 Dec 2014, David Herrmann wrote:

> On an PC-101/103/104 keyboard (American layout) the 'Enter' key and its
> neighbours look like this:
> 
>            +---+ +---+ +-------+
>            | 1 | | 2 | |   5   |
>            +---+ +---+ +-------+
>              +---+ +-----------+
>              | 3 | |     4     |
>              +---+ +-----------+

[ ... snip ... ]

Alright, I can't really see this introducing any regressions. I have now 
queued this for 3.20.

Thanks!

-- 
Jiri Kosina
SUSE Labs
