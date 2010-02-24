From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] winbond-cir: fix suspend/resume
Date: Wed, 24 Feb 2010 02:19:36 -0800
Message-ID: <20100224101936.GA8036@core.coreip.homeip.net>
References: <20100210220025.GA10609@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f182.google.com ([209.85.210.182]:46244 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756216Ab0BXKTl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Feb 2010 05:19:41 -0500
Content-Disposition: inline
In-Reply-To: <20100210220025.GA10609@hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 10, 2010 at 11:00:25PM +0100, David H=E4rdeman wrote:
> I finally got the time to fix suspend/resume with the winbond-cir
> driver on my mainboard. The main problem turned out to be that the
> ACPI _DIS method would completely power off the SP3 module which
> meant that the output lines (including IRQ lines) would be left
> in an undefined state which could cause spurious interrupts and
> that the hardware has to be reinitialized from scratch during
> resume.
>=20
> This fixes:
> http://bugzilla.kernel.org/show_bug.cgi?id=3D15257
>=20
> Signed-off-by: David H=E4rdeman <david@hardeman.nu>

Applied, thank you David. Let's see if I manage to quieeze it in .33.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
