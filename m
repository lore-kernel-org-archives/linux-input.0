From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 6/9] power_supply: wm97xx_battery: use power_supply_get_drvdata
Date: Fri, 25 Nov 2016 20:54:21 +0100
Message-ID: <87a8cnqqs2.fsf@belgarion.home>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
        <1477510907-23495-7-git-send-email-robert.jarzmik@free.fr>
        <20161123231320.fo3kilw5h7cctngc@earth>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:44642 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755213AbcKYTye (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Nov 2016 14:54:34 -0500
In-Reply-To: <20161123231320.fo3kilw5h7cctngc@earth> (Sebastian Reichel's
        message of "Thu, 24 Nov 2016 00:13:20 +0100")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

Sebastian Reichel <sre@kernel.org> writes:

> Hi Robert,
>
> On Wed, Oct 26, 2016 at 09:41:44PM +0200, Robert Jarzmik wrote:
>> As the power supply framework provides a way to store and retrieve
>> private supply data, use it.
>> 
>> In the process, change the platform data for wm97xx_battery from a
>> container of a single struct wm97xx_batt_pdata to the direct point to wm97xx_batt_pdata.
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> ---
>>  drivers/input/touchscreen/wm97xx-core.c |  2 +-
>>  drivers/power/supply/wm97xx_battery.c   | 25 ++++++++++---------------
>>  2 files changed, 11 insertions(+), 16 deletions(-)
>
> I queued this into power-supply's for-next branch.
Thanks Sebastian.

Cheers.

-- 
Robert
