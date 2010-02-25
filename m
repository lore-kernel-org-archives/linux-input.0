From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 2/3] hid: add suspend/resume hooks for hid drivers
Date: Thu, 25 Feb 2010 11:12:02 +0100
Message-ID: <20100225111202.4e433691@neptune.home>
References: <20100221002001.0a7e05a7@neptune.home>
	<20100224163101.3622d69f@neptune.home>
	<20100224170112.576403ee@neptune.home>
	<201002250519.46496.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201002250519.46496.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>
List-Id: linux-input@vger.kernel.org

On Thu, 25 February 2010 Oliver Neukum <oliver@neukum.org> wrote:
> Am Mittwoch, 24. Februar 2010 17:01:12 schrieb Bruno Pr=C3=A9mont:
> > Add suspend/resume hooks for HID drivers so these can do some
> > additional state adjustment when device gets suspended/resumed.
> >=20
> > This patch calls these hooks from usbhid suspend/resume functions,
> > only calling suspend on plain suspend, not autosuspend.
> > (it might be worth adding an autosuspend parameter to suspend
> > hook and calling suspend in both cases)
>=20
> This is quite dirty.

Yeah, it covers what I did need (at least for success path). For the
rest I was expecting feedback (and probably should have labeled the
patch RFC)

> A driver that was autosuspended may be non-auto resumed. Secondly, do
> you really want to call the hook for reset_resume() if
> hid_post_reset() has failed?

Possibly not though depending on why hid_post_reset failed the first
USB operation would fail as well, thus it would fall under "normal"
error conditions for the driver...

Opinion of USB/HID experts is welcome!

> 	Regards
> 		Oliver

Thanks for the review!

Regards,
Bruno
