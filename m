From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [Linux-v4.6-rc2] atkbd serio0: Unknown key pressed (translated
 set 2, code 0xa8 on isa0060/serio0).
Date: Fri, 8 Apr 2016 10:58:17 +0200
Message-ID: <CA+icZUV69RhvfgKD8a5Bm6PPvFikq6JGUP3_q0kUj9rd=Y+JVQ@mail.gmail.com>
References: <CA+icZUV0MGYme3EvLwYaW7HaAdKq7KQm6jgbcy58z4Vk3+n7qg@mail.gmail.com>
	<CA+icZUVZ05ri=Vs6UGWN0ks74_R2Q48u0=xoh2LSFwSLhpfabg@mail.gmail.com>
	<CA+icZUW0MFrV5gcVy=R6Jh+Fr7=5cr-ns0_ZXUjuY=LuiduLYw@mail.gmail.com>
	<CAKdAkRRT=Vq_X9Un3Zk-an42WR+ECKt-h6JxALK=4MkJkdgnow@mail.gmail.com>
	<alpine.LNX.2.00.1604072210110.27368@cbobk.fhfr.pm>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35805 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381AbcDHI6S (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Apr 2016 04:58:18 -0400
In-Reply-To: <alpine.LNX.2.00.1604072210110.27368@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, USB list <linux-usb@vger.kernel.org>

On Thu, Apr 7, 2016 at 10:11 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Wed, 6 Apr 2016, Dmitry Torokhov wrote:
>
>> > I forgot to tell that I have some patches on top of vanilla Linux v4.6-rc2.
>> >
>> > Dropping the patches from <jikos/hid.git#for-4.6/upstream-fixes> makes
>> > the issue go away.
>> > Unsure what is the cause.
>>
>> Hmm, this is quite curious, none of the recent patches in
>> for-4.6/upstream-fixes touches atkbd. I'd be very interested in which
>> one exactly causes this.
>
> Exactly, I don't see any possible relationship whatsoever.
>
> Sedat, for-4.6/upstream-fixes branch has only a couple of commits, so it
> should take just a very short while to bisect.
>
> Thanks,
>

Hmm, I could not reproduce it again.
Cursor up/down (pageup/pagedown) works again - unsure if the dmesg
outputs are related to this.
( And I have some (rfc) locking patches from PeterZ on top. )

- sed@ -
