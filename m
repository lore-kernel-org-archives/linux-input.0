From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 2/2] Add a driver for the Winbond WPCD376I IR
 functionality.
Date: Wed, 1 Jul 2009 14:53:51 -0700
Message-ID: <20090701145351.78c0f28b@jbarnes-g45>
References: <1246079912-17619-1-git-send-email-david@hardeman.nu>
	<1246079912-17619-3-git-send-email-david@hardeman.nu>
	<20090630142345.58e97b50.akpm@linux-foundation.org>
	<20090701214753.GB5946@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20090701214753.GB5946@hardeman.nu>
Sender: linux-acpi-owner@vger.kernel.org
To: David =?UTF-8?B?SMOkcmRlbWFu?= <david@hardeman.nu>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 1 Jul 2009 23:47:53 +0200
David H=C3=A4rdeman <david@hardeman.nu> wrote:

> This patch adds a driver for the the Consumer IR (CIR) functionality
> of the Winbond WPCD376I chipset (found on e.g. Intel DG45FC
> motherboards).
>=20
> Changes since the driver was first posted to the list:
> o Homebrew dprintk -> dev_dbg
> o Some magic values changed to defines
> o Fixed a bug where the wake-ir-command mask/value would not be
>    written properly
> o Fixed the use of the invert parameter both for wake and normal
>    IR reception.
>=20
> Changes since the second post to the list (AKPM's remarks):
> o Various comments added
> o Removed some casts
> o use bitrev8
> o convert data->irdata to unsigned longs, use __set_bit and test_bit
>=20
> Andrew, please replace the patch you currently have in the -mm tree
> with this one.
>=20
> Signed-off-by: David H=C3=A4rdeman <david@hardeman.nu>

Looking nice to me...  Thanks for writing this, David.

Reviewed-by: Jesse Barnes <jbarnes@virtuousgeek.org>

--=20
Jesse Barnes, Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
