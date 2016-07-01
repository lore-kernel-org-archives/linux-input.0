From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: add support for Type Cover Pro 3
Date: Fri, 1 Jul 2016 16:52:12 +0200
Message-ID: <20160701145212.GA24234@mail.corp.redhat.com>
References: <1466196443.21223.1.camel@gmail.com>
 <alpine.LNX.2.00.1606172259110.6874@cbobk.fhfr.pm>
 <20160617211142.GH24234@mail.corp.redhat.com>
 <1466275994.2669.11.camel@gmail.com>
 <20160618194534.GI24234@mail.corp.redhat.com>
 <1466369282.15726.7.camel@gmail.com>
 <20160620095934.GN24234@mail.corp.redhat.com>
 <1466739490.3464.8.camel@gmail.com>
 <20160624071419.GO24234@mail.corp.redhat.com>
 <1466840940.28419.6.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36837 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171AbcGAOwQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Jul 2016 10:52:16 -0400
Content-Disposition: inline
In-Reply-To: <1466840940.28419.6.camel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dennis Chen <barracks510@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input <linux-input@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi,

On Jun 25 2016 or thereabouts, Dennis Chen wrote:
> On Fri, 2016-06-24 at 09:14 +0200, Benjamin Tissoires wrote:
> > Looks like the same issue Andy is seeing on the Surface Book. So I
> > think my patch must have a bug where it resets the quirks set by
> > usbhid. And this is why we are screwed here.
> >=20
>=20
> Yes, I think that's likely. There doesn't seem to be an issue most of
> the time, so it's not a huge deal.=C2=A0

I spent a good amount of time trying to figure out where the bug was,
and I couldn't reproduce it either with uhid or even with usb_gadget.
Even KASan doesn't gives any wrong memory access, and I can't understan=
d
why you get this faulty behavior.

So I must say, I am puzzled on why you end up calling
usbhid_init_reports() while the quirk HID_QUIRK_NO_INIT_REPORTS should
be in place.
Would you mind adding some printk() in hid-multitouch to dump the value
of hdev->quirks before and after calling hid_hw_start() in mt_probe()?

Also, ideally, if you could add a dump_stack() in
drivers/hid/usbhid/hid-core.c, right before leaving
usbhid_init_reports(), that would be awesome.

I would have prefer being able to understand myself what is going on,
but it looks like there is something different happening when I do not
have the device.

>=20
> > Regarding your disconnect issue, what happens I think is that you
> > disconnect it before the timeout of usb_submit_urb(), and so the us=
b
> > layer is stuck trying to access the device and can't access the new=
ly
> > plugged one. If you wait enough (initial timeout + new timeout -> 2=
0
> > secs), then the device behaves properly again.
> >=20
>=20
> That is the behavior I have noticed. Is there any potential fix?
>=20

The fix is to not fetch the buggy features that timeout. For that, we
usually set the flag HID_QUIRK_NO_INIT_REPORTS, which prevents it. But
in your case, the code says that the flag is set, while the code is
still called :(

Thanks,
Benjamin


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
