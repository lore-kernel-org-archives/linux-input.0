From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Recover from failed recalibration for OLPC touchpad
Date: Sat, 20 Dec 2008 02:49:45 -0800
Message-ID: <200812200249.45956.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:23233 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbYLTKuH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Dec 2008 05:50:07 -0500
Received: by yw-out-2324.google.com with SMTP id 9so496613ywe.1
        for <linux-input@vger.kernel.org>; Sat, 20 Dec 2008 02:50:06 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: pgf@laptop.org
Cc: Andres Salomon <dilinger@queued.net>, dsaxena@laptop.org, linux-input@vger.kernel.org

On Tuesday 16 December 2008 13:00:18 pgf@laptop.org wrote:
> andres wrote:
>  > On Tue, 16 Dec 2008 11:45:09 -0800
>  >
>  > Deepak Saxena <dsaxena@laptop.org> wrote:
>  > > Sometimes the the HPGK touchpad will fail to properly respond
>  > > to a ps2_command() during recalibration. This patch works around
>  > > that issue be scheduling another recalibration if this happens.
>  > >
>  > > This solves http://dev.laptop.org/ticket/9008
>  >
>  > The bug lacks details regarding testing, see below.
>  >
>  > > Signed-off-by: Paul Fox <pgf@laptop.org>
>  > > Signed-off-by: Deepak Saxena <dsaxena@laptop.org>
>  > > ---
>  > >  drivers/input/mouse/hgpk.c |    9 ++++++++-
>  > >  1 files changed, 8 insertions(+), 1 deletions(-)
>  > >
>  > > diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
>  > > index 39cce65..9548e1c 100644
>  > > --- a/drivers/input/mouse/hgpk.c
>  > > +++ b/drivers/input/mouse/hgpk.c
>  > > @@ -233,6 +233,9 @@ static int hgpk_force_recalibrate(struct psmouse
>  > > *psmouse) ps2_command(ps2dev, NULL, 0xf5) ||
>  > >  	    ps2_command(ps2dev, NULL, 0xe6) ||
>  > >  	    ps2_command(ps2dev, NULL, 0xf5)) {
>  > > + 		psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
>  > > + 		psmouse_queue_work(psmouse, &priv->recalib_wq,
>  > > +				   msecs_to_jiffies(500));
>  > >  		return -1;
>  > >  	}
>  >
>  > Do we know why the ps2 commands are failing?  Do we really want to keep
>  > trying to recalibrate if something's screwy with ps2, rather than (say)
>  > completely reinitializing the driver?
>  >
>  > Paul, did you manage to reproduce the problem with this patch applied?
>
> i used to see this problem regularly (the mouse simply stops working),
> and could reproduce it readily.  i was not able to reproduce it after
> applying the fix.
>
> (that being said, i didn't look into why the ps2 commands were failing.)
>

I am not comfortable with the idea of endlessly recalibrating if device gets 
really screwy. I'd rather see a patch that did that 3-5 times and then issued 
complete reinitialization.

Thanks.

-- 
Dmitry

