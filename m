From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] Input: do not emit unneeded EV_SYN when suspending
Date: Thu, 6 Aug 2015 21:10:15 -0700
Message-ID: <CANLzEkuxOa5od8WURAm9Zn8jQ7Xc5rAhOHKz-cW1YMO797xyoA@mail.gmail.com>
References: <20150807022624.GA11834@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34342 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbHGEKQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2015 00:10:16 -0400
Received: by igk11 with SMTP id 11so24605228igk.1
        for <linux-input@vger.kernel.org>; Thu, 06 Aug 2015 21:10:15 -0700 (PDT)
In-Reply-To: <20150807022624.GA11834@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Aug 6, 2015 at 7:26 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Do not emit EV_SYN/SYN_REPORT on suspend if there were no keys that are
> still pressed as we are suspending the device.

It looks like input_dev_release_keys is used in several other places
other than input_dev_suspend (reset, disconnect, freeze), so maybe
change the commit message to reflect that?

Otherwise, LGTM.


-- 
Benson Leung
Software Engineer, Chrom* OS
bleung@chromium.org
