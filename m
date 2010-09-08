From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/6] Large scancode handling
Date: Wed, 8 Sep 2010 17:25:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009081723400.26813@pobox.suse.cz>
References: <20100908073233.32365.74621.stgit@hammer.corenet.prv> <alpine.LNX.2.00.1009081147540.26813@pobox.suse.cz> <20100908142418.GC22323@redhat.com> <4C87A87A.4060102@redhat.com> <20100908152234.GE22323@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100908152234.GE22323@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: Jarod Wilson <jarod@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, linux-media@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>, David Hardeman <david@hardeman.nu>, Ville Syrjala <syrjala@sci.fi>
List-Id: linux-input@vger.kernel.org

On Wed, 8 Sep 2010, Jarod Wilson wrote:

> > > It'll conflict a little bith with the tivo slide patch I posted yesterday,
> > > but mostly just minor context changes. I can redo that patch on top of
> > > these changes if that's preferred.
> > 
> > I can handle those context changes when merging the patches at linux-next and
> > when merging upstream. We just need to sync in a way that Dmitry send his patch
> > series before mine when sending them to Linus, and I'll take care of fixing the
> > merge conflicts.
> 
> Ah, the specific conflicts I was referring here are confined to
> drivers/hid/hid-input.c, and I sent the patch thinking it would go in via
> the hid tree. It *is* for a remote, but its a pure HID device in this
> case.

Umm, what patch are you talking about please? I don't seem to have 
anything from you in my queue.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
