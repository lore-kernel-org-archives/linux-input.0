From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH V3 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Wed, 5 Oct 2011 12:00:09 +0200
Message-ID: <20111005100009.GA7288@polaris.bitmath.org>
References: <1316311297-12765-1-git-send-email-martinez.javier@gmail.com>
 <1316311297-12765-2-git-send-email-martinez.javier@gmail.com>
 <20110927115207.GA3701@polaris.bitmath.org>
 <CAAwP0s1hEOkidUK48cDf4DhSKN=PwxkLmHHpAVSZ6kPp7bhE=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:42192 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab1JEJyF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2011 05:54:05 -0400
Received: from iph1.telenor.se (iph1.telenor.se [195.54.127.132])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id C2C36C0A3
	for <linux-input@vger.kernel.org>; Wed,  5 Oct 2011 11:54:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAAwP0s1hEOkidUK48cDf4DhSKN=PwxkLmHHpAVSZ6kPp7bhE=A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Kevin McNeely <kev@cypress.com>, Mohan Pallaka <mpallaka@codeaurora.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

> To be more precise, the correct approach is:
> 
> 	for (i = 0; i < CY_MAX_ID; i++)
> 		if (!(used & (1 << i)))
> 			cyttsp_report_slot_empty(ts->input, i);
> 
> or
> 
> 	for (i = 0; i < CY_MAX_ID; i++)
> 		if (previous & (1 << i) &&
> 		    !(used & (1 << i)))
> 			cyttsp_report_slot_empty(ts->input, i);
> 
> where used is a bitmask to store each contact state for this event and
> previous is a bitmask to store the state for the previous event.
> 
> I looked at input_mt_report_slot_state() and it seems that it only
> checks whether the active parameter to send an ABS_MT_TRACKING_ID -1
> input event, so I think that I should use the latter.

Please implement the first version; the event never gets sent unless
there is an actual change, which you can see by following the code
deeper. If/when there are more drivers in need of a similar approach,
I might integrate the logic in the input-mt core instead.

Thanks,
Henrik
