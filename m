From: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: Re: [PATCH] Input: scancode in get/set_keycodes should be unsigned
Date: Sun, 28 Feb 2010 09:40:18 +0100
Message-ID: <4B8A2BF2.40003@freemail.hu>
References: <20100228061310.GA765@core.coreip.homeip.net> <4B8A10D0.2020802@freemail.hu> <20100228070536.GC765@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100228070536.GC765@core.coreip.homeip.net>
Sender: linux-media-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Linux Input <linux-input@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Platform Driver x86 <platform-driver-x86@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Sun, Feb 28, 2010 at 07:44:32AM +0100, N=E9meth M=E1rton wrote:
>> Hi,
>> Dmitry Torokhov wrote:
>>> The HID layer has some scan codes of the form 0xffbc0000 for logite=
ch
>>> devices which do not work if scancode is typed as signed int, so we=
 need
>>> to switch to unsigned int instead. While at it keycode being signed=
 does
>>> not make much sense either.
>> Are the scan codes and key codes always 4 bytes long? Then the u32 d=
ata
>> type could be used to take 16 bit (or 64 bit) processors also into
>> consideration.
>>
>=20
> We do not support 16 bit processors and for 64 bit 'unsigned int' is
> still 32 bits.
>=20

OK, then:

Acked-by: M=E1rton N=E9meth <nm127@freemail.hu>
