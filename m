From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] elan_i2c: Add ACPI ID "ELAN1000"
Date: Thu, 3 Sep 2015 10:06:00 -0700
Message-ID: <20150903170600.GB17498@dtor-ws>
References: <1441137231-615-1-git-send-email-jprvita@endlessm.com>
 <CAKdAkRTWs1T7ZnMYABKtw2j3vfpVz5ngLdnehPcFoY4pz_jAoQ@mail.gmail.com>
 <CA+A7VXUXnNghu5ZCJoWo=w1vBpx43hy5AeypxJtxOVfMkhtt5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35741 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508AbbICRGE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Sep 2015 13:06:04 -0400
Received: by pacfv12 with SMTP id fv12so53243361pac.2
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2015 10:06:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+A7VXUXnNghu5ZCJoWo=w1vBpx43hy5AeypxJtxOVfMkhtt5Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Duson Lin <dusonlin@emc.com.tw>, =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@endlessm.com>

On Tue, Sep 01, 2015 at 05:15:55PM -0400, Jo=E3o Paulo Rechi Vita wrote=
:
> Hello Dmitry, thanks for the feedback.
>=20
> On 1 September 2015 at 17:00, Dmitry Torokhov <dmitry.torokhov@gmail.=
com> wrote:
> > On Tue, Sep 1, 2015 at 12:53 PM, Jo=E3o Paulo Rechi Vita
> > <jprvita@gmail.com> wrote:
> >> This ACPI ID present in the DSDT of the ASUS E202SA laptop.
> >
> > Can it be driven buy the standard hid-multitouch by any chance?
> >
>=20
> Without this change on v4.2 it is driven by i2c_hid, but behaves as a
> regular mouse, so no absolute events, multitouch, tap to click etc. I
> have not tried to use hid-multitouch with this touchpad, as I thought
> hid-multitouch was a touchscreen driver. Is there any drawback in
> having this supported by elan_i2c? Should I try a different approach?

No, that is fine, I was just checking. Applied, thank you.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
