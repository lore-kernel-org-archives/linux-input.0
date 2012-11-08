From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Why Cypress does not upstream its trackpad driver?
Date: Wed, 7 Nov 2012 23:41:54 -0800
Message-ID: <20121108074154.GA4037@core.coreip.homeip.net>
References: <CAFub=KTf2dWxM9=saG2JaNJpEioJM8rM3UBG9BkyxRN-+j0psQ@mail.gmail.com>
 <C825ADB6BE8AC2468577BFFCE7DF5B8A1F080FA111@VMBX133.ihostexchange.net>
 <EE629F2C-DD83-403C-AD73-E9ED966EEA91@cypress.com>
 <2208882.BvOrfBvj6F@dtor-d630.eng.vmware.com>
 <C6B11F3154DB7242B32DD96C876EA7847BAFFAFA95@VMBX113.ihostexchange.net>
 <877gpwlpus.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43985 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab2KHHl6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Nov 2012 02:41:58 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so1845424pbb.19
        for <linux-input@vger.kernel.org>; Wed, 07 Nov 2012 23:41:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <877gpwlpus.fsf@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: David Solda <dso@cypress.com>, Troy Abercrombia <ta@cypress.com>, Kamal Mostafa <kamal@canonical.com>, Ozan =?utf-8?B?w4dhxJ9sYXlhbg==?= <ozancag@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, customercare <customercare@cypress.com>, "mario_limonciello@dell.com" <mario_limonciello@dell.com>

On Wed, Nov 07, 2012 at 10:45:31PM -0500, Ben Gamari wrote:
> David Solda <dso@cypress.com> writes:
> 
> > Dmitry, all,
> >
> > To clarify my comment.  Our protocol utilizes 8 bytes which are needed
> > in our driver.  In order for the Linux system to accept 8 bytes of
> > data, the Linux psmouse system driver is required to be modified.
> > Without this modification, the driver that you are referring to will
> > not work correctly.  The psmouse system driver change that would be
> > required is the item that would be rejected.
> >
> > I appreciate your comments and of course, if the driver could be
> > upstreamed, it would (we already have I2C drivers updstreamed for
> > Chrome systems), but there is a difference here.
> >
> > I will again look into the possibility of what you are requesting,
> > however, the changes are extremely low if not zero that it will be
> > accepted.
> >
> You are speaking to the people who ultimately decide whether your change
> will be accepted or not. Currently there is no way anyone could know
> whether the desired change is acceptable as no patch has been
> submitted. 
> 
> Send a patch with the (minimal, well-organized) needed changes and the
> matter can be discussed from there. If the changes are sane and well
> justified, then there's little reason why they can't be accepted.

OK, so I looked at the psmouse changes briefly and indeed some of them
will not be accepted, because they are really ... weird. Surely if your
device produces command responses in excess of 6 bytes that is currently
the limit in libps2 module the easiest way would be increasing the
buffer in struct ps2dev.

The rest of psnouse-base changes are OK (and indeed because protocol
types are exported to userspace and thus form ABI new definitions has to
go to the end of the list); the driver itself needs bunch cleanups.
Henrik needs to see it as well.

It looks like you are trying to implement both relative and absolute
modes of operation, but we only want absolute as it provides best
experience.

Please post the patches and we'll go form there.

Thanks.

-- 
Dmitry
