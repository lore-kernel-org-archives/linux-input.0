From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [PATCH] evdev: discard oldest event on buffer overflow
Date: Wed, 27 Oct 2010 17:11:28 -0700
Message-ID: <AANLkTimLK=UJRGQ_M9=4o5R4v_P6YPbJtPybCzfVqSND@mail.gmail.com>
References: <1288199398-7198-1-git-send-email-bgat@billgatliff.com>
	<20101027235704.GA12179@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58869 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757605Ab0J1AL3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Oct 2010 20:11:29 -0400
Received: by eye27 with SMTP id 27so1210889eye.19
        for <linux-input@vger.kernel.org>; Wed, 27 Oct 2010 17:11:28 -0700 (PDT)
In-Reply-To: <20101027235704.GA12179@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Oct 27, 2010 at 4:57 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Oct 27, 2010 at 12:09:58PM -0500, Bill Gatliff wrote:
>> This patch moves the tail pointer up one event on a buffer
>> overflow, which "consumes" the oldest event in the buffer
>> to make room for the incoming event. =A0Thus, although data
>> is lost due to the overflow (which is unavoidable), the
>> data that remains is both recent and still time-ordered.
>>
>
> It does not really matter... You are losing part of the hardware stat=
e
> regardless so the packet is invalid anyway. What would probably make
> more sense is to ignore all events up until next packet boundary
> (EV_SYN/SYN_REPORT) so userspace would get most up-to-date _full_ pac=
ket
> (when it catches up).

That's an interesting idea, actually.  Maybe the subject of a future pa=
tch.  :)

I still think my patch is a genuine improvement as-is, however.  But
perhaps not the final word on the issue.

=46or example, how do you recall the events that userspace has already
digested from the current packet?  One alternative is to not queue a
packet until the whole packet is ready, but that will introduce
latency.  I don't like that approach, either.  Hmmm...

I suppose another possibility is to always reserve enough room for an
EV_SYN/SYN_REPORT event, and never discard those events.  Then
userspace will always see a properly-terminated packet, but in a
collision it would receive a partial-but-properly-terminated packet.


b.g.
--=20
Bill Gatliff
bgat@billgatliff.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
