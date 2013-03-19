From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH v2] sysrq: supplementing reset sequence with timeout functionality
Date: Mon, 18 Mar 2013 17:44:33 -0700
Message-ID: <CAMP5XgfSHcnarDmju-oEJwPbAzeOOOhfq7C1bvrQ5Zt7Wbid2A@mail.gmail.com>
References: <1363454057-7409-1-git-send-email-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:44767 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756413Ab3CSAoe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Mar 2013 20:44:34 -0400
Received: by mail-la0-f52.google.com with SMTP id fs12so6911264lab.25
        for <linux-input@vger.kernel.org>; Mon, 18 Mar 2013 17:44:33 -0700 (PDT)
In-Reply-To: <1363454057-7409-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kernel-team@android.com, john.stultz@linaro.org

On Sat, Mar 16, 2013 at 10:14 AM,  <mathieu.poirier@linaro.org> wrote:
> From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>
>
> Some devices have too few buttons, which it makes it hard to have
> a reset combo that won't trigger automatically.  As such a
> timeout functionality that requires the combination to be held for
> a given amount of time before triggering is introduced.
>
> If a key combo is recognized and held for a 'timeout' amount of time,
> the system triggers a reset.

The code seems to only require one of the keys in the combo to be held
for the full 'timeout' amount of time:

=2E..
>                 /* key release */
> -               if (--state->reset_seq_cnt =3D=3D 0)
> +               if (--state->reset_seq_cnt =3D=3D 0) {
>                         state->reset_canceled =3D false;
> +                       del_timer(&state->keyreset_timeout);
> +               }

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
