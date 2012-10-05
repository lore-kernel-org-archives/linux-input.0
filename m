From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Communicating tablet mode status to userspace
Date: Fri, 05 Oct 2012 17:50:48 +0200
Message-ID: <1349452248.11150.6.camel@novo.hadess.net>
References: <CAMLZHHS80_zdmgVtJ87w+fuQGC05yj+EoJt3C_zBC7hkyhnaoQ@mail.gmail.com>
	 <20121002233640.GB8542@core.coreip.homeip.net>
	 <CAMLZHHQfGuiK6s_d8ya8FUNiDiGDpgh35VFbHcu-mgCH-=TXVw@mail.gmail.com>
	 <20121003150542.GA8460@kroah.com>
	 <CAPXgP10+ZzLC98VdaQz19413guR-sKLT47iFLbN-mF_isF0n9A@mail.gmail.com>
	 <CAMLZHHTnhCjYA8x-=Q9+R3zbjV5ABnQ7D1hYX9qWfQ4Hck9f-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55569 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab2JEPuw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Oct 2012 11:50:52 -0400
In-Reply-To: <CAMLZHHTnhCjYA8x-=Q9+R3zbjV5ABnQ7D1hYX9qWfQ4Hck9f-Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Kay Sievers <kay@vrfy.org>, Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-hotplug@vger.kernel.org, Carlos Garnacho <carlosg@gnome.org>

Hey Daniel,

On Wed, 2012-10-03 at 10:04 -0600, Daniel Drake wrote:
> On Wed, Oct 3, 2012 at 9:23 AM, Kay Sievers <kay@vrfy.org> wrote:
> > The usual model is not uid/gid, it's ACLs dynamically applied for
> > logged-in users with active sessions:
> >   http://www.freedesktop.org/software/systemd/man/systemd-logind.service.html
> >   http://cgit.freedesktop.org/systemd/systemd/tree/src/login/70-uaccess.rules
> 
> Thanks, those were the pointers I needed.
> I'll work with this approach.

I think that there's a more generic approach to this, which would also
work with the tablet Thinkpads.

I would export the current "tablet mode" status through sysfs (which is
great if your driver keeps state), and send a uevent when the mode
changes (in addition to sending out that input event).

You'd probably need to tag your device in the udev database so that it
can be found and acted upon by user-space (probably a
gnome-settings-daemon plugin in your case).

Cheers

