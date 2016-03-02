From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: Chipone icn85xx support in x86 linux kernel
Date: Wed, 2 Mar 2016 23:06:10 +0000
Message-ID: <CA+V1LzoTK00jcNZFBKCA5QNTtA75+ZxJKrhogws9xMP+2dFc3w@mail.gmail.com>
References: <CA+V1LzoXvWO1FROO2z7tFc-0zoM_Ur+B1iiar+EJ4uvn+DWGdQ@mail.gmail.com>
	<56D569F8.6070209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34969 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcCBXGL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 18:06:11 -0500
Received: by mail-qg0-f54.google.com with SMTP id y89so3819968qge.2
        for <linux-input@vger.kernel.org>; Wed, 02 Mar 2016 15:06:10 -0800 (PST)
In-Reply-To: <56D569F8.6070209@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: linux-input@vger.kernel.org

Would like to add that specs are located
https://gitlab.com/antruziliak/icn8528.git
The main question - how to wake up chip.
Looks that 2 gpios are used INT/WAKE + RST.
Regards,
               Serge Kolotylo.

On Tue, Mar 1, 2016 at 10:07 AM, Gregor Riepl <onitake@gmail.com> wrote:
>> 2) Could be icn8318 by Hans de Goede be adopted for icn85xx?
>
> chipone_icn8318.c lacks ACPI support. It may not be difficult to add though.
>
> The question is if both chips are sufficiently compatible.
>
>> how it is possible to use atmel_mxt_ts module for chipone? or what is the trick?
>
> That sounds very odd. Perhaps they share the same control interface?
> Or perhaps Chipone just cloned the Atmel chips...
>
> I'm pretty certain that a specific firmware is required for your chip, though.
>
