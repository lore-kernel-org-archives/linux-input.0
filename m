From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: uinput really needs a custom sleep time?
Date: Tue, 31 Jan 2017 23:11:29 -0200
Message-ID: <20170201011126.GB1271@xfiles>
References: <20170131020039.GA2138@xfiles>
 <CAKdAkRT3t7o3EQESpMPdZtcutaXbPHHqywt38YJtR53NPhZq2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34058 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbdBABNK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Jan 2017 20:13:10 -0500
Received: by mail-qk0-f174.google.com with SMTP id s186so2738920qkb.1
        for <linux-input@vger.kernel.org>; Tue, 31 Jan 2017 17:11:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKdAkRT3t7o3EQESpMPdZtcutaXbPHHqywt38YJtR53NPhZq2w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Jan 30, 2017 at 06:21:59PM -0800, Dmitry Torokhov wrote:
> On Mon, Jan 30, 2017 at 6:00 PM, Marcos Paulo de Souza
> <marcos.souza.org@gmail.com> wrote:
> > Hi input guys,
> >
> > after playing with uinput, it seems an sleep call is necessary before emitting new events. If this really required?
> >
> > While reading code of cwiid project, another user of uinput interface, it seems this sleep time isn't necessary[1].
> >
> > In the other hang, when trying to send a simple event in my desktop, an sleep is necessary, take a look in my example[2].
> 
> The sleep is not necessary for sending events, but you need to give
> time for the rest of the system to notice that there is new input
> device, decide what to do with it, and open it, so that you can
> actually observe the events you sent, as opposed for them to be
> dropped because there are no users of that input device.

Makes sense to wait to the Window Manager to "discover" the new input
device and to receive the events. Thanks for the clarification!

> 
> Thanks.
> 
> -- 
> Dmitry
