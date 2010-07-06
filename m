From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [PATCH] hid-magicmouse: Correct parsing of large X and Y
 motions.
Date: Tue, 6 Jul 2010 17:08:50 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B360376C@dbde02.ent.ti.com>
References: <878w5qaspq.fsf@troilus.org>
	<AANLkTim9R0ur7r2Y3r3bOMIRSM7JYVcZdGZ0QMaYvK4X@mail.gmail.com>
	<1278360120.2425.97.camel@cndougla> <87wrt9acu5.fsf@troilus.org>
	<1278363118.10426.15.camel@cndougla>,<87sk3xa8f3.fsf@troilus.org>
 <702744BC498BAE41B3AA631D95EC463058B3CFD77F@NOK-EUMSG-01.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46626 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767Ab0GFLjQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jul 2010 07:39:16 -0400
In-Reply-To: <702744BC498BAE41B3AA631D95EC463058B3CFD77F@NOK-EUMSG-01.mgdnok.nokia.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>, "mdpoole@troilus.org" <mdpoole@troilus.org>, "chase.douglas@canonical.com" <chase.douglas@canonical.com>
Cc: "pinglinux@gmail.com" <pinglinux@gmail.com>, "jkosina@suse.cz" <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>



> -----Original Message-----
> From: linux-input-owner@vger.kernel.org [mailto:linux-input-
> owner@vger.kernel.org] On Behalf Of ext-phil.2.carmody@nokia.com
> Sent: Tuesday, July 06, 2010 4:53 PM
> To: mdpoole@troilus.org; chase.douglas@canonical.com
> Cc: pinglinux@gmail.com; jkosina@suse.cz; linux-input@vger.kernel.org
> Subject: RE: [PATCH] hid-magicmouse: Correct parsing of large X and Y
> motions.
> 
> Arsebiscuits, forced to use webmail, sloppily prefixing every line with
> '>' manually ...
> 
> ________________________________________
> From: linux-input-owner@vger.kernel.org [linux-input-
> owner@vger.kernel.org] On Behalf Of ext Michael Poole
> [mdpoole@troilus.org]
> Sent: Tuesday, July 06, 2010 12:08 AM
> To: Chase Douglas
> Cc: Ping Cheng; Jiri Kosina; linux-input@vger.kernel.org
> Subject: Re: [PATCH] hid-magicmouse: Correct parsing of large X and Y
> motions.
> 
> >Chase Douglas writes:
> >
> >> On Mon, 2010-07-05 at 16:33 -0400, Michael Poole wrote:
> >>> C99 says that the result of right-shifting a negative value is
> >>> compiler-defined.  gcc documents that it ensures sign extension.
> Other
> >>> parts of hid-magicmouse.c use this idiom already.  The corresponding
> >>> idiom in hid-core.c (see the snto32() function) would look something
> >>> like this:
> >>>
> >>>       x = ((data[3] & 0x0c) << 6) | data[1];
> >>>       x |= (x & (1 << 9)) ? (-1 << 10) : 0;
> >>
> >> snto32() seems like something we should be using in hid-magicmouse.c?
> On
> >> further thought, it actually seems like something that should be a
> macro
> >> in linux/kernel.h. I would think there could be utility for it in many
> >> places of the kernel.
> >
> >Probably so.  The patch below is a proof of concept, which probably is
> >not worth including until we decide the right place to put snto32(), but
> >I think does show that using snto32() is more readable than the current
> >code.
> >
> >Note the bitwise-and for the ABS_MT_POSITION_X value: I missed that the
> >first time I tried this, to rather undesirable effect.  I am not sure
> >whether snto32() should automatically do that kind of masking: It is
> >only needed in one out of the four sites here, but it is a fairly easy
> >mistake to make.
> >
> >Michael Poole
> >
> >--- a/drivers/hid/hid-magicmouse.c
> >+++ b/drivers/hid/hid-magicmouse.c
> >@@ -163,14 +163,26 @@ static void magicmouse_emit_buttons(struct
> magicmouse_sc *msc, int state)
> >                msc->scroll_accel = SCROLL_ACCEL_DEFAULT;
> > }
> >
> >+/* Function shamelessly borrowed from hid-core.c. */
> >+
> >+static s32 snto32(__u32 value, unsigned n)
> >+{
> >+       switch (n) {
> >+       case 8:  return ((__s8)value);
> >+       case 16: return ((__s16)value);
> >+       case 32: return ((__s32)value);
> 
> Beware - this relies on sane behaviour from the current and future
> compilers, as the C standard doesn't mandate what should happen when
> shortening out of range signed values. [n869.txt: 6.3.1.1.#3]
Any reason of choosing  __s32/  s32  ?

> 
> >+       }
> >+       return value & (1 << (n - 1)) ? value | (-1 << n) : value;
> 
> That signed left shift, however, is good old fashioned undefined
> behaviour. [n869.txt 6.5.7.#4]
> 
> >+}
> >+
> > static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id,
> u8 *tdata)
> > {
> >        struct input_dev *input = msc->input;
> >        __s32 x_y = tdata[0] << 8 | tdata[1] << 16 | tdata[2] << 24;
> >        int misc = tdata[5] | tdata[6] << 8;
> >        int id = (misc >> 6) & 15;
> >-       int x = x_y << 12 >> 20;
> >-       int y = -(x_y >> 20);
> >+       int x = snto32((x_y >> 8) & 4095, 12);
> >+       int y = snto32(x_y >> 20, 12);
> >        int down = (tdata[7] & TOUCH_STATE_MASK) != TOUCH_STATE_NONE;
> >
> >        /* Store tracking ID and other fields. */
> >@@ -285,8 +297,8 @@ static int magicmouse_raw_event(struct hid_device
> *hdev,
> >                 * to have the current touch information before
> >                 * generating a click event.
> >                 */
> >-               x = (int)(((data[3] & 0x0c) << 28) | (data[1] << 22)) >>
> 22;
> >-               y = (int)(((data[3] & 0x30) << 26) | (data[2] << 22)) >>
> 22;
> >+               x = snto32(((data[3] & 0x0c) << 6) | data[1], 10);
> >+               y = snto32(((data[3] & 0x30) << 4) | data[2], 10);
> >                clicks = data[3];
> >                break;
> >        case 0x20: /* Theoretically battery status (0-100), but I have
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
