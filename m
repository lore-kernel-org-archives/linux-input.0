From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Trackpoint not found when loading psmouse before rmi_smbus
Date: Thu, 1 Feb 2018 14:54:11 -0800
Message-ID: <CAKdAkRT4ktdJwFTQCDRA2GWir4hXuE34kfii6mvXauh1pK-X3g@mail.gmail.com>
References: <CAEk1YH68KecWAyeKTu_paL3CLtxLuw1hrH7Z4B_FqiWQML666Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:43486 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751967AbeBAWyN (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 1 Feb 2018 17:54:13 -0500
Received: by mail-vk0-f65.google.com with SMTP id x203so12328549vkx.10
        for <linux-input@vger.kernel.org>; Thu, 01 Feb 2018 14:54:12 -0800 (PST)
In-Reply-To: <CAEk1YH68KecWAyeKTu_paL3CLtxLuw1hrH7Z4B_FqiWQML666Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Damjan Georgievski <gdamjan@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Damjan,

On Tue, Jan 30, 2018 at 4:46 AM, Damjan Georgievski <gdamjan@gmail.com> wrote:
> This is tested on X1 Carbon (gen 5)
> pnp id: LEN0072
> kernel 4.15.0
>
> Since by default psmouse complains about
> "synaptics: Your touchpad (PNP: LEN0072 PNP0f13) says it can support a
> different bus....",
> I've patched the kernel to add the pnp id to smbus_pnp_ids in
> drivers/input/mouse/synaptics.c [1],
> and the trackpad seems to work at least a  bit smoother (it could be
> placebo though).
>
> But, with the default setup, and rmi_smbus and psmouse are both
> compiled as modules, the trackpoint device never appears in dmesg.
> I can make it appear if I put rmi_smbus in /etc/modules-load.d/ so it
> loads before psmouse, or if I unload psmouse and load it again.
>
> I can even reproduce it by unloading both rmi_smbus and psmouse, and
> then only loading psmouse
> (psmouse seems to load rmi_smbus and switch the trackpad to it but the
> trackpoint is lost)

Please try with these patches:

https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?h=next&id=a1ab69021a584d952e6548a44b93760547b1b6b5
https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?h=next&id=6abe534f0776d2437c8302f58d8eb5abd483e926
https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?h=next&id=9f87b9fc369f7719ccdac5077855c5c03b625571

Thanks.

-- 
Dmitry
