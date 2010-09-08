From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/6] Large scancode handling
Date: Wed, 8 Sep 2010 11:48:50 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009081147540.26813@pobox.suse.cz>
References: <20100908073233.32365.74621.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100908073233.32365.74621.stgit@hammer.corenet.prv>
Sender: linux-media-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Linux Input <linux-input@vger.kernel.org>, linux-media@vger.kernel.org, Jarod Wilson <jarod@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, David Hardeman <david@hardeman.nu>, Ville Syrjala <syrjala@sci.fi>
List-Id: linux-input@vger.kernel.org

On Wed, 8 Sep 2010, Dmitry Torokhov wrote:

> Hi Mauro,
> 
> I guess I better get off my behind and commit the changes to support large
> scancodes, or they will not make to 2.6.37 either... There isn't much
> changes, except I followed David's suggestion and changed boolean index
> field into u8 flags field. Still, please glance it over once again and
> shout if you see something you do not like.
> 
> Jiri, how do you want to handle the changes to HID? I could either push
> them through my tree together with the first patch or you can push through
> yours once the first change hits mainline.

I think that there will unlikely be any conflict in .37 merge window in 
this area (and if there were, I'll sort it out).

So please add

	Acked-by: Jiri Kosina <jkosina@suse.cz>

to the hid-input.c bits and feel free to take it through your tree, if it 
is convenient for you.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
