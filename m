From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] touchscreen: check kzalloc memory for data first
Date: Wed, 11 May 2011 14:12:38 -0700
Message-ID: <20110511211238.GA11178@core.coreip.homeip.net>
References: <BANLkTi=yWrPiz9Wp0H46at4NVfMSJ8n1uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49042 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755625Ab1EKVMq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 May 2011 17:12:46 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=yWrPiz9Wp0H46at4NVfMSJ8n1uw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steven Liu <lingjiujianke@gmail.com>
Cc: jy0922.shim@samsung.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, liuqi@thunderst.com

Hi Steven,

On Wed, May 11, 2011 at 10:23:16AM +0800, Steven Liu wrote:
> Hi Joonyoung Shim ,
> 
>             Can this patch be fixed in?
> 
> 
> if kzalloc memroy for data was faild, it will multi free data
> memory space. so check the data memory first, is it kzalloc faild
> for data, it should goto end and do nothing.

There is no double-free as both kfree() and input_free_device() know to
ignore NULL pointers and we ensure that both pointers to be initialized
(either point to allocated memory or be NULL). We do not expect either
of the memory allocations to fail so instead of handling failures
separately they are handled both at once.

Thanks.

-- 
Dmitry
