From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Side effect of pressing special keys
Date: Wed, 3 Dec 2014 13:40:42 +0100
Message-ID: <20141203124042.GA504@amd>
References: <201411231441.17592@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43579 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbaLCMko (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Dec 2014 07:40:44 -0500
Content-Disposition: inline
In-Reply-To: <201411231441.17592@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org

On Sun 2014-11-23 14:41:17, Pali Roh=E1r wrote:
> Hello,
>=20
> pressing some keys on laptops could cause some side effects.
>=20
> Example scenario 1:
>=20
> Laptop has Fn key for enabling/disabling WIFI and when that key=20
> is pressed BIOS is doing two things:
>=20
> 1) Switch hard rfkill state of WIFI
> 2) Report that Fn key was pressed to kernel
>    (either via i8042 bus or via ACPI/WMI)

We should not really report that as a "key" to userspace. We might
want to report that rfkill state changed....
							Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
