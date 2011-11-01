From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v7 0/3] Input: Cypress TTSP device driver
Date: Tue, 1 Nov 2011 16:20:15 +0100
Message-ID: <20111101152015.GA2183@polaris.bitmath.org>
References: <1319396024-28558-1-git-send-email-martinez.javier@gmail.com>
 <CAAwP0s0g8pu8zz8J+wEeD6iqH8XN8bqzT-rOQwPYA9jyw8RL7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:43766 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140Ab1KAPLD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Nov 2011 11:11:03 -0400
Received: from iph1.telenor.se (iph1.telenor.se [195.54.127.132])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 873A9F330
	for <linux-input@vger.kernel.org>; Tue,  1 Nov 2011 16:11:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAAwP0s0g8pu8zz8J+wEeD6iqH8XN8bqzT-rOQwPYA9jyw8RL7g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

Hi Javier,

> Any comments on this version of the driver?

I am still looking at them, sorry.  I take it the patches have been
tested and work well for you?

> Is the driver still too far away for being in a merge-able state? Do
> you think would be a better approach to try to pushing it through
> staging or should I keep resending to merge it via drivers/input?

I still worry about some of error states, so I can only sign off the
MT part for now. Perhaps Dmitry would like to answer the general
question.

> I can make it either way, whatever works better for you.
> 
> Thanks a lot and best regards,

Thank you, too.

Henrik
