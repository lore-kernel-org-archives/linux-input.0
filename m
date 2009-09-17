From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2 1/2] Input: Add DaVinci DM365 Keypad support
Date: Thu, 17 Sep 2009 12:48:17 -0700
Message-ID: <200909171248.18016.david-b@pacbell.net>
References: <1252951959-31015-1-git-send-email-miguel.aguilar@ridgerun.com> <4AB2795D.2060900@ru.mvista.com> <4AB28D94.2090401@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp107.sbc.mail.gq1.yahoo.com ([67.195.14.110]:25682 "HELO
	smtp107.sbc.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751830AbZIQTsP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2009 15:48:15 -0400
In-Reply-To: <4AB28D94.2090401@ridgerun.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, linux-input@vger.kernel.org, santiago.nunez@ridgerun.com, todd.fischer@ridgerun.com

On Thursday 17 September 2009, Miguel Aguilar wrote:
> I have another question: When should I use dev_err and dev_dbg in a probe 
> function, for reporting the errors (-ENOMEM, -ENODEV, -ENOMEM, etc)?

My two cents:  dev_dbg() for configuration errors, which
vanish once the board config is properly set up and are
only needed in early debug stages.  For anything else
(rare!) it's OK to use dev_err().

Some folk like to clutter kernel images with gobs of strings
for messages that never appear.  I'm not one of them; and I
think drivers should be written to minimize space used on
production systems.  Save that RAM for Real Work (tm)!

It's a good habit to scan the driver object before you call
work on it "done".  For platform drivers, probe/remove code
should normally sit in init/exit sections.  Symbols should
as a rule not be exported from drivers.  Having more than
a handful of strings should raise red flags ... who is ever
going to read them?  (And why, and what should they do with
them once they've seen those messages?)  Real hardware faults
generally deserve log messages.  Little else does.

Even look at the object code generated ... you may well observe
stupidly large amounts of code generated for some things, which
can easily be trimmed.  (Remember that the cost of a few extra
fetches into I-cache often dwarf call/return costs for a few
helper subroutines, even on critical paths!)

Sometimes a few minutes spent with such basic checks can show
problems that bloat the runtime footprint by 20% or more.
(Less after you get good habits though!)

- Dave
