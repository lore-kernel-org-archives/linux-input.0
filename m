From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 4/4] ACPI / button: Add document for ACPI control
 method lid device restrictions
Date: Mon, 11 Jul 2016 12:58:41 +0200
Message-ID: <1468234721.2277.35.camel@hadess.net>
References: <cover.1467717304.git.lv.zheng@intel.com>	
 <cover.1467875142.git.lv.zheng@intel.com>	
 <3f24a00df89f06661a64af6b4679a99bfff09aa7.1467875143.git.lv.zheng@intel.com>	
 <CAN+gG=G5p6ztJODQBBAF7MY0kBNGVpexY-+a8RQY9JKuY1AB1Q@mail.gmail.com>
	 <1AE640813FDE7649BE1B193DEA596E883BC02198@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BC02198@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Mon, 2016-07-11 at 03:20 +0000, Zheng, Lv wrote:
>=20
<snip>
> > This worries me as there is no plan after "During the period the
> > userspace hasn't been switched to use the new event".
> >=20
> > I really hope you'll keep sending SW_LID for reliable LID
> > platforms,
> > and not remove it entirely as you will break platforms.
>=20
> [Lv Zheng]=C2=A0
> We won't remove SW_LID from the kernel :).
>=20
> And we haven't removed SW_LID from the acpi button driver.
> We'll just stop sending "initial lid state" from acpi button driver,
> i.e., the behavior carried out by "button.lid_init_state=3Dignore".
>=20
> Maybe it is not sufficient, after the userspace has been changed to
> support the new event, we should stop sending SW_LID from acpi button
> driver.

=46or the affected devices? Sure, but I don't think that's a reasonable
thing to do for "all" the devices. We have a majority of laptops where
this isn't a problem, and it's not even a problem any more on one of
the devices that triggered this discussion (there's a patch for make
the LID status match reality for the Surface 3).
