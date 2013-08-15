From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input: htcpen - Fix incorrect placement of __initdata
Date: Wed, 14 Aug 2013 23:51:38 -0700
Message-ID: <20130815065138.GA15374@core.coreip.homeip.net>
References: <1375868346-28851-1-git-send-email-sachin.kamat@linaro.org>
 <CAK9yfHy-Q8W=0ujnnMmspsSJuwJeH-GMpOky+_GkPXf14mHK5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:65221 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922Ab3HOGvk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Aug 2013 02:51:40 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so464021pab.35
        for <linux-input@vger.kernel.org>; Wed, 14 Aug 2013 23:51:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAK9yfHy-Q8W=0ujnnMmspsSJuwJeH-GMpOky+_GkPXf14mHK5w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Pau Oliva Fora <pau@eslack.org>

Hi Sachin,

On Wed, Aug 14, 2013 at 11:55:22AM +0530, Sachin Kamat wrote:
> Hi Dmitry,
> 
> On 7 August 2013 15:09, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> > __initdata should be placed between the variable name and equal
> > sign for the variable to be placed in the intended section.
> >
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > Cc: Pau Oliva Fora <pau@eslack.org>
> > ---
> >  drivers/input/touchscreen/htcpen.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/touchscreen/htcpen.c b/drivers/input/touchscreen/htcpen.c
> > index 6c4fb84..6650085 100644
> > --- a/drivers/input/touchscreen/htcpen.c
> > +++ b/drivers/input/touchscreen/htcpen.c
> > @@ -221,7 +221,7 @@ static struct isa_driver htcpen_isa_driver = {
> >         }
> >  };
> >
> > -static struct dmi_system_id __initdata htcshift_dmi_table[] = {
> > +static struct dmi_system_id htcshift_dmi_table[] __initdata = {
> >         {
> >                 .ident = "Shift",
> >                 .matches = {
> > --
> > 1.7.9.5
> >
> 
> Thanks for applying my other patches. Looks like you missed this one though :)

Got it now, thanks.

-- 
Dmitry
