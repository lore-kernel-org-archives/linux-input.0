From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] hid-multitouch: introduce IrTouch Infrared USB device
Date: Fri, 28 Jan 2011 19:49:58 +0100
Message-ID: <20110128184958.GC2553@polaris.bitmath.org>
References: <1296230680-2871-1-git-send-email-benjamin.tissoires@enac.fr>
 <1296230680-2871-2-git-send-email-benjamin.tissoires@enac.fr>
 <20110128172139.GB2586@polaris.bitmath.org>
 <AANLkTi=XKTdOBGcG8oo49=yPvSnsH5CpCsfhwwedm0eT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:33834 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754628Ab1A1StO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 13:49:14 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=XKTdOBGcG8oo49=yPvSnsH5CpCsfhwwedm0eT@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 28, 2011 at 06:59:13PM +0100, Benjamin Tissoires wrote:
> On Fri, Jan 28, 2011 at 18:21, Henrik Rydberg <rydberg@euromail.se> wrote:
> > On Fri, Jan 28, 2011 at 05:04:40PM +0100, Benjamin Tissoires wrote:
> >> The product id is the 42 inches one. I don't know if they have
> >> other product id for the other size, or if it is a per-size product id.
> >>
> >> Tested-by: Victor Zhuk <v.zhuk@acs-ltd.ru>
> >> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> >> ---
> >
> > The canonical patch description presents the reason for the change,
> > and what the patch does (not necessarily how).
> 
> It was just to keep trace of the kind of display it was. As Florian
> told the 63" does not have the same PID but not also the same
> protocol.
> Otherwise, we can also change the name of the define, but I'm not sure
> on the rule to apply here.

Oh, I meant the patch description simply needs to be a bit more
self-contained. Keeping special information as what you write is
great, it just needs to in addition tell things like: "The IrTouch
infrared panels currently lack kernel support", and/or "This patch
adds support for IrTouch 42''".

Thanks,
Henrik
