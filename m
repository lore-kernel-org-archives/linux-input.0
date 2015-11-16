From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: drivers/hid/wacom_wac.c:2484: bad if test ?
Date: Mon, 16 Nov 2015 15:09:21 -0800
Message-ID: <CAF8JNhJ1Rpxnhcu=BtnhN551sLEBYzTmjrvbcjxk-gF5VqHdig@mail.gmail.com>
References: <DUB128-W780599F7F3EBF63F33B96A9C1E0@phx.gbl> <alpine.LNX.2.00.1511162336270.20111@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:32778 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbbKPXJl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2015 18:09:41 -0500
Received: by oixx65 with SMTP id x65so80623702oix.0
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2015 15:09:40 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1511162336270.20111@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: David Binderman <dcb314@hotmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Ping Cheng <pingc@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, Aaron Skomra <aaron.skomra@wacom.com>

Oh, boy! It should be:

 if (features->type>=3D INTUOSHT && features->type <=3D BAMBOO_PT)

Thank you David for your sharp eyes ;-).

Jiri,

Can you fix it upstream or do you need a patch from me?

Ping

On Mon, Nov 16, 2015 at 2:39 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Mon, 16 Nov 2015, David Binderman wrote:
>
>> Hello there,
>>
>> drivers/hid/wacom_wac.c:2484:35: warning: logical =E2=80=98or=E2=80=99=
 of collectively
>> exhaustive tests is always true [-Wlogical-op]
>>
>> Source code is
>>
>> if (features->type>=3D INTUOSHT || features->type <=3D BAMBOO_PT)
>
> Good catch, that code is obviously crappy.
>
> Adding Ping, Aaron and Jason to CC.
>
> --
> Jiri Kosina
> SUSE Labs
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
