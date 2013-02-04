From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2 1/9] HID: core: add "report" hook, called once the
 report has been parsed
Date: Mon, 4 Feb 2013 12:21:00 +0100
Message-ID: <20130204112100.GA4313@polaris.bitmath.org>
References: <1359649351-11092-1-git-send-email-benjamin.tissoires@gmail.com>
 <1359649351-11092-2-git-send-email-benjamin.tissoires@gmail.com>
 <20130203122748.GA2513@polaris.bitmath.org>
 <CAN+gG=H8tTcQ9NNAk-EOxMJsqvrC6X1ZqmQB62eBHnXyG=RRng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:60534 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab3BDLO7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Feb 2013 06:14:59 -0500
Content-Disposition: inline
In-Reply-To: <CAN+gG=H8tTcQ9NNAk-EOxMJsqvrC6X1ZqmQB62eBHnXyG=RRng@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> > I think this is more useful if called before the individual fields. In
> > fact, it seems raw_event() is already doing exactly that. No need for
> > a new callback, in other words.
> 
> I'm afraid this does not work:
> - calling it before the individual fields is not possible unless more
> intrusive changes to hid-core:
>   * "hid_input_field" does the actual parsing of the input report, so
> without the call the .value field is still set to the previous one
> (not very useful then)
>   * the "hid_input_field" requires to know the previous report, due to
> Array type reports which send the current keys down, and not the
> release.
> - the raw_event() callback contains the report _unparsed_, which means
> that it's up to the hid specific driver to split the fields depending
> on the report descriptor (for instance, get the right bit for
> tipswitch in a byte containing tipswitch, inrange, confidence,
> contactId).
> - the raw_event() mechanism was the one in place in the v1 of the
> patch series, in which the new callback was asked.

Thanks for the compelling argument list, v1 had obviously been thrown
out of the cache already. ;-) I agree with your approach.

Thanks,
Henrik
