From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Detect trackstick presence for v7 protocol
Date: Sat, 28 Mar 2015 20:59:35 -0700
Message-ID: <20150329035935.GC36501@dtor-ws>
References: <1427031971-13018-1-git-send-email-pali.rohar@gmail.com>
 <550FFB84.6000609@redhat.com>
 <201503231802.28977@pali>
 <551111E1.6090303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36681 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbbC2D7k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Mar 2015 23:59:40 -0400
Content-Disposition: inline
In-Reply-To: <551111E1.6090303@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Santiago Gala <sgala@apache.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Masaki Ota <012nexus@gmail.com>

On Tue, Mar 24, 2015 at 08:27:29AM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 23-03-15 18:02, Pali Roh=E1r wrote:
> >On Monday 23 March 2015 12:39:48 Hans de Goede wrote:
> >>Hi,
> >>
> >>On 22-03-15 14:46, Pali Roh=E1r wrote:
> >>>This patch adds detection of trackstick for v7 protocol
> >>>devices. Code in this patch is used in official Dell
> >>>touchpad linux drivers for Dell models: Dell Latitude
> >>>E5250/5250, E5450/5450, E5550/5550
> >>>
> >>>Detection code and base reg for alps v3 rushmore and v7
> >>>devices is exacly same.
> >>>
> >>>Also user in bug
> >>>https://bugzilla.kernel.org/show_bug.cgi?id=3D94801 reported
> >>>that Toshiba Sattellite Z30-A-1DG has only alps v7 touchpad
> >>>device without trackstick and kernel reports to userspace
> >>>also redundant trackstick device.
> >>>
> >>>Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> >>
> >>Looks good, but has this been tested on a laptop which
> >>actually has a v7 pad + trackstick? I would like to see this
> >>actually tested on at least one such laptop before it gets
> >>merged.
> >>
> >>Regards,
> >>
> >>Hans
> >>
> >
> >I did not tested my patch on any v7 touchpad-only laptop.
>=20
> Ah, but I'm not worried about testing on a touchpad-only laptop,
> we are already reporting a trackpoint there even though there
> is none. I'm worried about breaking existing v7 using laptops
> which actually have a trackstick.
>=20
> So if this is tested on a v7 laptop with trackstick, and it
> does not break the trackstick then that is good enough for me.

I wonder if Masaki might have devices with V7 and trackstick available
and could test the patch for us?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
