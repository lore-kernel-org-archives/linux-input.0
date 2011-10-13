From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v5 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Fri, 14 Oct 2011 00:32:15 +0200
Message-ID: <CAAwP0s0SZvWra5p0E4wuNrVrfPGEsWjnrNTAPBO+6dsVym2iDg@mail.gmail.com>
References: <1318099080-26227-1-git-send-email-martinez.javier@gmail.com>
 <1318099080-26227-2-git-send-email-martinez.javier@gmail.com> <20111013180319.GA2308@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111013180319.GA2308@polaris.bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 13, 2011 at 8:03 PM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> Hi Javier,
>
> some more comments on the code. Presumable Dmitry will have additiona=
l
> ones later on. Thank you for your patience.
>

Hi Henrik,

Thank for your patience. Sorry for all the iterations.

>> +/* Slots management */
>> +#define CY_MAX_FINGER =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 4
>> +#define CY_MAX_ID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 15
>
> I realize the firmware reports ids in the range [1..14], but it is no=
t
> visible from the code. Allowing all 16 values makes correctness
> obvious.
>

Ok, I'll change to: #define CY_MAX_ID 16.

>> +static int cyttsp_load_bl_regs(struct cyttsp *ts)
>> +{
>> + =C2=A0 =C2=A0 int retval;
>> +
>> + =C2=A0 =C2=A0 memset(&(ts->bl_data), 0, sizeof(struct cyttsp_bootl=
oader_data));
>> +
>> + =C2=A0 =C2=A0 ts->bl_data.bl_status =3D 0x10;
>> +
>> + =C2=A0 =C2=A0 retval =3D =C2=A0ttsp_read_block_data(ts, CY_REG_BAS=
E,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(ts->bl_data), &(t=
s->bl_data));
>> +
>> + =C2=A0 =C2=A0 return retval;
>> +}
>
> Looks like you missed the removal of retval here.
>

Yes, sorry. I'll change to return ttsp_read_block_data() so I can get
rid of the retval here.

>> +
>> +static int cyttsp_bl_app_valid(struct cyttsp *ts)
>> +{
>> + =C2=A0 =C2=A0 int retval;
>> +
>> + =C2=A0 =C2=A0 retval =3D cyttsp_load_bl_regs(ts);
>> +
>> + =C2=A0 =C2=A0 if (retval < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D -ENODEV;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto done;
>> + =C2=A0 =C2=A0 }
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
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 if (GET_HSTMODE(ts->bl_data.bl_file) =3D=3D CY_OPERA=
TE_MODE) {
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
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 dev_dbg(ts->dev, "%s: Non-Operational failure\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__);
>> + =C2=A0 =C2=A0 retval =3D -ENODEV;
>> +done:
>> + =C2=A0 =C2=A0 return retval;
>> +
>> +}
>
> Are the debug paths still necessary? There are a lot of them.
>

No I think there are not necessary any more, I'll remove them. It will
make the code cleaner.

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
> Regardless of if it can ever happen, programatically the (retval > 0)
> && GET_BOOTLOADERMODE(ts->bl_data.bl_status) case is slipping through=
 here.
>

Good question. I think it can happen if the read succeed and the
device is still in bootloader mode. But I don't know the hardware
enough to confirm that.

Kevin?

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
>
> So (xy_data.act_dist =3D=3D CY_ACT_DIST_DFL) here is not an error?
>

Yes, it is. I'll add the check to report accordingly.

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
>
> Expands to (retval || =C2=A0!ts->sysinfo_data.tts_verh &&
> !ts->sysinfo_data.tts_verl) && (tries++ < CY_DELAY_MAX), which seems =
a
> bit simpler to me. Also, &ts->sysinfo_data could be a pointer here.
>

Yes, it is simpler. Will change it.

> Coding verh+verl as a 16-bit value?
>
> Are the timeouted (tries >=3D CY_DELAY_MAX) cases not errors here eit=
her?
>

Yes, we should report that also.

> <snip>
>
>> +static int cyttsp_soft_reset(struct cyttsp *ts)
>> +{
>> + =C2=A0 =C2=A0 int retval;
>> + =C2=A0 =C2=A0 u8 cmd =3D CY_SOFT_RESET_MODE;
>> + =C2=A0 =C2=A0 long wait_jiffies =3D msecs_to_jiffies(CY_DELAY_DFLT=
 * CY_DELAY_MAX);
>> + =C2=A0 =C2=A0 /* wait for interrupt to set ready completion */
>> + =C2=A0 =C2=A0 INIT_COMPLETION(ts->bl_ready);
>> +
>> + =C2=A0 =C2=A0 retval =3D ttsp_write_block_data(ts, CY_REG_BASE, si=
zeof(cmd), &cmd);
>> + =C2=A0 =C2=A0 if (retval < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return retval;
>> +
>> + =C2=A0 =C2=A0 retval =3D wait_for_completion_timeout(&ts->bl_ready=
, wait_jiffies);
>> +
>> + =C2=A0 =C2=A0 if (retval > 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D 0;
>
> Seems this one slipped.
>

What cleanup do you want me to do here? Remove the last retval? or
there is some problem with the completion logic?

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
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hst_mode ^ CY_HNDSHK_BIT=
 :
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hst_mode | CY_HNDSHK_BIT=
;
>
> Whoa, please redo this one correctly.
>

Ok, I just realized that what you meant:

cmd =3D hst_mode ^ CY_HNDSHK_BIT;

is logically equivalent. Sorry for the mess with binary operators.

>> +
>> + =C2=A0 =C2=A0 retval =3D ttsp_write_block_data(ts, CY_REG_BASE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(cmd), (u8 *)&cmd)=
;
>> +
>> + =C2=A0 =C2=A0 return retval;
>> +}
>

Same here, will get rid of the retval with return ttsp_write_block_data=
().

>> +int cyttsp_resume(void *handle)
>> +{
>> + =C2=A0 =C2=A0 struct cyttsp *ts =3D handle;
>> + =C2=A0 =C2=A0 int retval =3D 0;
>> + =C2=A0 =C2=A0 struct cyttsp_xydata xydata;
>> +
>> + =C2=A0 =C2=A0 if (ts) {
>
> Neater if returning on (!ts) here instead.
>

Yes, will change that.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ts->platform_data->u=
se_sleep && (ts->power_state !=3D
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CY_ACTIVE_STATE)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (ts->platform_data->wakeup) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D ts->platform_data->wakeup();
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (retval < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(ts-=
>dev, "%s: Error, wakeup failed!\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 __func__);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(ts->dev, "%s: Error, wakeup not=
 implemented "
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "(check boa=
rd file).\n", __func__);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D -ENOSYS;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!(retval < 0)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D ttsp_read_block_data(ts, CY_=
REG_BASE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(=
xydata),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &xydata=
);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(retval < 0) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !GET_HSTMODE(xydata.hst_m=
ode))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->power_s=
tate =3D CY_ACTIVE_STATE;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(ts->dev, "%s: Wa=
ke Up %s\n", __func__,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (retval < 0) ? "FAIL" : "PASS");
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 return retval;
>> +}
>> +EXPORT_SYMBOL_GPL(cyttsp_resume);
>
> Thanks.
> Henrik
>

I'll fix these issues and resend in the next days. Thank you very much
for your time to review.

I'm new in kernel dev and it seems I'm still lacking "good taste" to
code, but I hope I'll get there :-)

Best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
