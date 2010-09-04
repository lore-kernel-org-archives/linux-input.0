From: Chris Ball <cjb@laptop.org>
Subject: Re: HIDDEV: potential NULL dereference
Date: Sat, 04 Sep 2010 12:39:27 -0400
Message-ID: <m38w3hqx8g.fsf@pullcord.laptop.org>
References: <4C82419C.3050903@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56456 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754433Ab0IDQiz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 4 Sep 2010 12:38:55 -0400
In-Reply-To: <4C82419C.3050903@suse.cz> (Jiri Slaby's message of "Sat, 04 Sep
	2010 14:54:52 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <error27@gmail.com>

Hi Jiri,

   > If hid was ever NULL at this phase, the check couldn't improve
   > anything due to hid->driver_data dereference being still before
   > the check. So again my question, how this could change anything?
   > 
   > Above that, it just makes the window shorter, but the bug is
   > still there, isn't it? Is the following scenario reasonable?

You're right -- I'd missed the other dereference, sorry.  It's
surprising that we have two reports from users saying that the
patch got rid of a reproducible oops for them.

Dan Carpenter has commented on this too:
   http://www.spinics.net/lists/linux-input/msg10541.html

As he says, it looks like the code's overdue for some real locking.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
