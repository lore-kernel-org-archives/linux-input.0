From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH] input: remove unneeded DRIVER_LICENSE #defines
Date: Sat, 18 Nov 2017 13:39:03 +0100
Message-ID: <CAOFm3uEScMh9PmQMuGvUY39sw=0iJhs0BezQHUhg2-KWZ1fRuQ@mail.gmail.com>
References: <20171117141720.GB17880@kroah.com> <20171117203313.l7lqzrun5bnuj2ht@dtor-ws>
 <20171118102724.GF8368@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:47095 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761378AbdKRMjo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 07:39:44 -0500
Received: by mail-wm0-f42.google.com with SMTP id u83so2508993wmb.5
        for <linux-input@vger.kernel.org>; Sat, 18 Nov 2017 04:39:44 -0800 (PST)
In-Reply-To: <20171118102724.GF8368@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Sat, Nov 18, 2017 at 11:27 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Please do, I got rid of all of the DRIVER_VERSION crap in the
> drivers/usb/ tree a release or so ago, as they make no sense at all.
> The other defines are also really silly and can be cleaned up too.
>
> Want me to do that for drivers/input/ for you?
>
> thanks,
>
> greg "I'm a janitor now" k-h


Thing could get worse: you could become a documentalist like tglx turned into.

For the fun, another weird thingie that I once stumbled upon in an
out-of-tree third-party module:

MODULE_LICENSE("\x47\x50\x4c\x20\x76\x32");

... which was most likely from a GPL-shy closet Free software
advocate: this is "GPL v2" in ASCII.

-- 
Cordially
Philippe Ombredanne
