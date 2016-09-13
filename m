From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH 3/4] input: Deprecate real timestamps beyond year 2106
Date: Tue, 13 Sep 2016 09:34:25 -0700
Message-ID: <CABeXuvqovKW4hGc+4BNG6q4x30wr45AxptHXnKcon8pMT6CXuA@mail.gmail.com>
References: <1473775805-2242-4-git-send-email-deepa.kernel@gmail.com> <201609140054.YrcBNFHV%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36148 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753562AbcIMQe0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Sep 2016 12:34:26 -0400
In-Reply-To: <201609140054.YrcBNFHV%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>

> All errors (new ones prefixed by >>):
>
>    drivers/input/input-compat.c: In function 'input_event_from_user':
>>> drivers/input/input-compat.c:24:15: error: invalid application of 'sizeof' to incomplete type 'struct input_event_compat'
>            sizeof(struct input_event_compat)))
>                   ^~~~~~
>    drivers/input/input-compat.c: In function 'input_event_to_user':
>    drivers/input/input-compat.c:55:13: error: invalid application of 'sizeof' to incomplete type 'struct input_event_compat'
>          sizeof(struct input_event_compat)))
>                 ^~~~~~

These 2 lines need to use raw_input_event_compat.

I will send an update to only this patch to help the discussion.
I will wait for other comments before updating the series.

-Deepa
