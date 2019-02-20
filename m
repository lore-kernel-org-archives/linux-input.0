From: Stefan Achatz <stefan_achatz@web.de>
Subject: Re: [PATCH] HID: roccat: Mark expected switch fall-through
Date: Wed, 20 Feb 2019 09:15:17 +0100
Message-ID: <1550650517.5256.2.camel@web.de>
References: <20190211215334.GA6216@embeddedor>
         <nycvar.YFH.7.76.1902191415550.11598@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1902191415550.11598@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
List-Id: linux-input@vger.kernel.org

Am Dienstag, den 19.02.2019, 14:16 +0100 schrieb Jiri Kosina:
> On Mon, 11 Feb 2019, Gustavo A. R. Silva wrote:
>
> > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > cases where we are expecting to fall through.
> >
> > This patch fixes the following warning:
> >
> > drivers/hid/hid-roccat-kone.c: In function
> > =E2=80=98kone_keep_values_up_to_date=E2=80=99:
> > drivers/hid/hid-roccat-kone.c:784:20: warning: this statement may
> > fall through [-Wimplicit-fallthrough=3D]
> >    kone->actual_dpi =3D kone->profiles[event->value - 1].
> >    ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      startup_dpi;
> >      ~~~~~~~~~~~
> > drivers/hid/hid-roccat-kone.c:786:2: note: here
> >   case kone_mouse_event_osd_profile:
> >   ^~~~
> >
> > Warning level 3 was used: -Wimplicit-fallthrough=3D3
> >
> > This patch is part of the ongoing efforts to enable
> > -Wimplicit-fallthrough.
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >  drivers/hid/hid-roccat-kone.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-
> > roccat-kone.c
> > index bf4675a27396..c4dd6162c1d6 100644
> > --- a/drivers/hid/hid-roccat-kone.c
> > +++ b/drivers/hid/hid-roccat-kone.c
> > @@ -783,6 +783,7 @@ static void kone_keep_values_up_to_date(struct
> > kone_device *kone,
> >  	case kone_mouse_event_switch_profile:
> >  		kone->actual_dpi =3D kone->profiles[event->value -
> > 1].
> >  				startup_dpi;
> > +		/* fall through */
> >  	case kone_mouse_event_osd_profile:
> >  		kone->actual_profile =3D event->value;
> >  		break;
>
> Stefan, could you please confirm that this is intended behavior?
>
> Thanks,

I already confirmed this 7 months ago but as I see only in a reply to
you.
Yes, this patch is correct.
Stefan
