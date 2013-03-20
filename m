From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH v2] sysrq: supplementing reset sequence with timeout functionality
Date: Wed, 20 Mar 2013 14:56:23 -0700
Message-ID: <CAMP5XgfwMjTjiCar2W-o0xt7dr2dQNkO+HnDNZOmrXZORcvq+A@mail.gmail.com>
References: <1363454057-7409-1-git-send-email-mathieu.poirier@linaro.org>
	<CAMP5XgfSHcnarDmju-oEJwPbAzeOOOhfq7C1bvrQ5Zt7Wbid2A@mail.gmail.com>
	<5149D19B.7090503@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:46246 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659Ab3CTWB1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Mar 2013 18:01:27 -0400
Received: by mail-pb0-f49.google.com with SMTP id xa12so1670129pbc.8
        for <linux-input@vger.kernel.org>; Wed, 20 Mar 2013 15:01:27 -0700 (PDT)
In-Reply-To: <5149D19B.7090503@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kernel-team@android.com, john.stultz@linaro.org

On Wed, Mar 20, 2013 at 8:11 AM, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> On 13-03-18 06:44 PM, Arve Hj=F8nnev=E5g wrote:
>> On Sat, Mar 16, 2013 at 10:14 AM,  <mathieu.poirier@linaro.org> wrot=
e:
>>> From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>
>>>
>>> Some devices have too few buttons, which it makes it hard to have
>>> a reset combo that won't trigger automatically.  As such a
>>> timeout functionality that requires the combination to be held for
>>> a given amount of time before triggering is introduced.
>>>
>>> If a key combo is recognized and held for a 'timeout' amount of tim=
e,
>>> the system triggers a reset.
>>
>> The code seems to only require one of the keys in the combo to be he=
ld
>> for the full 'timeout' amount of time:
>>
>> ...
>>>                 /* key release */
>>> -               if (--state->reset_seq_cnt =3D=3D 0)
>>> +               if (--state->reset_seq_cnt =3D=3D 0) {
>>>                         state->reset_canceled =3D false;
>>> +                       del_timer(&state->keyreset_timeout);
>>> +               }
>>
>
> I think the case you are referring to is when keys are released - ple=
ase
> correct me if I'm wrong.
>
> You are correct, after the timer has been initialised (meaning that
> _all_ the keys have been pressed) only a single key need to be held d=
own
> to carry out the reset order.
>
> The current keyreset driver works exactly the same way - I just tried=
 it
> on my board.
>
> Get back to me if you want to see this corrected.
>

Since this feature so far has only been used with a single key, fixing
the code is not a high priority. However, I don't think the current
description matches the implementation you have, so one of them should
change.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
