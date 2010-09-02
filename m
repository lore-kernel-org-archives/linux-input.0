From: "Xing Wei" <weixing@hanwang.com.cn>
Subject: Re: [PATCH v3] input: Add support for Hanwang tablet
Date: Thu, 2 Sep 2010 12:29:50 +0800
Message-ID: <201009021229501252232@hanwang.com.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hanwang.com.cn ([221.122.51.51]:33801 "EHLO mail.hanwang.com.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842Ab0IBE3u (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Sep 2010 00:29:50 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "dmitry.torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, jkosina <jkosina@suse.cz>

On Wed, Sep 01, 2010 mitry Torokhov wrote:
> Hi Xing,
> 
> On Wed, Sep 01, 2010 at 02:55:44PM +0800, Xing Wei wrote:
> > Hi Dmitry, it works well and I really appreciate your work. 
> > BTN_3 - BTN_8 & ABS_DISTANCE events are not handled & used in our X system driver by now,
> > sorry for my mistake.
> >
> 
> Just to avoid confusion - are BTN_3 - BTN_8 not used by your X driver or
> the hardware does not really report them? Because if it the former then
> we should continue reporting them - some other user (as in
> program/driver) might be interested in these.
> 
> Also, why do you develop your own X driver? Does not X's evdev driver
> work properly for you?
> 
> Thanks.
>  
> 

Hi Dmitry, the hardware does really report BTN_3 - BTN_8.
And I try to let the evdev driver(remove my X driver & .conf file ) take over the device,
but seem like it has no reflection to the pressure and roll wheel pad,just run like a generic mouse.

Our products are just used under Windows and Mac before,
really new to kernel-input and X system,correct me if something wrong.

Thanks.

