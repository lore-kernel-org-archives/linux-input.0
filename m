From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: wacom: Add support for 0x116 sensor on Win8
 Panasonic CF-H2
Date: Wed, 14 May 2014 11:47:16 -0700
Message-ID: <20140514184716.GI30089@core.coreip.homeip.net>
References: <1399685417-2063-1-git-send-email-killertofu@gmail.com>
 <CAF8JNhLNR3STcRcQumUN1SchreX=kVPGA5BSpGm5PH15rMV9Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50523 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbaENSrS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 May 2014 14:47:18 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so2033116pbb.19
        for <linux-input@vger.kernel.org>; Wed, 14 May 2014 11:47:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF8JNhLNR3STcRcQumUN1SchreX=kVPGA5BSpGm5PH15rMV9Pg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Wed, May 14, 2014 at 11:27:27AM -0700, Ping Cheng wrote:
> On Fri, May 9, 2014 at 6:30 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> > The Win8 version of the Panasonic CF-H2 includes a new Wacom device.
> > The pen interface appears to use the same protocol as before, but the
> > touch interface has been tweaked to send Win8-compatible reports.
> >
> > Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> > ---
> >  drivers/input/tablet/wacom_wac.c | 8 ++++++++
> >  drivers/input/tablet/wacom_wac.h | 1 +
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> > index a4d8f1d..e4566c3 100644
> > --- a/drivers/input/tablet/wacom_wac.c
> > +++ b/drivers/input/tablet/wacom_wac.c
> > @@ -1107,6 +1107,10 @@ static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t len)
> >                         prox = data[0] & 0x01;
> >                         x = get_unaligned_le16(&data[1]);
> >                         y = get_unaligned_le16(&data[3]);
> > +               } else if (len == WACOM_PKGLEN_TPC1FG_B) {
> > +                       prox = data[2] & 0x01;
> > +                       x = le16_to_cpup((__le16 *)&data[3]);
> > +                       y = le16_to_cpup((__le16 *)&data[5]);
> 
> Above two lines should use get_unaligned_le16() instead.
> wacom_mt_touch() needs some cleanup too.
> 
> Except that, the whole patchset looks good to me.
> 
> Reviewed-by: Ping Cheng <pingc@wacom.com>

I changed le16_to_cpup to get_unaligned_le16 locally and applied, thank
you.

-- 
Dmitry
