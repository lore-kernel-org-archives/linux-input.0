From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Default keyboard LEDs
Date: Mon, 14 Jan 2008 10:27:06 +0000
Message-ID: <20080114102706.GB4298@implementation.uk.xensource.com>
References: <20080114005219.GA4296@implementation> <478ADC0A.7020006@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:5781 "EHLO SMTP02.CITRIX.COM"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755852AbYANKdh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jan 2008 05:33:37 -0500
Content-Disposition: inline
In-Reply-To: <478ADC0A.7020006@zytor.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

H. Peter Anvin, le Sun 13 Jan 2008 19:50:34 -0800, a =E9crit :
> >Actually, what would be perfect would be to use the configuration th=
at
> >the BIOS sets at boot by default.  That is device-dependent, however=
=2E
> >
>=20
> It is, but it can be read out either by INT calls at initialization=20
> time, or by reading out the byte at physical address 0x417:

I should have said "arch-dependent".
I didn't mean it wasn't possible, but just it'd probably be better that
driver experts do it, not me :)

> --------K-M00400017--------------------------
> MEM 0040h:0017h - KEYBOARD - STATUS FLAGS 1
> Size:   BYTE
> SeeAlso: MEM 0040h:0018h,INT 16/AH=3D02h,MEM 0040h:0096h
>=20
> Bitfields for keyboard status flags 1:
> Bit(s)  Description     (Table M0010)
>  7      INSert active
>  6      Caps Lock active
>  5      Num Lock active
>  4      Scroll Lock active
>  3      either Alt pressed
>  2      either Ctrl pressed
>  1      Left Shift pressed
>  0      Right Shift pressed
> SeeAlso: #M0011,#00587
>=20
> The same information is available through INT 16h, AH=3D02h.

Samuel
-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
