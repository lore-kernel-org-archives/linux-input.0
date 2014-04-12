From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ads7846: Fix device usage within attribute show
Date: Sat, 12 Apr 2014 13:43:18 -0700
Message-ID: <20140412204318.GA28576@core.coreip.homeip.net>
References: <1397246613-26538-1-git-send-email-alexanders83@web.de>
 <5348644C.7070109@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:38690 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798AbaDLUnW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Apr 2014 16:43:22 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so6769498pab.13
        for <linux-input@vger.kernel.org>; Sat, 12 Apr 2014 13:43:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5348644C.7070109@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Stein <alexanders83@web.de>, linux-input@vger.kernel.org

On Fri, Apr 11, 2014 at 02:53:16PM -0700, Guenter Roeck wrote:
> On 04/11/2014 01:03 PM, Alexander Stein wrote:
> >With commit e585c40ba (Input: ads7846 - convert to
> >hwmon_device_register_with_groups()) the device passed to the attribute's
> >show function isn't the spi device as before.
> >So fixup the passed device to ads7846_read12_ser.
> >
> >Signed-off-by: Alexander Stein <alexanders83@web.de>
> 
> And I thought I got that right. Oh well.
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Applied, thank you.

-- 
Dmitry
