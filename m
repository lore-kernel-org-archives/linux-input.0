From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/3 v2] usb/hid-core: drain URB queue when going to
 suspend
Date: Wed, 7 Dec 2011 10:27:44 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1112071026440.21970@pobox.suse.cz>
References: <1321529030-7845-1-git-send-email-djkurtz@chromium.org> <CAGS+omBvSWz4vBsMDkwk3oge_+k64tqSkrHyF5-C5_LZte_hDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGS+omBvSWz4vBsMDkwk3oge_+k64tqSkrHyF5-C5_LZte_hDw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: oneukum@suse.de, bleung@chromium.org, stern@rowland.harvard.edu, olofj@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 7 Dec 2011, Daniel Kurtz wrote:

> > In some situations, trying to suspend a laptop with an attached USB=
 keyboard
> > would fail if both NumLock and CapsLock LEDs were lit.
> > This was due to a race condition between asynchronously submitted
> > LED-manipulating CTRL URBs and the suspend process.
> >
> > This is a different solution to the same problem highlighted here:
> > https://lkml.org/lkml/2011/9/2/391
> >
> > These patches are against Jiri's hid/for-next branch.
> >
> > Daniel Kurtz (3):
> > =A0HID: usbhid: remove LED_ON
> > =A0HID: usbhid: hid-core: submit queued urbs before suspend
> > =A0HID: usbhid: defer LED setting to a workqueue
> >
> > Differences since v1:
> > =A0* Rebase on hid/for-next
> > =A0* Solve race with usbhid_stop() [reported by Oliver Neukum]
> >
>=20
> Hi Jiri,
>=20
> Any chance you can take a look at this patch set?

Hi Dan,

it's still in my queue, sorry for delay; it absolutely hasn't been lost=
, I=20
just haven't gotten to it yet.

Oliver, did you have a chance to review it, please? I'd apprecite your=20
eventual Ack on this.

Thanks,

--=20
Jiri Kosina
SUSE Labs
