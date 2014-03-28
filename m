From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv6 0/5] Input: edt-ft5x06: Add DT support
Date: Fri, 28 Mar 2014 09:31:54 -0700
Message-ID: <20140328163154.GE22658@core.coreip.homeip.net>
References: <1395323075-12146-1-git-send-email-LW@KARO-electronics.de>
 <1395673870-29435-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1395673870-29435-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-doc-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Fugang Duan <B38611@freescale.com>, Grant Likely <grant.likely@linaro.org>, Henrik Rydberg <rydberg@euromail.se>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jg1.han@samsung.com>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Rob Landley <rob@landley.net>, Sachin Kamat <sachin.kamat@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Budig <simon.budig@kernelconcepts.de>, Daniel Wagener <daniel.wagener@kernelconcepts.de>
List-Id: linux-input@vger.kernel.org

On Mon, Mar 24, 2014 at 04:11:05PM +0100, Lothar Wa=DFmann wrote:
> Changes wrt. v1:
> addressed the comments from Jingoo Han and Mark Rutland
> - added another patch to convert the driver to use devm_* functions
> - removed sysfs reference from bindings documentation
> - changed '_' to '-' in property name
> - added 'edt,' prefix to properties names
> - added sanity check for parameters read from DT
> - cleaned up the gpio handling code
>=20
> Changes wrt. v2:
> - fixed the devm_* messup reported by Dmitry Torokhov
> - added unit for report-rate property to the binding doc
> - added separate patch to fix the reset delays
>=20
> Changes wrt: v3:
> - removed patches that have already been applied in the mean time
> - ignore touchdown events, since those may report bad coordinates
> - added support for a new firmware version
>=20
> Changes wrt: v4:
> - removed some empty lines in the cleanup patch
> - addressed comments by Mark Rutland concerning the binding doc
> - use of_property_read_u32() instead of of_property_get()
> - dropped the 'report_rate' property
> - addressed comments by Fugang Duan
> - added Daniel Wagener and myself to the Copyright header in the
>   source file
> - use msleep() rather than mdelay() for the reset/wake pin timing
>=20
> Changes wrt: v5:
> - added missing '&' to parameter of of_property_read_u32()
>=20

Applied, thank you.

--=20
Dmitry
