From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] [PATCH 8/9] Input: Block suspend while event queue is
	not empty.
Date: Sun, 25 Apr 2010 15:41:23 -0700
Message-ID: <j2id6200be21004251541z53ebce31rddb659680219c450@mail.gmail.com>
References: <201004250430.31054.rjw@sisk.pl>
	 <Pine.LNX.4.44L0.1004251122230.25835-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f178.google.com ([209.85.223.178]:36565 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138Ab0DYWlY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Apr 2010 18:41:24 -0400
In-Reply-To: <Pine.LNX.4.44L0.1004251122230.25835-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Randy Dunlap <randy.dunlap@oracle.com>, =?ISO-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-input@vger.kernel.org, Sven Neumann <s.neumann@raumfeld.com>, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-pm@lists.linux-foundation.org, Tero Saarni <tero.saarni@gmail.com>, Matthew Garrett <mjg@redhat.com>

On Sun, Apr 25, 2010 at 8:29 AM, Alan Stern <stern@rowland.harvard.edu>=
 wrote:
> On Sun, 25 Apr 2010, Rafael J. Wysocki wrote:
>
>> On Saturday 24 April 2010, Alan Stern wrote:
>> > On Fri, 23 Apr 2010, Arve Hj=F8nnev=E5g wrote:
>> >
>> > > On Fri, Apr 23, 2010 at 2:08 PM, Dmitry Torokhov
>> > > <dmitry.torokhov@gmail.com> wrote:
>> > > > On Friday 23 April 2010 01:56:25 pm Randy Dunlap wrote:
>> > > >> On Thu, 22 Apr 2010 18:08:57 -0700 Arve Hj=F8nnev=E5g wrote:
>> > > >> > Add an ioctl, EVIOCSSUSPENDBLOCK, to enable a suspend_block=
er that will
>> > > >> > block suspend while the event queue is not empty. This allo=
ws userspace
>> > > >> > code to process input events while the device appears to be=
 asleep.
>
>> > Is there some reason why this feature needs to be enabled by an
>> > ioctl? =A0Why not make this suspend blocker permanently enabled?
>>
>> The ioctl is there so that user space can use suspend blockers, whic=
h is
>> needed because only user space know that some activities are going t=
o continue
>> and therefore the system should not be suspended (like playing music=
 "in the
>> background").
>
> No, you're thinking of a different ioctl: SUSPEND_BLOCKER_IOCTL_BLOCK=
=2E
> This one (EVIOCSSUSPENDBLOCK) is present _only_ to enable one specifi=
c
> suspend blocker, which is activated when the input event queue is
> non-empty. =A0I don't see any reason why it shouldn't be enabled all =
the
> time.
>

Some user space processes keep input devices open that they don't
currently read from. The current android kernel use a wakelock with a
timeout limit the damage caused by this code, but not blocking suspend
at all by default will handle this case better. Also, not all input
devices are used for wakeup events, so there is no need to block
suspend when their event queue is not empty.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
