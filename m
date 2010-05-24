From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] powerpc: Add i8042 keyboard and mouse irq parsing
Date: Mon, 24 May 2010 11:33:34 -0600
Message-ID: <AANLkTikrakCQhSn9y07sSKlc2QuLU1Mg52Ko_cSsx2lZ@mail.gmail.com>
References: <20100524162325.11133.8579.stgit@ES-J7S4D2J.amer.consind.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33418 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757659Ab0EXRdz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 May 2010 13:33:55 -0400
Received: by gwaa20 with SMTP id a20so1599217gwa.19
        for <linux-input@vger.kernel.org>; Mon, 24 May 2010 10:33:54 -0700 (PDT)
In-Reply-To: <20100524162325.11133.8579.stgit@ES-J7S4D2J.amer.consind.ge.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martyn Welch <martyn.welch@ge.com>
Cc: benh@kernel.crashing.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org

On Mon, May 24, 2010 at 10:25 AM, Martyn Welch <martyn.welch@ge.com> wr=
ote:
> Currently the irqs for the i8042, which historically provides keyboar=
d and
> mouse (aux) support, is hardwired in the driver rather than parsing t=
he
> dts. =A0This patch modifies the powerpc legacy IO code to attempt to =
parse
> the device tree for this information, failing back to the hardcoded v=
alues
> if it fails.
>
> Signed-off-by: Martyn Welch <martyn.welch@ge.com>
> ---
>
> v2: This patch no longer requires the DTS files to be modified, readi=
ng the
> interrupts from the current location as suggested by Grant.
>
> =A0arch/powerpc/kernel/setup-common.c | =A0 49 ++++++++++++++++++++++=
++++++++++++--
> =A0drivers/input/serio/i8042-io.h =A0 =A0 | =A0 =A08 ++++++
> =A02 files changed, 54 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel=
/setup-common.c
> index 48f0a00..7f1bb99 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -94,6 +94,10 @@ struct screen_info screen_info =3D {
> =A0 =A0 =A0 =A0.orig_video_points =3D 16
> =A0};
>
> +/* Variables required to store legacy IO irq routing */
> +int of_i8042_kbd_irq;
> +int of_i8042_aux_irq;
> +
> =A0#ifdef __DO_IRQ_CANON
> =A0/* XXX should go elsewhere eventually */
> =A0int ppc_do_canonicalize_irqs;
> @@ -558,13 +562,52 @@ void probe_machine(void)
> =A0/* Match a class of boards, not a specific device configuration. *=
/
> =A0int check_legacy_ioport(unsigned long base_port)
> =A0{
> - =A0 =A0 =A0 struct device_node *parent, *np =3D NULL;
> + =A0 =A0 =A0 struct device_node *parent, *np =3D NULL, *np_aux =3D N=
ULL;
> =A0 =A0 =A0 =A0int ret =3D -ENODEV;
>
> =A0 =A0 =A0 =A0switch(base_port) {
> =A0 =A0 =A0 =A0case I8042_DATA_REG:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(np =3D of_find_compatible_node(NU=
LL, NULL, "pnpPNP,303")))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 np =3D of_find_compatib=
le_node(NULL, NULL, "pnpPNP,f03");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NU=
LL, "pnpPNP,303");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Interrupt routing in=
 parent node */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent =3D of_get_paren=
t(np);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (parent) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* At=
tempt to parse DTS for keyboard irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fa=
llback to standard.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_i804=
2_kbd_irq =3D irq_of_parse_and_map(parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!of=
_i8042_kbd_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 of_i8042_kbd_irq =3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node=
_put(parent);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 np_aux =3D of_find_compatible_node(NULL=
, NULL, "pnpPNP,f03");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (np_aux) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node=
_put(np);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 np =3D =
np_aux;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Interrupt routing in=
 parent node */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent =3D of_get_paren=
t(np_aux);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (parent) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* At=
tempt to parse DTS for mouse (aux) irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fa=
llback to standard.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_i804=
2_aux_irq =3D irq_of_parse_and_map(parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!of=
_i8042_aux_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 of_i8042_aux_irq =3D 12;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node=
_put(parent);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +

This seems to be a lot more code that you need.  The existing code
already obtains a pointer to the parent node for you.  All you really
should need to add is the two calls to irq_of_parse_and_map() for
obtaining the kbd and aux irq numbers.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (np) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parent =3D of_get_pare=
nt(np);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_node_put(np);
> diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i80=
42-io.h
> index 847f4aa..8fc8753 100644
> --- a/drivers/input/serio/i8042-io.h
> +++ b/drivers/input/serio/i8042-io.h
> @@ -19,6 +19,11 @@
> =A0* IRQs.
> =A0*/
>
> +#if defined(CONFIG_PPC)
> +extern int of_i8042_kbd_irq;
> +extern int of_i8042_aux_irq;
> +#endif

Please fold these two extern definitions into the #elif
defined(CONFIG_PPC) block below.

> +
> =A0#ifdef __alpha__
> =A0# define I8042_KBD_IRQ 1
> =A0# define I8042_AUX_IRQ (RTC_PORT(0) =3D=3D 0x170 ? 9 : 12) /* Jens=
en is special */
> @@ -27,6 +32,9 @@
> =A0#include <asm/irq.h>
> =A0#elif defined(CONFIG_SH_CAYMAN)
> =A0#include <asm/irq.h>
> +#elif defined(CONFIG_PPC)
> +#define I8042_KBD_IRQ =A0of_i8042_kbd_irq
> +#define I8042_AUX_IRQ =A0of_i8042_aux_irq
> =A0#else
> =A0# define I8042_KBD_IRQ 1
> =A0# define I8042_AUX_IRQ 12

Cheers,
g.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
