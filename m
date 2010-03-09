From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [git pull] Input updates for 2.6.34-rc0
Date: Tue, 9 Mar 2010 08:15:06 -0800
Message-ID: <6cb013311003090815o7ec1de7fna68150e469855ce5@mail.gmail.com>
References: <20100301080342.GH765@core.coreip.homeip.net> <8bd0f97a1003090644p19fb7dacqe1f2fb3adee3fa7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:40193 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab0CIQP1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 11:15:27 -0500
In-Reply-To: <8bd0f97a1003090644p19fb7dacqe1f2fb3adee3fa7a@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Robin Getz <rgetz@blackfin.uclinux.org>

On Tue, Mar 9, 2010 at 6:44 AM, Mike Frysinger <vapier.adi@gmail.com> w=
rote:
> On Mon, Mar 1, 2010 at 03:03, Dmitry Torokhov wrote:
>> Hi Linus,
>>
>> Please pull from:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git://git.kernel.org/pub/scm/linux/kernel=
/git/dtor/input.git for-linus
>> or
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0master.kernel.org:/pub/scm/linux/kernel/g=
it/dtor/input.git for-linus
>>
>> to receive first round of updates for the input subsystem.
>
> i'm trying to figure out what the problem is with the ADXL34x and
> AD714x drivers you seem to have accepted (at least, you didnt say
> there was anything left for us to do). =C2=A0i would have expected th=
em to
> be in 2.6.33/2.6.34 already, but it seems they arent moving now. =C2=A0=
so
> what's up ?
> -mike
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

I'm in the same boat with my TSC2046 driver.  Any idea why this hasn't
moved?  I have received no comments, nor has the driver been included
/ accepted.  Do I need to make revisions, or can it be included?

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
