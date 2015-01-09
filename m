From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 0/2] INPUT/HID: add touch support for SiS touch driver
Date: Fri, 09 Jan 2015 12:31:32 +0100
Message-ID: <1420803092.13007.9.camel@linux-0dmf.site>
References: <8322374EB97AA24A95D0DDBFC8F1CA1DBF96E8@SISMBEV01.sis.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8322374EB97AA24A95D0DDBFC8F1CA1DBF96E8@SISMBEV01.sis.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: "=?UTF-8?Q?=E6=9B=BE=E5=A9=B7=E8=91=B3?= (tammy_tseng)" <tammy_tseng@sis.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, tammy0524@gmail.com
List-Id: linux-input@vger.kernel.org

On Fri, 2015-01-09 at 18:36 +0800, =E6=9B=BE=E5=A9=B7=E8=91=B3 (tammy_t=
seng) wrote:
> Signed-off-by: Tammy Tseng <tammy_tseng@sis.com>
>=20
> ---
> The patch for i2c multitouch driver in input/touchscreen:
>=20
> linux-3.18.1/drivers/input/touchscreen/Kconfig   |   14 -
>  linux-3.18.1/drivers/input/touchscreen/Makefile  |    4 -
>  linux-3.18.1/drivers/input/touchscreen/sis_i2c.c | 1725
> ----------------------
>  linux-3.18.1/drivers/input/touchscreen/sis_i2c.h |  229 ---
>  4 files changed, 1972 deletions(-)

Only deletions and it adds support?
I guess you mixed up your trees.

	Regards
		Oliver
