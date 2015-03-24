From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 0/4] input: ft5x06: Fix userspace reported maximum
 value
Date: Tue, 24 Mar 2015 09:47:22 -0700
Message-ID: <20150324164722.GA11352@dtor-ws>
References: <1425390646-31196-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150324001002.GJ15676@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36765 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbbCXQr1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Mar 2015 12:47:27 -0400
Content-Disposition: inline
In-Reply-To: <20150324001002.GJ15676@lukather>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>, linux-kernel@vger.kernel.org

On Mon, Mar 23, 2015 at 05:10:02PM -0700, Maxime Ripard wrote:
> Hi Lothar, Dmitry,
> 
> On Tue, Mar 03, 2015 at 02:50:42PM +0100, Maxime Ripard wrote:
> > Hi,
> > 
> > The current ft5x06 reports to the user-space that its maximum
> > coordinates are, on both X and Y, way higher than what could be
> > actually usable on the screen (in my case, 5759x1151 instead of
> > 480x800).
> > 
> > This causes trouble on some userspace stacks that then try to re-scale
> > these coordinates back to the framebuffer resolution, like QT does.
> > 
> > Use the of_touchscreen code to find the real touchscreen limits in the
> > DT case, and report that to the userspace.
> 
> Do you have any comments on that?

Yes, I'll apply it, although if you could supply the updated patch
description for #1 that would be great. The current one seems from the
old version and is no longer accurate.

Thanks.

-- 
Dmitry
