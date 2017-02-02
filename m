From: Ignacy =?iso-8859-2?Q?Gaw=EAdzki?= <bugs@qult.net>
Subject: Re: Dell XPS 13 Fn key bug?
Date: Thu, 2 Feb 2017 09:40:33 +0100
Message-ID: <20170202084033.76d6youemdr2pc5f@zenon.in.qult.net>
References: <20170125084732.5hawvooeegtw4wwc@zenon.in.qult.net>
 <CAKdAkRQ=jCsQvPb8vK1byYYAbLSEeBHpMMDuMGhgwdqVKvQ_yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [78.193.33.39] ([78.193.33.39]:56456 "EHLO mail.qult.net"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbdBBIkr (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 2 Feb 2017 03:40:47 -0500
Content-Disposition: inline
In-Reply-To: <CAKdAkRQ=jCsQvPb8vK1byYYAbLSEeBHpMMDuMGhgwdqVKvQ_yg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario Limonciello <Mario_Limonciello@dell.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Feb 01, 2017 at 04:16:13PM -0800, thus spake Dmitry Torokhov:
> OK, so 'cd' is scancode for KEY_RIGHT and 'cf' is scancode for
> KEY_END, and it seems that implementation of FN handling is very naive
> as it emits "release" keycodes for the state FN is currently in, not
> the state it was when key was pressed.
> 
> Ideally Dell would fix that. Mario, any chance of that?

I'm just wondering whether this is still something that could be fixed
or worked around in the input driver, since the bug obviously doesn't
show up in neither in the linux console nor in Windows.

What do you think?

-- 
A person is shit's way of making more shit.
		-- S. Barnett, anthropologist.
