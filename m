From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: synaptics - set minimum coordinates as reported
 by firmware
Date: Fri, 8 Jul 2011 19:34:14 +0200
Message-ID: <20110708173414.GA3217@polaris.bitmath.org>
References: <20110707065705.GH7658@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:46458 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab1GHRcH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2011 13:32:07 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 8AEC4EA5B8
	for <linux-input@vger.kernel.org>; Fri,  8 Jul 2011 19:32:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110707065705.GH7658@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>

On Wed, Jul 06, 2011 at 11:57:05PM -0700, Dmitry Torokhov wrote:
> Newer Synaptics firmware allows to query minimum coordinates reported by
> the device, let's use this data.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/input/mouse/synaptics.c |   56 ++++++++++++++++++++++++++-------------
>  drivers/input/mouse/synaptics.h |    8 ++++--
>  2 files changed, 43 insertions(+), 21 deletions(-)
> 

    Acked-by: Henrik Rydberg <rydberg@euromail.se>

Cheers,
Henrik
