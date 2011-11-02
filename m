From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 1/3] Input: Add new ABS_WHEEL2 axis
Date: Wed, 2 Nov 2011 12:46:39 -0700
Message-ID: <CANRwn3TO6X9ABZJj+O+LW6W8RxB3mf5gpj7UUtCu46AkVtkU+g@mail.gmail.com>
References: <1319247352-2006-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:34090 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab1KBTqr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Nov 2011 15:46:47 -0400
Received: by wwf22 with SMTP id 22so5053351wwf.1
        for <linux-input@vger.kernel.org>; Wed, 02 Nov 2011 12:46:46 -0700 (PDT)
In-Reply-To: <1319247352-2006-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>

On Fri, Oct 21, 2011 at 6:35 PM, Jason Gerecke <killertofu@gmail.com> w=
rote:
> Provides a new ABS_WHEEL2 axis in input.h for use by drivers who
> need to represent hardware with dual wheels.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---
> =C2=A0include/linux/input.h | =C2=A0 =C2=A01 +
> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 6d5eddb..117c68d 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -768,6 +768,7 @@ struct input_keymap_entry {
> =C2=A0#define ABS_TILT_X =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x=
1a
> =C2=A0#define ABS_TILT_Y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x=
1b
> =C2=A0#define ABS_TOOL_WIDTH =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1c
> +#define ABS_WHEEL2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1d
>
> =C2=A0#define ABS_VOLUME =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x=
20
>
> --
> 1.7.6
>
>

We're coming up on two weeks without activity on this patchset. Any
comments or ACKs?

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
