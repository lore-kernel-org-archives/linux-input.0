Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E9BC433C1
	for <linux-input@archiver.kernel.org>; Fri, 26 Mar 2021 09:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E48161A4A
	for <linux-input@archiver.kernel.org>; Fri, 26 Mar 2021 09:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhCZJHu (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 26 Mar 2021 05:07:50 -0400
Received: from air.basealt.ru ([194.107.17.39]:50526 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229984AbhCZJHn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 Mar 2021 05:07:43 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Mar 2021 05:07:43 EDT
Received: by air.basealt.ru (Postfix, from userid 490)
        id 25655589441; Fri, 26 Mar 2021 09:00:34 +0000 (UTC)
Received: from [10.88.144.159] (obninsk.basealt.ru [217.15.195.17])
        by air.basealt.ru (Postfix) with ESMTPSA id 29292589433;
        Fri, 26 Mar 2021 09:00:32 +0000 (UTC)
To:     jingle.wu@emc.com.tw
Cc:     dmitry.torokhov@gmail.com, kernel@pengutronix.de,
        linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de
References: <016d01d70fdb$2aa48b00$7feda100$@emc.com.tw>
Subject: RE: elan_i2c: failed to read report data: -71
From:   Egor Ignatov <egori@basealt.ru>
Message-ID: <d725011e-5373-a132-71c4-bc7580b36999@basealt.ru>
Date:   Fri, 26 Mar 2021 12:00:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <016d01d70fdb$2aa48b00$7feda100$@emc.com.tw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi,

I have installed the latest 5.10 kernel on Lenovo L13 laptop and
both touchpad and trackpoint work fine. But after resuming from
hibernation mode trackpoint(and 3 buttons) stop working. The kernel
log says:
     elan_i2c 14-0015: failed to read report data: -71

I assume this is because some initial trackpoint setup is done on the
first boot. Then after hibernation the device resets. And the wake-up
code doesn't set it up properly.

Any help would be appreciated.

