From: Henk <henk.vergonet@gmail.com>
Subject: Fwd: [RFC PATCH 1/2] USB: input: yealink.c: use KEY_NUMERIC_* for
 numeric keys, star and pound
Date: Fri, 9 Jan 2015 13:41:21 +0100
Message-ID: <CAMFK4TMHwtXEy19ajsWD1AL4MyLLMyC8UCLq8eFeCU+2JP2G5w@mail.gmail.com>
References: <1419259269-23820-1-git-send-email-dforsi@gmail.com>
	<1419259269-23820-2-git-send-email-dforsi@gmail.com>
	<CAMFK4TMJTb5dJ1kXLBgsu8WE8Ygyh+jW_d_TqmDO5OqB5yr3nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:50854 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932363AbbAIMlW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jan 2015 07:41:22 -0500
In-Reply-To: <CAMFK4TMJTb5dJ1kXLBgsu8WE8Ygyh+jW_d_TqmDO5OqB5yr3nw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Henk Vergonet <henk.vergonet@gmail.com>

Thanks!

On Mon, Dec 22, 2014 at 3:41 PM, Daniele Forsi <dforsi@gmail.com> wrote=
:
>
> Fix the "pound" key that being mapped to Shift+3 was returning '=C2=A3=
' instead
> of '#' when using an Italian keyboard mapping and use the same values=
 as
> the cm109.c driver (which was based on this yealink.c driver) also fo=
r '0'
> to '9' and for '*'.
>
> Signed-off-by: Daniele Forsi <dforsi@gmail.com>
> ---
>  drivers/input/misc/yealink.c | 39 +++++++++++++++-------------------=
-----
>  1 file changed, 15 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealin=
k.c
> index 79c964c..e9403da 100644
> --- a/drivers/input/misc/yealink.c
> +++ b/drivers/input/misc/yealink.c
> @@ -212,27 +212,24 @@ static int map_p1k_to_key(int scancode)
>         case 0x03: return KEY_ENTER;    /*   pickup     */
>         case 0x14: return KEY_BACKSPACE; /*  C          */
>         case 0x13: return KEY_ESC;      /*   hangup     */
> -       case 0x00: return KEY_1;        /*   1          */
> -       case 0x01: return KEY_2;        /*   2          */
> -       case 0x02: return KEY_3;        /*   3          */
> -       case 0x10: return KEY_4;        /*   4          */
> -       case 0x11: return KEY_5;        /*   5          */
> -       case 0x12: return KEY_6;        /*   6          */
> -       case 0x20: return KEY_7;        /*   7          */
> -       case 0x21: return KEY_8;        /*   8          */
> -       case 0x22: return KEY_9;        /*   9          */
> -       case 0x30: return KEY_KPASTERISK; /* *          */
> -       case 0x31: return KEY_0;        /*   0          */
> -       case 0x32: return KEY_LEFTSHIFT |
> -                         KEY_3 << 8;   /*   #          */
> +       case 0x00: return KEY_NUMERIC_1;        /*   1          */
> +       case 0x01: return KEY_NUMERIC_2;        /*   2          */
> +       case 0x02: return KEY_NUMERIC_3;        /*   3          */
> +       case 0x10: return KEY_NUMERIC_4;        /*   4          */
> +       case 0x11: return KEY_NUMERIC_5;        /*   5          */
> +       case 0x12: return KEY_NUMERIC_6;        /*   6          */
> +       case 0x20: return KEY_NUMERIC_7;        /*   7          */
> +       case 0x21: return KEY_NUMERIC_8;        /*   8          */
> +       case 0x22: return KEY_NUMERIC_9;        /*   9          */
> +       case 0x30: return KEY_NUMERIC_STAR;     /*   *          */
> +       case 0x31: return KEY_NUMERIC_0;        /*   0          */
> +       case 0x32: return KEY_NUMERIC_POUND;    /*   #          */
>         }
>         return -EINVAL;
>  }
>
>  /* Completes a request by converting the data into events for the
>   * input subsystem.
> - *
> - * The key parameter can be cascaded: key2 << 8 | key1
>   */
>  static void report_key(struct yealink_dev *yld, int key)
>  {
> @@ -240,17 +237,13 @@ static void report_key(struct yealink_dev *yld,=
 int key)
>
>         if (yld->key_code >=3D 0) {
>                 /* old key up */
> -               input_report_key(idev, yld->key_code & 0xff, 0);
> -               if (yld->key_code >> 8)
> -                       input_report_key(idev, yld->key_code >> 8, 0)=
;
> +               input_report_key(idev, yld->key_code, 0);
>         }
>
>         yld->key_code =3D key;
>         if (key >=3D 0) {
>                 /* new valid key */
> -               input_report_key(idev, key & 0xff, 1);
> -               if (key >> 8)
> -                       input_report_key(idev, key >> 8, 1);
> +               input_report_key(idev, key, 1);
>         }
>         input_sync(idev);
>  }
> @@ -966,9 +959,7 @@ static int usb_probe(struct usb_interface *intf, =
const struct usb_device_id *id)
>         for (i =3D 0; i < 256; i++) {
>                 int k =3D map_p1k_to_key(i);
>                 if (k >=3D 0) {
> -                       set_bit(k & 0xff, input_dev->keybit);
> -                       if (k >> 8)
> -                               set_bit(k >> 8, input_dev->keybit);
> +                       set_bit(k, input_dev->keybit);
>                 }
>         }
>
> --
> 2.1.3
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
