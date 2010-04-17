From: Damjan Jovanovic <damjan.jov@gmail.com>
Subject: Re: [PATCH] input: handle bad parity PS/2 packets in mouse drivers
	better
Date: Sat, 17 Apr 2010 11:33:27 +0200
Message-ID: <m2k9e89675b1004170233yb5ab19ach1713ccbee001883e@mail.gmail.com>
References: <r2x9e89675b1004080434yfea09b06x2c3c4680a9437a9@mail.gmail.com>
	 <g2v9e89675b1004130429w6f6f9775u2e34d4727de706e@mail.gmail.com>
	 <20100414205959.GB11838@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:8924 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093Ab0DQJd3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Apr 2010 05:33:29 -0400
In-Reply-To: <20100414205959.GB11838@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alessandro Rubini <rubini@ipvvis.unipv.it>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, akpm@linux-foundation.org

On Wed, Apr 14, 2010 at 10:59 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Damjan,
>
> On Tue, Apr 13, 2010 at 01:29:20PM +0200, Damjan Jovanovic wrote:
>> This fixes a regression introduced in Linux 2.6.2 where mice that
>> sporadically produce bad parity go crazy and start jumping around an=
d
>> clicking randomly, which never happens in any version of Windows
>> running on the same hardware. The bugzilla bug is
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D6105
>>
>> The patch works by always accumulating a full PS/2 packet, then
>> ignoring the packet if any byte had a bad checksum. A month of testi=
ng
>> it against an affected mouse has revealed it works perfectly in
>> practice.
>>
>> This is the third resend, also CC'ed to lkml and Andrew Morton this
>> time, because the previous 2 emails to linux-input@vger.kernel.org a=
nd
>> the input/mouse maintainers from 28 March 2010 were ignored.
>>
>
> I am not sure whether we can rely on the mouse and KBC combo to alway=
s
> finish transmitting entire packet when parity error is detected,
> regardless of the protocol involved. However I had a chanceto observe
> several versions of the $OTHER_OS in presence of parity errors and
> they (at least when used with stock mouse driver) appear to simply
> ignore errors and process motion data as usual. Therefore I propose
> instead of your patch the patch below.
>
> Could you please try it on your box and see if it helps?
>
> Thanks.
>
> --
> Dmitry

Hi Dmitry and others

This patch works.

Thank you
Damjan Jovanovic





