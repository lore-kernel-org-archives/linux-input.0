From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 0/3] HID-Wacom: Fine-tuning for seven function implementations
Date: Mon, 15 May 2017 10:18:11 -0700
Message-ID: <CANRwn3TFV14iKV7riiFeOmGGv5rYLdXS3Tp1qZRVT09ksX3KoQ@mail.gmail.com>
References: <d126aeeb-f7e0-e54b-b874-61d776fe45cb@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:33193 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbdEORSN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 15 May 2017 13:18:13 -0400
In-Reply-To: <d126aeeb-f7e0-e54b-b874-61d776fe45cb@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Linux Input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

Came across these and noticed that it doesn't appear anything has
happened with them. The set looks good to me:

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....



On Tue, Apr 25, 2017 at 8:12 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 25 Apr 2017 17:07:07 +0200
>
> Three update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (3):
>   Use devm_kcalloc() in two functions
>   Improve size determinations in three functions
>   Delete two unnecessary return statements
>
>  drivers/hid/wacom_sys.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> --
> 2.12.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
