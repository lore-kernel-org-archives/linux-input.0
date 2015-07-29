From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [patch] HID: uclogic: fix limit in uclogic_tablet_enable()
Date: Wed, 29 Jul 2015 14:07:39 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507291407100.925@pobox.suse.cz>
References: <20150729101606.GA12100@mwanda> <55B8AAA7.6010708@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <55B8AAA7.6010708@gmail.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 29 Jul 2015, Nikolai Kondrashov wrote:

> On 07/29/2015 01:16 PM, Dan Carpenter wrote:
> > The limit should be ARRAY_SIZE(params) (5 elements) here instead of
> > sizeof(params) (20 bytes).
> > 
> > Fixes: 08177f40bd00 ('HID: uclogic: merge hid-huion driver in hid-uclogic')
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
> > index 9416731..b905d50 100644
> > --- a/drivers/hid/hid-uclogic.c
> > +++ b/drivers/hid/hid-uclogic.c
> > @@ -858,7 +858,7 @@ static int uclogic_tablet_enable(struct hid_device
> > *hdev)
> >   	for (p = drvdata->rdesc;
> >   	     p <= drvdata->rdesc + drvdata->rsize - 4;) {
> >   		if (p[0] == 0xFE && p[1] == 0xED && p[2] == 0x1D &&
> > -		    p[3] < sizeof(params)) {
> > +		    p[3] < ARRAY_SIZE(params)) {
> >   			v = params[p[3]];
> >   			put_unaligned(cpu_to_le32(v), (s32 *)p);
> >   			p += 4;
> 
> Argh, that's embarrassing. Thanks, Dan!

Good catch Dan, thanks. Applied to for-4.2/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs
