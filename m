From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] hid-magicmouse: Correct parsing of large X and Y
 motions.
Date: Mon, 05 Jul 2010 18:25:29 -0400
Message-ID: <1278368729.10426.76.camel@cndougla>
References: <878w5qaspq.fsf@troilus.org>
	 <AANLkTim9R0ur7r2Y3r3bOMIRSM7JYVcZdGZ0QMaYvK4X@mail.gmail.com>
	 <1278360120.2425.97.camel@cndougla> <87wrt9acu5.fsf@troilus.org>
	 <1278363118.10426.15.camel@cndougla>  <87sk3xa8f3.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:44872 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab0GEWZe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jul 2010 18:25:34 -0400
In-Reply-To: <87sk3xa8f3.fsf@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: Ping Cheng <pinglinux@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Mon, 2010-07-05 at 18:08 -0400, Michael Poole wrote:
> Chase Douglas writes:
> > snto32() seems like something we should be using in hid-magicmouse.c? On
> > further thought, it actually seems like something that should be a macro
> > in linux/kernel.h. I would think there could be utility for it in many
> > places of the kernel.
> 
> Probably so.  The patch below is a proof of concept, which probably is
> not worth including until we decide the right place to put snto32(), but
> I think does show that using snto32() is more readable than the current
> code.
> 
> Note the bitwise-and for the ABS_MT_POSITION_X value: I missed that the
> first time I tried this, to rather undesirable effect.  I am not sure
> whether snto32() should automatically do that kind of masking: It is
> only needed in one out of the four sites here, but it is a fairly easy
> mistake to make.
> 
> Michael Poole
> 
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -163,14 +163,26 @@ static void magicmouse_emit_buttons(struct magicmouse_sc *msc, int state)
>  		msc->scroll_accel = SCROLL_ACCEL_DEFAULT;
>  }
>  
> +/* Function shamelessly borrowed from hid-core.c. */
> +
> +static s32 snto32(__u32 value, unsigned n)
> +{
> +	switch (n) {
> +	case 8:  return ((__s8)value);
> +	case 16: return ((__s16)value);
> +	case 32: return ((__s32)value);
> +	}
> +	return value & (1 << (n - 1)) ? value | (-1 << n) : value;
> +}
> +
>  static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tdata)
>  {
>  	struct input_dev *input = msc->input;
>  	__s32 x_y = tdata[0] << 8 | tdata[1] << 16 | tdata[2] << 24;
>  	int misc = tdata[5] | tdata[6] << 8;
>  	int id = (misc >> 6) & 15;
> -	int x = x_y << 12 >> 20;
> -	int y = -(x_y >> 20);
> +	int x = snto32((x_y >> 8) & 4095, 12);
> +	int y = snto32(x_y >> 20, 12);
>  	int down = (tdata[7] & TOUCH_STATE_MASK) != TOUCH_STATE_NONE;
>  
>  	/* Store tracking ID and other fields. */

Instead of having this intermediate x_y that's shifted 8 bits to the
left, why not do:

int x = snto32((tdata[1] << 8 | tdata[0]) & 0xFFF, 12);
int y = snto32(tdata[2] << 4 | tdata[1] >> 4, 12);

P.S.: I much prefer hex when doing masks because it's easier to count
the bits.

-- Chase

