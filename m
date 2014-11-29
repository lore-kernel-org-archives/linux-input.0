From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH] Drivers:input:mousedev.c: Fixed trailing statement on the
 next line
Date: Sat, 29 Nov 2014 17:02:28 +0100
Message-ID: <CAAfyv36-=w86TgzdDwXY-w=OE848medifckUKArgwTSuFGJetQ@mail.gmail.com>
References: <1417275548-3431-1-git-send-email-athirasnamby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:51426 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbaK2QCa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 Nov 2014 11:02:30 -0500
In-Reply-To: <1417275548-3431-1-git-send-email-athirasnamby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Athira S <athirasnamby@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sat, Nov 29, 2014 at 4:39 PM, Athira S <athirasnamby@gmail.com> wrote:
> Fixed checkpatch error:
> trailing statements should be on next line
>
> Signed-off-by: Athira S <athirasnamby@gmail.com>
> ---
>  drivers/input/mousedev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
> index b604564..be2cc5c 100644
> --- a/drivers/input/mousedev.c
> +++ b/drivers/input/mousedev.c
> @@ -248,7 +248,8 @@ static void mousedev_key_event(struct mousedev *mousedev,
>         case BTN_4:
>         case BTN_EXTRA:         index = 4; break;
>
> -       default:                return;
> +       default:
> +       return;
           ^^^^ missing tab here
>         }
>
>         if (value) {
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
