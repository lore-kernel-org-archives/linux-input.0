From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/2] Winbond driver as PNP
Date: Thu, 9 Jul 2009 15:38:21 -0600
Message-ID: <200907091538.21685.bjorn.helgaas@hp.com>
References: <1246079912-17619-1-git-send-email-david@hardeman.nu> <737c7bd0a2f550d21d45b347d018a1ac.squirrel@www.hardeman.nu> <200907081052.20142.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200907081052.20142.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: David =?iso-8859-1?q?H=E4rdeman?= <david@hardeman.nu>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, Len Brown <lenb@kernel.org>
List-Id: linux-input@vger.kernel.org

On Wednesday 08 July 2009 10:52:19 am Bjorn Helgaas wrote:
> On Wednesday 01 July 2009 02:20:59 am David H=E4rdeman wrote:
> > On Wed, July 1, 2009 01:11, Bjorn Helgaas wrote:
> > > The winbond driver does not use any ACPI-specific functionality, =
so
> > > it might be simpler to write it as a PNP driver (which would depe=
nd
> > > on PNPACPI, of course).
> >=20
> > As far as I could tell from a quick look at include/linux/pnp.h, a
> > pnp_driver doesn't seem to have any .shutdown methods either, so I'=
m not
> > sure how it would help?
>=20
> PNPACPI parses the device resources for you, so you could get rid
> of the _CRS stuff in your driver.
>=20
> The only reason PNP and ACPI don't have .shutdown is because nobody
> has needed it yet.  If you need it (and it sounds like you do), I
> think the cleanest thing would be to add it to PNP and turn your
> driver into a PNP driver.

Here are two sample patches to show you what I was suggesting.  These
apply on top of the two Winbond patches currently in -mm.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
