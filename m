From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/1] HID: User-space HID I/O driver (UHID)
Date: Thu, 10 May 2012 12:19:22 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1205101218030.31253@pobox.suse.cz>
References: <1335799650-17597-1-git-send-email-dh.herrmann@googlemail.com> <CAAngNMabAxO9fVN2DM=5xPJAVk_is3QoS1=+TGZPJAbY3TYHMQ@mail.gmail.com> <CANq1E4QaRHtGxt3d=Z2mvqAFhTY2zid20GGNZ2ZzHjStGepc+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44121 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757753Ab2EJKT3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 May 2012 06:19:29 -0400
In-Reply-To: <CANq1E4QaRHtGxt3d=Z2mvqAFhTY2zid20GGNZ2ZzHjStGepc+A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Joao Paulo Rechi Vita <jprvita@openbossa.org>, linux-input@vger.kernel.org, marcel@holtmann.org, claudio.takahasi@openbossa.org, linux-bluetooth@vger.kernel.org

On Thu, 3 May 2012, David Herrmann wrote:

> > Thanks for your work, David. I'll test and review this new version.
> > Did you find out the what is the problem when passing BUS_BLUETOOTH on
> > the 'bus' field of the create request?
> 
> I've spent some time looking into that but I haven't found the
> problem, yet. Maybe Jiri can comment here.

This should now all be handled correctly using the hid-generic mechanism. 
If you still see any problems with this (currently in linux-next, more 
precisely 'device-groups' branch in hid.git), please let me know.

-- 
Jiri Kosina
SUSE Labs
