From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: mt: Add an envelope tool type
Date: Wed, 08 Dec 2010 20:23:33 +0100
Message-ID: <4CFFDB35.2020506@euromail.se>
References: <1291721340-22652-1-git-send-email-rydberg@euromail.se> <4CFFC3C2.1080905@canonical.com> <4CFFCD10.5030202@euromail.se> <4CFFD0BF.2020601@canonical.com> <4CFFD3FE.1090103@euromail.se> <4CFFD801.8060704@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:37751 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756330Ab0LHTXk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Dec 2010 14:23:40 -0500
In-Reply-To: <4CFFD801.8060704@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

>>> I suggest merely renaming this to MT_TOOL_RECT to avoid confusion.

> 
> This is really the main point I wanted to make, even though it was
> hidden among other things :). Do you have thoughts here?


I think envelope works fine - it is easier to associate with a single point that
the notion of a rectangle.

>>> 2. We could provide for multiple simultaneous rects by using the value
>>> of the MT_TOOL_RECT property. The first rect would have value 0, the
>>> second would have value 1, etc. I don't know if this will ever be used
>>> since most devices will have real MT soon enough, but it wouldn't hurt
>>> to define this.
>>
>> I do think this is an unnecessary complication.
> 
> It's not really any complication. I think we should define what the
> valid values are for MT_TOOL_{RECT,ENVELOPE} even if only one envelope
> is supported. Thus, I don't see why we shouldn't allow for multiple
> values for multiple rects.

> 
> Hardware manufacturers always seem to surprise us with what they come up
> with too :).


Yes, which is exciting per se. However, hardware seems to be moving towards more
individual (and tracked) contacts, and more granularity per contact. The idea of
supporting complex, non-connected boundaries (implication of your proposal),
which by construction contains less information that the individual contacts,
seems to be going against that trend. Since there are no current need for it,
and the indications point in a different direction, I suggest we put that in the
bag of possible "I told you so", and leave it open for now. ;-)

Cheers,
Henrik
