From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: uinput really needs a custom sleep time?
Date: Mon, 30 Jan 2017 18:21:59 -0800
Message-ID: <CAKdAkRT3t7o3EQESpMPdZtcutaXbPHHqywt38YJtR53NPhZq2w@mail.gmail.com>
References: <20170131020039.GA2138@xfiles>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33119 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbdAaC2N (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Jan 2017 21:28:13 -0500
Received: by mail-vk0-f42.google.com with SMTP id k127so228133210vke.0
        for <linux-input@vger.kernel.org>; Mon, 30 Jan 2017 18:28:13 -0800 (PST)
In-Reply-To: <20170131020039.GA2138@xfiles>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Jan 30, 2017 at 6:00 PM, Marcos Paulo de Souza
<marcos.souza.org@gmail.com> wrote:
> Hi input guys,
>
> after playing with uinput, it seems an sleep call is necessary before emitting new events. If this really required?
>
> While reading code of cwiid project, another user of uinput interface, it seems this sleep time isn't necessary[1].
>
> In the other hang, when trying to send a simple event in my desktop, an sleep is necessary, take a look in my example[2].

The sleep is not necessary for sending events, but you need to give
time for the rest of the system to notice that there is new input
device, decide what to do with it, and open it, so that you can
actually observe the events you sent, as opposed for them to be
dropped because there are no users of that input device.

Thanks.

-- 
Dmitry
