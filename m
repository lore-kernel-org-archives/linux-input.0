From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 3/7] input: atmel_mxt_ts: check mxt224 family before
 writing touchscreen voltage
Date: Wed, 20 Feb 2013 23:22:13 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1302202315330.18013@pmeerw.net>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net> <1360246668-2291-4-git-send-email-pmeerw@pmeerw.net> <CANLzEktvtNQZvfeJ19U4=ah4tN5EigQvs-e+bNF_24NJrhxsSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48466 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255Ab3BTWWP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Feb 2013 17:22:15 -0500
In-Reply-To: <CANLzEktvtNQZvfeJ19U4=ah4tN5EigQvs-e+bNF_24NJrhxsSw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benson Leung <bleung@chromium.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, y0922.shim@samsung.com, Yufeng Shen <miletus@chromium.org>

Hello Benson,

> Is the problem that the 224e is missing T28 object?
> This change seems extremely 224/224e specific. This driver, however,
> supports Atmel touch devices that are neither 224 or 224e, many have
> the  SPT_CTECONFIG_T28 object.

yes, I only have access to 224 and 224e; it is not clear what devices are 
supposed to be supported

> The driver does read out a supported object table from the device
> during initialize before handle_pdata. What sort of problem is there
> in trying to write the voltage to a non existent T28 object?  If the
> object is missing, then mxt_write_object for voltage should simply
> return -EINVAL, and no harm should be done.

a bogus error message is written, 'Invalid object type' in 
mxt_get_object()

> On Thu, Feb 7, 2013 at 6:17 AM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
> > From: Peter Meerwald <p.meerwald@bct-electronic.com>
> >
> > only the mxt224 has a SPT_CTECONFIG_T28 object, the mxt224e doesn't
> >
> > Signed-off-by: Peter Meerwald <p.meerwald@bct-electronic.com>
> > ---
> >  drivers/input/touchscreen/atmel_mxt_ts.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> > index 63a82bb..17cc15a 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -41,6 +41,10 @@
> >  #define MXT_OBJECT_NUM         0x06
> >  #define MXT_OBJECT_START       0x07
> >
> > +/* Family IDs */
> > +#define MXT224_ID      0x80
> > +#define MXT224E_ID     0x81
> > +
> >  #define MXT_OBJECT_SIZE                6
> >
> >  /* Object types */
> > @@ -687,7 +691,7 @@ static void mxt_handle_pdata(struct mxt_data *data)
> >                         MXT_TOUCH_YRANGE_MSB, (pdata->y_size - 1) >> 8);
> >
> >         /* Set touchscreen voltage */
> > -       if (pdata->voltage) {
> > +       if (pdata->voltage && data->info.family_id == MXT224_ID) {
> As an alternative, could you not check for the existence of the
> voltage object in the table here using mxt_get_object rather than
> specifically switching on family ID number?

yes, I think that is a good suggestion

> >                 if (pdata->voltage < MXT_VOLTAGE_DEFAULT) {
> >                         voltage = (MXT_VOLTAGE_DEFAULT - pdata->voltage) /
> >                                 MXT_VOLTAGE_STEP;

regards, p. 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
