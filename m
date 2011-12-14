From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 2/3] HID: usbhid: hid-core: submit queued urbs before suspend
Date: Wed, 14 Dec 2011 08:55:39 +0100
Message-ID: <201112140855.40050.oneukum@suse.de>
References: <1321529030-7845-1-git-send-email-djkurtz@chromium.org> <1321529030-7845-3-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1321529030-7845-3-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: jkosina@suse.cz, bleung@chromium.org, stern@rowland.harvard.edu, olofj@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am Donnerstag, 17. November 2011, 12:23:49 schrieb Daniel Kurtz:
> Unfortunately, this usually happens while the first LED request is
> actually still being processed.  Thus when the completion handler tri=
es
> to submit the second LED request it fails, since REPORTED_IDLE is
> already set!  This REPORTED_IDLE check failure causes the completion
> handler to complete, however without clearing the CTRL_RUNNING flag.
> This, in turn, means that the suspend() handler's wait_io() condition
> is never satisfied, and instead it times out after 10 seconds, aborti=
ng
> the original system suspend.
>=20
> This patch changes the behavior to the following:
>   (1) allow completion handler to finish submitting all queued URBs, =
even if
>       REPORTED_IDLE is set.  This guarantees that all URBs queued bef=
ore the
>       hid-core suspend() call will be submitted before the system is
>       suspended.

Hi,

why is this desirable? You'd want to requests to be executed at resumpt=
ion.
A system suspend will alter the LED state anyway.

	Regards
		Oliver
--=20
- - -=20
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6=
rffer, HRB 16746 (AG N=FCrnberg)=20
Maxfeldstra=DFe 5                        =20
90409 N=FCrnberg=20
Germany=20
- - -=20
