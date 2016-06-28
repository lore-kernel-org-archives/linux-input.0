From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/2] Revert "HID: multitouch: enable palm rejection if
 device implements confidence usage"
Date: Tue, 28 Jun 2016 10:38:17 -0700
Message-ID: <CALCETrUwUkx3sdup2zbVn0n1Hegi5qwk1OHzTYYpLYkP95Tykg@mail.gmail.com>
References: <1466670690-77458-1-git-send-email-allen_hung@dell.com>
 <2407f04d-4658-c3d5-1434-5e548f2063e0@kernel.org> <CALCETrWhHWeqGK6zmng=+8_N87cezi6EwO7xW96HoMTxTkzxeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34672 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbcF1Riy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jun 2016 13:38:54 -0400
Received: by mail-vk0-f53.google.com with SMTP id c2so32207224vkg.1
        for <linux-input@vger.kernel.org>; Tue, 28 Jun 2016 10:38:42 -0700 (PDT)
In-Reply-To: <CALCETrWhHWeqGK6zmng=+8_N87cezi6EwO7xW96HoMTxTkzxeQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Allen Hung <allen_hung@dell.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Jun 27, 2016 at 3:25 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Mon, Jun 27, 2016 at 10:55 AM, Andy Lutomirski <luto@kernel.org> wrote:
>>
>> This and patch 2 are:
>>
>> Tested-by: Andy Lutomirski <luto@kernel.org> # XPS 13 9350, BIOS 1.4.3
>>
>> (And I'm curious why 1.4.3 seems to have been pulled.  Might it have been
>> this issue?  For better or for worse, I upgraded in the narrow window in
>> which it was available on Dell's website.)
>>
>
> I should amend that Tested-by slightly: these patches seem to make the
> problem merely about as bad as it was before.  It's still not perfect
> -- I still occasionally get stuck touches.

On further investigation, I'm not getting stuck touches AFAICT.  I'm
experiencing an upgraded version of libinput being clever and
incorrectly deciding that I middle-clicked.  Sorry for the noise.

https://bugs.freedesktop.org/show_bug.cgi?id=96710

--Andy
