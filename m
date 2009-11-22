From: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: Re: [RFC, PATCH 1/2] gspca: add input support for interrupt endpoints
Date: Sun, 22 Nov 2009 16:49:48 +0100
Message-ID: <4B095D9C.2060002@freemail.hu>
References: <4B04F7E0.1090803@freemail.hu> <4B05074B.1030407@redhat.com> <4B0641C2.1050200@freemail.hu> <20091120101951.720e5703@tele> <4B07CC15.9010005@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4B07CC15.9010005@freemail.hu>
Sender: linux-media-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, V4L Mailing List <linux-media@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

N=E9meth M=E1rton wrote:
> Jean-Francois Moine wrote:
>> On Fri, 20 Nov 2009 08:14:10 +0100
>> N=E9meth M=E1rton <nm127@freemail.hu> wrote:
>>> Unfortunately I still get the following error when I start streamin=
g,
>>> stop streaming or unplug the device:
>>>
>>> [ 6876.780726] uhci_hcd 0000:00:10.1: dma_pool_free buffer-32,
>>> de0ad168/1e0ad168 (bad dma)
>> As there is no 'break' in gspca_input_create_urb(), many URBs are
>> created.
>=20
> I added 'break' in the loop, which makes no real difference because
> my device have only one interrupt in endpoint. The error message is
> printed when the usb_buffer_free() is called in gspca_input_destroy_u=
rb():
>=20
> [ 6362.113264] gspca_input: Freeing buffer
> [ 6362.113284] uhci_hcd 0000:00:1d.1: dma_pool_free buffer-32, f5ada9=
48/35ada948 (bad dma)
> [ 6362.113296] gspca_input: Freeing URB

The problem was that the URB buffer was allocated with kmalloc() and wa=
s freed
with usb_buffer_free(). The right pair is usb_buffer_alloc() and usb_bu=
ffer_free().

Regards,

	M=E1rton N=E9meth
