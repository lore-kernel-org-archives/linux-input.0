From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: qt602240 - Add ATMEL QT602240 touchscreen
 driver
Date: Mon, 28 Jun 2010 01:42:12 -0700
Message-ID: <20100628084212.GE25287@core.coreip.homeip.net>
References: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com>
 <4C24B86E.1030407@euromail.se>
 <4C283048.1090601@samsung.com>
 <4C285124.1050201@euromail.se>
 <4C285AB1.7030301@samsung.com>
 <4C285E85.6080008@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34187 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184Ab0F1ImS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 04:42:18 -0400
Received: by pwj8 with SMTP id 8so3292326pwj.19
        for <linux-input@vger.kernel.org>; Mon, 28 Jun 2010 01:42:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C285E85.6080008@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, kyungmin.park@samsung.com

On Mon, Jun 28, 2010 at 10:34:13AM +0200, Henrik Rydberg wrote:
> 
> It is a bit confusing I agree, but the document is correct. The empty
> input_mt_sync() is used when there is no data to report, no lifted fingers,
> nothing. Just imagine a device which gets polled periodically.

If there is no new data to report why we need to call input_mt_sync() at
all? You can send input_sync() but input core will filter it out...

-- 
Dmitry
