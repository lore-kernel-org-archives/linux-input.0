From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Mon, 09 Aug 2010 00:51:32 +0200
Message-ID: <4C5F34F4.7030503@tudelft.nl>
References: <4C567F27.7070900@tudelft.nl> <4C5697C4.1020801@euromail.se> <4C56A81E.3040703@tudelft.nl> <4C56AA67.8000902@euromail.se> <4C56AD12.1080106@tudelft.nl> <4C56B00B.50204@euromail.se> <4C56B686.60606@tudelft.nl> <4C56BA13.3030104@euromail.se> <4C56BE30.2070807@tudelft.nl> <4C56C213.2010605@euromail.se> <20100802163913.GB3276@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:37560 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094Ab0HHWzq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Aug 2010 18:55:46 -0400
In-Reply-To: <20100802163913.GB3276@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Chris Bagwell <chris@cnpbagwell.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

Op 02-08-10 18:39, Dmitry Torokhov schreef:
> No, I do not believe that this is the direcion we should be taking. I'd
> prefer we export as much information as we can for MT to be useful. And
> if we discover some missing pieces in proocol (or future firmware
> revisioons will be smarter) we can improve MT support.
> 
Hi Dimtry,

So I've implemented support for MT, with tracking to report as best as
possible the position of the 2 fingers and avoid jumps in the ST protocol.

So, please drop this 7/7 patch of this series, and instead apply the 4
coming patches 7 -> 10. Hopefully you manage to follow, otherwise just
tell me and I'll just resend the whole 10 patch series.

That's still against 2.6.35, but there shouldn't be any conflict with
the HEAD of your tree.

Cheers,
Eric
