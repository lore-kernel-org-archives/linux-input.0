From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3 3/3] HID: wacom: Report input events for each finger
 on generic devices
Date: Thu, 11 Dec 2014 23:04:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1412112304080.6679@pobox.suse.cz>
References: <CAN+gG=Fw0BvNZ8DQtGtuCer42D0wzBzE0NX4rAe+54b94=X7RQ@mail.gmail.com> <1418257564-5561-1-git-send-email-killertofu@gmail.com> <CAN+gG=GdJGuo3poOT8u8caVLP_XQqoDUNJONct9f5iJki2xH2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42456 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933922AbaLKWEU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Dec 2014 17:04:20 -0500
In-Reply-To: <CAN+gG=GdJGuo3poOT8u8caVLP_XQqoDUNJONct9f5iJki2xH2g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>

On Thu, 11 Dec 2014, Benjamin Tissoires wrote:

> On Wed, Dec 10, 2014 at 7:26 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> > The existing generic touch code only reports events after reading an
> > entire HID report, which practically means that only data about the last
> > contact in a report will ever be provided to userspace. This patch uses
> > a trick from hid-multitouch.c to discover what type of field is at the
> > end of each contact; when such a field is encountered all the stored
> > contact data will be reported.
> >
> > Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> > ---
> 
> Fine by me. Thanks for the quick respin Jason.
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thanks to both of you.

-- 
Jiri Kosina
SUSE Labs
