From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH 2/3] hid: add suspend/resume hooks for hid drivers
Date: Thu, 25 Feb 2010 05:19:46 +0100
Message-ID: <201002250519.46496.oliver@neukum.org>
References: <20100221002001.0a7e05a7@neptune.home> <20100224163101.3622d69f@neptune.home> <20100224170112.576403ee@neptune.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100224170112.576403ee@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Bruno =?utf-8?q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>
List-Id: linux-input@vger.kernel.org

Am Mittwoch, 24. Februar 2010 17:01:12 schrieb Bruno Pr=C3=A9mont:
> Add suspend/resume hooks for HID drivers so these can do some
> additional state adjustment when device gets suspended/resumed.
>=20
> This patch calls these hooks from usbhid suspend/resume functions,
> only calling suspend on plain suspend, not autosuspend.
> (it might be worth adding an autosuspend parameter to suspend
> hook and calling suspend in both cases)

This is quite dirty. A driver that was autosuspended may be non-auto re=
sumed.
Secondly, do you really want to call the hook for reset_resume() if
hid_post_reset() has failed?

	Regards
		Oliver
