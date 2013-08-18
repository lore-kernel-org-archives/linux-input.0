From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v1 26/49] input: cm109: prepare for enabling irq in complete()
Date: Sun, 18 Aug 2013 22:10:15 +0800
Message-ID: <CACVXFVMTAYZR43pk=sc=ZDMqgS_8iSzPo880CEATNj+0SEz0aQ@mail.gmail.com>
References: <1376756714-25479-1-git-send-email-ming.lei@canonical.com>
	<1376756714-25479-27-git-send-email-ming.lei@canonical.com>
	<20130818033745.GC11553@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:60624 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008Ab3HROKS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Aug 2013 10:10:18 -0400
In-Reply-To: <20130818033745.GC11553@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb <linux-usb@vger.kernel.org>, Oliver Neukum <oliver@neukum.org>, Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org

Hi Dmitry,

On Sun, Aug 18, 2013 at 11:37 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Ming,
>
> On Sun, Aug 18, 2013 at 12:24:51AM +0800, Ming Lei wrote:
>> Complete() will be run with interrupt enabled, so change to
>> spin_lock_irqsave().
>
> I think cm109 needs some love in it's URB handling, but this patch does
> not change anything, so:
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thank you.

>
> Or do you want me to pick it up for my tree?

IMO, it might be easier to merge these patches via one tree, so

Greg, would you like to manage all these patches via your tree?

If not, I have to push these patches on each subsystem, then you
need to pick it up for your input tree...


Thanks,
--
Ming Lei
