From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC v1 PATCH 1/6] matrix_keypad: Increase the max limit of rows
 and columns
Date: Thu, 11 Nov 2010 02:33:45 +0800
Message-ID: <AANLkTi=J2fGOC-RQsPB1SD4GcQ2Df2ZO_a=2mxneHbUa@mail.gmail.com>
References: <1289393281-4459-1-git-send-email-tsoni@codeaurora.org> <1289393281-4459-2-git-send-email-tsoni@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39017 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441Ab0KJSeH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 13:34:07 -0500
In-Reply-To: <1289393281-4459-2-git-send-email-tsoni@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, Nov 10, 2010 at 8:47 PM, Trilok Soni <tsoni@codeaurora.org> wro=
te:
> Some keyboard controller have support for more than
> 16 columns and rows.
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Signed-off-by: Trilok Soni <tsoni@codeaurora.org>
> ---
> =C2=A0include/linux/input/matrix_keypad.h | =C2=A0 =C2=A08 ++++----
> =C2=A01 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/input/matrix_keypad.h b/include/linux/inpu=
t/matrix_keypad.h
> index 80352ad..d80845e 100644
> --- a/include/linux/input/matrix_keypad.h
> +++ b/include/linux/input/matrix_keypad.h
> @@ -4,11 +4,11 @@
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/input.h>
>
> -#define MATRIX_MAX_ROWS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A016
> -#define MATRIX_MAX_COLS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A016
> +#define MATRIX_MAX_ROWS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A018
> +#define MATRIX_MAX_COLS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A018
>
> -#define KEY(row, col, val) =C2=A0 =C2=A0 ((((row) & (MATRIX_MAX_ROWS=
 - 1)) << 24) |\
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((col) & (MATRIX_MAX_COLS - =
1)) << 16) |\
> +#define KEY(row, col, val) =C2=A0 =C2=A0 ((((row) % (MATRIX_MAX_ROWS=
)) << 24) |\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((col) % (MATRIX_MAX_COLS)) =
<< 16) |\
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (val & 0xffff))
>

Or maybe we can solve this completely by introducing something like:

struct matrix_keycode {
        int row;
        int col;
        int value;
}

And make changes to KEY() macro and other places. You may also want to
eliminate the hardcoded MATRIX_MAX_* in matrix_keypad.c.
> =C2=A0#define KEY_ROW(k) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((=
(k) >> 24) & 0xff)
> --
> 1.7.0.2
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
