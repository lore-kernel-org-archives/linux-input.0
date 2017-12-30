From: Sebastian Schmidt <yath@yath.de>
Subject: Re: [PATCH] Revert "Input: trackpoint - add new trackpoint firmware
 ID"
Date: Sat, 30 Dec 2017 16:41:38 +0100
Message-ID: <20171230154138.GD23284@marax.lan.yath.de>
References: <20171230152213.GA2099@marax.lan.yath.de>
 <20171230153213.GA28219@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from karr.yath.de ([144.76.4.50]:48058 "EHLO karr.yath.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751026AbdL3Plp (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 30 Dec 2017 10:41:45 -0500
Content-Disposition: inline
In-Reply-To: <20171230153213.GA28219@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Aaron Ma <aaron.ma@canonical.com>

On Sat, Dec 30, 2017 at 04:32:13PM +0100, Greg KH wrote:
> On Sat, Dec 30, 2017 at 04:22:13PM +0100, Sebastian Schmidt wrote:
> > This reverts commit ec667683c532c93fb41e100e5d61a518971060e2, which
> > breaks the Trackpoint on ThinkPad X1 Carbon Gen5 (Model 20HR). That
> > commit intended to add support for later firmware versions to the
> > trackpoint driver, however, the version is reported in the second byte
> > whereas the change was made to the magic byte preceding that version.
> > The update package linked by Lenovo suggests that 20HR models use an
> > ALPS Touchpad instead.
> > 
> > Signed-off-by: Sebastian Schmidt <yath@yath.de>
> > Acked-by: Greg KH <gregkh@linuxfoundation.org>
> 
> Um, I didn't ack this patch, don't ever put something like that on a
> patch unless it is offered by the person.

Sorry. :( Should I re-send the amended patch?

Sebastian
