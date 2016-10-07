From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 4/5] HID: sony: Send ds4 output reports on output
 end-point
Date: Fri, 7 Oct 2016 17:56:28 +0200
Message-ID: <20161007155628.GE30411@mail.corp.redhat.com>
References: <1475636338-3779-1-git-send-email-roderick@gaikai.com>
 <1475636338-3779-5-git-send-email-roderick@gaikai.com>
 <20161005083150.GB19261@mail.corp.redhat.com>
 <5FB6ED86-613A-449C-8D7C-60FD136075C3@gmail.com>
 <4f8de661a2a8be99ddcb284a89d4422c.squirrel@mungewell.org>
 <740B6F90-3CBB-45F6-AE7A-CA510D397B92@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932268AbcJGP4e (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 7 Oct 2016 11:56:34 -0400
Content-Disposition: inline
In-Reply-To: <740B6F90-3CBB-45F6-AE7A-CA510D397B92@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: Simon Wood <simon@mungewell.org>, Roderick Colenbrander <roderick@gaikai.com>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>, Frank Praznik <frank.praznik@oh.rr.com>, Antonio Ospite <ao2@ao2.it>

On Oct 05 2016 or thereabouts, Frank Praznik wrote:
> 
> > On Oct 5, 2016, at 13:35, Simon Wood <simon@mungewell.org> wrote:
> > 
> > On Wed, October 5, 2016 10:54 am, Frank Praznik wrote:
> >> The best answer I can give is "not to my knowledge”.  Rumble and LEDs
> >> have standard kernel interfaces but obviously we can’t guarantee 100% that
> >> nobody is using hidraw directly.  Commercial games and engines aren't
> >> running as root and thus can’t use hidraw so I think we can safely say
> >> that no major commercial software will be broken by this.
> > 
> > There are a couple of projects I know of, but I am unable to say whether
> > they are still active or whether proposed changes will affect them...
> > https://thp.io/2010/psmove/
> > http://moveonpc.blogspot.ca/
> > https://github.com/chrippa/ds4drv
> > 
> > Audio output is one area of the DS4 which is not supported in kernel,
> > maybe some renewed interest can get this working.
> > 
> > I agree with Frank that we should move forward, if something gets broken
> > we can work a better solution.
> > Simon.
> > 
> > acked-by: Simon Wood <simon@mungewell.org>
> > 
> > 
> > 
> 
> This change only affects sending rumble/LED output reports to the DS4, so hidraw input reports and sending/receiving feature reports will be unchanged as will anything not in the DS4 codepath (ie. Move controllers).  It looks like ds4drv has both a hidraw backend and one which uses raw Bluetooth sockets.  The raw socket backend should be unaffected, but the hidraw backend will probably have issues.  It should be trivial to patch it to append the CRC to the raw data packet like the kernel module does though.  It also looks like hidraw isn’t the default Bluetooth backend which reduces the odds that it will be an issue even further.
> 
> I’m definitely in favor of moving toward more correct behavior as long as the ds4drv project is given a warning to start sending CRC-ed output reports.
> 
> acked-by: Frank Praznik <frank.praznik@gmail.com>

Then:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
For the user-space change: Acked-by me too.

Cheers,
Benjamin
