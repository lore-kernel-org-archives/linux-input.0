From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 5/17] input: rmidev character driver for RMI4 sensors
Date: Wed, 5 Sep 2012 10:29:50 +0200
Message-ID: <CACRpkdaL50Kp4O1=utw+c9yCCN_F5J9jb9s54=FRx1UCHqO3WQ@mail.gmail.com>
References: <1345241877-16200-1-git-send-email-cheiny@synaptics.com>
	<1345241877-16200-6-git-send-email-cheiny@synaptics.com>
	<CACRpkdYGR=YtgyvDjfH4w8OMnn3iZKuRpQKrTVCE=i=gZ1hPuw@mail.gmail.com>
	<50469C2F.2060008@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35856 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab2IEI3w (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Sep 2012 04:29:52 -0400
Received: by wgbdr13 with SMTP id dr13so385506wgb.1
        for <linux-input@vger.kernel.org>; Wed, 05 Sep 2012 01:29:51 -0700 (PDT)
In-Reply-To: <50469C2F.2060008@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, William Manson <wmanson@synaptics.com>, Peichen Chang <peichen.chang@synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

On Wed, Sep 5, 2012 at 2:26 AM, Christopher Heiny <cheiny@synaptics.com> wrote:
> On 08/27/2012 11:49 AM, Linus Walleij wrote:
>>
>> You need to patch your desired major number into
>> Documentation/devices.txt'
>
> We were going by the recommendation in Linux Device Drivers (3rd edition) to
> use dynamic major number allocation via alloc_chrdev_region.  In particular
> in section 3.2.3 it says "new numbers are not being assigned".  I guess at
> this point we need to know whether the info in LDD3 is authoritative or not.

You're right, go for dynamic numbers. I was plain wrong.

>>> +static struct class *rmidev_device_class;
>>
>>
>> Last time discussed with Greg, class devices were deprecated,
>> and you should just use a bus instead. (But not sure.)
>
> The references I found online weren't clear on this, so more investigation
> is required.  We'll defer that till we find out if the regmap changes
> eliminate the need for this.

Just push Greg to review next version and he'll tell you what to
do about this, no problem.

Yours,
Linus Walleij
