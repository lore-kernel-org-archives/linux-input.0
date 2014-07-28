From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: wacom: Support up to 2048 pressure levels
 with ISDv4
Date: Mon, 28 Jul 2014 11:00:40 -0700
Message-ID: <20140728180040.GA29714@core.coreip.homeip.net>
References: <1404164806-5141-1-git-send-email-killertofu@gmail.com>
 <CANRwn3TSsZMvGU1Oj1iu2a24JKxXfa2fsk8236fj7ek7TgEWeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:41486 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbaG1SAo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jul 2014 14:00:44 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so10362667pdb.27
        for <linux-input@vger.kernel.org>; Mon, 28 Jul 2014 11:00:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANRwn3TSsZMvGU1Oj1iu2a24JKxXfa2fsk8236fj7ek7TgEWeg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>

On Fri, Jul 18, 2014 at 04:12:21PM -0700, Jason Gerecke wrote:
> On Mon, Jun 30, 2014 at 2:46 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> > Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> > ---
> >  drivers/input/tablet/wacom_wac.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> > index 977d05c..61a45a5 100644
> > --- a/drivers/input/tablet/wacom_wac.c
> > +++ b/drivers/input/tablet/wacom_wac.c
> > @@ -1093,7 +1093,7 @@ static int wacom_tpc_pen(struct wacom_wac *wacom)
> >                 input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
> >                 input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&data[2]));
> >                 input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&data[4]));
> > -               input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x03) << 8) | data[6]);
> > +               input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x07) << 8) | data[6]);
> >                 input_report_key(input, BTN_TOUCH, data[1] & 0x05);
> >                 input_report_key(input, wacom->tool[0], prox);
> >                 return 1;
> > --
> > 2.0.0
> >
> 
> Just making sure these two patches don't get lost in all the work
> Benjamin's doing. They're going to conflict, so depending on the
> timeline for merging his patches, we can either push these up now(ish)
> or I'll rebase afterwards.

Benjamin added the first one to his series and I adjusted the 2nd one to
apply on top of his and applied.

Thanks.

-- 
Dmitry
