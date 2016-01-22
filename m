From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: ALPS v7 trackpad passthrough to Thinkpad trackpoint
Date: Fri, 22 Jan 2016 09:14:56 +0100
Message-ID: <20160122081456.GJ7192@pali>
References: <20150807141214.GD21627@pali>
 <CANULwrTm0XEdKfC7Shx5VLpvHmkzRt5mOUjbFSm8ck86Ci=iKQ@mail.gmail.com>
 <20150813110317.GC20040@pali>
 <20150813224839.GC15693@dtor-ws>
 <17D6F4B6F11B44BBB1A2C8EB95A9CF84@cirque.local>
 <20150814001833.GD15693@dtor-ws>
 <7A4B7432A86148988B9878D8EB50F969@cirque.local>
 <20160121121203.GC7192@pali>
 <497C6C7E7BB2424DB3AC56CD7FF593F6@cirque.local>
 <CANULwrRY4YZfWC24GrL8OAarhT4ufULvcyt84ifQs1_rBpHhdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35232 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbcAVIPA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jan 2016 03:15:00 -0500
Received: by mail-wm0-f45.google.com with SMTP id r129so202830357wmr.0
        for <linux-input@vger.kernel.org>; Fri, 22 Jan 2016 00:14:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANULwrRY4YZfWC24GrL8OAarhT4ufULvcyt84ifQs1_rBpHhdg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ari Entlich <atrigent@gmail.com>
Cc: Vadim Klishko <vadim@cirque.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Masaki Ota <012nexus@gmail.com>, Tommy Will <tommywill2011@gmail.com>, Qiting Chen <qiting.chen@cn.alps.com>, Qiting Chen <elaineee66@gmail.com>

On Thursday 21 January 2016 22:38:57 Ari Entlich wrote:
> On Thu, Jan 21, 2016 at 8:50 PM, Vadim Klishko <vadim@cirque.com> wro=
te:
> > However, it looks like you already know everything there is to know=
 about
> > how to set the trackpad in pass-thru mode and how to check if there=
 is a
> > trackstick behind the trackpad. The code is already in alps.c
>=20
> The original question was specifically about devices which use the v7
> protocol. It looks to me like alps.c only includes code for
> passthrough on v2 and v3 devices, unless alps_passthrough_mode_v2 or
> alps_passthrough_mode_v3 would also work on v7 devices. I believe we
> would also need to know whether passthrough support is always present
> on v7 devices with tracksticks or whether its presence needs to be
> detected somehow.

=46or v7 see my patch which was finally after Alex testing included:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/=
?id=3Ddae928ec3c29e7e16723c9c4c1299e00f4e9e949

> Also, neither of these passthrough modes are being used to provide a
> full serio device for the trackstick, but that might just be a
> limitation of the driver.

Yes, question for Vadim about providing full serio passthrough
trackstick device reminds open.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
