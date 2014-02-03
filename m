From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Bluetooth: hidp: make sure input buffers are big
 enough
Date: Mon, 3 Feb 2014 11:08:30 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402031107310.14066@pobox.suse.cz>
References: <1387451372-6881-1-git-send-email-dh.herrmann@gmail.com> <3109C2D8-E01C-4728-A593-1978BB3D202D@holtmann.org> <CANq1E4TOHvb3--H6SoRhB09sUwuYkrvSAXCNN2Y0PaVSOEte=w@mail.gmail.com> <alpine.LNX.2.00.1401071308020.4962@pobox.suse.cz>
 <CANq1E4SxrDnbOCsohZXYoYL-HQjEc-xcOnXfAm=npHG2QfMS9A@mail.gmail.com> <alpine.LNX.2.00.1401071811530.4962@pobox.suse.cz> <alpine.LNX.2.00.1401282152140.22492@pobox.suse.cz> <CANq1E4TW+GU=oaW0tXb=Tun9HMtr26u-PC3H6BsLot560ANgog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55959 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbaBCKIe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Feb 2014 05:08:34 -0500
In-Reply-To: <CANq1E4TW+GU=oaW0tXb=Tun9HMtr26u-PC3H6BsLot560ANgog@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>

On Wed, 29 Jan 2014, David Herrmann wrote:

> >> Due to various reasons I will not have access to any testing HW for the
> >> upcoming 2-3 days, so if you can cook something up in that timeframe, it'd
> >> be appreciated.
> >>
> >> Otherwise I'll be working on it by the end of this week.
> >
> > David,
> >
> > just got back to this, finally ... did you have time to work on this at
> > all, or should I just start from scratch?
> 
> Sorry, no. Fosdem is this weekend and I needed to get my code ready
> for that. But I'll finally have time again next week.

Okay, thanks. I then guess we should proceed with this bandaid (double 
allocation) for 3.14

-- 
Jiri Kosina
SUSE Labs
