From: =?UTF-8?B?RGFuaWVsIEdsw7Zja25lcg==?= <dg@emlix.com>
Subject: Re: [PATCH] ad7877: fix spi word size to 16 bit
Date: Tue, 18 May 2010 11:37:05 +0200
Message-ID: <4BF25FC1.30201@emlix.com>
References: <1273142265-11929-1-git-send-email-os@emlix.com> 	<n2j8bd0f97a1005061126h7fecc32btad9986c0e38246f2@mail.gmail.com> 	<4BE3E02E.1090500@emlix.com> <h2l8bd0f97a1005071123u782bab2doee5c122dbd4c8642@mail.gmail.com> 	<20100513075335.GD30110@core.coreip.homeip.net> <20100515181523.GA3081@emlix.com> 	<AANLkTinn6VgvujPP3gGsteBGckIFgljn7B35DV6n8kwL@mail.gmail.com> 	<20100517072935.GA14891@emlix.com> <AANLkTimeAn9ALs4KxBNwwk-B419OwZ0BUwoKcoEfUbGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.emlix.com ([193.175.82.87]:33332 "EHLO mx1.emlix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755928Ab0ERJhM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 May 2010 05:37:12 -0400
In-Reply-To: <AANLkTimeAn9ALs4KxBNwwk-B419OwZ0BUwoKcoEfUbGw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Oskar Schirmer <os@emlix.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Schneidewind <osw@emlix.com>, Michael Hennerich <michael.hennerich@analog.com>

On 05/18/2010 01:49 AM, Mike Frysinger wrote:
> the board settings also function as default setup values so when usin=
g
> generic things like the spidev driver, there is no kernel driver to
> request the desired bitmode.

spidev allows to set the bits per word with the SPI_IOC_WR_BITS_PER_WOR=
D
ioctl. it is also possible to set this on a per-transfer basis.

  Daniel


--=20
Dipl.-Math. Daniel Gl=C3=B6ckner, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G=C3=B6ttingen,=
 Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B =
3160
Gesch=C3=A4ftsf=C3=BChrer: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
