From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH] Add driver for mouse logitech M560
Date: Wed, 6 May 2015 08:48:14 +0200
Message-ID: <20150506084814.3937e2e816eab76bd0012a55@ao2.it>
References: <1430469813-3303-1-git-send-email-kreijack@libero.it>
	<20150505173659.b07a6c178996018bb43120b0@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:41574 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147AbbEFGsS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 May 2015 02:48:18 -0400
In-Reply-To: <20150505173659.b07a6c178996018bb43120b0@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Goffredo Baroncelli <kreijack@libero.it>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Dario Righelli <drighelli@gmail.com>, Goffredo Baroncelli <kreijack@inwind.it>

On Tue, 5 May 2015 17:36:59 +0200
Antonio Ospite <ao2@ao2.it> wrote:

> On Fri,  1 May 2015 10:43:33 +0200
> Goffredo Baroncelli <kreijack@libero.it> wrote:
> 
[...]
> > +	/* exit if the data is not a mouse related report */
> > +	if (data[0] != 0x02 && data[2] != M560_SUB_ID)
> 
> What are the possible values of data[0] that you observed?
> Can it only be 0x02 and 0x11?
> 
> If we wanted to be stricter we could anticipate the full validation and
> then simplify the ifs below to just check the report type, something
> like:
> 
> 	bool valid_mouse_report;
> 	...
> 
> 	valid_mouse_report = (data[0] == 0x02 ||
> 	                      (data[0] == REPORT_ID_HIDPP_LONG &&
> 	                       data[2] == M560_SUB_ID &&
> 	                       data[6] == 0x00))
> 
> 	if (!valid_mouse_report)
> 		return 0;
> 
> 	if (data[0] == REPORT_ID_HIDPP_LONG) {
> 		...
> 	} else /* if (data[0] == 0x02) */ {
> 		...
> 	}
> 
> but maybe this is overkill.
> 

Or maybe just using an else, without the preventive validation, would
already improve readability, checking things only once:

	if (data[0] == REPORT_ID_HIDPP_LONG &&
	    data[2] == M560_SUB_ID && data[6] == 0x00) {
		...
	} else if (data[0] == 0x02) {
		...
	} else {
		/* unsupported report */
		return 0;
	}

But again, this is just a suggestion.

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
