From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC v3 0/5] hid-multitouch: a first step towards multitouch
 unification
Date: Fri, 7 Jan 2011 21:08:50 +0100
Message-ID: <20110107200850.GE29913@polaris.bitmath.org>
References: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:44477 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752552Ab1AGUJq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Jan 2011 15:09:46 -0500
Content-Disposition: inline
In-Reply-To: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> here is the v3.
> 
> all changes are coming from the mails with Henrik:
> 
> - restricted to new drivers only
> - delete mt_buffer struct
> - replace/adapt prev_valid in favor of seen_in_this_frame
> - integrated fuzz
> - introduce MT_QUIRKS
> - other small fixes

A lot of progress in one day - thank you very much for making the
changes. I will be online for quite a bit longer in case there is more
coming this way. With some testing over the weekend (I will be
traveling, sorry), it doesn't look impossible to have this ready early
next week.

Cheers,
Henrik
