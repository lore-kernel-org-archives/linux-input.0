From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: asus: Add i2c touchpad support
Date: Tue, 29 Nov 2016 16:15:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611291613130.29400@cbobk.fhfr.pm>
References: <1480406365-31640-1-git-send-email-redmcg@redmandi.dyndns.org> <20161129091344.GD24670@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758029AbcK2PPW (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 10:15:22 -0500
In-Reply-To: <20161129091344.GD24670@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Brendan McGrath <redmcg@redmandi.dyndns.org>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Victor Vlasenko <victor.vlasenko@sysgears.com>, Frederik Wenigwieser <frederik.wenigwieser@gmail.com>

On Tue, 29 Nov 2016, Benjamin Tissoires wrote:

> On Nov 29 2016 or thereabouts, Brendan McGrath wrote:
> > Update the hid-asus module to add multitouch support for the Asus i2c touchpad.
> > 
> > Signed-off-by: Brendan McGrath <redmcg@redmandi.dyndns.org>
> > Signed-off-by: Victor Vlasenko <victor.vlasenko@sysgears.com>
> > Signed-off-by: Frederik Wenigwieser <frederik.wenigwieser@gmail.com>
> > ---
> > This patch aims to resolve the issue raised here:
> > https://bugzilla.kernel.org/show_bug.cgi?id=120181
> > 
> > The issue is in relation to an Asus touchpad device which currently does not have
> > multitouch support.
> > 
> > The device currently falls through to the hid-generic driver which
> > treats the device as a mouse.
> > 
> > This patch aims to add the multitouch support.
> 
> The comments above should be in the commit message.

I've fixed that up.

> Besides that and only one nitpick below, I don't have much to add.
> I have helped a little bit the development on github which explains why
> I can't find much to say ( I already complained :-P ).
> 
> There is at least an other device that would require to be added later,
> which is the bluetooth cover of some Asus tablet IIRC. The protocol is
> slightly different and we will need to keep both the keyboard and the
> touchpad around, but it could be added later in an other patch.
> 
> For me, the patch is:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks!

[ ... snip ... ]
> >  static struct hid_driver asus_driver = {
> > -	.name = "asus",
> > -	.id_table = asus_devices,
> > -	.report_fixup = asus_report_fixup
> > +	.name			= "hid-asus",
> 
> Not sure there is a need to change the name.

Good point, that's not for any good.

I've dropped this change, ammended the changelog (also indicating the 
changes I've done on top of the patch), and applied to for-4.10/asus.

Thanks,

-- 
Jiri Kosina
SUSE Labs

