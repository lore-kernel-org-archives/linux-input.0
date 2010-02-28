From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: scancode in get/set_keycodes should be unsigned
Date: Sat, 27 Feb 2010 23:05:36 -0800
Message-ID: <20100228070536.GC765@core.coreip.homeip.net>
References: <20100228061310.GA765@core.coreip.homeip.net>
 <4B8A10D0.2020802@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49285 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031421Ab0B1HFm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Feb 2010 02:05:42 -0500
Content-Disposition: inline
In-Reply-To: <4B8A10D0.2020802@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: Matthew Garrett <mjg@redhat.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Linux Input <linux-input@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Platform Driver x86 <platform-driver-x86@vger.kernel.org>

On Sun, Feb 28, 2010 at 07:44:32AM +0100, N=E9meth M=E1rton wrote:
> Hi,
> Dmitry Torokhov wrote:
> > The HID layer has some scan codes of the form 0xffbc0000 for logite=
ch
> > devices which do not work if scancode is typed as signed int, so we=
 need
> > to switch to unsigned int instead. While at it keycode being signed=
 does
> > not make much sense either.
>=20
> Are the scan codes and key codes always 4 bytes long? Then the u32 da=
ta
> type could be used to take 16 bit (or 64 bit) processors also into
> consideration.
>

We do not support 16 bit processors and for 64 bit 'unsigned int' is
still 32 bits.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
