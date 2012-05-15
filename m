From: viresh kumar <viresh.linux@gmail.com>
Subject: Re: [PATCH V3 2/2] Input: spear-keyboard: add device tree bindings
Date: Tue, 15 May 2012 12:24:11 +0530
Message-ID: <CAOh2x=k2bZy-FV9XUWUxDaB7hCi1mfYv9tFVTnGObiAVjfOpvQ@mail.gmail.com>
References: <cover.1333009670.git.viresh.kumar@st.com>
	<eebfde0a1511204cab203fa18efe6264abe00486.1333009670.git.viresh.kumar@st.com>
	<20120509052828.GD10514@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45785 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab2EOGyM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 May 2012 02:54:12 -0400
Received: by weyu7 with SMTP id u7so2268764wey.19
        for <linux-input@vger.kernel.org>; Mon, 14 May 2012 23:54:11 -0700 (PDT)
In-Reply-To: <20120509052828.GD10514@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Viresh Kumar <viresh.kumar@st.com>, swarren@nvidia.com, spear-devel@list.st.com, devicetree-discuss@lists.ozlabs.org, olof@lixom.net, linux-input@vger.kernel.org, sr@denx.de

Hi Dmitry,

On Wed, May 9, 2012 at 10:58 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Now that I got matrix_keypad_build_keymap() also handle DT case, how
> about the patch below?
>
> Input: spear-keyboard - add device tree bindings
>
> From: Viresh Kumar <viresh.kumar@st.com>
>
> This adds simple DT bindings for spear-keyboard controller.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =A0drivers/input/keyboard/spear-keyboard.c | =A0 71 +++++++++++++++++=
+++++++-------
> =A01 files changed, 56 insertions(+), 15 deletions(-)

You missed following file in this patch, which was there in original pa=
tch.

Documentation/devicetree/bindings/input/spear-keyboard.txt

--
viresh
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
