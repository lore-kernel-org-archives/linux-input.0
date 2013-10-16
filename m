From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Add an additional argument for decode routine,
 change secondary device name
Date: Tue, 15 Oct 2013 23:54:17 -0700
Message-ID: <20131016065417.GA15710@core.coreip.homeip.net>
References: <1379045010-3347-1-git-send-email-yunkang.tang@cn.alps.com>
 <1379045010-3347-2-git-send-email-yunkang.tang@cn.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:40910 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722Ab3JPGyU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Oct 2013 02:54:20 -0400
Received: by mail-pa0-f44.google.com with SMTP id lf10so623684pab.17
        for <linux-input@vger.kernel.org>; Tue, 15 Oct 2013 23:54:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1379045010-3347-2-git-send-email-yunkang.tang@cn.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yunkang Tang <tommywill2011@gmail.com>
Cc: yunkang.tang@cn.alps.com, linux-input@vger.kernel.org

Hi Yunkang,

On Fri, Sep 13, 2013 at 12:03:29PM +0800, Yunkang Tang wrote:
> From: Yunkang Tang <yunkang.tang@cn.alps.com>
> 
> - Add an addition argument for decode routine, new devices need this info.
> - Change the dev2's name from "PS/2 Mouse" to "ALPS PS/2 Device".
> 

I carved the name change device out of this patch and applied to my
3.13 queue.

Thanks.

-- 
Dmitry
