From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: qt602240 - Add ATMEL QT602240 touchscreen
 driver
Date: Mon, 28 Jun 2010 02:01:35 -0700
Message-ID: <20100628090135.GA13523@core.coreip.homeip.net>
References: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com>
 <4C24B86E.1030407@euromail.se>
 <4C283048.1090601@samsung.com>
 <4C285124.1050201@euromail.se>
 <4C285AB1.7030301@samsung.com>
 <4C285E85.6080008@euromail.se>
 <20100628084212.GE25287@core.coreip.homeip.net>
 <4C286183.6080304@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48081 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046Ab0F1JBo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 05:01:44 -0400
Received: by pvg2 with SMTP id 2so1802787pvg.19
        for <linux-input@vger.kernel.org>; Mon, 28 Jun 2010 02:01:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C286183.6080304@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, kyungmin.park@samsung.com

On Mon, Jun 28, 2010 at 10:46:59AM +0200, Henrik Rydberg wrote:
> Dmitry Torokhov wrote:
> > On Mon, Jun 28, 2010 at 10:34:13AM +0200, Henrik Rydberg wrote:
> >> It is a bit confusing I agree, but the document is correct. The empty
> >> input_mt_sync() is used when there is no data to report, no lifted fingers,
> >> nothing. Just imagine a device which gets polled periodically.
> > 
> > If there is no new data to report why we need to call input_mt_sync() at
> > all? You can send input_sync() but input core will filter it out...
> > 
> 
> Yep, that is the reason. Admittedly, this is a corner cases that type A does not
> handle very gracefully, but it works. The only device so far where this seems
> useful is for the magic mouse, which does not want to report BTN_TOUCH at all.
> 

So what if we filter everything out? Userspace will never know that we
got an interrupt and will be just fine...

-- 
Dmitry
