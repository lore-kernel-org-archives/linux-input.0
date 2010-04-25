From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH 8/9] Input: Block suspend while event queue
 is not empty.
Date: Sun, 25 Apr 2010 11:29:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004251122230.25835-100000@netrider.rowland.org>
References: <201004250430.31054.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:46285 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752604Ab0DYP30 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Apr 2010 11:29:26 -0400
In-Reply-To: <201004250430.31054.rjw@sisk.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Randy Dunlap <randy.dunlap@oracle.com>, =?iso-8859-1?q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-input@vger.kernel.org, Sven Neumann <s.neumann@raumfeld.com>, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-pm@lists.linux-foundation.org, Tero Saarni <tero.saarni@gmail.com>, Matthew Garrett <mjg@redhat.com>

On Sun, 25 Apr 2010, Rafael J. Wysocki wrote:

> On Saturday 24 April 2010, Alan Stern wrote:
> > On Fri, 23 Apr 2010, Arve Hj=F8nnev=E5g wrote:
> >=20
> > > On Fri, Apr 23, 2010 at 2:08 PM, Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > > On Friday 23 April 2010 01:56:25 pm Randy Dunlap wrote:
> > > >> On Thu, 22 Apr 2010 18:08:57 -0700 Arve Hj=F8nnev=E5g wrote:
> > > >> > Add an ioctl, EVIOCSSUSPENDBLOCK, to enable a suspend_blocke=
r that will
> > > >> > block suspend while the event queue is not empty. This allow=
s userspace
> > > >> > code to process input events while the device appears to be =
asleep.

> > Is there some reason why this feature needs to be enabled by an=20
> > ioctl?  Why not make this suspend blocker permanently enabled?
>=20
> The ioctl is there so that user space can use suspend blockers, which=
 is
> needed because only user space know that some activities are going to=
 continue
> and therefore the system should not be suspended (like playing music =
"in the
> background").

No, you're thinking of a different ioctl: SUSPEND_BLOCKER_IOCTL_BLOCK. =
=20
This one (EVIOCSSUSPENDBLOCK) is present _only_ to enable one specific
suspend blocker, which is activated when the input event queue is
non-empty.  I don't see any reason why it shouldn't be enabled all the
time.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
