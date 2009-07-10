From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/2] Winbond driver as PNP
Date: Fri, 10 Jul 2009 10:01:21 -0600
Message-ID: <200907101001.22122.bjorn.helgaas@hp.com>
References: <1246079912-17619-1-git-send-email-david@hardeman.nu> <200907091538.21685.bjorn.helgaas@hp.com> <11512ed726f2d6754f46e76c7db191a8.squirrel@www.hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11512ed726f2d6754f46e76c7db191a8.squirrel@www.hardeman.nu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: David =?iso-8859-1?q?H=E4rdeman?= <david@hardeman.nu>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, Len Brown <lenb@kernel.org>
List-Id: linux-input@vger.kernel.org

On Friday 10 July 2009 01:55:27 am David H=E4rdeman wrote:
> On Thu, July 9, 2009 23:38, Bjorn Helgaas wrote:
> > Here are two sample patches to show you what I was suggesting.  The=
se
> > apply on top of the two Winbond patches currently in -mm.
>=20
> Thanks, great service :)
>=20
> I'll test the patches as soon as I have time and access to the hardwa=
re.
>=20
> One question though, the resulting patch series (if AKPM merges these
> patches in addition to the existing ones and drops the patch adding
> .shutdown to acpi_driver) will be git bisect unfriendly.
>=20
> Should I roll two new patches instead to replace the three patches
> currently in -mm?

If you like the approach and it works, I would take the latter
approach (replace the three patches with two new ones -- e.g.,
add-pnp-shutdown-method and add-winbond-pnp-driver).  I don't
think we have to worry about bisectability until they show up
in a git tree.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
