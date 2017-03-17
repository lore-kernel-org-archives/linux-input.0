From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/7] Input: fix NULL-derefs at probe
Date: Fri, 17 Mar 2017 11:53:37 +0100
Message-ID: <20170317105337.GD20622@localhost>
References: <20170313123539.28103-1-johan@kernel.org>
 <1489418118.30110.26.camel@suse.com>
 <20170313154552.GT4211@localhost>
 <20170316223728.GC2935@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36602 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdCQLDW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Mar 2017 07:03:22 -0400
Content-Disposition: inline
In-Reply-To: <20170316223728.GC2935@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Oliver Neukum <oneukum@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Thu, Mar 16, 2017 at 03:37:28PM -0700, Dmitry Torokhov wrote:
> On Mon, Mar 13, 2017 at 04:45:52PM +0100, Johan Hovold wrote:
> > On Mon, Mar 13, 2017 at 04:15:18PM +0100, Oliver Neukum wrote:
> > > Am Montag, den 13.03.2017, 13:35 +0100 schrieb Johan Hovold:
> > > > This series fixes a number of NULL-pointer dereferences due to
> > > > missing endpoint sanity checks that can be triggered by a
> > > > malicious USB device.

> Applied the lot.

I noticed you dropped the Fixes tag from the patches that fix bugs which
predate git. While this is probably not much of an issue in this case, I
think it's generally a bad idea since we're loosing information this
way, and this specifically makes it harder for the stable maintainers to
figure out which tree to backport a fix to.

Thanks,
Johan
