From: Amit Nagal <helloin.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: list not released in case of -ENODEV in hidraw_release (hidraw.c)
Date: Wed, 22 Jun 2011 17:13:36 +0530
Message-ID: <BANLkTikJfc_ZNG6LudKupUULqK+pN93MLg@mail.gmail.com>
References: <BANLkTi=Teg9iN8osSDY9fqadZ+sA-Ng2Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTi=Teg9iN8osSDY9fqadZ+sA-Ng2Sw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jun 22, 2011 at 1:28 PM, Amit Nagal <helloin.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
> Hi ,
>
> linux kernel ver 2.6.39.1 =A0, =A0hidraw.c =A0, in =A0hidraw_release =
function
> , list pointer ( struct hidraw_list *list ) is not freed
> in case of -ENODEV .
>
> i think the following patch is applicable :
>
> --- a/drivers/hid/hidraw.c =A0 =A0 =A02011-06-22 08:57:55.000000000 -=
0400
> +++ b/drivers/hid/hidraw.c =A0 =A0 =A02011-06-22 08:42:04.000000000 -=
0400
> @@ -298,6 +298,7 @@ static int hidraw_release(struct inode *
>
> =A0 =A0 =A0 =A0mutex_lock(&minors_lock);
> =A0 =A0 =A0 =A0if (!hidraw_table[minor]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(list);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENODEV;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unlock;
> =A0 =A0 =A0 =A0}
>
> Please correct me if i am mistaken .
>

In continuation of above , in hidraw_release(), for the sequence
disconnect  followed by last userspace close(fd) call ,
even kfree(list->hidraw) should also be called , as in
hidraw_disconnect() function kfree(hidraw) is called only when
hidraw->open is 0 .
so list->hidraw should also be freed when calling last close() call
even after disconnect .

if i have misunderstood facts , kindly clear my doubts .


Regards
Amit Nagal
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
