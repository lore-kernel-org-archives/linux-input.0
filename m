From: Amit Nagal <helloin.amit@gmail.com>
Subject: Re: HIDDEV: potential NULL dereference
Date: Mon, 6 Sep 2010 11:03:13 +0530
Message-ID: <AANLkTin+T2tB+oXu9BzUfBkPpxEe47+tSMr2Yf4_Lb=x@mail.gmail.com>
References: <4C82419C.3050903@suse.cz>
	<m38w3hqx8g.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57333 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab0IFFdO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Sep 2010 01:33:14 -0400
In-Reply-To: <m38w3hqx8g.fsf@pullcord.laptop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <error27@gmail.com>

Hi ,

i was one of the users who informed that crash do disappears .

the reality with me is that the probability of occurence of crash
reduces significantly

but on rigourous testing crash resurfaces again .

sorry for wrong reporting .

Regards
Amit Nagal



On Sat, Sep 4, 2010 at 10:09 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Jiri,
>
> =A0 > If hid was ever NULL at this phase, the check couldn't improve
> =A0 > anything due to hid->driver_data dereference being still before
> =A0 > the check. So again my question, how this could change anything=
?
> =A0 >
> =A0 > Above that, it just makes the window shorter, but the bug is
> =A0 > still there, isn't it? Is the following scenario reasonable?
>
> You're right -- I'd missed the other dereference, sorry. =A0It's
> surprising that we have two reports from users saying that the
> patch got rid of a reproducible oops for them.
>
> Dan Carpenter has commented on this too:
> =A0 http://www.spinics.net/lists/linux-input/msg10541.html
>
> As he says, it looks like the code's overdue for some real locking.
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
