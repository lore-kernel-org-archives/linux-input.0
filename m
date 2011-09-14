From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH V2 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Thu, 15 Sep 2011 00:32:58 +0200
Message-ID: <CAAwP0s1A4EMOBYTeEVg2WFYKnf6e+LfU2Sg_wwf7TLtjqXZBXQ@mail.gmail.com>
References: <1315029042-27513-1-git-send-email-martinez.javier@gmail.com>
 <1315029042-27513-2-git-send-email-martinez.javier@gmail.com> <4E7086F0.8050009@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f52.google.com ([74.125.83.52]:63884 "EHLO
	mail-gw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab1INWdN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Sep 2011 18:33:13 -0400
In-Reply-To: <4E7086F0.8050009@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mohan Pallaka <mpallaka@codeaurora.org>
Cc: Kevin McNeely <kev@cypress.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 14, 2011 at 12:50 PM, Mohan Pallaka <mpallaka@codeaurora.or=
g> wrote:
> =C2=A0Hi Javier,
>
> Please find my review comments.
>

Hello Mohan,

Thank you very much for the review and your comments.

> On 9/3/2011 11:20 AM, Javier Martinez Canillas wrote:
>> +
>> +struct cyttsp {
>> + =C2=A0 =C2=A0 =C2=A0 struct device *dev;
>> + =C2=A0 =C2=A0 =C2=A0 int irq;
>> + =C2=A0 =C2=A0 =C2=A0 struct input_dev *input;
>> + =C2=A0 =C2=A0 =C2=A0 char phys[32];
>> + =C2=A0 =C2=A0 =C2=A0 const struct bus_type *bus_type;
>
> Do we need to know the bus type? Rest of the code doesn't seem to
> be using this information.

You are right, will remove it.

>> +
>> +static int ttsp_write_block_data(struct cyttsp *ts, u8 command,
>> + =C2=A0 =C2=A0 =C2=A0 u8 length, void *buf)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 int retval;
>> + =C2=A0 =C2=A0 =C2=A0 if (!buf || !length)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 retval =3D ts->bus_ops->write(ts->bus_ops, co=
mmand, length, buf);
>> + =C2=A0 =C2=A0 =C2=A0 if (retval)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msleep(CY_DELAY_D=
=46LT);
>
> Don't we need to retry if write fails?

Yes, I'll add the retry logic also to ttsp_write_block_data().

>> +
>> +static int cyttsp_set_operational_mode(struct cyttsp *ts)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp_xydata xy_data;
>> + =C2=A0 =C2=A0 =C2=A0 int retval;
>> + =C2=A0 =C2=A0 =C2=A0 int tries;
>> + =C2=A0 =C2=A0 =C2=A0 u8 cmd =3D CY_OPERATE_MODE;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 retval =3D ttsp_write_block_data(ts, CY_REG_B=
ASE, sizeof(cmd),&cmd);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (retval< =C2=A00)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return retval;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* wait for TTSP Device to complete switch to=
 Operational mode */
>> + =C2=A0 =C2=A0 =C2=A0 tries =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 do {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msleep(CY_DELAY_D=
=46LT);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D ttsp_r=
ead_block_data(ts, CY_REG_BASE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sizeof(xy_data),&(xy_data));
>> + =C2=A0 =C2=A0 =C2=A0 } while (!((retval =3D=3D 0)&&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (xy_data.act_dist=
 =3D=3D CY_ACT_DIST_DFLT))&&
>
> what is the need for this check,"xy_data.act_dist =3D=3D CY_ACT_DIST_=
DFLT"?
> we can pass a different value for act_dist from pdata. Another point =
to
> concerns me
> is that in case of i2c/spi failures "ttsp_read_block_data" will it se=
lf try
> for NUM_TRY
> and this particular code block tries till CY_DELAY_MAX, I think we ar=
e
> overdoing
> in this case. =C2=A0How about keeping the "ttsp_read_block_dat" simpl=
e and let
> the
> code that uses do the retry job.

Yes, there are too many msleep() and retry here, will clean this code
and let ttsp_read_block_data() do the retry.

>> +
>> +static irqreturn_t cyttsp_irq(int irq, void *handle)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp *ts =3D handle;
>> + =C2=A0 =C2=A0 =C2=A0 int retval;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (ts->power_state =3D=3D CY_BL_STATE)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 complete(&ts->bl_=
ready);
>> + =C2=A0 =C2=A0 =C2=A0 else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* process the to=
uches */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D cyttsp=
_xy_worker(ts);
>
> can we have a different name than cyttsp_xy_worker as we can misinter=
pret as
> a workqueue,
> like cyttsp_handle_tchdata. Also, we seem to be doing good amount of =
work in
> this function,
> how about deferring it to a workqueue to make irq handler fast to not=
 to
> miss any irqs.

Yes, your are right worker sounds like a workqueue. Will change the
name of the handler function.

Well cyttsp_xy_worker() is calling from cyttsp_irq() which is
initialized has a threaded irq with request_threaded_irq(). I thought
it was the way to go for new drivers, isn't using a workqueue inside a
threaded irq overkill?

>> +
>> +#ifdef CONFIG_PM
>> +int cyttsp_resume(void *handle)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp *ts =3D handle;
>
> "handle" is passed from a different path, so it is possible to be a "=
NULL"
> which
> could crash the machine. so I think we can have an extra check here l=
ike you
> did for core_release.

Ok, will add the check.

>>
>> + =C2=A0 =C2=A0 =C2=A0 int retval =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp_xydata xydata;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (ts->platform_data->use_sleep&& =C2=A0(ts-=
>power_state !=3D
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CY_ACTIVE_STATE))=
 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ts->platform_=
data->wakeup) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 retval =3D ts->platform_data->wakeup();
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (retval< =C2=A00)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(ts->dev, "%s: Error, wak=
eup
>> failed!\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __fu=
nc__);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev_dbg(ts->dev, "%s: Error, wakeup not
>> implemented "
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "(check board file).\n", __func_=
_);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 retval =3D -ENOSYS;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(retval< =C2=
=A00)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 retval =3D ttsp_read_block_data(ts, CY_REG_BASE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(xydata),&xydata);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (!(retval< =C2=A00)&&
>> =C2=A0!GET_HSTMODE(xydata.hst_mode))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->power_state =3D CY_ACTIVE_ST=
ATE;
>
> I think we need to have a error msg when it fails to resume. Also, sa=
y after
> resume if it goes to
> "bootloader"(which happens when the chip is reset) mode then touch wi=
ll not
> work. So, we
> can get it out of the bootloader mode in cyttsp_xy_worker as interrup=
ts are
> fired even in bootloader
> mode.

Yes, will add the error msg and add the logic in the irq handler to go
out from bootloader mode.

>> +
>> +int cyttsp_suspend(void *handle)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct cyttsp *ts =3D handle;
>> + =C2=A0 =C2=A0 =C2=A0 u8 sleep_mode =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 int retval =3D 0;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (ts->platform_data->use_sleep&&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ts->power_state =
=3D=3D CY_ACTIVE_STATE)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep_mode =3D CY=
_DEEP_SLEEP_MODE;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D ttsp_w=
rite_block_data(ts,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 CY_REG_BASE, sizeof(sleep_mode),&sleep_mode);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(retval< =C2=
=A00))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ts->power_state =3D CY_SLEEP_STATE;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 dev_dbg(ts->dev, "%s: Sleep Power state is %s=
\n", __func__,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ts->power_state =
=3D=3D CY_ACTIVE_STATE) ?
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "ACTIVE" :
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((ts->power_state=
 =3D=3D CY_SLEEP_STATE) ?
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "SLEEP" : "LOW PO=
WER"));
>
> This code will not let the chip to go to low power mode since we are =
setting
> CY_DEEP_SLEEP_MODE directly. So, lets use platform_data's "use_sleep"=
 flag
> to
> determine if we want to go to deep sleep or low power mode.

Ok, will change to check platform_data's to take the decision.


>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (input_register_device(input_device)) {
>
> Please avoid this style of check, we will not know why it is failed.

Ok, will get the error value to know what happened.

>>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(ts->dev, =
"%s: Error, failed to register input
>> device\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 __func__);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_input_=
register_device;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 goto no_error;
>> +
>> +error_input_register_device:
>> + =C2=A0 =C2=A0 =C2=A0 input_unregister_device(input_device);
>
> Here we should use input_free_device() rather than unregister since i=
t
> failed in
> registration.

Ok, will use input_free_device() instead.

>
> --Mohan.
>
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum.
>
>
>

Again, thank you very much for taking the time to look at the code and
for your suggestions. Will work on this and resend.

Best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
