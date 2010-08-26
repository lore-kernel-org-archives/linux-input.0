From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v2] input: add multitouch slot support to w8001.
Date: Thu, 26 Aug 2010 08:42:18 +0200
Message-ID: <4C760CCA.4070403@euromail.se>
References: <20100826020141.GA24887@barra.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:49294 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751859Ab0HZGm0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Aug 2010 02:42:26 -0400
In-Reply-To: <20100826020141.GA24887@barra.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pinglinux@gmail.com

On 08/26/2010 04:01 AM, Peter Hutterer wrote:

> Some serial wacom devices support two-finger touch. Test for this during
> init and parse the touch packets accordingly. Touch packets are
> processed using Protocol B (MT Slots).
>
> Note: there are several wacom versions that do touch but not two-finger
> touch. These are not catered for here, touch events for these are simply
> discarded.
>
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> CC: Henrik Rydberg <rydberg@euromail.se>
> ---
> Changes to v1:
> - model MT slot approach after Henrik's bamboo patches
> - add a comment about what the missing bytes are in the data packets
>
> Henrik, I think this addresses all your comments? The patch is certainly
> a bit simpler now.


Acked-by: Henrik Rydberg <rydberg@euromail.se>

Yes, thanks, it looks fine now. And thanks for finding the bug in my own
version. :-)

Cheers,
Henrik
