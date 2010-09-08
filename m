From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH 4/6] Input: winbond-cir - switch to using new keycode
 interface
Date: Wed, 8 Sep 2010 23:16:17 +0200
Message-ID: <20100908211617.GB13938@hardeman.nu>
References: <20100908073233.32365.74621.stgit@hammer.corenet.prv>
 <20100908074200.32365.98120.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100908074200.32365.98120.stgit@hammer.corenet.prv>
Sender: linux-media-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Linux Input <linux-input@vger.kernel.org>, linux-media@vger.kernel.org, Jarod Wilson <jarod@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ville Syrjala <syrjala@sci.fi>
List-Id: linux-input@vger.kernel.org

On Wed, Sep 08, 2010 at 12:42:00AM -0700, Dmitry Torokhov wrote:
> Switch the code to use new style of getkeycode and setkeycode
> methods to allow retrieving and setting keycodes not only by
> their scancodes but also by index.
>=20
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>=20
>  drivers/input/misc/winbond-cir.c |  248 +++++++++++++++++++++++++---=
----------
>  1 files changed, 163 insertions(+), 85 deletions(-)

Thanks for doing the conversion for me, but I think you can skip this=20
patch. The driver will (if I understood your patchset correctly) still=20
work with the old get/setkeycode ioctls and I have a patch lined up tha=
t=20
converts winbond-cir.c to use ir-core which means all of the input=20
related code is removed.


--=20
David H=E4rdeman
