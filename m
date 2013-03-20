From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v2] sysrq: supplementing reset sequence with timeout functionality
Date: Wed, 20 Mar 2013 09:11:23 -0600
Message-ID: <5149D19B.7090503@linaro.org>
References: <1363454057-7409-1-git-send-email-mathieu.poirier@linaro.org> <CAMP5XgfSHcnarDmju-oEJwPbAzeOOOhfq7C1bvrQ5Zt7Wbid2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:64340 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab3CTPS4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Mar 2013 11:18:56 -0400
Received: by mail-pb0-f41.google.com with SMTP id um15so1447824pbc.0
        for <linux-input@vger.kernel.org>; Wed, 20 Mar 2013 08:18:55 -0700 (PDT)
In-Reply-To: <CAMP5XgfSHcnarDmju-oEJwPbAzeOOOhfq7C1bvrQ5Zt7Wbid2A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kernel-team@android.com, john.stultz@linaro.org

On 13-03-18 06:44 PM, Arve Hj=C3=B8nnev=C3=A5g wrote:
> On Sat, Mar 16, 2013 at 10:14 AM,  <mathieu.poirier@linaro.org> wrote=
:
>> From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>
>>
>> Some devices have too few buttons, which it makes it hard to have
>> a reset combo that won't trigger automatically.  As such a
>> timeout functionality that requires the combination to be held for
>> a given amount of time before triggering is introduced.
>>
>> If a key combo is recognized and held for a 'timeout' amount of time=
,
>> the system triggers a reset.
>=20
> The code seems to only require one of the keys in the combo to be hel=
d
> for the full 'timeout' amount of time:
>=20
> ...
>>                 /* key release */
>> -               if (--state->reset_seq_cnt =3D=3D 0)
>> +               if (--state->reset_seq_cnt =3D=3D 0) {
>>                         state->reset_canceled =3D false;
>> +                       del_timer(&state->keyreset_timeout);
>> +               }
>=20

I think the case you are referring to is when keys are released - pleas=
e
correct me if I'm wrong.

You are correct, after the timer has been initialised (meaning that
_all_ the keys have been pressed) only a single key need to be held dow=
n
to carry out the reset order.

The current keyreset driver works exactly the same way - I just tried i=
t
on my board.

Get back to me if you want to see this corrected.

Thanks,
Mathieu.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
