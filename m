From: Adam Goode <adam@spicenitz.org>
Subject: Re: Problem with Das Keyboard 4 in N-key rollover mode
Date: Thu, 16 Oct 2014 07:38:48 -0400
Message-ID: <CADN=WdpLd-+JV6jvrgmBOevO7D3dpATCQ7=+kMpmTP0tGqWdug@mail.gmail.com>
References: <CADN=WdrqExP36Drz-8ZLi=jU0Ga9Zdsw6LKqm3oJphD2-kM7=w@mail.gmail.com>
 <CAMsZVf_7o-ChQfxGRW1ZWth-HKrrr=99TU5Pn0TGd-hsRoMyvg@mail.gmail.com> <CANq1E4RkeszLkrqtadtt72k3TBPEOAfnjzQygfFCOD1dX+U4=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:58592 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbaJPLjJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Oct 2014 07:39:09 -0400
Received: by mail-oi0-f49.google.com with SMTP id a3so2487893oib.36
        for <linux-input@vger.kernel.org>; Thu, 16 Oct 2014 04:39:08 -0700 (PDT)
In-Reply-To: <CANq1E4RkeszLkrqtadtt72k3TBPEOAfnjzQygfFCOD1dX+U4=g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Fredrik Hallenberg <megahallon@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Thu, Oct 16, 2014 at 4:12 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Thu, Oct 16, 2014 at 8:36 AM, Fredrik Hallenberg
> <megahallon@gmail.com> wrote:
>> Hi, this issue was discussed on this list a while ago. Look for
>> spurious backslash in the archive. I submitted a patch that fixed the
>> problem but David Herrmann did a better one later in the thread.
>> However the patch was not applied.
>> David, are there remaining issues with your patch?
>
> Yeah, we need to move it into hid-input.c. Should be fairly easy to do
> and its on my TODO list, but currently busy with conferences.. sorry.
>

Thanks for looking into this. As mentioned on the thread, it would be
interesting if this also solves
https://bugzilla.kernel.org/show_bug.cgi?id=76461 (Bryan actually
works down the hall from me).


Adam
