From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input: Add support for Hanwang tablet
Date: Wed, 1 Sep 2010 17:28:09 -0700
Message-ID: <20100902002809.GA9157@core.coreip.homeip.net>
References: <201009011455438909077@hanwang.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40286 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535Ab0IBA2Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Sep 2010 20:28:16 -0400
Content-Disposition: inline
In-Reply-To: <201009011455438909077@hanwang.com.cn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xing Wei <weixing@hanwang.com.cn>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, jkosina <jkosina@suse.cz>

Hi Xing,

On Wed, Sep 01, 2010 at 02:55:44PM +0800, Xing Wei wrote:
> Hi Dmitry, it works well and I really appreciate your work. 
> BTN_3 - BTN_8 & ABS_DISTANCE events are not handled & used in our X system driver by now,
> sorry for my mistake.
>

Just to avoid confusion - are BTN_3 - BTN_8 not used by your X driver or
the hardware does not really report them? Because if it the former then
we should continue reporting them - some other user (as in
program/driver) might be interested in these.

Also, why do you develop your own X driver? Does not X's evdev driver
work properly for you?

Thanks.
 
-- 
Dmitry
