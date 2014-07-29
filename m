From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 00/12] HID: Convert UHID to new HID transport-layer
Date: Tue, 29 Jul 2014 21:00:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1407292100150.16390@pobox.suse.cz>
References: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51180 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbaG2TAt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 15:00:49 -0400
In-Reply-To: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Tue, 29 Jul 2014, David Herrmann wrote:

> Hi
> 
> When Benjamin cleanup up the transport layer, he left UHID mostly unconverted
> due to ABI issues. I promised to take a look, so here're the patches.
> 
> Most of the patches are fairly straightforward. Comments welcome. I tested an
> old uhid-sample.c build and it still works, so I think I didn't break
> backwards-compatibility.

I will definitely take a look, but I can't promise I will be able to 
finish a review in time for 3.17.

If you find this a severe issue, please let me know.

Thanks,

-- 
Jiri Kosina
SUSE Labs
