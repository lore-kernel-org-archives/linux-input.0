From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [PATCH 1/2] input: Add KEY_RFKILL
Date: Thu, 10 Sep 2009 18:31:27 +0100
Message-ID: <20090910173127.GA8465@srcf.ucam.org>
References: <1252603292-20830-1-git-send-email-mjg@redhat.com> <43e72e890909101027saf1ed35u23936729eccf3f92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43e72e890909101027saf1ed35u23936729eccf3f92-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Luis R. Rodriguez" <mcgrof-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Sep 10, 2009 at 10:27:01AM -0700, Luis R. Rodriguez wrote:
> On Thu, Sep 10, 2009 at 10:21 AM, Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wr=
ote:
>=20
> > This patch adds a new keycode, KEY_RFKILL_ALL.
>=20
> > =A0include/linux/input.h | =A0 =A02 ++
> > =A01 files changed, 2 insertions(+), 0 deletions(-)
>=20
> > +#define KEY_RFKILL =A0 =A0 =A0 =A0 =A0 =A0 0x20c /* Key that contr=
ols all radios */
>=20
> But this above is KEY_RFKILL, not KEY_RKILL_ALL. Typo?

Sorry, yes - forgot to update the commit message to match the change in=
=20
the patch and subject.

--=20
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
