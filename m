From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: Problem with Das Keyboard 4 in N-key rollover mode
Date: Thu, 16 Oct 2014 10:12:13 +0200
Message-ID: <CANq1E4RkeszLkrqtadtt72k3TBPEOAfnjzQygfFCOD1dX+U4=g@mail.gmail.com>
References: <CADN=WdrqExP36Drz-8ZLi=jU0Ga9Zdsw6LKqm3oJphD2-kM7=w@mail.gmail.com>
	<CAMsZVf_7o-ChQfxGRW1ZWth-HKrrr=99TU5Pn0TGd-hsRoMyvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:39214 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbaJPIMO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Oct 2014 04:12:14 -0400
Received: by mail-ig0-f182.google.com with SMTP id hn15so2974432igb.9
        for <linux-input@vger.kernel.org>; Thu, 16 Oct 2014 01:12:13 -0700 (PDT)
In-Reply-To: <CAMsZVf_7o-ChQfxGRW1ZWth-HKrrr=99TU5Pn0TGd-hsRoMyvg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fredrik Hallenberg <megahallon@gmail.com>
Cc: Adam Goode <adam@spicenitz.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Thu, Oct 16, 2014 at 8:36 AM, Fredrik Hallenberg
<megahallon@gmail.com> wrote:
> Hi, this issue was discussed on this list a while ago. Look for
> spurious backslash in the archive. I submitted a patch that fixed the
> problem but David Herrmann did a better one later in the thread.
> However the patch was not applied.
> David, are there remaining issues with your patch?

Yeah, we need to move it into hid-input.c. Should be fairly easy to do
and its on my TODO list, but currently busy with conferences.. sorry.

Thanks
David
