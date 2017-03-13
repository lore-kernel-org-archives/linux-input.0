From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/7] Input: fix NULL-derefs at probe
Date: Mon, 13 Mar 2017 16:45:52 +0100
Message-ID: <20170313154552.GT4211@localhost>
References: <20170313123539.28103-1-johan@kernel.org>
 <1489418118.30110.26.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35290 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdCMPqD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 11:46:03 -0400
Content-Disposition: inline
In-Reply-To: <1489418118.30110.26.camel@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Johan Hovold <johan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Mon, Mar 13, 2017 at 04:15:18PM +0100, Oliver Neukum wrote:
> Am Montag, den 13.03.2017, 13:35 +0100 schrieb Johan Hovold:
> > This series fixes a number of NULL-pointer dereferences due to
> > missing
> > endpoint sanity checks that can be triggered by a malicious USB
> > device.
>
> At the risk of repeating myself, doesn't the sheer number of fixes
> demonstrate the need for a more centralized check?

No, I don't think that follows. These are plain bugs that needs to be
fixed (cf. not checking for allocation failures or whatever) and
backported to the stable trees.

I think I may have surveyed just about every USB driver this last week,
and there is no single pattern for how endpoints are verified and
retrieved that could easily be refactored into USB core.

Now there are certain patterns that could benefit from a few helpers,
and some obvious bugs could then be caught by declaring those helpers as
__must_check. But specifically, you'd still be checking the return
value from the helpers.

Then verifying the endpoint counts before calling driver probe,
typically only saves a bit of time while probing *malicious* devices
(and the occasional odd interface which cannot be matched on other
attributes).

That being said, we could still add a centralised sanity check for a
large class of drivers (e.g. that do not use altsettings and only need
minimum constraints) but it's not going to obviate the need for careful
driver implementations.

I'll be posting some more patches related to this shortly.

Thanks,
Johan
