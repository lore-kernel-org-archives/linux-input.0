From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/2] ACPI: reintroduce acpi_device_ops .shutdown method
Date: Wed, 8 Jul 2009 10:52:19 -0600
Message-ID: <200907081052.20142.bjorn.helgaas@hp.com>
References: <1246079912-17619-1-git-send-email-david@hardeman.nu> <200906301711.34074.bjorn.helgaas@hp.com> <737c7bd0a2f550d21d45b347d018a1ac.squirrel@www.hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:23068 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbZGHQwX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jul 2009 12:52:23 -0400
In-Reply-To: <737c7bd0a2f550d21d45b347d018a1ac.squirrel@www.hardeman.nu>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David =?iso-8859-1?q?H=E4rdeman?= <david@hardeman.nu>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, Len Brown <lenb@kernel.org>

On Wednesday 01 July 2009 02:20:59 am David H=E4rdeman wrote:
> On Wed, July 1, 2009 01:11, Bjorn Helgaas wrote:
> > The winbond driver does not use any ACPI-specific functionality, so
> > it might be simpler to write it as a PNP driver (which would depend
> > on PNPACPI, of course).
>=20
> As far as I could tell from a quick look at include/linux/pnp.h, a
> pnp_driver doesn't seem to have any .shutdown methods either, so I'm =
not
> sure how it would help?

PNPACPI parses the device resources for you, so you could get rid
of the _CRS stuff in your driver.

The only reason PNP and ACPI don't have .shutdown is because nobody
has needed it yet.  If you need it (and it sounds like you do), I
think the cleanest thing would be to add it to PNP and turn your
driver into a PNP driver.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
