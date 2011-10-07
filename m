From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] Input: psmouse - change log messages from psmouse.c to psmouse
Date: Fri, 7 Oct 2011 18:07:28 +0800
Message-ID: <CAGS+omACkwB1GSxcFHiuvi43Q5dzx_m-K_85VHOJSKc3YUXSnA@mail.gmail.com>
References: <1317273295-4931-1-git-send-email-jj_ding@emc.com.tw>
 <4E83FF81.700@cn.fujitsu.com> <20111007063926.GA32142@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:54663 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759664Ab1JGKHx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2011 06:07:53 -0400
Received: from hpaq1.eem.corp.google.com (hpaq1.eem.corp.google.com [172.25.149.1])
	by smtp-out.google.com with ESMTP id p97A7oae021779
	for <linux-input@vger.kernel.org>; Fri, 7 Oct 2011 03:07:50 -0700
Received: from iarr31 (iarr31.prod.google.com [10.12.44.31])
	by hpaq1.eem.corp.google.com with ESMTP id p97A6l4l026484
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 7 Oct 2011 03:07:48 -0700
Received: by iarr31 with SMTP id r31so275567iar.4
        for <linux-input@vger.kernel.org>; Fri, 07 Oct 2011 03:07:48 -0700 (PDT)
In-Reply-To: <20111007063926.GA32142@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>, JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, JJ Ding <dgdunix@gmail.com>

Hi Dmitry,

On Fri, Oct 7, 2011 at 2:39 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi JJ, Wanlong,
>
> On Thu, Sep 29, 2011 at 01:17:53PM +0800, Wanlong Gao wrote:
>> On 09/29/2011 01:14 PM, JJ Ding wrote:
>>
>> > From: JJ Ding <dgdunix@gmail.com>
>> >
>> > psmouse.c had long been renamed to psmouse-base.c back in 2003, wh=
en we
>> > were still at Linux 2.5.xx. This change makes the log less mislead=
ing.
>> >
>> > Signed-off-by: JJ Ding <dgdunix@gmail.com>
>>
>> Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
>>
>
> Actually, I (and other people) wanted to go through psmouse logging a=
nd
> make it all consistent. What do you think about the patch below?
>
> Thanks.
>
> --
> Dmitry
>
> Input: psmouse - switch to using dev_*() for messages
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> This will ensure our reporting is consistent with the rest of the sys=
tem
> and we do not refer to obsolete source file names.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =A0drivers/input/mouse/alps.c =A0 =A0 =A0 =A0 | =A0 52 +++++++++++---=
--------
> =A0drivers/input/mouse/elantech.c =A0 =A0 | =A0 84 ++++++++++++++++++=
++----------------
> =A0drivers/input/mouse/hgpk.c =A0 =A0 =A0 =A0 | =A0 84 ++++++++++++++=
++++------------------
> =A0drivers/input/mouse/hgpk.h =A0 =A0 =A0 =A0 | =A0 11 -----
> =A0drivers/input/mouse/lifebook.c =A0 =A0 | =A0 =A06 +--
> =A0drivers/input/mouse/logips2pp.c =A0 =A0| =A0 16 +++----
> =A0drivers/input/mouse/psmouse-base.c | =A0 67 +++++++++++++++++-----=
------
> =A0drivers/input/mouse/psmouse.h =A0 =A0 =A0| =A0 25 +++++++++++
> =A0drivers/input/mouse/sentelic.c =A0 =A0 | =A0 13 +++---
> =A0drivers/input/mouse/synaptics.c =A0 =A0| =A0 85 ++++++++++++++++++=
++----------------
> =A010 files changed, 245 insertions(+), 198 deletions(-)
>
>
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 99d5876..003587c 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -23,13 +23,6 @@
> =A0#include "psmouse.h"
> =A0#include "alps.h"
>
> -#undef DEBUG
> -#ifdef DEBUG
> -#define dbg(format, arg...) printk(KERN_INFO "alps.c: " format "\n",=
 ## arg)
> -#else
> -#define dbg(format, arg...) do {} while (0)
> -#endif
> -
> =A0#define ALPS_OLDPROTO =A0 =A0 =A0 =A0 =A00x01 =A0 =A0/* old style =
input */
> =A0#define ALPS_DUALPOINT =A0 =A0 =A0 =A0 0x02 =A0 =A0/* touchpad has=
 trackstick */
> =A0#define ALPS_PASS =A0 =A0 =A0 =A0 =A0 =A0 =A00x04 =A0 =A0/* device=
 has a pass-through port */
