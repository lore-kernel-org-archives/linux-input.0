From: Dave Young <hidave.darkstar@gmail.com>
Subject: Re: [PATCH][RFC] input: remove bios I8042_CTR_XLATE check to make
	keyboard usable
Date: Mon, 2 Nov 2009 18:49:34 +0800
Message-ID: <a8e1da0911020249w5f21c7d7t4b9bb7de77b32304@mail.gmail.com>
References: <20091027053404.GA2241@darkstar.vlan7>
	 <20091028054309.GA2368@core.coreip.homeip.net>
	 <20091028100318.GA4861@suse.cz> <20091028104211.GA2207@darkstar.vlan7>
	 <20091029003325.GA2739@darkstar.vlan7>
	 <20091029032633.GA7959@core.coreip.homeip.net>
	 <20091029071544.GA2220@darkstar.vlan7>
	 <a8e1da0911010133u57bd85cfj6cdcb789edc4d522@mail.gmail.com>
	 <20091102074737.GA3063@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:39468 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424AbZKBKtb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Nov 2009 05:49:31 -0500
In-Reply-To: <20091102074737.GA3063@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Mon, Nov 2, 2009 at 3:47 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Dave,
>
> On Sun, Nov 01, 2009 at 04:33:05PM +0800, Dave Young wrote:
>> On Thu, Oct 29, 2009 at 3:15 PM, Dave Young <hidave.darkstar@gmail.c=
om> wrote:
>> > On Wed, Oct 28, 2009 at 08:26:33PM -0700, Dmitry Torokhov wrote:
>> >> On Thu, Oct 29, 2009 at 08:33:26AM +0800, Dave Young wrote:
>> >> > On Wed, Oct 28, 2009 at 06:42:12PM +0800, Dave Young wrote:
>> >> > > On Wed, Oct 28, 2009 at 11:03:18AM +0100, Vojtech Pavlik wrot=
e:
>> >> > > > On Tue, Oct 27, 2009 at 10:43:10PM -0700, Dmitry Torokhov w=
rote:
>> >> > > > > Hi Dave,
>> >> > > > >
>> >> > > > > On Tue, Oct 27, 2009 at 01:34:04PM +0800, Dave Young wrot=
e:
>> >> > > > > >
>> >> > > > > > Pressing somekey at early booting phase cause keyboard =
to be not usable
>> >> > > > > > (The hardware is DELL latitude e5400):
>> >> > > >
>> >> > > > Does early booting mean while the BIOS is coming up? Does t=
he keyboard
>> >> > > > work in GRUB then? Or is it during the early init of the Li=
nux kernel?
>> >> > >
>> >> > > Keyboard work under lilo.
>> >> > > For the early booting I means the early init of the linux ker=
nel
>> >> > >
>> >> > > >
>> >> > > > > > atkbd.c: Unknown key pressed (raw set 2, code 0xd3 on i=
sa0060/serio0).
>> >> > > > > > atkbd.c: Use 'setkeycodes e053 <keycode>' to make it kn=
own.
>> >> > > > > > atkbd.c: Unknown key pressed (raw set 2, code 0x1d3 on =
isa0060/serio0).
>> >> > > > > > atkbd.c: Use 'setkeycodes e053 <keycode>' to make it kn=
own.
>> >> > > > > >
>> >> > > > > > i8042.c set i8042_direct to true when the controller in=
it. But the result
>> >> > > > > > is keyboard not usable, The only option is press the po=
wer button to shutdown.
>> >> > > > > >
>> >> > > > > > So here remove the bios check to fix it.
>> >> > > >
>> >> > > > My question would be: Why this happens? Could it be that th=
e probe is
>> >> > > > confused by the keypress and reads the CTR incorrectly? Or =
is it just
>> >> > > > that the keyboard controller is in fact in translating mode=
, yet the CTR
>> >> > > > indicates otherwise?
>> >> > > >
>> >> > > > A i8042.debug=3D1 log of the bad init would be good.
>> >> > >
>> >> > > Here it is (retrieve from syslog):
>> >> >
>> >> > Syslog redirect the debug info to another log file, sorry, post=
 again:
>> >> >
>> >>
>> >> Any chance of reconfiguring syslog so debug is captured in the sa=
me
>> >> file? It is easier to see what is happening with the rest of cont=
ext
>> >> present...
>> >
>> > Sure, here it is:
>> >
>
> Does the patch below help by any chance?
>
> Thanks.
>
> --
> Dmitry
>
>
> Input: i8042 - try to get stable CTR value when initializing
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> If user presses keys while i8042 is being initialized there is a chan=
ce
> that keyboard data will be mistaken for results of Read Control Regis=
ter
> command causing futher troubles. Work around this issue by reading CT=
R
> several times and stop when we get matching results.
>
> Reported-by: Dave Young <hidave.darkstar@gmail.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---

Works well, thanks.

Tested-by: Dave Young <hidave.darkstar@gmail.com>

>
> =C2=A0drivers/input/serio/i8042.c | =C2=A0 35 +++++++++++++++++++++++=
+++++-------
> =C2=A01 files changed, 28 insertions(+), 7 deletions(-)
>
>
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.=
c
> index a315781..43f2b19 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -836,17 +836,32 @@ static int i8042_controller_selftest(void)
> =C2=A0static int i8042_controller_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
> + =C2=A0 =C2=A0 =C2=A0 int n =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char ctr[2];
>
> =C2=A0/*
> - * Save the CTR for restoral on unload / reboot.
> + * Save the CTR for restore on unload / reboot.
> =C2=A0*/
>
> - =C2=A0 =C2=A0 =C2=A0 if (i8042_command(&i8042_ctr, I8042_CMD_CTL_RC=
TR)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "i=
8042.c: Can't read CTR while initializing i8042.\n");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;
> - =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 do {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n >=3D 10) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 printk(KERN_ERR
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "i8042.c: Unable to get stable CTR =
read.\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return -EIO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n !=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 udelay(50);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i8042_command(=
&ctr[n++ % 2], I8042_CMD_CTL_RCTR)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 printk(KERN_ERR
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "i8042.c: Can't read CTR while init=
ializing i8042.\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return -EIO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> - =C2=A0 =C2=A0 =C2=A0 i8042_initial_ctr =3D i8042_ctr;
> + =C2=A0 =C2=A0 =C2=A0 } while (n < 2 || ctr[0] !=3D ctr[1]);
> +
> + =C2=A0 =C2=A0 =C2=A0 i8042_initial_ctr =3D i8042_ctr =3D ctr[0];
>
> =C2=A0/*
> =C2=A0* Disable the keyboard interface and interrupt.
> @@ -895,6 +910,12 @@ static int i8042_controller_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> +/*
> + * Flush whatever accumulated while we were disabling keyboard port
> + */
> +
> + =C2=A0 =C2=A0 =C2=A0 i8042_flush();
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> @@ -914,7 +935,7 @@ static void i8042_controller_reset(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0i8042_ctr |=3D I8042_CTR_KBDDIS | I8042_CT=
R_AUXDIS;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0i8042_ctr &=3D ~(I8042_CTR_KBDINT | I8042_=
CTR_AUXINT);
>
> - =C2=A0 =C2=A0 =C2=A0 if (i8042_command(&i8042_initial_ctr, I8042_CM=
D_CTL_WCTR))
> + =C2=A0 =C2=A0 =C2=A0 if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WC=
TR))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_WA=
RNING "i8042.c: Can't write CTR while resetting.\n");
>
> =C2=A0/*
>



--=20
Regards
dave
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
