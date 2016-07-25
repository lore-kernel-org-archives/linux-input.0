From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input/serio/i8042: Skip selftest on i8042 controller
 in some ASUS laptops
Date: Mon, 25 Jul 2016 11:22:37 -0700
Message-ID: <20160725182237.GC27415@dtor-ws>
References: <1469467222-2382-1-git-send-email-marcos.souza.org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33705 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbcGYSWl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 14:22:41 -0400
Content-Disposition: inline
In-Reply-To: <1469467222-2382-1-git-send-email-marcos.souza.org@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: =?iso-8859-1?Q?Aur=E9lien?= Francillon <aurelien@francillon.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

[ resending to all - mutt is for some reason confused about recipent
list ]
On Mon, Jul 25, 2016 at 02:20:16PM -0300, Marcos Paulo de Souza wrote:
> On suspend/resume cycle, selftest is executed on to reset i8042 controller. But
> when this is done in these devices, posterior calls to detect/init functions
> to elantech driver fails. Skipping selftest fixes this problem.
> 
> An easier step to reproduce this problem is adding i8042.reset=1 as a kernel
> parameter. On problematic laptops, it'll make the system to start with the
> touchpad already stucked, since psmouse_probe forcibly calls the
> selftest function.
> 
> This patch was inspired by John Hiesey's change[1].
> 
> [1]: https://marc.info/?l=linux-input&m=144312209020616&w=2
> 
> Fixes: "ETPS/2 Elantech Touchpad dies after resume from suspend" (https://bugzilla.kernel.org/show_bug.cgi?id=7739)

*sigh* You just cant win, they'll manage to mess up the firmware one way
or another :( Witness:

"
commit 1ca56e513a9fd356d5a9e0de45dbe0e189e00386
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue Jul 20 20:25:34 2010 -0700

    Input: i8042 - reset keyboard controller wehen resuming from S2R

    Some laptops, such as Lenovo 3000 N100, require keyboard controller reset
    in order to have touchpad operable after suspend to RAM. Even if box does
    not need the reset it should be safe to do so, so instead of chasing
    after misbehaving boxes and grow DMI tables, let's reset the controller
    unconditionally.

    Reported-and-tested-by: Jerome Lacoste <jerome.lacoste@gmail.com>
    Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
"

so apparently it is not safe to reset the controller on resume. Oh joy.

The issue I have here is selftest is the same as reset, and we already
have i8042_reset flag, so 2 flags controlling the same functionality is
not great. Could we extend i8042 to an enum, like:

I8042_RESET_ALWAYS
I8042_RESET_NEVER
I8042_RESET_ON_RESUME (default)

and have a custom module parameter for it?

i8042.reset and i8042_reset={1|Y|y} would result in I8042_RESET_ALWAYS
i8042.reset={0|N|n} would result in I8042_RESET_NEVER
Without i8042.reset we just reset it when resuming from S3.

What do you think?

Thanks.

-- 
Dmitry
