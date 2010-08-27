From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 3/4] identify firmware version
Date: Fri, 27 Aug 2010 14:01:51 +0200
Message-ID: <4C77A92F.8020302@euromail.se>
References: <1282798497-19791-1-git-send-email-rafi@seas.upenn.edu> <1282798497-19791-4-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:47353 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750989Ab0H0MCr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Aug 2010 08:02:47 -0400
In-Reply-To: <1282798497-19791-4-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, chatty@enac.fr, micki@n-trig.com

On 08/26/2010 06:54 AM, Rafi Rubin wrote:

> This adds firmware version polling to the end of probe and reports the
> version both in the raw form and proccessed to match the formatting used
> by ntrig in windows.
> 
> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>


The version field of the input_id struct is a 16-bit number that can be used to
code device-specific version information, and is retrievable via EVIOCGID.
Perhaps one could code the firmware version in there.

Henrik
