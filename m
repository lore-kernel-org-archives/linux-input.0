From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/3] Input: gpio_keys.c: Simplify platform_device ->
 device casting
Date: Sat, 18 Jun 2011 03:19:25 -0700
Message-ID: <20110618101925.GC2401@core.coreip.homeip.net>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
 <1308042491-20203-2-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55632 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766Ab1FRKTj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Jun 2011 06:19:39 -0400
Received: by pvg12 with SMTP id 12so2428760pvg.19
        for <linux-input@vger.kernel.org>; Sat, 18 Jun 2011 03:19:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308042491-20203-2-git-send-email-david@protonic.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Jander <david@protonic.nl>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org

On Tue, Jun 14, 2011 at 11:08:09AM +0200, David Jander wrote:
> This patch factors out the use of struct platform_device *pdev in most
> places.
> 

Why? We are dealing with a platform device so why would we switch to
generic device?

I also think that we should not be mixing dev_get/set_drvdata() and
<bus>_get/set_drvdata() calls but rather use appropriate bus-specific
version to access data on given layer.

Thanks.

-- 
Dmitry
