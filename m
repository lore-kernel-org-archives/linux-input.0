From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] HID: asus: fix special key support for ASUS I2C keyboards
Date: Tue, 7 Mar 2017 07:27:47 -0600
Message-ID: <CAD8Lp44FDCOrYSy_6NoYoWO1ixWkR+Ajndr0Yus_TDQVTAY3gg@mail.gmail.com>
References: <1488675034-7220-1-git-send-email-matjaz.hegedic@gmail.com>
 <20170306084701.GV7064@mail.corp.redhat.com> <89d42448-01af-055c-877b-3ed0896b6ae6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f170.google.com ([74.125.82.170]:36012 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbdCGN4a (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 08:56:30 -0500
Received: by mail-ot0-f170.google.com with SMTP id i1so2665779ota.3
        for <linux-input@vger.kernel.org>; Tue, 07 Mar 2017 05:56:29 -0800 (PST)
In-Reply-To: <89d42448-01af-055c-877b-3ed0896b6ae6@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?TWF0amHFviBIZWdlZGnEjQ==?= <matjaz.hegedic@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Hi,

On Tue, Mar 7, 2017 at 5:56 AM, Matja=C5=BE Hegedi=C4=8D <matjaz.hegedic@gm=
ail.com> wrote:
> That's good - I see our patches are very similar (also referring to the s=
ame Usage Page) and might feasibly be merged.

Mine is already accepted here:

https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/log/?h=3Dfor-4.1=
2/asus

So I suggest respinning yours on top of that.

Thanks!
Daniel
