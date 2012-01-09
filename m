From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v8 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Mon, 9 Jan 2012 21:41:20 +0100
Message-ID: <CABxcv==QfPnXgBLjFLxQmpWRGRDPE11aP8xMGsMbh-dJBVtQjQ@mail.gmail.com>
References: <1325722586-12886-1-git-send-email-javier@dowhile0.org>
	<1325722586-12886-2-git-send-email-javier@dowhile0.org>
	<20120109173523.GA5613@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43304 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933151Ab2AIUlV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jan 2012 15:41:21 -0500
In-Reply-To: <20120109173523.GA5613@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 9, 2012 at 6:35 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
>
> Hi Javier,
>
> > Changes for v8:
> > =C2=A0 =C2=A0 Dmitry Torokhov (9):
> > =C2=A0 =C2=A0 - Fix use-after-free in cyttsp_release
> > =C2=A0 =C2=A0 - Remove ext() method from bus ops
> > =C2=A0 =C2=A0 - Move up into main touchscreen directory
> > =C2=A0 =C2=A0 - Rework Kconfig entries
> > =C2=A0 =C2=A0 - Guard PM methods with CONFIG_PM_SLEEP
> > =C2=A0 =C2=A0 - Device does not belong in bus structure
> > =C2=A0 =C2=A0 - Set up bus type in input device
> > =C2=A0 =C2=A0 - Use unified structure for ts object
> > =C2=A0 =C2=A0 - Consolidate PM methods
> >
> > =C2=A0 =C2=A0 Javier Martinez Canillas (5):
> > =C2=A0 =C2=A0 - Add <linux/device.h> macro to cyttsp_core.h
> > =C2=A0 =C2=A0 - Soft reset returns negative on error, not 0
> > =C2=A0 =C2=A0 - Use CY_NUM_RETRY instead of CY_DELAY_MAX for retrie=
s
> > =C2=A0 =C2=A0 - Add suspended an on boolean to cyttsp core
> > =C2=A0 =C2=A0 - Rework PM functions
>
> Looking a lot better now, thank you. Some tiny comments below.
>

Hi Henrik,

Your welcome. Thank you for the review and your patience.

> > +static int ttsp_read_block_data(struct cyttsp *ts, u8 command,
> > + =C2=A0 =C2=A0 u8 length, void *buf)
> > +{
> > + =C2=A0 =C2=A0 int retval =3D -1;
> > + =C2=A0 =C2=A0 int tries;
> > +
> > + =C2=A0 =C2=A0 if (!buf || !length)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> > +
> > + =C2=A0 =C2=A0 for (tries =3D 0; tries < CY_NUM_RETRY && (retval <=
 0); tries++) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D ts->bus_ops-=
>read(ts->dev, command, length, buf);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (retval)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 msleep(CY_DELAY_DFLT);
> > + =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 return retval;
> > +}
>
> Still wondering why (retval > 0) is handled the same way as (retval <=
 0).
>

Well, that is a convention followed in the driver. All the bus
specific read/write operations (I2C, SPI, etc) never return positive
numbers. They return 0 on success or the error value (retval < 0).

Changing that semantic could be a bit of a hassle since all the driver
assumes that behavior. But to be consistent with the rest of the
kernel and if that could be a reason to not merge the driver I can
rework that.

> > +static int cyttsp_bl_app_valid(struct cyttsp *ts)
> > +{
> > + =C2=A0 =C2=A0 int retval;
> > +
> > + =C2=A0 =C2=A0 retval =3D cyttsp_load_bl_regs(ts);
> > +
> > + =C2=A0 =C2=A0 if (retval < 0) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D -ENODEV;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto done;
> > + =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 if (GET_BOOTLOADERMODE(ts->bl_data.bl_status)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_VALID_APP(ts->bl=
_data.bl_status))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return 0;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -ENODEV;
> > + =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 if (GET_HSTMODE(ts->bl_data.bl_file) =3D=3D CY_OPER=
ATE_MODE) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(IS_OPERATIONAL_ER=
R(ts->bl_data.bl_status)))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return 1;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -ENODEV;
> > + =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 retval =3D -ENODEV;
> > +done:
> > + =C2=A0 =C2=A0 return retval;
>
> The function seems to always return ENODEV, something to simplify?
>

Actually, it returns 1 if the device is not in bootloader mode an
operational or 0 otherwise. But you are right, the function is kind of
a mess. I'll simplify this.

> > +static int cyttsp_set_sysinfo_mode(struct cyttsp *ts)
> > +{
> > + =C2=A0 =C2=A0 int retval;
> > + =C2=A0 =C2=A0 int tries;
> > + =C2=A0 =C2=A0 u8 cmd =3D CY_SYSINFO_MODE;
> > +
> > + =C2=A0 =C2=A0 memset(&(ts->sysinfo_data), 0, sizeof(struct cyttsp=
_sysinfo_data));
> > +
> > + =C2=A0 =C2=A0 /* switch to sysinfo mode */
> > + =C2=A0 =C2=A0 retval =3D ttsp_write_block_data(ts, CY_REG_BASE, s=
izeof(cmd), &cmd);
> > + =C2=A0 =C2=A0 if (retval < 0)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return retval;
> > +
> > + =C2=A0 =C2=A0 /* read sysinfo registers */
> > + =C2=A0 =C2=A0 tries =3D 0;
> > + =C2=A0 =C2=A0 do {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msleep(CY_DELAY_DFLT);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D ttsp_read_bl=
ock_data(ts, CY_REG_BASE,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sizeof(ts->sysinfo_data), &ts->sysinfo_data);
> > + =C2=A0 =C2=A0 } while ((retval || (!ts->sysinfo_data.tts_verh &&
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0!ts->sysinfo_data.tts_verl)) &&
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(tries++ < CY_NUM=
_RETRY));
> > +
> > + =C2=A0 =C2=A0 if (tries >=3D CY_NUM_RETRY)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EAGAIN;
>
> The loop above seems to appear many times in the code. Something to
> simplify?
>

Ok, will simplify this also.

> Thanks,
> Henrik

Thanks a lot and best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
