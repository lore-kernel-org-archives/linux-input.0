From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio-keys - fix possible NULL pointer
	dereference
Date: Wed, 30 Jul 2008 10:53:03 -0400
Message-ID: <20080730104856.ZZRA012@mailhub.coreip.homeip.net>
References: <1217424431-8732-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:5294 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbYG3OxH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jul 2008 10:53:07 -0400
Received: by an-out-0708.google.com with SMTP id d40so7603and.103
        for <linux-input@vger.kernel.org>; Wed, 30 Jul 2008 07:53:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1217424431-8732-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe Kleine-K??nig <Uwe.Kleine-Koenig@digi.com>
Cc: linux-input@vger.kernel.org, Dmitry Baryshkov <dbaryshkov@gmail.com>

Hi Uwe,

On Wed, Jul 30, 2008 at 03:27:10PM +0200, Uwe Kleine-K??nig wrote:
> bdata->button is used in gpio_check_button but never initialized.  Having a
> device with debounce_interval != 0 without this patch resulted on an oops on
> my machine.
> 

Applied both patches to 'for-linus' branch, thanks!

-- 
Dmitry
