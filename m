From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 09/37] Remove unneeded version.h includes from
 drivers/input/
Date: Mon, 27 Jun 2011 08:10:18 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713EA0AEE78D@LIMKCMBX1.ad.analog.com>
References: <alpine.LNX.2.00.1106232344480.17688@swampdragon.chaosbits.net>
 <alpine.LNX.2.00.1106240009201.17688@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1106240009201.17688@swampdragon.chaosbits.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Juhl <jj@chaosbits.net>, LKML <linux-kernel@vger.kernel.org>
Cc: "trivial@kernel.org" <trivial@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Rubini <rubini@cvml.unipv.it>, Mike Frysinger <vapier@gentoo.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Jesper Juhl wrote on 2011-06-24:
> It was pointed out by 'make versioncheck' that some includes of
> linux/version.h are not needed in drivers/input/.
> This patch removes them.
>
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
>  drivers/input/keyboard/adp5588-keys.c |    1 -
>  drivers/input/keyboard/adp5589-keys.c |    1 -

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
