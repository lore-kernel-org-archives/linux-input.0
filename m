From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Posiflex 0d3a:a000 touchscreen press not recognized in kernel
 3.9.4
Date: Wed, 19 Jun 2013 23:54:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1306192354220.20425@pobox.suse.cz>
References: <51C159C5.7070702@gmx.de> <CAN+gG=HCREVXCsQjGjyJApR=U=TO4Kvaa1s+X-UEVe6akyj-7Q@mail.gmail.com> <51C17882.4050206@gmx.de> <51C1D4C8.5040201@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34590 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934961Ab3FSVyw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Jun 2013 17:54:52 -0400
In-Reply-To: <51C1D4C8.5040201@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jan Kandziora <jjj@gmx.de>, linux-input@vger.kernel.org, Jiri Kosina <jikos@jikos.cz>

On Wed, 19 Jun 2013, Benjamin Tissoires wrote:

> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Date: Wed, 19 Jun 2013 17:49:05 +0200
> Subject: [PATCH] HID: input: fix false positive out of range values
> 
> Commit 6da7066906e977d42104a859c490f5f9a300488c introduced in 3.3
> "HID: ignore absolute values which don't fit between logical min and max"
> prevents some Posiflex touch screen to work because they do not provide
> logical min and max for their buttons.
> Thus, logical min and max are at 0, discarding the buttons events, and
> preventing the device to report appropriate X Y.
> 
> Adding a check on "min < max" solves the problem.
> 
> Reported-by: Jan Kandziora <jjj@gmx.de>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks. I am applying this with Jan's Tested-by: (and I am also extending 
the comnent preceeding the condition to better explain this case).

-- 
Jiri Kosina
SUSE Labs
