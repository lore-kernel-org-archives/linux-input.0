From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH] Input: evdev - drop redundant list-locking
Date: Sun, 20 Jul 2014 11:54:06 -0700
Message-ID: <20140720185406.GA4446@core.coreip.homeip.net>
References: <1405882092-7005-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:53645 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbaGTSyI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2014 14:54:08 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so6424616pdi.34
        for <linux-input@vger.kernel.org>; Sun, 20 Jul 2014 11:54:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405882092-7005-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

On Sun, Jul 20, 2014 at 08:48:12PM +0200, David Herrmann wrote:
> evdev->client_list is rcu-protected. There is no need to have a
> separate spinlock just for the list. Either one is good enough, so lets
> drop the spinlock.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
> Hi
> 
> I stumbled across this one when doing some evdev reviews. Maybe I'm missing
> something obvious and I should stop coding on Sundays. But the RCU-protection
> should be enough here, right?

RCU protection is for traversing list only, writes (as is adding and removing
elements from client_list) still have to be mutually exclusive.

Thanks.

-- 
Dmitry
