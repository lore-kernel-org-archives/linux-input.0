From: Jeffrey Brown <jeffbrown@android.com>
Subject: Re: [PATCH 2/3] hid-multitouch: Filter collections by application usage.
Date: Mon, 25 Jul 2011 11:08:30 -0700
Message-ID: <CAMu+ixi4gpKg=LW4o2nK7NDm4r+B368qh=fSvtndKfqf204K9A@mail.gmail.com>
References: <1311545261-34067-1-git-send-email-jeffbrown@android.com>
 <CAN+gG=FAFX-N-3FpAmgkE+im4oT9h657Rk9h3=-17sCBwVx35A@mail.gmail.com> <E25AA279-4029-40BF-9CB0-873763C53AB4@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f171.google.com ([209.85.215.171]:60691 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab1GYSJL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 14:09:11 -0400
In-Reply-To: <E25AA279-4029-40BF-9CB0-873763C53AB4@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: benjamin.tissoires@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, rydberg@euromail.se

On Mon, Jul 25, 2011 at 6:48 AM, St=E9phane Chatty <chatty@enac.fr> wro=
te:
> So far it works fine on our Cypress panel. I'll keep you posted about=
 Lumio and Stantum as soon as we have finished compiling Linux 3.0.

Actually, I'm wondering if we could merge hid-multitouch into hid-input=
=2E

Checking for an application usage of TouchScreen or TouchPad should be
pretty unambiguous.  It ought to be possible to support most Windows 7
compatible HID multitouch devices out of the box without needing to
add them to any exception lists whatsoever, except for those few that
might need quirks.

Jeff.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
