From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 02/19] Input: Improve the events-per-packet estimate
Date: Tue, 14 Aug 2012 22:01:53 +0200
Message-ID: <20120814200153.GA3525@polaris.bitmath.org>
References: <1344807757-2217-1-git-send-email-rydberg@euromail.se>
 <1344807757-2217-3-git-send-email-rydberg@euromail.se>
 <CAF8JNhJzu9wW52PbydVuH9y8TwOs=mPO0DJn0aJBpsh-wETzuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:35498 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911Ab2HNT57 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Aug 2012 15:57:59 -0400
Content-Disposition: inline
In-Reply-To: <CAF8JNhJzu9wW52PbydVuH9y8TwOs=mPO0DJn0aJBpsh-wETzuQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Ping,

Long time no see. :-)

> > +       /* Make room for KEY and MSC events */
> > +       events += 7;
> 
> It is nice to get rid of the redundant pieces and to incorporate
> common functions. Thank you.
> 
> I have a question about the code above though.  Why do we use 7
> instead of going through the keys like:
> 
> 	for (i = 0; i < KEY_MAX; i++)
> 		if (test_bit(i, dev->keybit))
> 			events++;

Keyboards register a large amount of different keys, but seldom send
more than one or two at a time. The value 7 is ad hoc, admittedly, but
it makes the default buffer 8 bytes, which happens to precisely match
the default buffer in evdev.

Thanks,
Henrik
