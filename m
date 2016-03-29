From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: fix Bamboo ONE oops
Date: Tue, 29 Mar 2016 15:44:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1603291543120.3656@cbobk.fhfr.pm>
References: <1458916015-27658-1-git-send-email-benjamin.tissoires@redhat.com> <CAF8JNh+tY-4QA1911t5uA9B+_u_VqrGvEAfhNbhuayxmtzQDOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43676 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbcC2NoV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2016 09:44:21 -0400
In-Reply-To: <CAF8JNh+tY-4QA1911t5uA9B+_u_VqrGvEAfhNbhuayxmtzQDOQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <jason.gerecke@wacom.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 28 Mar 2016, Ping Cheng wrote:

> > Looks like recent changes in the Wacom driver made the Bamboo ONE crashes.
> > The tablet behaves as if it was a regular Bamboo device with pen, touch
> > and pad, but there is no physical pad connected to it.
> > The weird part is that the pad is still sending events and given that
> > there is no input node connected to it, we get  anull pointer exception.
> >
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=1317116
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Acked-by: Ping Cheng <pingc@wacom.com>
> 
> Thank you Benjamin for the fix.

Queued for 4.6-rc, thanks.

> As Benjamin mentioned, both users tested the patch. Since their
> testing was on kernel 4.4, we need to backport the patch to 4.4. Do
> you need us to make a patch for 4.4 or will you take care of stable as
> well?

I've added -stable tag to the patch.

-- 
Jiri Kosina
SUSE Labs

