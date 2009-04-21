From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/5 UPDATED] [ARM] pxa: lx: add keyboard driver
Date: Mon, 20 Apr 2009 19:16:45 -0700
Message-ID: <20090421021644.GB13617@dtor-d630.eng.vmware.com>
References: <20090418141932.GA1236@n2100.arm.linux.org.uk> <1240064452-14691-3-git-send-email-linux@arm.linux.org.uk> <20090418231018.GA32346@dtor-d630.eng.vmware.com> <20090420110640.GC3653@n2100.arm.linux.org.uk> <20090420111347.GD3653@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:12961 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbZDUCQx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Apr 2009 22:16:53 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1214794wah.21
        for <linux-input@vger.kernel.org>; Mon, 20 Apr 2009 19:16:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090420111347.GD3653@n2100.arm.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org

Hi Russell,

On Mon, Apr 20, 2009 at 12:13:47PM +0100, Russell King - ARM Linux wrote:
> +
> +static unsigned char normal_map[LX_NUMKEYCODES] = {

Please chanege this to unsigned short since we _do_ allow changing this
part of keymap from userspace and possible KEY_* values extend beyond
unsigned char range.

> +static unsigned char numlck_map[LX_NUMKEYCODES] = {
> +static unsigned char fn_map[LX_NUMKEYCODES] = {

These 2 will have to be unisgned short as well, unless you want to adjust
lx_keyb_process_key() to cope with different keymap sizes...

> +	kbd->evbit[0]    = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
> +			   BIT_MASK(EV_PWR);
> +	kbd->keycode     = normal_map;
> +	kbd->keycodesize = sizeof(unsigned char);

And this should be "sizeof(normal_map[0]);" then.

Otherwise you may add:

	Acked-by: Dmitry Torokhov <dtor@mail.ru>

I assume the driver will be merged with the rest of LX changes through
your tree, is that right?

-- 
Dmitry
