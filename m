From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/26] Consolidate patches and add support for new devices
Date: Mon, 9 Nov 2015 13:49:11 +0100
Message-ID: <CACRpkdb2KNJ7qJ_UZYnW_0gb2ExJNOEdwvYakhbngztckWTBsg@mail.gmail.com>
References: <1446766466-30043-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:36346 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbbKIMtM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 07:49:12 -0500
Received: by obdgf3 with SMTP id gf3so138479166obd.3
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 04:49:11 -0800 (PST)
In-Reply-To: <1446766466-30043-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:34 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> NOTE: This patch set applies to synaptics-rmi4 branch in
> Dmitry Torokhov's input tree.
(...)
> This patchset applies cleanly to the synaptics-rmi4 branch, but does not
> successfully build because the synaptics-rmi4 branch is based on the 3.14
(...)
> I would suggest updating the synaptics-rmi4 branch to something
> more resent.

I suggest we stop seeing Dmitry's branch as "master" for RMI4 development.
Instead work on the v4.3-rc6-based branch you have at
https://github.com/aduggan/linux.git, and then (after the merge window)
rebase it to v4.4-rc1 and ask Dmitry to *drop* this old branch and pull in
your stuff instead, and then look at the end result of that.

Who knows, maybe he thinks it's clean enough to go into v4.5.
Or for parts of it to go into v4.5.

In any case, surely he's more helped by an up-to-date rebased branch
than having to rebase it himself too.

> This patch set consolidates some outstanding patches and then builds on
> that to add support for new devices.

Unless Dmitry is extremely interested in the development history,
I suggest to squash the whole thing down to a few patches that
begins by adding the bus and infrastructure and then one function per
patch.

> I also have some additional patches which convert hid-rmi
> into a transport driver for rmi_core. I held off submitting since 3.14
> doesn't contain hid-rmi.

Another reason for us to reboot development based on *your*
branch.

I'll go over and review the patches though!

Yours,
Linus Walleij
