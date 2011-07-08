From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 3/4] Fix hover in Android (Gingerbread)
Date: Fri, 8 Jul 2011 14:04:48 -0700
Message-ID: <CANRwn3S=BaPC+_syL-2C-Wbff5C1cLkMy_kHLTmiLroJbQEn6Q@mail.gmail.com>
References: <1310072700-2829-1-git-send-email-killertofu@gmail.com>
	<1310072700-2829-3-git-send-email-killertofu@gmail.com>
	<CADqH6Vyn3=WW3bz5YESTEJgTUfaeCgX7rQjT6s96DfjQnENa_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54333 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab1GHVEu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2011 17:04:50 -0400
Received: by wwe5 with SMTP id 5so2324905wwe.1
        for <linux-input@vger.kernel.org>; Fri, 08 Jul 2011 14:04:49 -0700 (PDT)
In-Reply-To: <CADqH6Vyn3=WW3bz5YESTEJgTUfaeCgX7rQjT6s96DfjQnENa_w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jgerecke@wacom.com>, Dima Zavin <dima@android.com>

On Thu, Jul 7, 2011 at 6:13 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Fri, Jul 8, 2011 at 5:04 AM, Jason Gerecke <killertofu@gmail.com> wrote:
>> As of Gingerbread, Android does not pay attention to if the pen
>> is in contact with the screen, or merely in proximity. Since the
>> Xorg Wacom driver does not make use of MT pen events, we simply
>> do not emit MT data while hovering.
>
> Hi Jason,
>
> It would be nice if you could CC me next time. I would like to be
> aware of the changes to the driver I wrote and use.
>
> I guess the change below is ok, but it changes existing behavior. It
> doesn't affect my apps (be aware that Xorg and Android may be the well
> known users, but there are other custom apps).
>
> Thanks,
> jaya
>

Thanks for the heads-up. Since I had originally intended the patches
to go against the Android tree, I wasn't thinking too hard about how
other things would react to the changes. I figured I'd make them
Xorg-compatible in case they were rejected by Google, but didn't
consider custom applications.

Based on the replies to the first patch though, I may be withdrawing
these patches anyway... We need to wait and see if my Android
rejection is reversed or not.

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.
