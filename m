From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: linux-next: Tree for Mar 6 (hid)
Date: Thu, 7 Mar 2013 11:33:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1303071130520.28677@pobox.suse.cz>
References: <20130306115052.2b1969acb7b7a0fa35975984@canb.auug.org.au> <51379849.6040903@infradead.org> <CAN+gG=H4_1nUhhsUe031Q1QrnVna+F7hmAepe6kbNm=8z_gOjw@mail.gmail.com> <alpine.LNX.2.00.1303071108150.28677@pobox.suse.cz>
 <CAN+gG=HhatpiPWUJ72Pr45odtcM6AJ5broNVrQ_=dF5AU6TEig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <CAN+gG=HhatpiPWUJ72Pr45odtcM6AJ5broNVrQ_=dF5AU6TEig@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 7 Mar 2013, Benjamin Tissoires wrote:

> You should have at least one other patch for hid-mt:
> https://patchwork.kernel.org/patch/2193641/

Ah, right, that one is in my queue as well, sorry for not mentioning it in 
my previous post.

That doesn't remove the direct call either though.

> And I sent as a RFC the patch I was talking about:
> https://patchwork.kernel.org/patch/2193801/
> https://patchwork.kernel.org/patch/2193821/
> 
> These two RFCs have been reviewed by David Herrmann, so maybe we can
> include them in their current form as no one else complained about it
> ( maybe you will :) ).

For some reason these two vanished between the cracks of my mailbox. 
Thanks for pointing those out, I will process them today and either apply 
it, or fix it for -next by adding a config dependency.

-- 
Jiri Kosina
SUSE Labs
