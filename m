From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Thu, 2 Dec 2010 13:22:24 -0800
Message-ID: <20101202212223.GA9864@core.coreip.homeip.net>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52809 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757468Ab0LBVWf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Dec 2010 16:22:35 -0500
Received: by iwn42 with SMTP id 42so1396130iwn.19
        for <linux-input@vger.kernel.org>; Thu, 02 Dec 2010 13:22:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-input@vger.kernel.org

On Thu, Dec 02, 2010 at 11:26:53AM -0600, Bill Gatliff wrote:
> Guys:
> 
> 
> Is there any  way for an input device driver (e.g. something that
> calls input_report_abs() and input_sync()) to know when there is a
> reader of its associated /dev/input/eventX?
> 
> I would love to know when something calls evdev_read() and/or
> evdev_poll(), so that I could then initiate a sampling operation on
> the hardware itself.  Otherwise, I'm forced to periodically poll the
> hardware and that means I'm either gathering data that no application
> wants,

We do not have such fine granularity as per-read. Input drivers get
notified when first application opens one of the interfaces (by
implementing input->open()). We expect that applications that open
input interfaces will read the data from them.

-- 
Dmitry
