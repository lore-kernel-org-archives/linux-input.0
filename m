From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: BUG: hid-multitouch causes 10 second delay and error
Date: Tue, 1 Nov 2011 15:27:36 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1111011526350.348@pobox.suse.cz>
References: <20111026213705.GA32664@pequod.mess.org> <CAN+gG=E0sUd3WOzAuT1LOTz_U9jLrGg2Bq_jRjha8Dcptk6Zcw@mail.gmail.com> <4EA9466F.4000508@gmail.com> <20111028111605.GA23693@polaris.bitmath.org> <CAN+gG=EiJJR464q_eoJuJYpWOPMsk61W6sAKD18SdT+2tQfmQA@mail.gmail.com>
 <20111028140033.GA2155@polaris.bitmath.org> <alpine.LNX.2.00.1110281913010.3541@pobox.suse.cz> <20111101141704.GA2135@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47080 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754410Ab1KAO1h (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Nov 2011 10:27:37 -0400
In-Reply-To: <20111101141704.GA2135@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Sean Young <sean@mess.org>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>

On Tue, 1 Nov 2011, Henrik Rydberg wrote:

> This reverts commit 0db3bfc72adf0cb70f08dfe92e4040f64e25e205.
> 
> The generic detection of hid-mt devices has two major flaws, and was
> merged prematurely. Firstly, the hid-multitouch gets loaded even when
> the device is handled by a special device. Secondly, the patch only
> partially duplicates the device whitelist already present in hid-core,
> effectively rendering a number of devices non-functional.
> 
> Reported-by: Sean Young <sean@mess.org>
> Tested-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Hi Jiri,
> 
> Unfortunately, the recently discussed solution does not seem to work,
> so there is only a revert for now.
> 
> I was planning to send a second patch, very small and concise, based
> on Benjamins patch, but
> 
> 1. It still does not resolve the
> hid-multitouch-gets-loaded-for-every-hid-device problem, and

Hmm, I thought it should work. What is the catch?

> In other words, there is currently no viable solution.

Thanks, I will be including the patch in my next pile of fixes for 3.2 
that will go to Linus.

-- 
Jiri Kosina
SUSE Labs
