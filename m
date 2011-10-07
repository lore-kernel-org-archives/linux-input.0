From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v4 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Sat, 8 Oct 2011 00:15:23 +0200
Message-ID: <CAAwP0s2TMpjh13PAocepLDy7zE32+q7uHBNAedcYwXGhXi4x+Q@mail.gmail.com>
References: <1317849965-18557-1-git-send-email-martinez.javier@gmail.com>
 <1317849965-18557-2-git-send-email-martinez.javier@gmail.com> <20111007115555.GA2199@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58458 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364Ab1JGWPn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2011 18:15:43 -0400
Received: by ywb5 with SMTP id 5so4059659ywb.19
        for <linux-input@vger.kernel.org>; Fri, 07 Oct 2011 15:15:43 -0700 (PDT)
In-Reply-To: <20111007115555.GA2199@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, linux-input@vger.kernel.org

On Fri, Oct 7, 2011 at 1:55 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> Hi Javier,
>
> thanks for the changes. Some general comments below, but the MT
> implementation looks good now.
>

Hi Henrik,

Your welcome, thank you for reviewing.

Good to know that the MT implementation looks good to you now.

>> Cypress TrueTouch(tm) Standard Product controllers are found in
>> a wide range of embedded devices. This driver add support for a
>> variety of TTSP controllers.
>>
>> The driver is composed of a core driver that process the data sent b=
y
>> the contacts and a set of bus specific interface modules. This patch
>> adds the base core TTSP driver.
>>
>> The original author of the driver is Kevin McNeely <kev@cypress.com>
>>
>> Since the hardware is capable of tracking identifiable contacts and =
the
>> original driver used multi-touch protocol type A (stateless), multi-=
touch
>> protocol type B (stateful) support was added by Javier Martinez Cani=
llas.
>>
>> Signed-off-by: Javier Martinez Canillas <martinez.javier@gmail.com>
>> ---
>>
>> v2: Fix issues called out by Dmitry Torokhov
>> =C2=A0 =C2=A0 =C2=A0- Add msleep() delays between retries for read a=
nd write operations
>> =C2=A0 =C2=A0 =C2=A0- Change cyttsp_core_init() to receive the IRQ f=
rom the client data
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0instead of obtaining from the platform_da=
ta
>>
>> v3: Fix issues called out by Henrik Rydberg and Mohan Pallaka
>> =C2=A0 =C2=A0 - Map each possible track id to a multitouch input slo=
t
>> =C2=A0 =C2=A0 - Remove bus type info since it is not used
>> =C2=A0 =C2=A0 - Add retry logic to ttsp_write_block_data()
>> =C2=A0 =C2=A0 - ttsp_read_block_data() already msleep() remove the s=
leep in the caller
>> =C2=A0 =C2=A0 - cyttsp_xy_worker() sounds as if it's a workqueue, ch=
ange the function name
>> =C2=A0 =C2=A0 - Check if handle is NULL in cyttsp_resume()
>> =C2=A0 =C2=A0 - Use platform data's use_sleep to decide to go deep s=
leep or low power mode
>> =C2=A0 =C2=A0 - input_register_device() error path has to call input=
_free_device()
>>
>> v4: Fix issues called out by Henrik Rydberg
>> =C2=A0 =C2=A0 - Remove unnecesary code and cleanup contact handler s=
ince input core is able
>> =C2=A0 =C2=A0 =C2=A0 to detect duplicates
>>
>> +
>> +static int ttsp_read_block_data(struct cyttsp *ts, u8 command,
>> + =C2=A0 =C2=A0 u8 length, void *buf)
>> +{
>> + =C2=A0 =C2=A0 int retval;
>> + =C2=A0 =C2=A0 int tries;
>> +
>> + =C2=A0 =C2=A0 if (!buf || !length)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>> +
>> + =C2=A0 =C2=A0 for (tries =3D 0, retval =3D -1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tries < CY_NUM_RETRY && (retval =
< 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tries++) {
>
> Possible to use less than three lines here?
>

Yes it is, the retval =3D -1 doesn't make to much sense since it can be
set at variable declaration.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D ts->bus_ops->=
read(ts->bus_ops, command, length, buf);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (retval)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 msleep(CY_DELAY_DFLT);
>
> The loop breaks on retval < 0, but delays on retval - is a) the delay
> on retval < 0 really necessary, and b) is there an assumption that
> retval > 0 all mean retry?
>

Every bus_ops->read function (I2C, SPI, etc) returns 0 on success and
propagate the corresponding error otherwise. So retval >=3D 0 is what
breaks the loop not retval < 0. The delay on retval < 0 is to wait
some miliseconds and retry the operations a few times (CY_NUM_RETRY)
before desist.

In early versions of the patch each bus read and write function
implemented the retry logic so moving to the core read/write
operations made sense to remove duplicate code.

>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 return retval;
>> +}
>> +
>> +static int ttsp_write_block_data(struct cyttsp *ts, u8 command,
>> + =C2=A0 =C2=A0 u8 length, void *buf)
>> +{
>> + =C2=A0 =C2=A0 int retval;
>> + =C2=A0 =C2=A0 int tries;
>> +
>> + =C2=A0 =C2=A0 if (!buf || !length)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>> +
>> + =C2=A0 =C2=A0 for (tries =3D 0, retval =3D -1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tries < CY_NUM_RETRY && (retval =
< 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tries++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D ts->bus_ops->=
write(ts->bus_ops, command, length, buf);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (retval)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 msleep(CY_DELAY_DFLT);
>> + =C2=A0 =C2=A0 }
>
> Ditto.
>

Same here retval < 0 indicates an error so retval =3D=3D 0 breaks the
loop, will clean the for so it uses one line instead of three.

>> +
>> + =C2=A0 =C2=A0 return retval;
>> +}
>> +
>> +static int ttsp_tch_ext(struct cyttsp *ts, void *buf)
>> +{
>> + =C2=A0 =C2=A0 int retval;
>> +
>> + =C2=A0 =C2=A0 if (!buf)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;
>> +
>> + =C2=A0 =C2=A0 retval =3D ts->bus_ops->ext(ts->bus_ops, buf);
>> +
>> + =C2=A0 =C2=A0 return retval;
>> +}
>
> Seems this could be simplified or even removed.
>

Yes, the core was thought to handle touch extended information but is
not used so I will remove this.

>> +
>> +static int cyttsp_load_bl_regs(struct cyttsp *ts)
>> +{
>> + =C2=A0 =C2=A0 int retval;
>> +
>> + =C2=A0 =C2=A0 memset(&(ts->bl_data), 0, sizeof(struct cyttsp_bootl=
oader_data));
>> +
>> + =C2=A0 =C2=A0 retval =3D =C2=A0ttsp_read_block_data(ts, CY_REG_BAS=
E,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(ts->bl_data), &(t=
s->bl_data));
>> +
>> + =C2=A0 =C2=A0 return retval;
>> +}
>
> Ditto.
>

This function is used to get the bootloader data from the device when
it is open and for exiting the bootloader.

>> +
>> +static int cyttsp_bl_app_valid(struct cyttsp *ts)
>> +{
>> + =C2=A0 =C2=A0 int retval;
>> +
>> + =C2=A0 =C2=A0 retval =3D cyttsp_load_bl_regs(ts);
>> +
>> + =C2=A0 =C2=A0 if (retval < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>> +
>> + =C2=A0 =C2=A0 if (GET_BOOTLOADERMODE(ts->bl_data.bl_status)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_VALID_APP(ts->bl_=
data.bl_status)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_dbg(ts->dev, "%s: App found; normal boot\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_dbg(ts->dev, "%s: NO APP; load firmware!!\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -ENODEV;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 } else if (GET_HSTMODE(ts->bl_data.bl_file) =3D=3D C=
Y_OPERATE_MODE) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(IS_OPERATIONAL_ERR=
(ts->bl_data.bl_status))) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_dbg(ts->dev, "%s: Operational\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_dbg(ts->dev, "%s: Operational failure\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -ENODEV;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(ts->dev, "%s: No=
n-Operational failure\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -ENODEV;
>> + =C2=A0 =C2=A0 }
>
> No return here is slightly confusing. Seems return -ENODEV could be m=
oved here.
>

Yes, this code can be cleaned. I=C2=B4will change it to always return
retval and setting its value.

>> +
>> +}
>> +
>> +static int cyttsp_exit_bl_mode(struct cyttsp *ts)
>> +{
>> + =C2=A0 =C2=A0 int retval;
>> + =C2=A0 =C2=A0 int tries;
>> + =C2=A0 =C2=A0 u8 bl_cmd[sizeof(bl_command)];
>> +
>> + =C2=A0 =C2=A0 memcpy(bl_cmd, bl_command, sizeof(bl_command));
>> + =C2=A0 =C2=A0 if (ts->platform_data->bl_keys)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&bl_cmd[sizeof(bl=
_command) - CY_NUM_BL_KEYS],
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ts->platform_data->bl_keys, sizeof(bl_command));
>> +
>> + =C2=A0 =C2=A0 dev_dbg(ts->dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "%s: bl_cmd=3D "
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "%02X %02X %02X %02X %02=
X %02X %02X %02X %02X %02X %02X\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, bl_cmd[0], bl_=
cmd[1], bl_cmd[2],
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bl_cmd[3], bl_cmd[4], bl=
_cmd[5], bl_cmd[6],
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bl_cmd[7], bl_cmd[8], bl=
_cmd[9], bl_cmd[10]);
>> +
>> + =C2=A0 =C2=A0 retval =3D ttsp_write_block_data(ts, CY_REG_BASE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(bl_cmd), (void *)=
bl_cmd);
>> + =C2=A0 =C2=A0 if (retval < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return retval;
>> +
>> + =C2=A0 =C2=A0 /* wait for TTSP Device to complete switch to Operat=
ional mode */
>> + =C2=A0 =C2=A0 tries =3D 0;
>> + =C2=A0 =C2=A0 do {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msleep(CY_DELAY_DFLT);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D cyttsp_load_b=
l_regs(ts);
>> + =C2=A0 =C2=A0 } while (!((retval =3D=3D 0) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !GET_BOOTLOADERMODE(ts->=
bl_data.bl_status)) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (tries++ < CY_DELAY_MAX)=
);
>> +
>> + =C2=A0 =C2=A0 dev_dbg(ts->dev, "%s: check bl ready tries=3D%d ret=3D=
%d stat=3D%02X\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, tries, retval,=
 ts->bl_data.bl_status);
>> +
>> + =C2=A0 =C2=A0 if (retval < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return retval;
>> + =C2=A0 =C2=A0 else if (GET_BOOTLOADERMODE(ts->bl_data.bl_status))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> +}
>
> Is retval > 0 && !GET_BOOTLOADERMODE(ts->bl_data.bl_status) a possibl=
e
> state, and if so, valid?
>

cyttsp_load_bl_regs() memset the structure with 0s before reading from
the bus so the registers state should be correct.

I will modify cyttsp_load_bl_regs() to set the bootloader mode bit
after the memset but before the read to ensure that a bit clear is
because that value was really readed from the bus.

>> +
>> +static int cyttsp_set_operational_mode(struct cyttsp *ts)
>> +{
>> + =C2=A0 =C2=A0 struct cyttsp_xydata xy_data;
>> + =C2=A0 =C2=A0 int retval;
>> + =C2=A0 =C2=A0 int tries;
>> + =C2=A0 =C2=A0 u8 cmd =3D CY_OPERATE_MODE;
>> +
>> + =C2=A0 =C2=A0 retval =3D ttsp_write_block_data(ts, CY_REG_BASE, si=
zeof(cmd), &cmd);
>> +
>> + =C2=A0 =C2=A0 if (retval < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return retval;
>> +
>> + =C2=A0 =C2=A0 /* wait for TTSP Device to complete switch to Operat=
ional mode */
>> + =C2=A0 =C2=A0 tries =3D 0;
>> + =C2=A0 =C2=A0 do {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D ttsp_read_blo=
ck_data(ts, CY_REG_BASE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sizeof(xy_data), &(xy_data));
>> + =C2=A0 =C2=A0 } while (!((retval =3D=3D 0) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (xy_data.act_dist =3D=3D=
 CY_ACT_DIST_DFLT)) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (tries++ < CY_DELAY_MAX)=
);
>> +
>> + =C2=A0 =C2=A0 dev_dbg(ts->dev, "%s: check op ready tries=3D%d ret=3D=
%d dist=3D%02X\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, tries, retval,=
 xy_data.act_dist);
>> +
>> + =C2=A0 =C2=A0 return retval;
>> +}
>> +
>> +static int cyttsp_set_sysinfo_mode(struct cyttsp *ts)
>> +{
>> + =C2=A0 =C2=A0 int retval;
>> + =C2=A0 =C2=A0 int tries;
>> + =C2=A0 =C2=A0 u8 cmd =3D CY_SYSINFO_MODE;
>> +
>> + =C2=A0 =C2=A0 memset(&(ts->sysinfo_data), 0, sizeof(struct cyttsp_=
sysinfo_data));
>> +
>> + =C2=A0 =C2=A0 /* switch to sysinfo mode */
>> + =C2=A0 =C2=A0 retval =3D ttsp_write_block_data(ts, CY_REG_BASE, si=
zeof(cmd), &cmd);
>> + =C2=A0 =C2=A0 if (retval < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return retval;
>> +
>> + =C2=A0 =C2=A0 /* read sysinfo registers */
>> + =C2=A0 =C2=A0 tries =3D 0;
>> + =C2=A0 =C2=A0 do {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msleep(CY_DELAY_DFLT);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D ttsp_read_blo=
ck_data(ts, CY_REG_BASE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sizeof(ts->sysinfo_data), &(ts->sysinfo_data));
>> + =C2=A0 =C2=A0 } while (!((retval =3D=3D 0) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !((ts->sysinfo_data.tts_=
verh =3D=3D 0) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ts->sysinfo_data.tts_ve=
rl =3D=3D 0))) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (tries++ < CY_DELAY_MAX)=
);
>> +
>> + =C2=A0 =C2=A0 dev_dbg(ts->dev, "%s: check sysinfo ready tries=3D%d=
 ret=3D%d\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, tries, retval)=
;
>> +
>> + =C2=A0 =C2=A0 dev_info(ts->dev, "%s: tv=3D%02X%02X ai=3D0x%02X%02X=
 "
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "av=3D0x%02X%02X ci=3D0x=
%02X%02X%02X\n", "cyttsp",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->sysinfo_data.tts_ver=
h, ts->sysinfo_data.tts_verl,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->sysinfo_data.app_idh=
, ts->sysinfo_data.app_idl,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->sysinfo_data.app_ver=
h, ts->sysinfo_data.app_verl,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->sysinfo_data.cid[0],=
 ts->sysinfo_data.cid[1],
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->sysinfo_data.cid[2])=
;
>> +
>> + =C2=A0 =C2=A0 return retval;
>> +}
>
> Similar questions here; apparently not only retval matters, but only =
retval is returned.
>

Yes, this is for the semantic of the bus read functions. At the end of
each read function (I2C, SPI) only is check if the return value is  <
0. i.e:

	retval =3D i2c_master_recv(ts->client, values, length);

	return (retval < 0) ? retval : 0;

So, in other words we don't care the bytes count, only if an error has
occurred or not. It this correct? Or should I propagate the byte count
and check if is equal to sizeof(struct) read?

>> +
>> +static int cyttsp_set_sysinfo_regs(struct cyttsp *ts)
>> +{
>> + =C2=A0 =C2=A0 int retval =3D 0;
>> +
>> + =C2=A0 =C2=A0 if (ts->platform_data->act_intrvl !=3D CY_ACT_INTRVL=
_DFLT ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->platform_data->tch_t=
mout !=3D CY_TCH_TMOUT_DFLT ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->platform_data->lp_in=
trvl !=3D CY_LP_INTRVL_DFLT) {
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 intrvl_ray[3];
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 intrvl_ray[0] =3D ts->pl=
atform_data->act_intrvl;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 intrvl_ray[1] =3D ts->pl=
atform_data->tch_tmout;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 intrvl_ray[2] =3D ts->pl=
atform_data->lp_intrvl;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* set intrvl registers =
*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D ttsp_write_bl=
ock_data(ts,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CY_REG_ACT_INTRVL,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(intrvl_ray), intrvl_ray);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msleep(CY_DELAY_DFLT);
>
> What happens if there is no delay here?
>

The delay here is to make sure that the sysinfo register settings are c=
omplete.
We wait since we usually change mode to operational after this function=
=2E

>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 return retval;
>> +}
>> +
>> +static int cyttsp_soft_reset(struct cyttsp *ts)
>> +{
>> + =C2=A0 =C2=A0 int retval;
>> + =C2=A0 =C2=A0 u8 cmd =3D CY_SOFT_RESET_MODE;
>> +
>> + =C2=A0 =C2=A0 retval =3D ttsp_write_block_data(ts, CY_REG_BASE, si=
zeof(cmd), &cmd);
>> + =C2=A0 =C2=A0 if (retval < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return retval;
>> +
>> + =C2=A0 =C2=A0 /* wait for interrupt to set ready completion */
>> + =C2=A0 =C2=A0 INIT_COMPLETION(ts->bl_ready);
>> +
>> + =C2=A0 =C2=A0 retval =3D wait_for_completion_interruptible_timeout=
(&ts->bl_ready,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msecs_to_jiffies(CY_DELA=
Y_DFLT * CY_DELAY_MAX));
>> +
>> + =C2=A0 =C2=A0 if (retval > 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D 0;
>> +
>> + =C2=A0 =C2=A0 return retval;
>
> Please simplify/correct the logic here.
>

Ok, will do.

>> +}
>> +
>> +static int cyttsp_act_dist_setup(struct cyttsp *ts)
>> +{
>> + =C2=A0 =C2=A0 int retval;
>> + =C2=A0 =C2=A0 u8 act_dist_setup;
>> +
>> + =C2=A0 =C2=A0 /* Init gesture; active distance setup */
>> + =C2=A0 =C2=A0 act_dist_setup =3D ts->platform_data->act_dist;
>> + =C2=A0 =C2=A0 retval =3D ttsp_write_block_data(ts, CY_REG_ACT_DIST=
,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(act_dist_setup), =
&act_dist_setup);
>> +
>> + =C2=A0 =C2=A0 return retval;
>> +}
>> +
>> +static int cyttsp_hndshk(struct cyttsp *ts, u8 hst_mode)
>> +{
>> + =C2=A0 =C2=A0 int retval;
>> + =C2=A0 =C2=A0 u8 cmd;
>> +
>> + =C2=A0 =C2=A0 cmd =3D hst_mode & CY_HNDSHK_BIT ?
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hst_mode & ~CY_HNDSHK_BI=
T :
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hst_mode | CY_HNDSHK_BIT=
;
>
> why not XOR?
>

OK, will change

>> +
>> +static irqreturn_t cyttsp_irq(int irq, void *handle)
>> +{
>> + =C2=A0 =C2=A0 struct cyttsp *ts =3D handle;
>> + =C2=A0 =C2=A0 int retval;
>> +
>> + =C2=A0 =C2=A0 if (ts->power_state =3D=3D CY_BL_STATE)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 complete(&ts->bl_ready);
>> + =C2=A0 =C2=A0 else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* process the touches *=
/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D cyttsp_handle=
_tchdata(ts);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (retval < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0* TTSP device has reset back to bootloader mode.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0* Restore to operational mode.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 retval =3D cyttsp_exit_bl_mode(ts);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (retval)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->power_state =3D CY_IDLE_STATE;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->power_state =3D CY_ACTIVE_STATE;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cyttsp_pr_state(ts);
>
> You really want to call the above from the interrupt handler?
>

Is good to notice that this is the scheduled half of the interrupt
process. So, since the handler is a threaded IRQ technically we are in
process context and not in interrupt context.

If retval<0, then the touch handler found that the bootloader is runnin=
g.
If the part is glitched, then it will reset itself back to bootloader m=
ode and
the bootloader heartbeat interrupt would have occurred which will be th=
e
cause of the interrupt.

So we want to exit the bootloader immediately and continue running.

>
> Thanks,
> Henrik
>

Thank you very much for your time to review this. I will try to fix
these issues on the weekend and resend.

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
