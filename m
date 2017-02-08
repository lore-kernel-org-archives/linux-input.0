From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Half second spend in i8042 during suspend on TUXEDO BU1406
Date: Thu, 9 Feb 2017 00:58:26 +0100
Message-ID: <20170208235826.GA28058@suse.com>
References: <234cc57f-6922-d866-e457-66eb2cafb85d@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jablonecka.jablonka.cz ([91.219.244.36]:44921 "EHLO
        jablonecka.jablonka.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbdBIDUI (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 8 Feb 2017 22:20:08 -0500
Content-Disposition: inline
In-Reply-To: <234cc57f-6922-d866-e457-66eb2cafb85d@molgen.mpg.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, Feb 08, 2017 at 02:12:44PM +0100, Paul Menzel wrote:

> On the TUXEDO BU1406 [1] the Linux kernel (tested with 4.10-rc{6,7})
> takes over a second to get into suspend [2]. For whatever reason
> around 550 ms are spent in `i8042_set_mux_mode()` (cf. attached
> /*
>  * Internal loopback test - send three bytes, they should come back
> from the
>  * mouse interface, the last should be version.
>  */
> 
>         param = val = 0xf0;
>         if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != val)
>                 return -1;
>         param = val = multiplex ? 0x56 : 0xf6;
>         if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != val)
>                 return -1;
>         param = val = multiplex ? 0xa4 : 0xa5;
>         if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == val)
>                 return -1;
> ```
> 
> Is that a hardware limitation, or even an error as such long delays
> are not allowed according to some standard?

It looks like an EC firmware bug not handling the CMD_AUX_LOOP command
correctly.

> Is there anything, that can be done about this, to get into S3 state faster?

Does it still happen if you specify i8042.nomux=1 on the kernel command
line?

If that helps, it can be added to a blacklist based on DMI.

Vojtech
