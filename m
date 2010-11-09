From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Tue, 9 Nov 2010 10:28:51 -0600
Message-ID: <AANLkTi=rxkJcmp8WLKCRnxqNd_1QBT4W_2YJNJBcsHzF@mail.gmail.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
	<20101108035121.GA4630@barra.bne.redhat.com>
	<4CD7B012.1030809@cena.fr>
	<AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
	<20101109033149.GC19313@barra.redhat.com>
	<20101109065933.GA13921@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36760 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab0KIQ2w (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Nov 2010 11:28:52 -0500
Received: by gyh4 with SMTP id 4so4425503gyh.19
        for <linux-input@vger.kernel.org>; Tue, 09 Nov 2010 08:28:52 -0800 (PST)
In-Reply-To: <20101109065933.GA13921@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, Ping Cheng <pinglinux@gmail.com>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

On Tue, Nov 9, 2010 at 12:59 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Nov 09, 2010 at 01:31:49PM +1000, Peter Hutterer wrote:
>>
>> That said, it also goes counter the whole multi-touch approach - allowing
>> more than one device on a single physical device.
>>
>
> So maybe we should teach wacom to handle all devices as a single input device even
> in cases when they use several USB interfaces? We should be able to
> detect related interfaces by examining intf->intf_assoc (I hope) and
> using usb_driver_claim_interface() to claim them.

Thanks for tips.  I may try it just to prove its possible.

Here is extra info on resolution/dimension issue to also solve when
combining.  Taken from current logic on touch input of Wacom Bamboo:

input_mt_create_slots(input_dev, 2);
input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, features->x_max,
features->x_fuzz, 0);

Combining 2 inputs means MT slots increases from 2 to 3 (2 touches and
1 stylus).

Today, Pen has x_max=17420, x_fuzz=4 and resolution of 2540.  Also
today, Touch has x_max=15360, x_fuzz=128 and resolution=dunno (we are
scaling up touch x_max in driver and I haven't calculated its affects
on resolution).

I believe that a normalized value of x_max would show that there is a
greater area of tablet can be used for touch then pen.

To handle this difference, we can scale reported values in driver such
that x_max=x_max for all slots.  I'm not clear on fuzz logic so don't
know what 4 vs 128 does.

Or we can maybe update MT interface so you can have per slot values
for clients to query (or MT logic automatically scales for driver as
another option).  Then slots 0-1 are reserved for touch and slot 3 is
reserved for pen.

Chris
