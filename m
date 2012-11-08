From: David Solda <dso@cypress.com>
Subject: RE: Why Cypress does not upstream its trackpad driver?
Date: Thu, 8 Nov 2012 03:09:36 -0500
Message-ID: <C6B11F3154DB7242B32DD96C876EA7847BAFFAFB11@VMBX113.ihostexchange.net>
References: <CAFub=KTf2dWxM9=saG2JaNJpEioJM8rM3UBG9BkyxRN-+j0psQ@mail.gmail.com>
 <C825ADB6BE8AC2468577BFFCE7DF5B8A1F080FA111@VMBX133.ihostexchange.net>
 <EE629F2C-DD83-403C-AD73-E9ED966EEA91@cypress.com>
 <2208882.BvOrfBvj6F@dtor-d630.eng.vmware.com>
 <C6B11F3154DB7242B32DD96C876EA7847BAFFAFA95@VMBX113.ihostexchange.net>
 <877gpwlpus.fsf@gmail.com> <20121108074154.GA4037@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay.ihostexchange.net ([66.46.182.52]:2355 "EHLO
	relay.ihostexchange.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab2KHIJk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Nov 2012 03:09:40 -0500
In-Reply-To: <20121108074154.GA4037@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ben Gamari <bgamari.foss@gmail.com>
Cc: Troy Abercrombia <ta@cypress.com>, Kamal Mostafa <kamal@canonical.com>, =?iso-8859-9?Q?Ozan_=C7a=F0layan?= <ozancag@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, customercare <customercare@cypress.com>, "mario_limonciello@dell.com" <mario_limonciello@dell.com>

Dmitry,

The change you are referring to is the one that I was mentioning.

The "absolute mode" is the only mode of our module that produces multip=
le fingers.  We do not communicate relative position for more than one =
finger.  The 8 byte packet is only used in the Absolute Mode, you are r=
ight, however, this packet contains the necessary information for deter=
mining the position of 2 fingers on the Trackpad.  Hence the reason why=
 I stated that a Firmware change (complete architectural and protocol r=
ewrite) on our side would be need to comply with the 6 byte maximum lim=
it.

So, the only method that I have available right now to upstream somethi=
ng that wouldn't be rejected (as you stated below) is either an archite=
ctural overhaul (which I cannot launch at this time), or single finger =
position tracking only.

Any other thoughts are appreciated, but the 8 bytes packet is needed fo=
r our multi-finger detection and communication scheme that is implement=
ed.

Dave

-----Original Message-----
=46rom: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
Sent: Wednesday, November 07, 2012 11:42 PM
To: Ben Gamari
Cc: David Solda; Troy Abercrombia; Kamal Mostafa; Ozan =C7a=F0layan; li=
nux-input@vger.kernel.org; customercare; mario_limonciello@dell.com
Subject: Re: Why Cypress does not upstream its trackpad driver?

On Wed, Nov 07, 2012 at 10:45:31PM -0500, Ben Gamari wrote:
> David Solda <dso@cypress.com> writes:
>
> > Dmitry, all,
> >
> > To clarify my comment.  Our protocol utilizes 8 bytes which are
> > needed in our driver.  In order for the Linux system to accept 8
> > bytes of data, the Linux psmouse system driver is required to be mo=
dified.
> > Without this modification, the driver that you are referring to wil=
l
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
> You are speaking to the people who ultimately decide whether your
> change will be accepted or not. Currently there is no way anyone coul=
d
> know whether the desired change is acceptable as no patch has been
> submitted.
>
> Send a patch with the (minimal, well-organized) needed changes and th=
e
> matter can be discussed from there. If the changes are sane and well
> justified, then there's little reason why they can't be accepted.

OK, so I looked at the psmouse changes briefly and indeed some of them =
will not be accepted, because they are really ... weird. Surely if your=
 device produces command responses in excess of 6 bytes that is current=
ly the limit in libps2 module the easiest way would be increasing the b=
uffer in struct ps2dev.

The rest of psnouse-base changes are OK (and indeed because protocol ty=
pes are exported to userspace and thus form ABI new definitions has to =
go to the end of the list); the driver itself needs bunch cleanups.
Henrik needs to see it as well.

It looks like you are trying to implement both relative and absolute mo=
des of operation, but we only want absolute as it provides best experie=
nce.

Please post the patches and we'll go form there.

Thanks.

--
Dmitry

This message and any attachments may contain Cypress (or its subsidiari=
es) confidential information. If it has been received in error, please =
advise the sender and immediately delete this message.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
