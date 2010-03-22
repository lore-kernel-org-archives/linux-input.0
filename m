From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/6] hid: new driver for PicoLCD device
Date: Sun, 21 Mar 2010 21:35:09 -0700
Message-ID: <20100322043508.GC31621@core.coreip.homeip.net>
References: <20100320170014.440959a8@neptune.home>
 <20100320170241.55258b0d@neptune.home>
 <20100321034600.GE29360@core.coreip.homeip.net>
 <20100321173737.5fcf3580@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f182.google.com ([209.85.210.182]:60316 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab0CVEfP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 00:35:15 -0400
Content-Disposition: inline
In-Reply-To: <20100321173737.5fcf3580@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Sun, Mar 21, 2010 at 05:37:37PM +0100, Bruno Pr=E9mont wrote:
> On Sat, 20 March 2010 Dmitry Torokhov <dmitry.torokhov@gmail.com> wro=
te:
> > > +	usbhid_submit_report(data->hdev, report, USB_DIR_OUT);
> > > +	complete_all(&data->ready);
> > > +	INIT_COMPLETION(data->ready);
> >=20
> > Umm, what does this do, exactly?
>=20
> It wakes up anyone waiting on the completion and then resets the comp=
letion
> as otherwise any future attempt to wait on it would succeed immediate=
ly.
>=20

You realize that if you re-initialize the completion right after
signalling it there is a big chance the waiters will miss it (they do
check completion->done flags that you reset right away.

In general completions are suited for something that happens once (a
single request - allocated - processed - signalled) but not for
repeating use.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
