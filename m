From: =?ISO-8859-1?Q?Ezequiel_Garc=EDa?= <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v2 1/2] Input: rotary-encoder: Add 'stepped' irq handler
Date: Sat, 12 Oct 2013 13:58:59 -0300
Message-ID: <CAAEAJfCmnMFWnSRcWN946fc615po4zAn0a-yUSUnYeTjObXr_w@mail.gmail.com>
References: <1380891203-17617-1-git-send-email-ezequiel@vanguardiasur.com.ar>
	<1380891203-17617-2-git-send-email-ezequiel@vanguardiasur.com.ar>
	<524EC022.2050203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:40296 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab3JLQ7A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Oct 2013 12:59:00 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so5737048pad.30
        for <linux-input@vger.kernel.org>; Sat, 12 Oct 2013 09:59:00 -0700 (PDT)
In-Reply-To: <524EC022.2050203@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Dmitry,

On 4 October 2013 10:18, Daniel Mack <zonque@gmail.com> wrote:
> On 04.10.2013 14:53, Ezequiel Garcia wrote:
>> Some rotary-encoder devices (such as those with detents) are capable
>> of producing a stable event on each step. This commit adds support
>> for this case, by implementing a new interruption handler.
>>
>> The handler needs only detect the direction of the turn and generate
>> an event according to this detection.
>
> I think you can squash patch 2/2 into this one. It doesn't make much
> sense to have a one-liner patch to just update the documenation separ=
ately.
>
> Other than that, the code looks fine to me.
>
>   Acked-by: Daniel Mack <zonque@gmail.com>
>

Could you merge these two patches?

It's already acked by Daniel, and there wasn't any other feedback
so I think we're ready to get them in and support more devices :-)
--=20
Ezequiel Garc=EDa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
