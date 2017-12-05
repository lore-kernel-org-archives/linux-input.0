From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 08/45] drivers: input: remove duplicate includes
Date: Tue, 5 Dec 2017 09:15:55 +0100
Message-ID: <CAO-hwJLM=T35-RFpn=LS=amZmBi9S3eLHVrqsFOs238D3oQexg@mail.gmail.com>
References: <1512439272-15824-1-git-send-email-pravin.shedge4linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40285 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbdLEIP4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 5 Dec 2017 03:15:56 -0500
Received: by mail-qt0-f196.google.com with SMTP id u42so27165701qte.7
        for <linux-input@vger.kernel.org>; Tue, 05 Dec 2017 00:15:56 -0800 (PST)
In-Reply-To: <1512439272-15824-1-git-send-email-pravin.shedge4linux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pravin Shedge <pravin.shedge4linux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Dyer <nick@shmanahar.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Colin Ian King <colin.king@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>

Hi,

[adding Jiri, the HID maintainer in CC]

On Tue, Dec 5, 2017 at 3:01 AM, Pravin Shedge
<pravin.shedge4linux@gmail.com> wrote:
> These duplicate includes have been found with scripts/checkincludes.pl but
> they have been removed manually to avoid removing false positives.
>
> Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
> ---

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/input/rmi4/rmi_f34.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
> index 4cfe970..f1f5ac5 100644
> --- a/drivers/input/rmi4/rmi_f34.c
> +++ b/drivers/input/rmi4/rmi_f34.c
> @@ -11,7 +11,6 @@
>  #include <linux/rmi.h>
>  #include <linux/firmware.h>
>  #include <asm/unaligned.h>
> -#include <asm/unaligned.h>
>  #include <linux/bitops.h>
>
>  #include "rmi_driver.h"
> --
> 2.7.4
>
