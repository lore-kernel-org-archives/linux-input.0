From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] evdev: Replace rcu_assign_pointer() with
 RCU_INIT_POINTER()
Date: Mon, 18 Aug 2014 11:41:25 -0700
Message-ID: <20140818184125.GA31121@core.coreip.homeip.net>
References: <20140818144445.GA13933@ada>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:39351 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbaHRSlf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Aug 2014 14:41:35 -0400
Content-Disposition: inline
In-Reply-To: <20140818144445.GA13933@ada>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andreea-Cristina Bernat <bernat.ada@gmail.com>
Cc: rydberg@euromail.se, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com

Hi Andreea,

On Mon, Aug 18, 2014 at 05:44:45PM +0300, Andreea-Cristina Bernat wrote:
> The use of "rcu_assign_pointer()" is NULLing out the pointer.
> According to RCU_INIT_POINTER()'s block comment:
> "1.   This use of RCU_INIT_POINTER() is NULLing out the pointer"
> it is better to use it instead of rcu_assign_pointer() because it has a
> smaller overhead.
> 
> The following Coccinelle semantic patch was used:
> @@
> @@
> 
> - rcu_assign_pointer
> + RCU_INIT_POINTER
>   (..., NULL)

The same objection as here: https://lkml.org/lkml/2014/3/23/96

Thanks.

-- 
Dmitry
