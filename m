From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/6] hid: new driver for PicoLCD device
Date: Fri, 26 Mar 2010 14:16:24 -0700
Message-ID: <201003261416.25387.dmitry.torokhov@gmail.com>
References: <20100324233707.7243b04d@neptune.home> <20100326102951.3b9ecda1@neptune.home> <alpine.LNX.2.00.1003262156280.24576@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:43305 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939Ab0CZVQj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Mar 2010 17:16:39 -0400
In-Reply-To: <alpine.LNX.2.00.1003262156280.24576@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Bruno =?iso-8859-15?q?Pr=E9mont?= <bonbons@linux-vserver.org>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Friday 26 March 2010 01:59:19 pm Jiri Kosina wrote:
> On Fri, 26 Mar 2010, Bruno Pr=E9mont wrote:
> > > > +	for (i =3D 0; i < PICOLCD_KEYS; i++) {
> > > > +		int key =3D ((int *)idev->keycode)[i];
> > >=20
> > > Keycodes are now short, not int. Also, just do:
> > > 		input_set_capability(idev, EV_KEY, data->keycode[i]);
> > > 	=09
> > > > +		if (key < KEY_MAX && key >=3D 0)
> > > > +			input_set_capability(idev, EV_KEY, key);
> >=20
> > Oops, I was not careful enough when switching over...
>=20
> Dmitry, thanks a lot for rapid review the driver.
>=20
> Bruno, could you please fix this and submit a followup 1/6 patch, so =
that
> I could queue the driver in my tree?
>=20
> I have almost finished going over the driver and haven't encountered =
any
> other issues that would require immediate fixing.
>=20
> Still, it would be nice to have the framebuffer/LCD/backlight bits
> reviewed by respective subsystem maintainers. But I'll probably queue=
 the
> driver nevertheless and add potential ACKs later.

=46WIW I am not entrely happy with the whole send-and_wait implementati=
on -
it looks like it is not being called concurrently so we don't need mute=
x
there... I'd do something like:

send_nand_wait() {

	set_bit(WAITING_RESPONSE, data->state);
	prepare message
	send message
	wait_for_event_interruptible_timeout(&data->wait,
					!test_bit(WAITING_RESPONSE, data->state));
	if (!test_bit()) {
		process
		return 0;
	}

	return -ETIME;
}

irq(...) {

	else if (test_bit(WAITING_RESPONSE, data->state)) {
		copy response...
		clear_bit(WAITING_RESPONSE, data->state);=09
		wake_up(&data->wait);
	}
}

and not bother with kmallocing pending structure, but it should not
stop from merging driver.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
