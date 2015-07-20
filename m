From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: ALPS DualPoint double click bug
Date: Mon, 20 Jul 2015 09:25:48 +0200
Message-ID: <20150720072548.GA25910@pali>
References: <CANuv8QyimosOLwtvLpSLjjEk2SemgxTrZDJxWnzQG-M3q20CHg@mail.gmail.com>
 <20150720065446.GA13879@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35354 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563AbbGTHZz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 03:25:55 -0400
Received: by wibxm9 with SMTP id xm9so83793761wib.0
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2015 00:25:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150720065446.GA13879@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Douglas Christman <douglaschristman@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Sunday 19 July 2015 23:54:46 Dmitry Torokhov wrote:
> On Sun, Jul 19, 2015 at 09:29:26AM -0400, Douglas Christman wrote:
> > Hello all,
> >=20
> > Kernel v4.1 introduces a bug for my laptop's (Toshiba Tecra A10)
> > touchpad.  Clicking twice only registers as a single click (and thr=
ee
> > clicks are needed to double-click).
> >=20
> > The touchpad shows up as 'AlpsPS/2 ALPS DualPoint' in dmesg.
> > Bisecting drivers/input/mouse suggests that commit 92bac83d introdu=
ced
> > the bug.
> >=20
> > Please let me know if I can provide any other information that woul=
d be useful.
> >=20
> > Filed as bug #101701 on bugzilla.
>=20
> Let's add a few people...
>=20

Hi! Please recompile psmouse.ko with dev_dbg() debug information and
send new dmesg output. We need to know type of ALPS device. Thanks!

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
