From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ACPI: Always report a sync event after a lid state change
Date: Sat, 25 Oct 2008 22:03:34 -0400
Message-ID: <200810252203.35219.dmitry.torokhov@gmail.com>
References: <20081023212833.GA1923@ziggurat.research.nokia.com> <alpine.LFD.1.10.0810241529110.3056@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:36722 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbYJZCDn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Oct 2008 22:03:43 -0400
Received: by gxk9 with SMTP id 9so1168688gxk.13
        for <linux-input@vger.kernel.org>; Sat, 25 Oct 2008 19:03:42 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0810241529110.3056@localhost.localdomain>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Guillem Jover <guillem.jover@nokia.com>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org

Hi Len,

On Friday 24 October 2008, Len Brown wrote:
> Dmitry,
>=20
> Looking around the tree, the other calls to
> input_report_switch() and input_report_key()
> are all followed by input_sync().
>=20

The idea is that userspace can accumulate input events and not act on
them till it gets the "whole state" of the device which is indicated by
sending EV_SYN/SYN_REPORT event. This really does not matter for most
of the simple devices (such as most button devices) but is required
when you need to report state of a touchpad or a tablet (ABS_X, ABS_Y,
ABS_PRESSURE, host of buttons and so on). And that is the reason to hav=
e
2 input_sync when you you reporting button down and up back to back -
if there was only one input_sync userspace may (although I don't think
anyone does) wait to reacting till the sync and by that time the up eve=
nt
will "cancel out" the down event.

> I guess we didn't understand the API when we added
> these calls to button.c?
>

The code was fine until acpi_lid_send_state was used un resume path,
then it needed its own input_sync.
=20
> Looks like the other users of input_report_* in
> drivers/acpi and drivers/misc are okay,
> with the exception of toshiba_acpi.c --
> the most neglected driver we have,
> so I"ll do the same to that one?
>=20
> Ack?

Yep.

>=20
> thanks,
> -Len
>=20
>=20
> On Fri, 24 Oct 2008, Guillem Jover wrote:
>=20
> > Currently not always an EV_SYN event is reported to userland
> > after the EV_SW SW_LID event has been sent. This is easy to verify
> > by using =E2=80=9Cinput-events=E2=80=9D from input-utils and just c=
losing and opening
> > the lid.
> >=20
> > Signed-off-by: Guillem Jover <guillem.jover@nokia.com>
> > ---
> >  drivers/acpi/button.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> > index 1dfec41..59352d9 100644
> > --- a/drivers/acpi/button.c
> > +++ b/drivers/acpi/button.c
> > @@ -262,6 +262,7 @@ static int acpi_lid_send_state(struct acpi_butt=
on *button)
> >  		return -ENODEV;
> >  	/* input layer checks if event is redundant */
> >  	input_report_switch(button->input, SW_LID, !state);
> > +	input_sync(button->input);
> >  	return 0;
> >  }
> > =20
> > @@ -285,8 +286,8 @@ static void acpi_button_notify(acpi_handle hand=
le, u32 event, void *data)
> >  			input_report_key(input, keycode, 1);
> >  			input_sync(input);
> >  			input_report_key(input, keycode, 0);
> > +			input_sync(input);
> >  		}
> > -		input_sync(input);
> > =20
> >  		acpi_bus_generate_proc_event(button->device, event,
> >  					++button->pushed);
> > --=20
> > 1.6.0.2
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
>=20



--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
