From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: synaptics - ignore bogus mt packet
Date: Wed, 22 Dec 2010 02:12:19 -0800
Message-ID: <20101222101219.GB22590@core.coreip.homeip.net>
References: <1292852364-19127-1-git-send-email-rydberg@euromail.se>
 <1292852364-19127-4-git-send-email-rydberg@euromail.se>
 <4D10D875.5040905@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45987 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab0LVKM0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Dec 2010 05:12:26 -0500
Content-Disposition: inline
In-Reply-To: <4D10D875.5040905@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Takashi Iwai <tiwai@suse.de>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Dec 21, 2010 at 11:40:21AM -0500, Chase Douglas wrote:
> On 12/20/2010 08:39 AM, Henrik Rydberg wrote:
> > In multitouch mode, at least one device (fw: 7.4 id: 0x1c0b1) sometimes
> > sends a final main packet with x == 1. Since the normal values are above
> > 1472, this is clearly bogus. At the same time, a two-finger touch is
> > signaled, even though only one finger was on the pad to begin with. This
> > patch ignores the packet altogether, removing the problem.
> > 
> > Acked-by: Chris Bagwell <chris@cnpbagwell.com>
> > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> 
> Acked-by: Chase Douglas <chase.douglas@canonical.com>

Looks good to me as well.

Acked-by: Dmitry Torokhov <dtor@mail.ru>

-- 
Dmitry