>
> Input: psmouse - ignore parity error for basic protocols
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Observing behavior of the other OS it appears that parity errors repo=
rted
> by the keyboard controller are being ignored and the data is processe=
d
> as usual. Let's do the same for standard PS/2 protocols (bare, Intell=
imouse
> and Intellimouse Explorer) to provide better compatibility. Thsi shou=
ld fix
> teh following bug:
>
> =A0 =A0 =A0 =A0https://bugzilla.kernel.org/show_bug.cgi?id=3D6105
>
> Thanks for Damjan Jovanovic for locating the source of issue and idea=
s
> for the patch.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =A0drivers/input/mouse/psmouse-base.c | =A0 18 +++++++++++++++---
> =A0drivers/input/mouse/psmouse.h =A0 =A0 =A0| =A0 =A01 +
> =A02 files changed, 16 insertions(+), 3 deletions(-)
>
>
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse=
/psmouse-base.c
> index d8c0c8d..cbc8072 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -110,6 +110,7 @@ static struct workqueue_struct *kpsmoused_wq;
> =A0struct psmouse_protocol {
> =A0 =A0 =A0 =A0enum psmouse_type type;
> =A0 =A0 =A0 =A0bool maxproto;
> + =A0 =A0 =A0 bool ignore_parity; /* Protocol should ignore parity er=
rors from KBC */
> =A0 =A0 =A0 =A0const char *name;
> =A0 =A0 =A0 =A0const char *alias;
> =A0 =A0 =A0 =A0int (*detect)(struct psmouse *, bool);
> @@ -288,7 +289,9 @@ static irqreturn_t psmouse_interrupt(struct serio=
 *serio,
> =A0 =A0 =A0 =A0if (psmouse->state =3D=3D PSMOUSE_IGNORE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> - =A0 =A0 =A0 if (flags & (SERIO_PARITY|SERIO_TIMEOUT)) {
> + =A0 =A0 =A0 if (unlikely((flags & SERIO_TIMEOUT) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((flags & SERIO_PARITY) && !=
psmouse->ignore_parity))) {
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (psmouse->state =3D=3D PSMOUSE_ACTI=
VATED)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_WARNING "p=
smouse.c: bad data from KBC -%s%s\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flags =
& SERIO_TIMEOUT ? " timeout" : "",
> @@ -759,6 +762,7 @@ static const struct psmouse_protocol psmouse_prot=
ocols[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "PS/2",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.alias =A0 =A0 =A0 =A0 =A0=3D "bare",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.maxproto =A0 =A0 =A0 =3D true,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ignore_parity =A0=3D true,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.detect =A0 =A0 =A0 =A0 =3D ps2bare_de=
tect,
> =A0 =A0 =A0 =A0},
> =A0#ifdef CONFIG_MOUSE_PS2_LOGIPS2PP
> @@ -786,6 +790,7 @@ static const struct psmouse_protocol psmouse_prot=
ocols[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "ImPS/2"=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.alias =A0 =A0 =A0 =A0 =A0=3D "imps",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.maxproto =A0 =A0 =A0 =3D true,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ignore_parity =A0=3D true,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.detect =A0 =A0 =A0 =A0 =3D intellimou=
se_detect,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> @@ -793,6 +798,7 @@ static const struct psmouse_protocol psmouse_prot=
ocols[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "ImExPS/=
2",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.alias =A0 =A0 =A0 =A0 =A0=3D "exps",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.maxproto =A0 =A0 =A0 =3D true,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ignore_parity =A0=3D true,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.detect =A0 =A0 =A0 =A0 =3D im_explore=
r_detect,
> =A0 =A0 =A0 =A0},
> =A0#ifdef CONFIG_MOUSE_PS2_SYNAPTICS
> @@ -1222,6 +1228,7 @@ static void psmouse_disconnect(struct serio *se=
rio)
> =A0static int psmouse_switch_protocol(struct psmouse *psmouse,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c=
onst struct psmouse_protocol *proto)
> =A0{
> + =A0 =A0 =A0 const struct psmouse_protocol *selected_proto;
> =A0 =A0 =A0 =A0struct input_dev *input_dev =3D psmouse->dev;
>
> =A0 =A0 =A0 =A0input_dev->dev.parent =3D &psmouse->ps2dev.serio->dev;
> @@ -1245,9 +1252,14 @@ static int psmouse_switch_protocol(struct psmo=
use *psmouse,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->type =3D proto->type;
> - =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 selected_proto =3D proto;
> + =A0 =A0 =A0 } else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->type =3D psmouse_extensions(p=
smouse,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse_max_proto, true);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 selected_proto =3D psmouse_protocol_by_=
type(psmouse->type);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 psmouse->ignore_parity =3D selected_proto->ignore_parit=
y;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * If mouse's packet size is 3 there is no point in po=
lling the
> @@ -1267,7 +1279,7 @@ static int psmouse_switch_protocol(struct psmou=
se *psmouse,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->resync_time =3D 0;
>
> =A0 =A0 =A0 =A0snprintf(psmouse->devname, sizeof(psmouse->devname), "=
%s %s %s",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse_protocol_by_type(psmouse->ty=
pe)->name, psmouse->vendor, psmouse->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0selected_proto->name, psmouse->vendo=
r, psmouse->name);
>
> =A0 =A0 =A0 =A0input_dev->name =3D psmouse->devname;
> =A0 =A0 =A0 =A0input_dev->phys =3D psmouse->phys;
> diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmo=
use.h
> index e053bdd..593e910 100644
> --- a/drivers/input/mouse/psmouse.h
> +++ b/drivers/input/mouse/psmouse.h
> @@ -47,6 +47,7 @@ struct psmouse {
> =A0 =A0 =A0 =A0unsigned char pktcnt;
> =A0 =A0 =A0 =A0unsigned char pktsize;
> =A0 =A0 =A0 =A0unsigned char type;
> + =A0 =A0 =A0 bool ignore_parity;
> =A0 =A0 =A0 =A0bool acks_disable_command;
> =A0 =A0 =A0 =A0unsigned int model;
> =A0 =A0 =A0 =A0unsigned long last;
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
