From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: misc: delete MPU3050 driver
Date: Wed, 1 Feb 2017 15:48:54 -0800
Message-ID: <20170201234854.GH40720@dtor-ws>
References: <20170110083141.4103-1-linus.walleij@linaro.org>
 <20170110104333.GB18258@kuha.fi.intel.com>
 <20170131081433.GB8311@dtor-ws>
 <CACRpkda_VP=PKDxHyq_v7q2k3Q4XhGV34bgD1ez5Rdg2O1f5cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34516 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdBAXtO (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Feb 2017 18:49:14 -0500
Content-Disposition: inline
In-Reply-To: <CACRpkda_VP=PKDxHyq_v7q2k3Q4XhGV34bgD1ez5Rdg2O1f5cQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, Bastien Nocera <hadess@hadess.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Linux Input <linux-input@vger.kernel.org>, Joseph Lai <joseph_lai@wistron.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>

On Tue, Jan 31, 2017 at 10:30:01AM +0100, Linus Walleij wrote:
> On Tue, Jan 31, 2017 at 9:14 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
> > OK, since nobody yelled that they need it I applied the patch.
> 
> Thanks!
> 
> We need to think about the future of these misc input drivers:
> 
> misc/bma150.c
> misc/cma3000*
> misc/mma8450.c
> 
> The first has a partial (or maybe complete) support in
> iio/accel/bma180.c and the last seems to be possible to be
> supported by iio/accel/mma8452.c with some slight adjustments.
> 
> It's not only because I have OCD and want to sort every driver
> in the right pigeon-hole... the iio-sensor-proxy GNOME daemon
> bugzilla/github has been spamming me with complaints about
> problems caused by the accelerometer-as-input drivers.
> It would be nice to at least compartmentalize the problems
> into one subsystem. Terminating misc/bma150.c has been
> mentioned.

I we have replacements in drivers/iio I'd be happy to cut these out of
drivers/input.

Thanks.

-- 
Dmitry
