From: Santiago Carot <sancane@gmail.com>
Subject: Re: [PATCH] Fix device_match_pattern function
Date: Thu, 20 May 2010 12:12:50 +0200
Message-ID: <AANLkTimTW6-tcCNQ_e1uCE_ByN_5mVrFMefzixEjS0ql@mail.gmail.com>
References: <1274349303-19044-1-git-send-email-sancane@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:44996 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424Ab0ETKMv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 06:12:51 -0400
Received: by pxi18 with SMTP id 18so1240714pxi.19
        for <linux-input@vger.kernel.org>; Thu, 20 May 2010 03:12:51 -0700 (PDT)
In-Reply-To: <1274349303-19044-1-git-send-email-sancane@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Sorry,
I was wrong about the mailing list. Please, discard this patch here.

2010/5/20 Santiago Carot-Nemesio <sancane@gmail.com>:
> This patch fixes a problem adding uuids to list provided when a
> driver is probed. Without this patch the same uuids were added
> more than once to list and if two or more uuids were in the
> same class id list only the first one was included repeatedly
> ---
> =A0src/device.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index 6ba1612..d0768ce 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1053,7 +1053,7 @@ static GSList *device_match_pattern(struct btd_=
device *device,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (record_has_uuid(rec, match_uuid))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uuids =3D g_slist_appen=
d(uuids, profile_uuid);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uuids =3D g_slist_appen=
d(uuids, match_uuid);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return uuids;
> --
> 1.6.3.3
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
