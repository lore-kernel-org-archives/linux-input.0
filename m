From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH] Input: define KEY_WWAN for Wireless WAN
Date: Wed, 4 Dec 2013 19:00:00 +0100
Message-ID: <CACna6rzEg5kTApDf7QeCafwYbXwamE+pru+vos=A1-P_mSSqaQ@mail.gmail.com>
References: <1385664173-18879-1-git-send-email-zajec5@gmail.com>
	<20131204171029.GC8838@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:36173 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294Ab3LDSAA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Dec 2013 13:00:00 -0500
Received: by mail-oa0-f50.google.com with SMTP id n16so17041937oag.37
        for <linux-input@vger.kernel.org>; Wed, 04 Dec 2013 10:00:00 -0800 (PST)
In-Reply-To: <20131204171029.GC8838@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Hauke Mehrtens <hauke@hauke-m.de>

2013/12/4 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Rafal,
>
> On Thu, Nov 28, 2013 at 07:42:53PM +0100, Rafa=C5=82 Mi=C5=82ecki wro=
te:
>> Some devices with support for mobile networks may have buttons for
>> enabling/disabling such connection. An example can be Linksys router
>> 54G3G.
>> We already have KEY_BLUETOOTH, KEY_WLAN and KEY_UWB so it makes sens=
e
>> to add KEY_WWAN as well.
>
> Isn't WiMAX an implementation of WWAN? Maybe instead of adding a new
> keycode we should use KEY_WIMAX code and alias KEY_WIMAX to KEY_WWAN =
to
> preserve ABI?

I didn't think about it but if WiMAX is indeed kind of WWAN, it makes
a perfect sense to me!

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
