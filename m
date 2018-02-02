From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - Lenovo Carbon X1 Gen5 (2017) devices
 should use RMI
Date: Fri, 2 Feb 2018 12:50:50 -0800
Message-ID: <20180202205050.i5pkl3rji45oovxb@dtor-ws>
References: <20170818193436.GA31365@dtor-ws>
 <CAEk1YH7A3ENphMLdgdgMqyvq5CmCe3P5KpeekPpzV_4FcGUU-g@mail.gmail.com>
 <20170821154522.GA21773@dtor-ws>
 <CAEk1YH7+8Vnqpe5o30bsgH+fU7U+T9uEtHmK+dah5vaPwo1w0Q@mail.gmail.com>
 <CAEk1YH7Ni04Hs4RHtDJyE368aA4-DSW5aGx+v8kpbhLF2OR2Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37597 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBBUuy (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 2 Feb 2018 15:50:54 -0500
Received: by mail-pg0-f68.google.com with SMTP id o1so375893pgn.4
        for <linux-input@vger.kernel.org>; Fri, 02 Feb 2018 12:50:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAEk1YH7Ni04Hs4RHtDJyE368aA4-DSW5aGx+v8kpbhLF2OR2Sg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Damjan Georgievski <gdamjan@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Aug 25, 2017 at 12:55:29PM +0200, Damjan Georgievski wrote:
> On 21 August 2017 at 18:25, Damjan Georgievski <gdamjan@gmail.com> wrote:
> >> I wonder if we have different configs...
> >>
> >>>
> >>> Second issues is, trackpoint is reported as "ImPS/2 Generic Wheel
> >>> Mouse". Middle button scrolling is not enabled by default.
> >>
> >> I think this will be fixed by:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/patch/?id=ec667683c532c93fb41e100e5d61a518971060e2
> >>
> >
> > Interesting, with this patch, the trackpoint appeared sooner, but
> > still late (at the 44 second mark):
> 
> but that seems sporadic. on second boot, it didn't show up until I
> reloaded the psmouse module
> 
> any ideas how to debug this issue further? possibly before the change
> goes upstream.

Damjan,

Since my other patches seem to have fixed the trackpoint detection
issue, mind giving your "tested-by" to this patch so I can get it in?

Thanks.

-- 
Dmitry
