From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Fix touch support for wacom bamboo fun CTH-461
Date: Mon, 3 Dec 2012 21:22:05 -0800
Message-ID: <20121204052205.GA23964@core.coreip.homeip.net>
References: <3305232.JQ4fXkYdWp@diego-arch>
 <CAF8JNh+s6L1=V1ccxRSvERjgAFPekN5dP-3Y0vLBFTe+ctn52A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52064 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab2LDFWK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Dec 2012 00:22:10 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2561856pbc.19
        for <linux-input@vger.kernel.org>; Mon, 03 Dec 2012 21:22:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAF8JNh+s6L1=V1ccxRSvERjgAFPekN5dP-3Y0vLBFTe+ctn52A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Diego Calleja <diegocg@gmail.com>, linux-input@vger.kernel.org

On Mon, Dec 03, 2012 at 04:26:23PM -0800, Ping Cheng wrote:
> On Mon, Dec 3, 2012 at 3:56 PM, Diego Calleja <diegocg@gmail.com> wrote:
> 
> > Commit f393ee2b814e3291c12565000210b3cf10aa5c1d forgot to add the
> > touch_max property for wacom bamboo fun CTH-461/S, id 056a:00d2.
> >
> > This broke the touch functionality for that device. This patch,
> > (done with help of Ping Cheng), adds the correct value and makes
> > touch work again.
> >
> > (Note: this problem exists since 3.5, so it may be a candidate for
> > -stable)
> >
> >
> > Signed-off-by: Diego Calleja <diegocg@gmail.com>
> >
> 
> Thank you Diego for finding and fixing the issue.
> 
> Reviewed-by: Ping Cheng <pinglinux@gmail.com>

Applied, thanks Diego and Ping.

-- 
Dmitry
