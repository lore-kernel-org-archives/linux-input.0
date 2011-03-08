From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Tue, 8 Mar 2011 10:46:30 +0100
Message-ID: <20110308094630.GA3396@polaris.bitmath.org>
References: <1299417912.9645.495.camel@itzy>
 <AANLkTimkYHPvn0PqcVyJv1rPTn3F7F8p3+3Y0-4F=MwW@mail.gmail.com>
 <1299564524.2306.18.camel@itzy>
 <20110308080414.GA2888@polaris.bitmath.org>
 <AANLkTimT9q8mo3uW0P7T0B=D4kkE83OB9ycgdJ_muZ2W@mail.gmail.com>
 <20110308091434.GA3282@polaris.bitmath.org>
 <AANLkTiko_mKgW6fXeAuBY4D5AT_9OHAJnk_mfQEPQVF9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:39801 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754320Ab1CHJpM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Mar 2011 04:45:12 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTiko_mKgW6fXeAuBY4D5AT_9OHAJnk_mfQEPQVF9@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Richard Nauber <richard.nauber@googlemail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

> >> I'm not in favor of a quirk in this particular case: the information
> >> is already here: max > 0.
> >
> > Only if min == 0, which is far from always the case. And setting a
> > special value for a special hardware does what a quirk does, so maybe
> > it is a quirk after all.
> >
> 
> I think there is a misunderstanding:
> if the class provides max_x (so > 0), or min_x, that means that the
> person in charge of adding the driver wants to replace the two values
> min/max.

What I meant is that (min_x < max_x) is the proper test.

> No need for a quirk that will be redundant with the hand-provided values.

Yes, but I think we might be better off using a quirk than a generic
way to replace the values provided by the hardware.

Thanks,
Henrik
