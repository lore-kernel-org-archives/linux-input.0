From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 8/9] Input: Block suspend while event queue is not empty.
Date: Sun, 25 Apr 2010 04:30:30 +0200
Message-ID: <201004250430.31054.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1004241035260.6848-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39730 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab0DYCap convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Apr 2010 22:30:45 -0400
In-Reply-To: <Pine.LNX.4.44L0.1004241035260.6848-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Randy Dunlap <randy.dunlap@oracle.com>, =?iso-8859-1?q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-input@vger.kernel.org, Sven Neumann <s.neumann@raumfeld.com>, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-pm@lists.linux-foundation.org, Tero Saarni <tero.saarni@gmail.com>, Matthew Garrett <mjg@redhat.com>

On Saturday 24 April 2010, Alan Stern wrote:
> On Fri, 23 Apr 2010, Arve Hj=F8nnev=E5g wrote:
>=20
> > On Fri, Apr 23, 2010 at 2:08 PM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > On Friday 23 April 2010 01:56:25 pm Randy Dunlap wrote:
> > >> On Thu, 22 Apr 2010 18:08:57 -0700 Arve Hj=F8nnev=E5g wrote:
> > >> > Add an ioctl, EVIOCSSUSPENDBLOCK, to enable a suspend_blocker =
that will
> > >> > block suspend while the event queue is not empty. This allows =
userspace
> > >> > code to process input events while the device appears to be as=
leep.
> > >>
> > >> All new ioctls need to be added to Documentation/ioctl/ioctl-num=
ber.txt,
> > >> please.
> > >
> > > I do not see the reason for it to be in the kernel still. Have a =
process
> > > that listens to all input devices (or subset of them), once event=
s stop
> > > coming initiate suspend.

This solution is not practical with the Android user space AFAICT.
=20
> > I think the document added by the first patch explains this. The
> > solution you propose above will ignore a wakeup key pressed right
> > after user space decides to initiate suspend.
>=20
> Is there some reason why this feature needs to be enabled by an=20
> ioctl?  Why not make this suspend blocker permanently enabled?

The ioctl is there so that user space can use suspend blockers, which i=
s
needed because only user space know that some activities are going to c=
ontinue
and therefore the system should not be suspended (like playing music "i=
n the
background").

=46rom all of the interfaces that could be used for this purpose ioctl =
appears to
be the most convenient (we need something that is per process and allow=
s us
to carry out four operations: creat, destroy, activate, deactivate).

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
