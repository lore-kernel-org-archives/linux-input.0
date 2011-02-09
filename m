From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC v2 PATCH 1/7] matrix_keypad: Increase the max limit of rows
 and columns
Date: Wed, 9 Feb 2011 16:02:27 +0800
Message-ID: <AANLkTimZ9UwcQp5QQjyHVsRdEAcf6+rL18mCesishPoC@mail.gmail.com>
References: <1296568063-12010-1-git-send-email-aghayal@codeaurora.org> <1296568063-12010-2-git-send-email-aghayal@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48949 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430Ab1BIICs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Feb 2011 03:02:48 -0500
In-Reply-To: <1296568063-12010-2-git-send-email-aghayal@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anirudh Ghayal <aghayal@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org, Trilok Soni <tsoni@codeaurora.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, Feb 1, 2011 at 9:47 PM, Anirudh Ghayal <aghayal@codeaurora.org>=
 wrote:
> From: Trilok Soni <tsoni@codeaurora.org>
>
> Some keyboard controller have support for more than
> 16 columns and rows. Moving this value to 32.
>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Trilok Soni <tsoni@codeaurora.org>

This looks good to me, as long as the bits don't exceed 256, which
is used in the #KEY() macro. So far, 32 looks to be a sane number
to me, unless we have further requirement to get this larger.

Acked-by: Eric Miao <eric.y.miao@gmail.com>


> ---
> Changes from v1:
> Moved the max columns and rows to 32
>
> =C2=A0include/linux/input/matrix_keypad.h | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/input/matrix_keypad.h b/include/linux/inpu=
t/matrix_keypad.h
> index 6974746..fe7c4b9 100644
> --- a/include/linux/input/matrix_keypad.h
> +++ b/include/linux/input/matrix_keypad.h
> @@ -4,8 +4,8 @@
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/input.h>
>
> -#define MATRIX_MAX_ROWS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A016
> -#define MATRIX_MAX_COLS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A016
> +#define MATRIX_MAX_ROWS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A032
> +#define MATRIX_MAX_COLS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A032
>
> =C2=A0#define KEY(row, col, val) =C2=A0 =C2=A0 ((((row) & (MATRIX_MAX=
_ROWS - 1)) << 24) |\
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((col) & (MATRIX_MAX_COLS -=
 1)) << 16) |\
> --
> 1.7.3.5
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
