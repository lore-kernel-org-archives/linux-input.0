From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or
 elevated privileges
Date: Mon, 19 Nov 2018 14:26:11 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1811191425280.21108@cbobk.fhfr.pm>
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com> <20181114215509.163600-1-ebiggers@kernel.org> <nycvar.YFH.7.76.1811191351020.21108@cbobk.fhfr.pm> <CANq1E4QDP9EiJZG2pqfKtA_ESoBgNb5ECjause2tTUdYWaqYZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CANq1E4QDP9EiJZG2pqfKtA_ESoBgNb5ECjause2tTUdYWaqYZA@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: ebiggers@kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, Dmitry Torokhov <dtor@google.com>, syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com, stable <stable@vger.kernel.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, 19 Nov 2018, David Herrmann wrote:

> > Thanks for the patch. I however believe the fix below is more generic, and
> > would prefer taking that one in case noone sees any major flaw in that
> > I've overlooked. Thanks.
> 
> As Andy rightly pointed out, the credentials check is actually needed.
> The scenario here is using a uhid-fd as stdout when executing a
> setuid-program. This will possibly end up reading arbitrary memory
> from the setuid program and use it as input for the hid-descriptor.

Ah, right, that's a very good point indeed; I've overlooked that (valid) 
concern in the thread. Thanks for spotting that, Andy.

I've now applied Eric's patch. Thanks everybody,

-- 
Jiri Kosina
SUSE Labs
