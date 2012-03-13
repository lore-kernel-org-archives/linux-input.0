From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: wacom: Fix physical size calculation for 3rd-gen
 Bamboo
Date: Mon, 12 Mar 2012 22:21:12 -0700
Message-ID: <20120313052112.GA9449@core.coreip.homeip.net>
References: <1331592784-6894-1-git-send-email-killertofu@gmail.com>
 <CAGzDe_aNMddbMCnK61c3J+3zTOtuM9EMkf5RhbfBs0oodnsNoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36994 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab2CMFVU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 01:21:20 -0400
Received: by iagz16 with SMTP id z16so284522iag.19
        for <linux-input@vger.kernel.org>; Mon, 12 Mar 2012 22:21:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGzDe_aNMddbMCnK61c3J+3zTOtuM9EMkf5RhbfBs0oodnsNoA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net

On Mon, Mar 12, 2012 at 10:25:47PM -0500, Chris Bagwell wrote:
> On Mon, Mar 12, 2012 at 5:53 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> > This calculation determines the physical dimensions of the tablet,
> > used later on in calculate_touch_res to obtain the touch sensor
> > resolution.
> >
> > Instead of dividing the logical size by the resolution, the current
> > code performs a multiplication. This doesn't pose a problem for the
> > 3rd-gen Bamboo since the resolution and scale factor happen to be
> > identical, but will produce an incorrect result for other cases.
> >
> > Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> 
> Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

Applied, thank you.

-- 
Dmitry
