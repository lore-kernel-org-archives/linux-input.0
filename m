From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 26/49] input: cm109: prepare for enabling irq in
 complete()
Date: Sat, 17 Aug 2013 20:37:45 -0700
Message-ID: <20130818033745.GC11553@core.coreip.homeip.net>
References: <1376756714-25479-1-git-send-email-ming.lei@canonical.com>
 <1376756714-25479-27-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35587 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab3HRDhs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Aug 2013 23:37:48 -0400
Content-Disposition: inline
In-Reply-To: <1376756714-25479-27-git-send-email-ming.lei@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Oliver Neukum <oliver@neukum.org>, Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org

Hi Ming,

On Sun, Aug 18, 2013 at 12:24:51AM +0800, Ming Lei wrote:
> Complete() will be run with interrupt enabled, so change to
> spin_lock_irqsave().

I think cm109 needs some love in it's URB handling, but this patch does
not change anything, so:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Or do you want me to pick it up for my tree?

Thanks.

-- 
Dmitry
