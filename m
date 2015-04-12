From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4.0 REGRESSION FIX] alps: Fix left touchpad button
 getting stuck when using it with trackpoint
Date: Sun, 12 Apr 2015 16:00:23 -0700
Message-ID: <20150412230023.GC15638@dtor-ws>
References: <1428507532-25533-1-git-send-email-hdegoede@redhat.com>
 <1428507532-25533-2-git-send-email-hdegoede@redhat.com>
 <201504082226.36289@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38423 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbbDLXA2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Apr 2015 19:00:28 -0400
Content-Disposition: inline
In-Reply-To: <201504082226.36289@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Hans de Bruin <jmdebruin@xmsnet.nl>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 08, 2015 at 10:26:36PM +0200, Pali Roh=E1r wrote:
> On Wednesday 08 April 2015 17:38:52 Hans de Goede wrote:
> > When the left touchpad button gets pressed, and then the
> > trackpoint is moved, and then the button is released, the
> > following happens:
> >=20
> > 1) touchpad packet is received, touchpad evdev node reports
> > BTN_LEFT 1 2) pointingstick packet is received, the hw will
> > report a BTN_LEFT 1 in this packet because when the
> > trackstick is active it communicates the combined touchpad +
> > pointingstick buttons in the trackstick packet, since
> > alps_report_bare_ps2_packet passes NULL (*) for the dev2
> > parameter to alps_report_buttons the combining is not
> > detected and the pointingstick evdev node will also report
> > BTN_LEFT 1
> > 3) on release of the button a pointingstick packet with
> > BTN_LEFT 0 is received, and the pointingstick evdev node will
> > report BTN_LEFT 0
> >=20
> > Note how because of the passing as NULL for dev2 the touchpad
> > evdev node will never send BTN_LEFT 0 in this scenario
> > leading to a stuck mouse button.
> >=20
> > This is a regression in 4.0 introduced by commit 04aae283ba6a8
> > ("Input: ALPS - do not mix trackstick and external PS/2 mouse
> > data")
> >=20
> > This commit fixes this by passing in the touchpad evdev as
> > dev2 parameter when calling alps_report_buttons for the
> > pointingstick on alps v2 devices, so that alps_report_buttons
> > correctly detect that we're already reporting the button as
> > pressed via the touchpad evdev node, and will also send the
> > release event there.
> >=20
> > Reported-by: Hans de Bruin <jmdebruin@xmsnet.nl>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Patch looks good to me, so
>=20
> Acked-by: Pali Roh=E1r <pali.rohar@gmail.com>
>=20
> As this is regression in 4.0 (which was not in 3.19), I'm also=20
> for fixing it. But decision is of course on maintainers...

Doh! Missed the 4.0 so had to tag it for stable.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