> @@ -297,10 +290,10 @@ static psmouse_ret_t alps_handle_interleaved_ps=
2(struct psmouse *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->packet[4] |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->packet[5]) & 0x80=
) ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(!alps_is_valid_first_byte(pri=
v->i, psmouse->packet[6]))) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg("refusing packet %x=
 %x %x %x "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "(suspected int=
erleaved ps/2)\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->packet=
[3], psmouse->packet[4],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->packet=
[5], psmouse->packet[6]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 "refusing packet %x %x %x %x (suspected interleaved ps/2)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 psmouse->packet[3], psmouse->packet[4],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 psmouse->packet[5], psmouse->packet[6]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PSMOUSE_BAD_DAT=
A;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> @@ -319,13 +312,13 @@ static psmouse_ret_t alps_handle_interleaved_ps=
2(struct psmouse *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * There is also possibility that we g=
ot 6-byte ALPS
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * packet followed =A0by 3-byte packet=
 from trackpoint. We
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * can not distinguish between these 2=
 scenarios but
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* becase the latter is unlikely to h=
appen in course of
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* because the latter is unlikely to =
happen in course of
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * normal operation (user would need t=
o press all
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * buttons on the pad and start moving=
 trackpoint
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * without touching the pad surface) w=
e assume former.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Even if we are wrong the wost thing=
 that would happen
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * the cursor would jump but we should=
 not get protocol
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* desynchronization.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* de-synchronization.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0alps_report_bare_ps2_packet(psmouse, &=
psmouse->packet[3],
> @@ -361,10 +354,10 @@ static void alps_flush_packet(unsigned long dat=
a)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((psmouse->packet[3] |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->packet[4] |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->packet[5]) & 0x80) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg("refusing packet %x=
 %x %x "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "(suspected int=
erleaved ps/2)\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->packet=
[3], psmouse->packet[4],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->packet=
[5]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 "refusing packet %x %x %x (suspected interleaved ps/2)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 psmouse->packet[3], psmouse->packet[4],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 psmouse->packet[5]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0alps_process_packet(ps=
mouse);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -396,16 +389,18 @@ static psmouse_ret_t alps_process_byte(struct p=
smouse *psmouse)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (!alps_is_valid_first_byte(model, psmouse->packet[0=
])) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg("refusing packet[0] =3D %x (mask0 =3D=
 %x, byte0 =3D %x)\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->packet[0], model->mask=
0, model->byte0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "refusing packe=
t[0] =3D %x (mask0 =3D %x, byte0 =3D %x)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->packet=
[0], model->mask0, model->byte0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PSMOUSE_BAD_DATA;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Bytes 2 - 6 should have 0 in the highest bit */
> =A0 =A0 =A0 =A0if (psmouse->pktcnt >=3D 2 && psmouse->pktcnt <=3D 6 &=
&
> =A0 =A0 =A0 =A0 =A0 =A0(psmouse->packet[psmouse->pktcnt - 1] & 0x80))=
 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg("refusing packet[%i] =3D %x\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->pktcnt - 1, psmouse->p=
acket[psmouse->pktcnt - 1]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse, "refusing packet[%=
i] =3D %x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->pktcnt=
 - 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->packet=
[psmouse->pktcnt - 1]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PSMOUSE_BAD_DATA;
> =A0 =A0 =A0 =A0}
>
> @@ -439,7 +434,8 @@ static const struct alps_model_info *alps_get_mod=
el(struct psmouse *psmouse, int
> =A0 =A0 =A0 =A0if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
>
> - =A0 =A0 =A0 dbg("E6 report: %2.2x %2.2x %2.2x", param[0], param[1],=
 param[2]);
> + =A0 =A0 =A0 psmouse_dbg(psmouse, "E6 report: %2.2x %2.2x %2.2x",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 param[0], param[1], param[2]);
>
> =A0 =A0 =A0 =A0if (param[0] !=3D 0 || param[1] !=3D 0 || (param[2] !=3D=
 10 && param[2] !=3D 100))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
> @@ -459,7 +455,8 @@ static const struct alps_model_info *alps_get_mod=
el(struct psmouse *psmouse, int
> =A0 =A0 =A0 =A0if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
>
> - =A0 =A0 =A0 dbg("E7 report: %2.2x %2.2x %2.2x", param[0], param[1],=
 param[2]);
> + =A0 =A0 =A0 psmouse_dbg(psmouse, "E7 report: %2.2x %2.2x %2.2x",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 param[0], param[1], param[2]);
>
> =A0 =A0 =A0 =A0if (version) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < ARRAY_SIZE(rates) &&=
 param[2] !=3D rates[i]; i++)
> @@ -527,7 +524,8 @@ static int alps_get_status(struct psmouse *psmous=
e, char *param)
> =A0 =A0 =A0 =A0 =A0 =A0ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO=
))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> - =A0 =A0 =A0 dbg("Status: %2.2x %2.2x %2.2x", param[0], param[1], pa=
ram[2]);
> + =A0 =A0 =A0 psmouse_dbg(psmouse, "Status: %2.2x %2.2x %2.2x",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 param[0], param[1], param[2]);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -605,12 +603,12 @@ static int alps_hw_init(struct psmouse *psmouse=
)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (alps_tap_mode(psmouse, true)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "alps.c: Failed to =
enable hardware tapping\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse, "Failed to enable=
 hardware tapping\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (alps_absolute_mode(psmouse)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "alps.c: Failed to enab=
le absolute mode\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "Failed to enable =
absolute mode\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> @@ -621,7 +619,7 @@ static int alps_hw_init(struct psmouse *psmouse)
>
> =A0 =A0 =A0 =A0/* ALPS needs stream mode, otherwise it won't report a=
ny data */
> =A0 =A0 =A0 =A0if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SE=
TSTREAM)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "alps.c: Failed to enab=
le stream mode\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "Failed to enable =
stream mode\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/ela=
ntech.c
> index 25290b3..09b93b1 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -10,8 +10,6 @@
> =A0* Trademarks are the property of their respective owners.
> =A0*/
>
> -#define pr_fmt(fmt) KBUILD_BASENAME ": " fmt
> -
> =A0#include <linux/delay.h>
> =A0#include <linux/slab.h>
> =A0#include <linux/module.h>
> @@ -25,7 +23,8 @@
> =A0#define elantech_debug(fmt, ...) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0do { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (etd->debug) =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG pr_fm=
t(fmt), ##__VA_ARGS__); =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_printk(KERN_DEB=
UG, psmouse, =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 fmt, ##__VA_ARGS__); =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0} while (0)
>
> =A0/*
> @@ -36,7 +35,7 @@ static int synaptics_send_cmd(struct psmouse *psmou=
se, unsigned char c,
> =A0{
> =A0 =A0 =A0 =A0if (psmouse_sliced_command(psmouse, c) ||
> =A0 =A0 =A0 =A0 =A0 =A0ps2_command(&psmouse->ps2dev, param, PSMOUSE_C=
MD_GETINFO)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("synaptics_send_cmd query 0x%02x=
 failed.\n", c);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "%s query 0x%02x f=
ailed.\n", __func__, c);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> @@ -65,7 +64,7 @@ static int elantech_ps2_command(struct psmouse *psm=
ouse,
> =A0 =A0 =A0 =A0} while (tries > 0);
>
> =A0 =A0 =A0 =A0if (rc)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("ps2 command 0x%02x failed.\n", =
command);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "ps2 command 0x%02=
x failed.\n", command);
>
> =A0 =A0 =A0 =A0return rc;
> =A0}
> @@ -117,7 +116,7 @@ static int elantech_read_reg(struct psmouse *psmo=
use, unsigned char reg,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (rc)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to read register 0x%02x.=
\n", reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "failed to read re=
gister 0x%02x.\n", reg);
> =A0 =A0 =A0 =A0else if (etd->hw_version !=3D 4)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*val =3D param[0];
> =A0 =A0 =A0 =A0else
> @@ -191,8 +190,9 @@ static int elantech_write_reg(struct psmouse *psm=
ouse, unsigned char reg,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (rc)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to write register 0x%02x=
 with value 0x%02x.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg, val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to writ=
e register 0x%02x with value 0x%02x.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg, val);
>
> =A0 =A0 =A0 =A0return rc;
> =A0}
> @@ -200,13 +200,13 @@ static int elantech_write_reg(struct psmouse *p=
smouse, unsigned char reg,
> =A0/*
> =A0* Dump a complete mouse movement packet to the syslog
> =A0*/
> -static void elantech_packet_dump(unsigned char *packet, int size)
> +static void elantech_packet_dump(struct psmouse *psmouse)
> =A0{
> =A0 =A0 =A0 =A0int =A0 =A0 i;
>
> - =A0 =A0 =A0 printk(KERN_DEBUG pr_fmt("PS/2 packet ["));
> - =A0 =A0 =A0 for (i =3D 0; i < size; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%s0x%02x ", (i) ? ", " : " ", p=
acket[i]);
> + =A0 =A0 =A0 psmouse_printk(KERN_DEBUG, psmouse, "PS/2 packet [");
> + =A0 =A0 =A0 for (i =3D 0; i < psmouse->pktsize; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%s0x%02x ", i ? ", " : " ", psm=
ouse->packet[i]);
> =A0 =A0 =A0 =A0printk("]\n");
> =A0}
>
> @@ -705,7 +705,7 @@ static psmouse_ret_t elantech_process_byte(struct=
 psmouse *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PSMOUSE_GOOD_DATA;
>
> =A0 =A0 =A0 =A0if (etd->debug > 1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 elantech_packet_dump(psmouse->packet, p=
smouse->pktsize);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 elantech_packet_dump(psmouse);
>
> =A0 =A0 =A0 =A0switch (etd->hw_version) {
> =A0 =A0 =A0 =A0case 1:
> @@ -801,7 +801,7 @@ static int elantech_set_absolute_mode(struct psmo=
use *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Read back reg 0x10. For hardware ve=
rsion 1 we must make
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * sure the absolute mode bit is set. =
=46or hardware version 2
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the touchpad is probably initalisi=
ng and not ready until
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the touchpad is probably initializ=
ing and not ready until
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * we read back the value we just wrot=
e.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
> @@ -814,17 +814,19 @@ static int elantech_set_absolute_mode(struct ps=
mouse *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} while (tries > 0);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rc) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to read =
back register 0x10.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 "failed to read back register 0x10.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (etd->hw_version =3D=3D 1 &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(val & ETP_R10_A=
BSOLUTE_MODE)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("touchpad refuse=
s to switch to absolute mode.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 "touchpad refuses to switch to absolute mode.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rc =3D -1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> =A0skip_readback_reg_10:
> =A0 =A0 =A0 =A0if (rc)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to initialise registers.=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "failed to initial=
ise registers.\n");
>
> =A0 =A0 =A0 =A0return rc;
> =A0}
> @@ -1131,7 +1133,7 @@ int elantech_detect(struct psmouse *psmouse, bo=
ol set_properties)
> =A0 =A0 =A0 =A0 =A0 =A0ps2_command(ps2dev, =A0NULL, PSMOUSE_CMD_SETSC=
ALE11) ||
> =A0 =A0 =A0 =A0 =A0 =A0ps2_command(ps2dev, =A0NULL, PSMOUSE_CMD_SETSC=
ALE11) ||
> =A0 =A0 =A0 =A0 =A0 =A0ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO=
)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("sending Elantech magic knock =
failed.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse, "sending Elantech =
magic knock failed.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> @@ -1141,8 +1143,9 @@ int elantech_detect(struct psmouse *psmouse, bo=
ol set_properties)
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (param[0] !=3D 0x3c || param[1] !=3D 0x03 ||
> =A0 =A0 =A0 =A0 =A0 =A0(param[2] !=3D 0xc8 && param[2] !=3D 0x00)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("unexpected magic knock result=
 0x%02x, 0x%02x, 0x%02x.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0param[0], param[1], =
param[2]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unexpected mag=
ic knock result 0x%02x, 0x%02x, 0x%02x.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 param[0], param=
[1], param[2]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> @@ -1152,15 +1155,17 @@ int elantech_detect(struct psmouse *psmouse, =
bool set_properties)
> =A0 =A0 =A0 =A0 * to Elantech magic knock and there might be more.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (synaptics_send_cmd(psmouse, ETP_FW_VERSION_QUERY, =
param)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("failed to query firmware vers=
ion.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse, "failed to query f=
irmware version.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 pr_debug("Elantech version query result 0x%02x, 0x%02x,=
 0x%02x.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0param[0], param[1], param[2]);
> + =A0 =A0 =A0 psmouse_dbg(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Elantech version query result =
0x%02x, 0x%02x, 0x%02x.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 param[0], param[1], param[2]);
>
> =A0 =A0 =A0 =A0if (!elantech_is_signature_valid(param)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("Probably not a real Elantech =
touchpad. Aborting.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Probably not a=
 real Elantech touchpad. Aborting.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> @@ -1192,7 +1197,8 @@ static int elantech_reconnect(struct psmouse *p=
smouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> =A0 =A0 =A0 =A0if (elantech_set_absolute_mode(psmouse)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to put touchpad back int=
o absolute mode.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to put =
touchpad back into absolute mode.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> @@ -1262,42 +1268,46 @@ int elantech_init(struct psmouse *psmouse)
> =A0 =A0 =A0 =A0 * Do the version query again so we can store the resu=
lt
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (synaptics_send_cmd(psmouse, ETP_FW_VERSION_QUERY, =
param)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to query firmware versio=
n.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "failed to query f=
irmware version.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto init_fail;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0etd->fw_version =3D (param[0] << 16) | (param[1] << 8)=
 | param[2];
>
> =A0 =A0 =A0 =A0if (elantech_set_properties(etd)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("unknown hardware version, abort=
ing...\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "unknown hardware =
version, aborting...\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto init_fail;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 pr_info("assuming hardware version %d "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "(with firmware version 0x%02x%02x%02x)=
\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 etd->hw_version, param[0], param[1], pa=
ram[2]);
> + =A0 =A0 =A0 psmouse_info(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"assuming hardware version %=
d (with firmware version 0x%02x%02x%02x)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0etd->hw_version, param[0], p=
aram[1], param[2]);
>
> =A0 =A0 =A0 =A0if (synaptics_send_cmd(psmouse, ETP_CAPABILITIES_QUERY=
,
> =A0 =A0 =A0 =A0 =A0 =A0etd->capabilities)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to query capabilities.\n=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "failed to query c=
apabilities.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto init_fail;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 pr_info("Synaptics capabilities query result 0x%02x, 0x=
%02x, 0x%02x.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 etd->capabilities[0], etd->capabilities=
[1],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 etd->capabilities[2]);
> + =A0 =A0 =A0 psmouse_info(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Synaptics capabilities quer=
y result 0x%02x, 0x%02x, 0x%02x.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0etd->capabilities[0], etd->c=
apabilities[1],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0etd->capabilities[2]);
>
> =A0 =A0 =A0 =A0if (elantech_set_absolute_mode(psmouse)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to put touchpad into abs=
olute mode.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to put =
touchpad into absolute mode.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto init_fail;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (elantech_set_input_params(psmouse)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to query touchpad range.=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "failed to query t=
ouchpad range.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto init_fail;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0error =3D sysfs_create_group(&psmouse->ps2dev.serio->d=
ev.kobj,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &=
elantech_attr_group);
> =A0 =A0 =A0 =A0if (error) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to create sysfs attribut=
es, error: %d.\n", error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to crea=
te sysfs attributes, error: %d.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto init_fail;
> =A0 =A0 =A0 =A0}
>
> diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
> index 4d17d9f..0470dd4 100644
> --- a/drivers/input/mouse/hgpk.c
> +++ b/drivers/input/mouse/hgpk.c
> @@ -136,10 +136,10 @@ static int hgpk_discard_decay_hack(struct psmou=
se *psmouse, int x, int y)
> =A0 =A0 =A0 =A0/* discard if too big, or half that but > 4 times the =
prev delta */
> =A0 =A0 =A0 =A0if (avx > recalib_delta ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(avx > recalib_delta / 2 && ((avx / 4)=
 > priv->xlast))) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_err(psmouse, "detected %dpx jump i=
n x\n", x);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse, "detected %dpx ju=
mp in x\n", x);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->xbigj =3D avx;
> =A0 =A0 =A0 =A0} else if (approx_half(avx, priv->xbigj)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_err(psmouse, "detected secondary %=
dpx jump in x\n", x);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse, "detected seconda=
ry %dpx jump in x\n", x);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->xbigj =3D avx;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->xsaw_secondary++;
> =A0 =A0 =A0 =A0} else {
> @@ -151,10 +151,10 @@ static int hgpk_discard_decay_hack(struct psmou=
se *psmouse, int x, int y)
>
> =A0 =A0 =A0 =A0if (avy > recalib_delta ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(avy > recalib_delta / 2 && ((avy / 4)=
 > priv->ylast))) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_err(psmouse, "detected %dpx jump i=
n y\n", y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse, "detected %dpx ju=
mp in y\n", y);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->ybigj =3D avy;
> =A0 =A0 =A0 =A0} else if (approx_half(avy, priv->ybigj)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_err(psmouse, "detected secondary %=
dpx jump in y\n", y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse, "detected seconda=
ry %dpx jump in y\n", y);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->ybigj =3D avy;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->ysaw_secondary++;
> =A0 =A0 =A0 =A0} else {
> @@ -168,7 +168,7 @@ static int hgpk_discard_decay_hack(struct psmouse=
 *psmouse, int x, int y)
> =A0 =A0 =A0 =A0priv->ylast =3D avy;
>
> =A0 =A0 =A0 =A0if (do_recal && jumpy_delay) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_err(psmouse, "scheduling recalibra=
tion\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse, "scheduling recal=
ibration\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse_queue_work(psmouse, &priv->rec=
alib_wq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msecs_=
to_jiffies(jumpy_delay));
> =A0 =A0 =A0 =A0}
> @@ -260,8 +260,8 @@ static void hgpk_spewing_hack(struct psmouse *psm=
ouse,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * movement, it is probably a case of =
the user moving the
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * cursor very slowly across the scree=
n. */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (abs(priv->x_tally) < 3 && abs(priv=
->y_tally) < 3) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_err(psmouse, "pack=
et spew detected (%d,%d)\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv=
->x_tally, priv->y_tally);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse, "=
packet spew detected (%d,%d)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0priv->x_tally, priv->y_tally);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->spew_flag =3D RE=
CALIBRATING;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse_queue_work(psm=
ouse, &priv->recalib_wq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 msecs_to_jiffies(spew_delay));
> @@ -333,12 +333,12 @@ static bool hgpk_is_byte_valid(struct psmouse *=
psmouse, unsigned char *packet)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (!valid)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_dbg(psmouse,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"bad data, mode %d (=
%d) %02x %02x %02x %02x %02x %02x\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->mode, pktcnt,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->packet[0], =
psmouse->packet[1],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->packet[2], =
psmouse->packet[3],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->packet[4], =
psmouse->packet[5]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "bad data, mode=
 %d (%d) %02x %02x %02x %02x %02x %02x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mode, pkt=
cnt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->packet=
[0], psmouse->packet[1],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->packet=
[2], psmouse->packet[3],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->packet=
[4], psmouse->packet[5]);
>
> =A0 =A0 =A0 =A0return valid;
> =A0}
> @@ -361,19 +361,20 @@ static void hgpk_process_advanced_packet(struct=
 psmouse *psmouse)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(idev, ABS_PRESSURE, z=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tpdebug)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_dbg(psmouse, "pd=3D=
%d fd=3D%d z=3D%d",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pt_d=
own, finger_down, z);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse, "p=
d=3D%d fd=3D%d z=3D%d",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 pt_down, finger_down, z);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * PenTablet mode does not report pres=
sure, so we don't
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * report it here
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tpdebug)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_dbg(psmouse, "pd=3D=
%d ", down);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse, "p=
d=3D%d ", down);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (tpdebug)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_dbg(psmouse, "l=3D%d r=3D%d x=3D%d=
 y=3D%d\n", left, right, x, y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse, "l=3D%d r=3D%d x=3D=
%d y=3D%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 left, right, x,=
 y);
>
> =A0 =A0 =A0 =A0input_report_key(idev, BTN_TOUCH, down);
> =A0 =A0 =A0 =A0input_report_key(idev, BTN_LEFT, left);
> @@ -395,7 +396,7 @@ static void hgpk_process_advanced_packet(struct p=
smouse *psmouse)
> =A0 =A0 =A0 =A0if (x =3D=3D priv->abs_x && y =3D=3D priv->abs_y) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (++priv->dupe_count > SPEW_WATCH_CO=
UNT) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tpdebug)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_db=
g(psmouse, "hard spew detected\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse=
_dbg(psmouse, "hard spew detected\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->spew_flag =3D RE=
CALIBRATING;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse_queue_work(psm=
ouse, &priv->recalib_wq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 msecs_to_jiffies(spew_delay));
> @@ -412,7 +413,7 @@ static void hgpk_process_advanced_packet(struct p=
smouse *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int y_diff =3D priv->abs_y - y;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (hgpk_discard_decay_hack(psmouse, x=
_diff, y_diff)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tpdebug)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_db=
g(psmouse, "discarding\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse=
_dbg(psmouse, "discarding\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto done;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hgpk_spewing_hack(psmouse, left, right=
, x_diff, y_diff);
> @@ -437,20 +438,21 @@ static void hgpk_process_simple_packet(struct p=
smouse *psmouse)
> =A0 =A0 =A0 =A0int y =3D ((packet[0] << 3) & 0x100) - packet[2];
>
> =A0 =A0 =A0 =A0if (packet[0] & 0xc0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_dbg(psmouse,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"overflow -- 0x%02x =
0x%02x 0x%02x\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0packet[0], packet[1]=
, packet[2]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "overflow -- 0x=
%02x 0x%02x 0x%02x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 packet[0], pack=
et[1], packet[2]);
>
> =A0 =A0 =A0 =A0if (hgpk_discard_decay_hack(psmouse, x, y)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tpdebug)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_dbg(psmouse, "disc=
arding\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse, "d=
iscarding\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0hgpk_spewing_hack(psmouse, left, right, x, y);
>
> =A0 =A0 =A0 =A0if (tpdebug)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_dbg(psmouse, "l=3D%d r=3D%d x=3D%d=
 y=3D%d\n", left, right, x, y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse, "l=3D%d r=3D%d x=3D=
%d y=3D%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 left, right, x,=
 y);
>
> =A0 =A0 =A0 =A0input_report_key(dev, BTN_LEFT, left);
> =A0 =A0 =A0 =A0input_report_key(dev, BTN_RIGHT, right);
> @@ -482,9 +484,8 @@ static psmouse_ret_t hgpk_process_byte(struct psm=
ouse *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * ugh, got a packet i=
nside our recalibration
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * window, schedule an=
other recalibration.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_dbg(psmouse,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"pac=
ket inside calibration window, "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"que=
ueing another recalibration\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 "packet inside calibration window, queueing another recalibration\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse_queue_work(psm=
ouse, &priv->recalib_wq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0msecs_to_jiffies(post_interrupt_delay));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -628,7 +629,7 @@ static int hgpk_reset_device(struct psmouse *psmo=
use, bool recalibrate)
>
> =A0 =A0 =A0 =A0err =3D hgpk_select_mode(psmouse);
> =A0 =A0 =A0 =A0if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_err(psmouse, "failed to select mod=
e\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "failed to select =
mode\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
> =A0 =A0 =A0 =A0}
>
> @@ -648,11 +649,11 @@ static int hgpk_force_recalibrate(struct psmous=
e *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0if (!autorecal) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_dbg(psmouse, "recalibrations disab=
led, ignoring\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse, "recalibration dis=
abled, ignoring\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 hgpk_dbg(psmouse, "recalibrating touchpad..\n");
> + =A0 =A0 =A0 psmouse_dbg(psmouse, "recalibrating touchpad..\n");
>
> =A0 =A0 =A0 =A0/* we don't want to race with the irq handler, nor wit=
h resyncs */
> =A0 =A0 =A0 =A0psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
> @@ -675,7 +676,7 @@ static int hgpk_force_recalibrate(struct psmouse =
*psmouse)
> =A0 =A0 =A0 =A0psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
>
> =A0 =A0 =A0 =A0if (tpdebug)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_dbg(psmouse, "touchpad reactivated=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse, "touchpad reactiva=
ted\n");
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * If we get packets right away after recalibrating, i=
t's likely
> @@ -727,16 +728,16 @@ static int hgpk_toggle_powersave(struct psmouse=
 *psmouse, int enable)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D hgpk_reset_device(psmouse, fal=
se);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_err(psmouse, "Fail=
ed to reset device!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "F=
ailed to reset device!\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* should be all set, enable the touch=
pad */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ps2_command(&psmouse->ps2dev, NULL, PS=
MOUSE_CMD_ENABLE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse_set_state(psmouse, PSMOUSE_ACT=
IVATED);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_dbg(psmouse, "Touchpad powered up.=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse, "Touchpad powered =
up.\n");
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_dbg(psmouse, "Powering off touchpa=
d.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse, "Powering off touc=
hpad.\n");
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ps2_command(ps2dev, NULL, 0xec) ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ps2_command(ps2dev, NULL, 0xec=
) ||
> @@ -923,7 +924,7 @@ static void hgpk_recalib_work(struct work_struct =
*work)
> =A0 =A0 =A0 =A0struct psmouse *psmouse =3D priv->psmouse;
>
> =A0 =A0 =A0 =A0if (hgpk_force_recalibrate(psmouse))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_err(psmouse, "recalibration failed=
!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "recalibration fai=
led!\n");
> =A0}
>
> =A0static int hgpk_register(struct psmouse *psmouse)
> @@ -947,14 +948,15 @@ static int hgpk_register(struct psmouse *psmous=
e)
> =A0 =A0 =A0 =A0err =3D device_create_file(&psmouse->ps2dev.serio->dev=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &psmo=
use_attr_powered.dattr);
> =A0 =A0 =A0 =A0if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_err(psmouse, "Failed creating 'pow=
ered' sysfs node\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "Failed creating '=
powered' sysfs node\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0err =3D device_create_file(&psmouse->ps2dev.serio->dev=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &psmo=
use_attr_hgpk_mode.dattr);
> =A0 =A0 =A0 =A0if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_err(psmouse, "Failed creating 'hgp=
k_mode' sysfs node\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Failed creatin=
g 'hgpk_mode' sysfs node\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_remove_powered;
> =A0 =A0 =A0 =A0}
>
> @@ -963,8 +965,8 @@ static int hgpk_register(struct psmouse *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D device_create_file(&psmouse->p=
s2dev.serio->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &psmouse_attr_recalibrate.dattr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hgpk_err(psmouse,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Failed=
 creating 'recalibrate' sysfs node\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 "Failed creating 'recalibrate' sysfs node\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_remove_mode;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> @@ -1027,13 +1029,13 @@ static enum hgpk_model_t hgpk_get_model(struc=
t psmouse *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 hgpk_dbg(psmouse, "ID: %02x %02x %02x\n", param[0], par=
am[1], param[2]);
> + =A0 =A0 =A0 psmouse_dbg(psmouse, "ID: %02x %02x %02x\n", param[0], =
param[1], param[2]);
>
> =A0 =A0 =A0 =A0/* HGPK signature: 0x67, 0x00, 0x<model> */
> =A0 =A0 =A0 =A0if (param[0] !=3D 0x67 || param[1] !=3D 0x00)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> - =A0 =A0 =A0 hgpk_info(psmouse, "OLPC touchpad revision 0x%x\n", par=
am[2]);
> + =A0 =A0 =A0 psmouse_info(psmouse, "OLPC touchpad revision 0x%x\n", =
param[2]);
>
> =A0 =A0 =A0 =A0return param[2];
> =A0}
> diff --git a/drivers/input/mouse/hgpk.h b/drivers/input/mouse/hgpk.h
> index 311c0e8..dd68677 100644
> --- a/drivers/input/mouse/hgpk.h
> +++ b/drivers/input/mouse/hgpk.h
> @@ -46,17 +46,6 @@ struct hgpk_data {
> =A0 =A0 =A0 =A0int xsaw_secondary, ysaw_secondary; /* jumpiness detec=
tion */
> =A0};
>
> -#define hgpk_dbg(psmouse, format, arg...) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
\
> - =A0 =A0 =A0 dev_dbg(&(psmouse)->ps2dev.serio->dev, format, ## arg)
> -#define hgpk_err(psmouse, format, arg...) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
\
> - =A0 =A0 =A0 dev_err(&(psmouse)->ps2dev.serio->dev, format, ## arg)
> -#define hgpk_info(psmouse, format, arg...) =A0 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 dev_info(&(psmouse)->ps2dev.serio->dev, format, ## arg)
> -#define hgpk_warn(psmouse, format, arg...) =A0 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 dev_warn(&(psmouse)->ps2dev.serio->dev, format, ## arg)
> -#define hgpk_notice(psmouse, format, arg...) =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 dev_notice(&(psmouse)->ps2dev.serio->dev, format, ## ar=
g)
> -
> =A0#ifdef CONFIG_MOUSE_PS2_OLPC
> =A0void hgpk_module_init(void);
> =A0int hgpk_detect(struct psmouse *psmouse, bool set_properties);
> diff --git a/drivers/input/mouse/lifebook.c b/drivers/input/mouse/lif=
ebook.c
> index 83bcaba..2c4db63 100644
> --- a/drivers/input/mouse/lifebook.c
> +++ b/drivers/input/mouse/lifebook.c
> @@ -169,8 +169,8 @@ static psmouse_ret_t lifebook_process_byte(struct=
 psmouse *psmouse)
>
> =A0 =A0 =A0 =A0if (relative_packet) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!dev2)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "li=
febook.c: got relative packet "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "but no=
 relative device set up\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"got relative packet but no relative device set up\n");
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (lifebook_use_6byte_proto) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(dev1,=
 ABS_X,
> @@ -212,7 +212,7 @@ static int lifebook_absolute_mode(struct psmouse =
*psmouse)
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Enable absolute output -- ps2_command fails always =
but if
> - =A0 =A0 =A0 =A0* you leave this call out the touchsreen will never =
send
> + =A0 =A0 =A0 =A0* you leave this call out the touchscreen will never=
 send
> =A0 =A0 =A0 =A0 * absolute coordinates
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0param =3D lifebook_use_6byte_proto ? 0x08 : 0x07;
> diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/lo=
gips2pp.c
> index c9983ae..faac2c3 100644
> --- a/drivers/input/mouse/logips2pp.c
> +++ b/drivers/input/mouse/logips2pp.c
> @@ -82,11 +82,11 @@ static psmouse_ret_t ps2pp_process_byte(struct ps=
mouse *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0packet[0] =3D packet[2=
] | 0x08;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> -#ifdef DEBUG
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "ps=
mouse.c: Received PS2++ packet #%x, but don't know how to handle.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (packet=
[1] >> 4) | (packet[0] & 0x30));
> -#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 "Received PS2++ packet #%x, but don't know how to handle.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (packet[1] >> 4) | (packet[0] & 0x30));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Standard PS/2 motion data */
> @@ -382,7 +382,7 @@ int ps2pp_init(struct psmouse *psmouse, bool set_=
properties)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "logips2pp: Detecte=
d unknown logitech mouse model %d\n", model);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse, "Detected unknown=
 Logitech mouse model %d\n", model);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (set_properties) {
> @@ -400,9 +400,9 @@ int ps2pp_init(struct psmouse *psmouse, bool set_=
properties)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =
=3D device_create_file(&psmouse->ps2dev.serio->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &psmouse_attr_smartscroll.=
dattr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (er=
ror) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 printk(KERN_ERR
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "logips2pp.c: failed to create smartscroll "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "sysfs attribute, error: %d\n", error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 psmouse_err(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to create smartscroll sysfs at=
tribute, error: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0return -1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse=
/psmouse-base.c
> index 3f74bae..9f352fb 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -11,6 +11,9 @@
> =A0* the Free Software Foundation.
> =A0*/
>
> +#define pr_fmt(fmt) =A0 =A0 =A0 =A0 =A0 =A0KBUILD_MODNAME ": " fmt
> +#define psmouse_fmt(fmt) =A0 =A0 =A0 fmt
> +
> =A0#include <linux/delay.h>
> =A0#include <linux/module.h>
> =A0#include <linux/slab.h>
> @@ -251,11 +254,14 @@ static int psmouse_handle_byte(struct psmouse *=
psmouse)
> =A0 =A0 =A0 =A0switch (rc) {
> =A0 =A0 =A0 =A0case PSMOUSE_BAD_DATA:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (psmouse->state =3D=3D PSMOUSE_ACTI=
VATED) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "ps=
mouse.c: %s at %s lost sync at byte %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse=
->name, psmouse->phys, psmouse->pktcnt);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"%s at %s lost sync at byte %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0psmouse->name, psmouse->phys,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0psmouse->pktcnt);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (++psmouse->out_of_=
sync_cnt =3D=3D psmouse->resetafter) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__psmo=
use_set_state(psmouse, PSMOUSE_IGNORE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
KERN_NOTICE "psmouse.c: issuing reconnect request\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse=
_notice(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "issuing reconnect request\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serio_=
reconnect(psmouse->ps2dev.serio);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
 -1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -267,8 +273,9 @@ static int psmouse_handle_byte(struct psmouse *ps=
mouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->pktcnt =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (psmouse->out_of_sync_cnt) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->out_of_sync_c=
nt =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_NOTICE "psm=
ouse.c: %s at %s - driver resynched.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse=
->name, psmouse->phys);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_notice(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "%s at %s - driver resynced.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 psmouse->name, psmouse->phys);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> @@ -295,9 +302,10 @@ static irqreturn_t psmouse_interrupt(struct seri=
o *serio,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((flags & SERIO_PARITY) && !p=
smouse->ignore_parity))) {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (psmouse->state =3D=3D PSMOUSE_ACTI=
VATED)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "ps=
mouse.c: bad data from KBC -%s%s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags &=
 SERIO_TIMEOUT ? " timeout" : "",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags &=
 SERIO_PARITY ? " bad parity" : "");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"bad data from KBC -%s%s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0flags & SERIO_TIMEOUT ? " timeout" : "",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0flags & SERIO_PARITY ? " bad parity" : "");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ps2_cmd_aborted(&psmouse->ps2dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
> @@ -315,8 +323,8 @@ static irqreturn_t psmouse_interrupt(struct serio=
 *serio,
>
> =A0 =A0 =A0 =A0if (psmouse->state =3D=3D PSMOUSE_ACTIVATED &&
> =A0 =A0 =A0 =A0 =A0 =A0psmouse->pktcnt && time_after(jiffies, psmouse=
->last + HZ/2)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "psmouse.c: %s at %s l=
ost synchronization, throwing %d bytes away.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->name, psmouse->=
phys, psmouse->pktcnt);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_info(psmouse, "%s at %s lost sy=
nchronization, throwing %d bytes away.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->nam=
e, psmouse->phys, psmouse->pktcnt);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->badbyte =3D psmouse->packet[0=
];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__psmouse_set_state(psmouse, PSMOUSE_R=
ESYNCING);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse_queue_work(psmouse, &psmouse->=
resync_work, 0);
> @@ -943,7 +951,8 @@ static int psmouse_probe(struct psmouse *psmouse)
> =A0*/
>
> =A0 =A0 =A0 =A0if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_DIS))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "psmouse.c: Failed =
to reset mouse on %s\n", ps2dev->serio->phys);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse, "Failed to reset =
mouse on %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ps2dev->seri=
o->phys);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -1005,8 +1014,8 @@ static void psmouse_initialize(struct psmouse *=
psmouse)
> =A0static void psmouse_activate(struct psmouse *psmouse)
> =A0{
> =A0 =A0 =A0 =A0if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_EN=
ABLE))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "psmouse.c: Failed =
to enable mouse on %s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->ps2dev.serio->=
phys);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse, "Failed to enable=
 mouse on %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->ps2=
dev.serio->phys);
>
> =A0 =A0 =A0 =A0psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
> =A0}
> @@ -1020,14 +1029,14 @@ static void psmouse_activate(struct psmouse *=
psmouse)
> =A0static void psmouse_deactivate(struct psmouse *psmouse)
> =A0{
> =A0 =A0 =A0 =A0if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_DI=
SABLE))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "psmouse.c: Failed =
to deactivate mouse on %s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->ps2dev.serio->=
phys);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse, "Failed to deacti=
vate mouse on %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->ps2=
dev.serio->phys);
>
> =A0 =A0 =A0 =A0psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
> =A0}
>
> =A0/*
> - * psmouse_poll() - default poll hanlder. Everyone except for ALPS u=
ses it.
> + * psmouse_poll() - default poll handler. Everyone except for ALPS u=
ses it.
> =A0*/
>
> =A0static int psmouse_poll(struct psmouse *psmouse)
> @@ -1115,14 +1124,15 @@ static void psmouse_resync(struct work_struct=
 *work)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (!enabled) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "psmouse.c: failed =
to re-enable mouse on %s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->ps2dev.serio->=
phys);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse, "failed to re-ena=
ble mouse on %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->ps2=
dev.serio->phys);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0failed =3D true;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (failed) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse_set_state(psmouse, PSMOUSE_IGN=
ORE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "psmouse.c: resync fai=
led, issuing reconnect request\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_info(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"resync fail=
ed, issuing reconnect request\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serio_reconnect(serio);
> =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse_set_state(psmouse, PSMOUSE_ACT=
IVATED);
> @@ -1155,8 +1165,8 @@ static void psmouse_cleanup(struct serio *serio=
)
> =A0 =A0 =A0 =A0 * Disable stream mode so cleanup routine can proceed =
undisturbed.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_DI=
SABLE))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "psmouse.c: Failed =
to disable mouse on %s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->ps2dev.serio->=
phys);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse, "Failed to disabl=
e mouse on %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->ps2=
dev.serio->phys);
>
> =A0 =A0 =A0 =A0if (psmouse->cleanup)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->cleanup(psmouse);
> @@ -1400,7 +1410,8 @@ static int psmouse_reconnect(struct serio *seri=
o)
> =A0 =A0 =A0 =A0int rc =3D -1;
>
> =A0 =A0 =A0 =A0if (!drv || !psmouse) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "psmouse: reconnect r=
equest, but serio is disconnected, ignoring...\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "reconnect requ=
est, but serio is disconnected, ignoring...\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> @@ -1427,8 +1438,9 @@ static int psmouse_reconnect(struct serio *seri=
o)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* ok, the device type (and capabilities) match the old=
 one,
> - =A0 =A0 =A0 =A0* we can continue using it, complete intialization
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* OK, the device type (and capabilities) match the o=
ld one,
> + =A0 =A0 =A0 =A0* we can continue using it, complete initialization
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
>
> @@ -1586,9 +1598,8 @@ static ssize_t psmouse_attr_set_protocol(struct=
 psmouse *psmouse, void *data, co
>
> =A0 =A0 =A0 =A0while (!list_empty(&serio->children)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (++retry > 3) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "psmous=
e: failed to destroy children ports, "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "protoc=
ol change aborted.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"failed to destroy children ports, protocol change aborted.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_free_device(new_=
dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -1715,7 +1726,7 @@ static int __init psmouse_init(void)
>
> =A0 =A0 =A0 =A0kpsmoused_wq =3D create_singlethread_workqueue("kpsmou=
sed");
> =A0 =A0 =A0 =A0if (!kpsmoused_wq) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "psmouse: failed to cre=
ate kpsmoused workqueue\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to create kpsmoused work=
queue\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> =A0 =A0 =A0 =A0}
>
> diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmo=
use.h
> index 593e910..9b84b0c 100644
> --- a/drivers/input/mouse/psmouse.h
> +++ b/drivers/input/mouse/psmouse.h
> @@ -150,4 +150,29 @@ static struct psmouse_attribute psmouse_attr_##_=
name =3D { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0static ssize_t _set(struct psmouse *, void *, const ch=
ar *, size_t); =A0 =A0\
> =A0 =A0 =A0 =A0__PSMOUSE_DEFINE_ATTR_VAR(_name, _mode, _data, NULL, _=
set, true)
>
> +#ifndef psmouse_fmt
> +#define psmouse_fmt(fmt) =A0 =A0 =A0 KBUILD_BASENAME ": " fmt
> +#endif
> +
> +#define psmouse_dbg(psmouse, format, ...) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
\
> + =A0 =A0 =A0 dev_dbg(&(psmouse)->ps2dev.serio->dev, =A0 =A0 =A0 =A0 =
=A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_fmt(format), ##__VA_ARGS__)
> +#define psmouse_info(psmouse, format, ...) =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 dev_info(&(psmouse)->ps2dev.serio->dev, =A0 =A0 =A0 =A0=
 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse_fmt(format), ##__VA_ARGS__)
> +#define psmouse_warn(psmouse, format, ...) =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 dev_warn(&(psmouse)->ps2dev.serio->dev, =A0 =A0 =A0 =A0=
 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse_fmt(format), ##__VA_ARGS__)
> +#define psmouse_err(psmouse, format, ...) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
\
> + =A0 =A0 =A0 dev_err(&(psmouse)->ps2dev.serio->dev, =A0 =A0 =A0 =A0 =
=A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_fmt(format), ##__VA_ARGS__)
> +#define psmouse_notice(psmouse, format, ...) =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 dev_notice(&(psmouse)->ps2dev.serio->dev, =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse_fmt(format), ##__VA_ARGS=
__)
> +#define psmouse_printk(level, psmouse, format, ...) =A0 =A0\
> + =A0 =A0 =A0 dev_printk(level, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&(psmouse)->ps2dev.serio->dev, =A0=
 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse_fmt(format), ##__VA_ARGS=
__)
> +
> +
> =A0#endif /* _PSMOUSE_H */
> diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sen=
telic.c
> index 2fc887a..c5b12d2 100644
> --- a/drivers/input/mouse/sentelic.c
> +++ b/drivers/input/mouse/sentelic.c
> @@ -607,11 +607,12 @@ static void fsp_packet_debug(unsigned char pack=
et[])
>
> =A0 =A0 =A0 =A0ps2_packet_cnt++;
> =A0 =A0 =A0 =A0jiffies_msec =3D jiffies_to_msecs(jiffies);
> - =A0 =A0 =A0 printk(KERN_DEBUG "%08dms PS/2 packets: %02x, %02x, %02=
x, %02x\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 jiffies_msec, packet[0], packet[1], pac=
ket[2], packet[3]);
> + =A0 =A0 =A0 psmouse_dbg(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%08dms PS/2 packets: %02x, %02=
x, %02x, %02x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 jiffies_msec, packet[0], packet=
[1], packet[2], packet[3]);
>
> =A0 =A0 =A0 =A0if (jiffies_msec - ps2_last_second > 1000) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "PS/2 packets/sec =3D=
 %d\n", ps2_packet_cnt);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse, "PS/2 packets/sec =
=3D %d\n", ps2_packet_cnt);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ps2_packet_cnt =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ps2_last_second =3D jiffies_msec;
> =A0 =A0 =A0 =A0}
> @@ -820,9 +821,9 @@ int fsp_init(struct psmouse *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 printk(KERN_INFO
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Finger Sensing Pad, hw: %d.%d.%d, sw: =
%s, buttons: %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ver >> 4, ver & 0x0F, rev, fsp_drv_ver,=
 buttons & 7);
> + =A0 =A0 =A0 psmouse_info(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Finger Sensing Pad, hw: %d.=
%d.%d, sw: %s, buttons: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ver >> 4, ver & 0x0F, rev, f=
sp_drv_ver, buttons & 7);
>
> =A0 =A0 =A0 =A0psmouse->private =3D priv =3D kzalloc(sizeof(struct fs=
p_data), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!priv)
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/sy=
naptics.c
> index 30c85a5..9d46c98 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -167,8 +167,8 @@ static int synaptics_capability(struct psmouse *p=
smouse)
>
> =A0 =A0 =A0 =A0if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >=3D 1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (synaptics_send_cmd(psmouse, SYN_QU=
E_EXT_CAPAB, cap)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Synapt=
ics claims to have extended capabilities,"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" but I'=
m not able to read them.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"device claims to have extended capabilities, but I'm not able to r=
ead them.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->ext_cap =3D (cap=
[0] << 16) | (cap[1] << 8) | cap[2];
>
> @@ -183,8 +183,8 @@ static int synaptics_capability(struct psmouse *p=
smouse)
>
> =A0 =A0 =A0 =A0if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >=3D 4) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (synaptics_send_cmd(psmouse, SYN_QU=
E_EXT_CAPAB_0C, cap)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Synapt=
ics claims to have extended capability 0x0c,"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" but I'=
m not able to read it.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"device claims to have extended capability 0x0c, but I'm not able t=
o read it.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->ext_cap_0c =3D (=
cap[0] << 16) | (cap[1] << 8) | cap[2];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -232,8 +232,8 @@ static int synaptics_resolution(struct psmouse *p=
smouse)
> =A0 =A0 =A0 =A0if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >=3D 5 &&
> =A0 =A0 =A0 =A0 =A0 =A0SYN_CAP_MAX_DIMENSIONS(priv->ext_cap_0c)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (synaptics_send_cmd(psmouse, SYN_QU=
E_EXT_MAX_COORDS, resp)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Synapt=
ics claims to have max coordinates"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" query,=
 but I'm not able to read it.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"device claims to have max coordinates query, but I'm not able to r=
ead it.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->x_max =3D (resp[=
0] << 5) | ((resp[1] & 0x0f) << 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->y_max =3D (resp[=
2] << 5) | ((resp[1] & 0xf0) >> 3);
> @@ -243,8 +243,8 @@ static int synaptics_resolution(struct psmouse *p=
smouse)
> =A0 =A0 =A0 =A0if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >=3D 7 &&
> =A0 =A0 =A0 =A0 =A0 =A0SYN_CAP_MIN_DIMENSIONS(priv->ext_cap_0c)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (synaptics_send_cmd(psmouse, SYN_QU=
E_EXT_MIN_COORDS, resp)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Synapt=
ics claims to have min coordinates"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" query,=
 but I'm not able to read it.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"device claims to have min coordinates query, but I'm not able to r=
ead it.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->x_min =3D (resp[=
0] << 5) | ((resp[1] & 0x0f) << 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->y_min =3D (resp[=
2] << 5) | ((resp[1] & 0xf0) >> 3);
> @@ -388,7 +388,8 @@ static void synaptics_pt_activate(struct psmouse =
*psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->mode &=3D ~SYN_B=
IT_FOUR_BYTE_CLIENT;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (synaptics_mode_cmd(psmouse, priv->=
mode))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "synap=
tics: failed to switch guest protocol\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_warn(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0"failed to switch guest protocol\n");
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -398,7 +399,8 @@ static void synaptics_pt_create(struct psmouse *p=
smouse)
>
> =A0 =A0 =A0 =A0serio =3D kzalloc(sizeof(struct serio), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!serio) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "synaptics: not enough =
memory to allocate pass-through port\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "not enough mem=
ory for pass-through port\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> @@ -412,7 +414,8 @@ static void synaptics_pt_create(struct psmouse *p=
smouse)
>
> =A0 =A0 =A0 =A0psmouse->pt_activate =3D synaptics_pt_activate;
>
> - =A0 =A0 =A0 printk(KERN_INFO "serio: %s port at %s\n", serio->name,=
 psmouse->phys);
> + =A0 =A0 =A0 psmouse_info(psmouse, "serio: %s port at %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serio->name, psmouse->phys);
> =A0 =A0 =A0 =A0serio_register_port(serio);
> =A0}
>
> @@ -1049,13 +1052,15 @@ static void synaptics_process_packet(struct p=
smouse *psmouse)
> =A0 =A0 =A0 =A0input_sync(dev);
> =A0}
>
> -static int synaptics_validate_byte(unsigned char packet[], int idx, =
unsigned char pkt_type)

Why pass idx if we already have psmouse?

static int synaptics_validate_byte(struct psmouse *psmouse, unsigned
char pkt_type)
> =A0{
> =A0 =A0 =A0 =A0static const unsigned char newabs_mask[] =A0 =A0 =A0 =A0=
=3D { 0xC8, 0x00, 0x00, 0xC8, 0x00 };
> =A0 =A0 =A0 =A0static const unsigned char newabs_rel_mask[] =A0 =A0=3D=
 { 0xC0, 0x00, 0x00, 0xC0, 0x00 };
> =A0 =A0 =A0 =A0static const unsigned char newabs_rslt[] =A0 =A0 =A0 =A0=
=3D { 0x80, 0x00, 0x00, 0xC0, 0x00 };
> =A0 =A0 =A0 =A0static const unsigned char oldabs_mask[] =A0 =A0 =A0 =A0=
=3D { 0xC0, 0x60, 0x00, 0xC0, 0x60 };
> =A0 =A0 =A0 =A0static const unsigned char oldabs_rslt[] =A0 =A0 =A0 =A0=
=3D { 0xC0, 0x00, 0x00, 0x80, 0x00 };
> + =A0 =A0 =A0 const char *packet =3D psmouse->packet;
    int idx =3D psmouse->pktcnt - 1;

>
> =A0 =A0 =A0 =A0if (idx < 0 || idx > 4)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> @@ -1073,7 +1078,7 @@ static int synaptics_validate_byte(unsigned cha=
r packet[], int idx, unsigned cha
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return (packet[idx] & oldabs_mask[idx]=
) =3D=3D oldabs_rslt[idx];
>
> =A0 =A0 =A0 =A0default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "synaptics: unknown pac=
ket type %d\n", pkt_type);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "unknown packet ty=
pe %d\n", pkt_type);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0}
> =A0}
> @@ -1083,8 +1088,8 @@ static unsigned char synaptics_detect_pkt_type(=
struct psmouse *psmouse)
> =A0 =A0 =A0 =A0int i;
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < 5; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!synaptics_validate_byte(psmouse->p=
acket, i, SYN_NEWABS_STRICT)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "synap=
tics: using relaxed packet validation\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!synaptics_validate_byte(psmouse, i=
, SYN_NEWABS_STRICT)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_info(psmouse, "=
using relaxed packet validation\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return SYN_NEWABS_RELA=
XED;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> @@ -1109,7 +1114,7 @@ static psmouse_ret_t synaptics_process_byte(str=
uct psmouse *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PSMOUSE_FULL_PACKET;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 return synaptics_validate_byte(psmouse->packet, psmouse=
->pktcnt - 1, priv->pkt_type) ?
> + =A0 =A0 =A0 return synaptics_validate_byte(psmouse, psmouse->pktcnt=
 - 1, priv->pkt_type) ?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PSMOUSE_GOOD_DATA : PSMOUSE_BAD_DATA;
> =A0}
>
> @@ -1222,21 +1227,22 @@ static int synaptics_reconnect(struct psmouse=
 *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> =A0 =A0 =A0 =A0if (retry > 1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "Synaptics reconnecte=
d after %d tries\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retry);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_dbg(psmouse, "reconnected after=
 %d tries\n", retry);
>
> =A0 =A0 =A0 =A0if (synaptics_query_hardware(psmouse)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to query Synapt=
ics hardware.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "Unable to query S=
ynaptics hardware.\n");
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "unable to query devi=
ce.\n");

We can get rid of some more redundant "Synaptics"...

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (synaptics_set_absolute_mode(psmouse)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to initialize S=
ynaptics hardware.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Unable to init=
ialize Synaptics hardware.\n");
=A0  =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "unable to initia=
lize device.\n");

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (synaptics_set_advanced_gesture_mode(psmouse)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Advanced gesture mode =
reconnect failed.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Advanced gestu=
re mode reconnect failed.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> @@ -1244,12 +1250,12 @@ static int synaptics_reconnect(struct psmouse=
 *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0old_priv.model_id !=3D priv->model_id ||
> =A0 =A0 =A0 =A0 =A0 =A0old_priv.capabilities !=3D priv->capabilities =
||
> =A0 =A0 =A0 =A0 =A0 =A0old_priv.ext_cap !=3D priv->ext_cap) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Synaptics hardware app=
ears to be different: "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "id(%ld-%ld), model(%ld=
-%ld), caps(%lx-%lx), ext(%lx-%lx).\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_priv.identity, priv=
->identity,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_priv.model_id, priv=
->model_id,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_priv.capabilities, =
priv->capabilities,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_priv.ext_cap, priv-=
>ext_cap);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "hardware appea=
rs to be different: id(%ld-%ld), model(%ld-%ld), caps(%lx-%lx), ext(%lx=
-%lx).\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_priv.identi=
ty, priv->identity,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_priv.model_=
id, priv->model_id,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_priv.capabi=
lities, priv->capabilities,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_priv.ext_ca=
p, priv->ext_cap);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> @@ -1330,7 +1336,8 @@ int synaptics_init(struct psmouse *psmouse)
> =A0 =A0 =A0 =A0 * just fine.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (broken_olpc_ec) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "synaptics: OLPC XO de=
tected, not enabling Synaptics protocol.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_info(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"OLPC XO det=
ected, not enabling Synaptics protocol.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
>
> @@ -1341,26 +1348,29 @@ int synaptics_init(struct psmouse *psmouse)
> =A0 =A0 =A0 =A0psmouse_reset(psmouse);
>
> =A0 =A0 =A0 =A0if (synaptics_query_hardware(psmouse)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to query Synapt=
ics hardware.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "Unable to query S=
ynaptics hardware.\n");
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "unable to query devi=
ce.\n");

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto init_fail;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (synaptics_set_absolute_mode(psmouse)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to initialize S=
ynaptics hardware.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Unable to init=
ialize Synaptics hardware.\n");
=A0  =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "unable to initia=
lize device.\n");

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto init_fail;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (synaptics_set_advanced_gesture_mode(psmouse)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Advanced gesture mode =
init failed.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_err(psmouse, "Advanced gesture =
mode init failed.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto init_fail;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0priv->pkt_type =3D SYN_MODEL_NEWABS(priv->model_id) ? =
SYN_NEWABS : SYN_OLDABS;
>
> - =A0 =A0 =A0 printk(KERN_INFO "Synaptics Touchpad, model: %ld, fw: %=
ld.%ld, id: %#lx, caps: %#lx/%#lx/%#lx\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 SYN_ID_MODEL(priv->identity),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 SYN_ID_MAJOR(priv->identity), SYN_ID_MI=
NOR(priv->identity),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->model_id, priv->capabilities, pri=
v->ext_cap, priv->ext_cap_0c);
> + =A0 =A0 =A0 psmouse_info(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Touchpad model: %ld, fw: %l=
d.%ld, id: %#lx, caps: %#lx/%#lx/%#lx\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYN_ID_MODEL(priv->identity)=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYN_ID_MAJOR(priv->identity)=
, SYN_ID_MINOR(priv->identity),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->model_id,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->capabilities, priv->ex=
t_cap, priv->ext_cap_0c);
>
> =A0 =A0 =A0 =A0set_input_params(psmouse->dev, priv);
>
> @@ -1392,8 +1402,9 @@ int synaptics_init(struct psmouse *psmouse)
> =A0 =A0 =A0 =A0 * the same rate as a standard PS/2 mouse).
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (psmouse->rate >=3D 80 && impaired_toshiba_kbc) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "synaptics: Toshiba %s=
 detected, limiting rate to 40pps.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmi_get_system_info(DMI=
_PRODUCT_NAME));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_info(psmouse,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Toshiba %s =
detected, limiting rate to 40pps.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dmi_get_syst=
em_info(DMI_PRODUCT_NAME));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->rate =3D 40;
> =A0 =A0 =A0 =A0}
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
