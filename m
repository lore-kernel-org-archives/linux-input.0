From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v6 7/8, needs improvement] hid: add suspend/resume hooks
 for hid drivers
Date: Wed, 31 Mar 2010 14:15:53 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1003311415000.24576@pobox.suse.cz>
References: <20100324233707.7243b04d@neptune.home> <20100324234022.0361bd80@neptune.home> <20100326065656.GC26602@core.coreip.homeip.net> <20100326102951.3b9ecda1@neptune.home> <alpine.LNX.2.00.1003262156280.24576@pobox.suse.cz> <20100327012245.0ace6a09@neptune.home>
 <alpine.LNX.2.00.1003291144350.24576@pobox.suse.cz> <20100329121611.0c22dcaf@pluto.restena.lu> <alpine.LNX.2.00.1003301010410.24576@pobox.suse.cz> <20100330223224.18fe4f3e@neptune.home> <20100330224230.7b84df75@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54947 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932204Ab0CaMP6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Mar 2010 08:15:58 -0400
In-Reply-To: <20100330224230.7b84df75@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Tue, 30 Mar 2010, Bruno Pr=C3=A9mont wrote:

> Add suspend/resume hooks for HID drivers so these can do some
> additional state adjustment when device gets suspended/resumed.
>=20
> This patch calls these hooks from usbhid suspend/resume functions,
> only calling suspend on plain suspend, not autosuspend.
> (it might be worth adding an autosuspend parameter to suspend
> hook and calling suspend in both cases)
>=20
> Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> ---
>=20
> Note:
>   this patch needs improvements as mentionned by Olivier Neukum:
>   - suspend hook for both system suspend and autosuspend
>   - no call of hook on USB-HID-resume failure

I agree with Oliver's comments.

We should also consider putting the hook calls into bluetooth=20
implementation as well (though there is currently no driver using it, b=
ut=20
I don't know, maybe Wacom could benefit from it as well).

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
