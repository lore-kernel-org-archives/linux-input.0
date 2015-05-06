From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH] Add driver for mouse logitech M560
Date: Wed, 6 May 2015 09:35:58 +0200
Message-ID: <20150506093558.c479b8499fb63c5f9b05cc31@ao2.it>
References: <1430469813-3303-1-git-send-email-kreijack@libero.it>
	<20150505173659.b07a6c178996018bb43120b0@ao2.it>
	<20150506084814.3937e2e816eab76bd0012a55@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:24540 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbbEFHgC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 May 2015 03:36:02 -0400
In-Reply-To: <20150506084814.3937e2e816eab76bd0012a55@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Goffredo Baroncelli <kreijack@libero.it>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Dario Righelli <drighelli@gmail.com>, Goffredo Baroncelli <kreijack@inwind.it>

On Wed, 6 May 2015 08:48:14 +0200
Antonio Ospite <ao2@ao2.it> wrote:

> On Tue, 5 May 2015 17:36:59 +0200
> Antonio Ospite <ao2@ao2.it> wrote:
> 
> > On Fri,  1 May 2015 10:43:33 +0200
> > Goffredo Baroncelli <kreijack@libero.it> wrote:
> > 
> [...]
> > > +	/* exit if the data is not a mouse related report */
> > > +	if (data[0] != 0x02 && data[2] != M560_SUB_ID)
> > 
> > What are the possible values of data[0] that you observed?
> > Can it only be 0x02 and 0x11?
> > 
> > If we wanted to be stricter we could anticipate the full validation and
> > then simplify the ifs below to just check the report type, something
> > like:
> > 
> > 	bool valid_mouse_report;
> > 	...
> > 
> > 	valid_mouse_report = (data[0] == 0x02 ||
> > 	                      (data[0] == REPORT_ID_HIDPP_LONG &&
> > 	                       data[2] == M560_SUB_ID &&
> > 	                       data[6] == 0x00))
> > 
> > 	if (!valid_mouse_report)
> > 		return 0;
> > 
> > 	if (data[0] == REPORT_ID_HIDPP_LONG) {
> > 		...
> > 	} else /* if (data[0] == 0x02) */ {
> > 		...
> > 	}
> > 
> > but maybe this is overkill.
> > 
> 
> Or maybe just using an else, without the preventive validation, would
> already improve readability, checking things only once:
> 
> 	if (data[0] == REPORT_ID_HIDPP_LONG &&
> 	    data[2] == M560_SUB_ID && data[6] == 0x00) {
> 		...
> 	} else if (data[0] == 0x02) {
> 		...
> 	} else {
> 		/* unsupported report */
> 		return 0;
> 	}
> 

If the function returns 0 at the end, then the else here is even
redundant.

We may return 1 at the end of the function to differentiate between "no
action performed (0)" and "no further processing (1)" like stated in
include/linux/hid.h line 661, even if I don't see the core handling the
difference between the two return values when calling the raw_event
callback.

Benjamin, can you comment about what the convention is here? I am
referring also to the checks at the begin of m560_raw_event().

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
