From: "Luis R. Rodriguez" <mcgrof-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] input: Add KEY_RFKILL
Date: Thu, 10 Sep 2009 10:27:01 -0700
Message-ID: <43e72e890909101027saf1ed35u23936729eccf3f92@mail.gmail.com>
References: <1252603292-20830-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1252603292-20830-1-git-send-email-mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Sep 10, 2009 at 10:21 AM, Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrot=
e:

> This patch adds a new keycode, KEY_RFKILL_ALL.

> =C2=A0include/linux/input.h | =C2=A0 =C2=A02 ++
> =C2=A01 files changed, 2 insertions(+), 0 deletions(-)

> +#define KEY_RFKILL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x20c /=
* Key that controls all radios */

But this above is KEY_RFKILL, not KEY_RKILL_ALL. Typo?

  Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
