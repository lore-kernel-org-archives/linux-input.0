From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hid-input: Add eraser usage to
 hidinput_configure_usage
Date: Mon, 2 Oct 2017 13:41:36 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710021340210.17517@jbgna.fhfr.qr>
References: <20170921223706.3289-1-ping.cheng@wacom.com> <CAKdAkRTgag2OcLVHDzdYD6zLxHuzg-TitWb+EjTVS1fojfZ02w@mail.gmail.com> <CAF8JNhJ3=-uP0Q_FxvLnj-evubBovRttX6F8jTG50aEqwJV80w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60738 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750949AbdJBLlj (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 2 Oct 2017 07:41:39 -0400
In-Reply-To: <CAF8JNhJ3=-uP0Q_FxvLnj-evubBovRttX6F8jTG50aEqwJV80w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Takeuchi, Toshiki" <toshiki.takeuchi@wacom.com>, Jason Gerecke <killertofu@gmail.com>, Ping Cheng <ping.cheng@wacom.com>

On Fri, 22 Sep 2017, Ping Cheng wrote:

> > > Some tablets report eraser usage to indicate the eraser tool. But,
> > > hidinput_configure_usage doesn't support it, which led the usage
> > > falls into default as ABS_MISC.
> > >
> > > Signed-off-by: Ping Cheng <ping.cheng@wacom.com <javascript:;>>
> > > ---
> > >  drivers/hid/hid-input.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > > index 199f6a01fc62..4d36b08494fd 100644
> > > --- a/drivers/hid/hid-input.c
> > > +++ b/drivers/hid/hid-input.c
> > > @@ -797,6 +797,10 @@ static void hidinput_configure_usage(struct
> > hid_input *hidinput, struct hid_fiel
> > >                         map_key_clear(BTN_STYLUS);
> > >                         break;
> > >
> > > +               case 0x45: /* ERASER */
> > > +                       map_key_clear(BTN_TOUCH);
> >
> > Surely you mean BTN_TOOL_RUBBER?
> 
> 
> No, I meant BTN_TOUCH since INVERT usage decides if an eraser is in
> proximity and send BTN_TOOL_RUBBER bit. Eraser usage means it is actually
> touching the device.

The reasoning makes sense, but it is indeed confusing, so I believe a 
small comment explaining it would be appropriate. Could you please add it 
and resend?

Thanks,

-- 
Jiri Kosina
SUSE Labs

