From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH  3/3] hid: Multitouch support for the N-Trig
 touchscreen
Date: Wed, 20 May 2009 13:00:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905201257370.13917@wotan.suse.de>
References: <3EF4E25A-E606-4056-BBF0-4BC2B31001F1@enac.fr> <alpine.LNX.2.00.0905191646130.22712@wotan.suse.de> <5696FC49-3530-4D5B-B5B5-924973AD3120@enac.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168427776-1875085502-1242817225=:13917"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56740 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715AbZETLAY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2009 07:00:24 -0400
In-Reply-To: <5696FC49-3530-4D5B-B5B5-924973AD3120@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Rafi Rubin <rafi@seas.upenn.edu>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--168427776-1875085502-1242817225=:13917
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


[ BTW, in all your mails you have @suze.cz as my recepient domain, but 
  it's in fact @suse.cz, you must be getting bounces for that one :) ]

On Tue, 19 May 2009, Stéphane Chatty wrote:

> > >+	static __s32 x, y, id, w, h;
> > >+	static char reading_a_point = 0, found_contact_id = 0;
> > >+	struct input_dev *input = field->hidinput->input;
> >Why are these variables static? This will break horribly if multiple 
> >devices are connected to the system, right?
> You're right. But so far these devices are sold only as embedded in a 
> notebook, and I doubt we will see standalone devices in the near future. 
> Do you think it is worth planning ahead for this eventuality?

But we should at least be consistent. So at least the driver should 
explicitly check whether it is driving more than one device, and if so, 
report that this is unsupported configuration.

But I would really prefer doing this cleanly from the start (let's say 
allocating per-device structure during probe and storing all these data in 
it, let's say). 

Would that be possible please?

Thanks,

-- 
Jiri Kosina
SUSE Labs
--168427776-1875085502-1242817225=:13917--
