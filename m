From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add LED_0..LED_15 define
Date: Fri, 10 Feb 2017 16:54:49 -0800
Message-ID: <CAKdAkRSL1uqCTbyX8Wmh+DA=vs6nmOCU-F88Ceizh7acOf=SNw@mail.gmail.com>
References: <20170208004141.30540-1-me@paulo.costa.nom.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:36522 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbdBKAyv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Feb 2017 19:54:51 -0500
Received: by mail-vk0-f43.google.com with SMTP id t8so37006923vke.3
        for <linux-input@vger.kernel.org>; Fri, 10 Feb 2017 16:54:51 -0800 (PST)
In-Reply-To: <20170208004141.30540-1-me@paulo.costa.nom.br>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paulo Costa <me@paulo.costa.nom.br>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Paulo,

On Tue, Feb 7, 2017 at 4:41 PM, Paulo Costa <me@paulo.costa.nom.br> wrote:
> Some input devices have many controllable leds that don't fit any standard function (e.g., the Wiimote has 4 controllable LEDs)
>
> Just as we have BTN_0..BTN_9 for generic buttons, LED_0...LED_15 can now be used to control generic leds.

Generic LEDs should use LED subsystem; we are not going to be adding
more LED definitions to input.

Thanks.

-- 
Dmitry
