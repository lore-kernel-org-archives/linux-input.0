From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: move check for same handler in input_pass_event
Date: Thu, 6 Jan 2011 22:04:56 -0800
Message-ID: <20110107060456.GA29038@core.coreip.homeip.net>
References: <1294352688-29564-1-git-send-email-kristen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53880 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518Ab1AGGFD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Jan 2011 01:05:03 -0500
Received: by gwj20 with SMTP id 20so7613400gwj.19
        for <linux-input@vger.kernel.org>; Thu, 06 Jan 2011 22:05:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294352688-29564-1-git-send-email-kristen@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Thu, Jan 06, 2011 at 02:24:48PM -0800, Kristen Carlson Accardi wrote:
> If the handler that injected an event is the same,
> just skip the filter, but allow the handler->event()
> routine to be called.  This allows evdev to be able to
> be used to loopback events.

Why is it needed? Could you please give some examples?

Thanks.

-- 
Dmitry
