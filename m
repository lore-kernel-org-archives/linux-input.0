From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/mouse/elantech.c: Remove trackpoint related label
Date: Mon, 25 Jul 2016 11:35:41 -0700
Message-ID: <20160725183541.GG27415@dtor-ws>
References: <1469281960-27572-1-git-send-email-marcos.souza.org@gmail.com>
 <20160725095356.GI19383@mail.corp.redhat.com>
 <CAH0vN5J=hEJ0-BgTDUnRi0Jny34mAGxZ+V9pY3Jnx9uwjxaPKQ@mail.gmail.com>
 <20160725183332.GF27415@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36627 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638AbcGYSfo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 14:35:44 -0400
Received: by mail-pa0-f54.google.com with SMTP id pp5so63616621pac.3
        for <linux-input@vger.kernel.org>; Mon, 25 Jul 2016 11:35:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160725183332.GF27415@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Souza <marcos.souza.org@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ulrik De Bie <ulrik.debie-os@e2big.org>, Takashi Iwai <tiwai@suse.de>, Duson Lin <dusonlin@emc.com.tw>, "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN),
	linux-kernel@vger.kernel.org (open list)" <linux-input@vger.kernel.org>

On Mon, Jul 25, 2016 at 11:33:32AM -0700, Dmitry Torokhov wrote:
> On Mon, Jul 25, 2016 at 10:34:28AM +0000, Marcos Souza wrote:
> > Hi,
> > 
> > On Mon, Jul 25, 2016 at 6:54 AM Benjamin Tissoires <
> > benjamin.tissoires@redhat.com> wrote:
> > 
> > > Hi,
> > >
> > > On Jul 23 2016 or thereabouts, Marcos Paulo de Souza wrote:
> > > > by rearranging the code to release the trackpoint resource when some
> > > error
> > > > happens.
> > >
> > > Is there any advantage of doing so beside trying to remove one goto?
> > > Because if not, that's the kernel failure style and this is much better
> > > given that if somebody needs to add other commands after initializing the
> > > trackstick, and if those command fail, we can then remove the
> > > trackstick.
> > >
> > 
> > My only reason was to shrink the code a little, by removing a label used
> 
> Shrink executable code or source code? I do not see either of them
> shrinking, you have the same number of code lines and compiler is going
> to rearrange the instructions the way it sees fit anyway.

By the way, it looks like you are taking the addresses from
git_maitainer.pl but the output is "interesting" to say the least. You
have

"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN),
linux-kernel@vger.kernel.org (open list)" <linux-input@vger.kernel.org>

as one of the recipients while.

Thanks.

-- 
Dmitry
