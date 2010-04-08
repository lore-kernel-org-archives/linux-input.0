From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [patch 3/3] Convert drivers/media/dvb/ttpci/budget-ci.c to use
 ir-core
Date: Thu, 08 Apr 2010 18:59:30 -0300
Message-ID: <4BBE51C2.8060505@infradead.org>
References: <20100402185827.425741206@hardeman.nu> <20100402190255.774628605@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100402190255.774628605@hardeman.nu>
Sender: linux-media-owner@vger.kernel.org
To: david@hardeman.nu
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

david@hardeman.nu wrote:
> This patch converts drivers/media/dvb/ttpci/budget-ci.c to use ir-cor=
e
> rather than rolling its own keydown timeout handler and reporting key=
s
> via drivers/media/IR/ir-functions.c.

Hmm... had you test this patch? It got me an error here:

drivers/media/dvb/ttpci/budget-ci.c: In function =91msp430_ir_init=92:
drivers/media/dvb/ttpci/budget-ci.c:228: error: implicit declaration of=
 function =91ir_input_init=92
drivers/media/dvb/ttpci/budget-ci.c:228: error: =91struct budget_ci_ir=92=
 has no member named =91state=92

The fix is trivial. Just drop this line:

        ir_input_init(input_dev, &budget_ci->ir.state, IR_TYPE_RC5);

It shouldn't cause any troubles, since the only things this function cu=
rrently do are:
        ir->ir_type =3D ir_type;

        if (repeat)
                set_bit(EV_REP, dev->evbit);

As the repeat is inside ir-core, and the ir struct is not used anymore,=
 this removal
should cause no harm.

So, I am dropping the line at the code I'm committing at v4l-dvb.git, t=
o avoid bisect
breakages.

>=20
> Signed-off-by: David H=C3=A4rdeman <david@hardeman.nu>
>=20
>=20
> Index: ir/drivers/media/dvb/ttpci/budget-ci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ir.orig/drivers/media/dvb/ttpci/budget-ci.c	2010-04-02 16:41:15.5=
24206900 +0200
> +++ ir/drivers/media/dvb/ttpci/budget-ci.c	2010-04-02 16:48:15.668239=
437 +0200
> @@ -35,7 +35,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/input.h>
>  #include <linux/spinlock.h>
> -#include <media/ir-common.h>
> +#include <media/ir-core.h>
> =20
>  #include "budget.h"
> =20
> @@ -82,12 +82,6 @@
>  #define SLOTSTATUS_READY	8
>  #define SLOTSTATUS_OCCUPIED	(SLOTSTATUS_PRESENT|SLOTSTATUS_RESET|SLO=
TSTATUS_READY)
> =20
> -/*
> - * Milliseconds during which a key is regarded as pressed.
> - * If an identical command arrives within this time, the timer will =
start over.
> - */
> -#define IR_KEYPRESS_TIMEOUT	250
> -
>  /* RC5 device wildcard */
>  #define IR_DEVICE_ANY		255
> =20
> @@ -104,12 +98,9 @@
>  struct budget_ci_ir {
>  	struct input_dev *dev;
>  	struct tasklet_struct msp430_irq_tasklet;
> -	struct timer_list timer_keyup;
>  	char name[72]; /* 40 + 32 for (struct saa7146_dev).name */
>  	char phys[32];
> -	struct ir_input_state state;
>  	int rc5_device;
> -	u32 last_raw;
>  	u32 ir_key;
>  	bool have_command;
>  };
> @@ -124,18 +115,11 @@
>  	u8 tuner_pll_address; /* used for philips_tdm1316l configs */
>  };
> =20
> -static void msp430_ir_keyup(unsigned long data)
> -{
> -	struct budget_ci_ir *ir =3D (struct budget_ci_ir *) data;
> -	ir_input_nokey(ir->dev, &ir->state);
> -}
> -
>  static void msp430_ir_interrupt(unsigned long data)
>  {
>  	struct budget_ci *budget_ci =3D (struct budget_ci *) data;
>  	struct input_dev *dev =3D budget_ci->ir.dev;
>  	u32 command =3D ttpci_budget_debiread(&budget_ci->budget, DEBINOSWA=
P, DEBIADDR_IR, 2, 1, 0) >> 8;
> -	u32 raw;
> =20
>  	/*
>  	 * The msp430 chip can generate two different bytes, command and de=
vice
> @@ -171,20 +155,12 @@
>  		return;
>  	budget_ci->ir.have_command =3D false;
> =20
> +	/* FIXME: We should generate complete scancodes with device info */
>  	if (budget_ci->ir.rc5_device !=3D IR_DEVICE_ANY &&
>  	    budget_ci->ir.rc5_device !=3D (command & 0x1f))
>  		return;
> =20
> -	/* Is this a repeated key sequence? (same device, command, toggle) =
*/
> -	raw =3D budget_ci->ir.ir_key | (command << 8);
> -	if (budget_ci->ir.last_raw !=3D raw || !timer_pending(&budget_ci->i=
r.timer_keyup)) {
> -		ir_input_nokey(dev, &budget_ci->ir.state);
> -		ir_input_keydown(dev, &budget_ci->ir.state,
> -				 budget_ci->ir.ir_key);
> -		budget_ci->ir.last_raw =3D raw;
> -	}
> -
> -	mod_timer(&budget_ci->ir.timer_keyup, jiffies + msecs_to_jiffies(IR=
_KEYPRESS_TIMEOUT));
> +	ir_keydown(dev, budget_ci->ir.ir_key, (command & 0x20) ? 1 : 0);
>  }
> =20
>  static int msp430_ir_init(struct budget_ci *budget_ci)
> @@ -251,11 +227,6 @@
> =20
>  	ir_input_init(input_dev, &budget_ci->ir.state, IR_TYPE_RC5);
> =20
> -	/* initialise the key-up timeout handler */
> -	init_timer(&budget_ci->ir.timer_keyup);
> -	budget_ci->ir.timer_keyup.function =3D msp430_ir_keyup;
> -	budget_ci->ir.timer_keyup.data =3D (unsigned long) &budget_ci->ir;
> -	budget_ci->ir.last_raw =3D 0xffff; /* An impossible value */
>  	error =3D ir_input_register(input_dev, ir_codes, NULL, MODULE_NAME)=
;
>  	if (error) {
>  		printk(KERN_ERR "budget_ci: could not init driver for IR device (c=
ode %d)\n", error);
> @@ -284,9 +255,6 @@
>  	saa7146_setgpio(saa, 3, SAA7146_GPIO_INPUT);
>  	tasklet_kill(&budget_ci->ir.msp430_irq_tasklet);
> =20
> -	del_timer_sync(&dev->timer);
> -	ir_input_nokey(dev, &budget_ci->ir.state);
> -
>  	ir_input_unregister(dev);
>  }
> =20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20

Cheers,
Mauro
