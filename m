From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH] Input: keyboard - add device tree bindings for simple key matrixes
Date: Mon, 2 Jan 2012 09:41:19 +0530
Message-ID: <CAJuYYwQSgM+zevsSZ71LTYnScLq+q=D7KO3uD5A1O_gOnDAQ=A@mail.gmail.com>
References: <1325112771-31941-1-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF17755DC8D2@HQMAIL01.nvidia.com>
	<CAOesGMiNuW3mexN_8PtunZkaVX4Uph-OgZFr5zLhaB1nih_EEw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF17755DC8DB@HQMAIL01.nvidia.com>
	<CAOesGMjZoP+FsGWo9cWKvgs8KD9tT6KBHbK5qKX8NTGOY3HUjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36751 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab2ABELU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Jan 2012 23:11:20 -0500
In-Reply-To: <CAOesGMjZoP+FsGWo9cWKvgs8KD9tT6KBHbK5qKX8NTGOY3HUjQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Stephen Warren <swarren@nvidia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <rob.herring@calxeda.com>, "Simon Glass (sjg@chromium.org)" <sjg@chromium.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Rakesh Iyer <riyer@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>

Hi Olof,

On 29 December 2011 12:36, Olof Johansson <olof@lixom.net> wrote:
[...]

>> Can we deprecate the Samsung format, and only allow it for that Samsung
>> device (and allow both there), and require a single format for any other
>> keyboard?
>
> I'm definitely ok with that. Thomas, Grant, Rob? The code in question
> is queued for 3.3, so it hasn't been out in a real release yet.
>
> Adding Kukjin as well since it's getting merged through his tree.

I am okay with switching to the new keyboard binding. I will modify
the Samsung keyboard device tree support and prepare a patch.

Thanks,
Thomas.
