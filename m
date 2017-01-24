From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 6/9] power_supply: wm97xx_battery: use power_supply_get_drvdata
Date: Tue, 24 Jan 2017 15:39:27 -0800
Message-ID: <m27f5k1100.fsf@baylibre.com>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
        <1477510907-23495-7-git-send-email-robert.jarzmik@free.fr>
        <CAOi56cVk17w6C6msnT88c0Zh1OgLM=FbZAw32MzLRatjFraYhg@mail.gmail.com>
        <87h94odic0.fsf@belgarion.home> <20170124204011.GH27969@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33879 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdAXXkD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Jan 2017 18:40:03 -0500
Received: by mail-pg0-f44.google.com with SMTP id 14so58695106pgg.1
        for <linux-input@vger.kernel.org>; Tue, 24 Jan 2017 15:39:29 -0800 (PST)
In-Reply-To: <20170124204011.GH27969@dtor-ws> (Dmitry Torokhov's message of
        "Tue, 24 Jan 2017 12:40:11 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-pm <linux-pm@vger.kernel.org>, alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Stefan Agner <stefan@agner.ch>

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Tue, Jan 24, 2017 at 08:31:59AM +0100, Robert Jarzmik wrote:
>> Kevin Hilman <khilman@kernel.org> writes:
>> 
>> > Hello,
>> >
>> > On Wed, Oct 26, 2016 at 12:41 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> >> As the power supply framework provides a way to store and retrieve
>> >> private supply data, use it.
>> >>
>> >> In the process, change the platform data for wm97xx_battery from a
>> >> container of a single struct wm97xx_batt_pdata to the direct point to wm97xx_batt_pdata.
>> >>
>> >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> >
>> > kernelci.org has been reporting that the tegra20-iris board has been
>> > failing in -next since next-20161123[1], and also in mainline
>> > v4.10-rc.  I finally took the time to bisect, and it pointed to this
>> > patch.  I verified that reverting $SUBJECT patch[2] on top of
>> > v4.10-rc5 fixes the problem.
>> >
>> > Kevin
>> >
>> > [1] https://kernelci.org/boot/id/5879a3fe59b5141534f6c3ac/
>> > [2] in mainline as commit: 6480af4915d6 power_supply: wm97xx_battery:
>> > use power_supply_get_drvdata
>> 
>> Hi Kevin,
>> 
>> There is a fix posted in here :
>> https://patchwork.kernel.org/patch/9499231/
>> 
>> I don't know if it's related, as I have no Oops signature nor any data to be
>> able to help further.

FWIW, that kernelci.org link above has full boot log available:
https://storage.kernelci.org/next/next-20170113/arm-tegra_defconfig/lab-baylibre-seattle/boot-tegra20-iris-512.html

> I picked up the patch from patchwork and will send it on to Linus in the
> next day or so.

I tested this on top of linus/master and the boot failure goes away.

Feel free to add,

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
