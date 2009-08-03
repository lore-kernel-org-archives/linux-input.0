From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Enable ADC Filter on UCB1400
Date: Mon, 3 Aug 2009 12:15:41 -0700
Message-ID: <20090803191600.EA5CC526EA5@mailhub.coreip.homeip.net>
References: <200907301922.24818.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:46260 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442AbZHCTQH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2009 15:16:07 -0400
Received: by ewy10 with SMTP id 10so3286031ewy.37
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2009 12:16:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200907301922.24818.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-input@vger.kernel.org, sameo@linux.intel.com

On Thu, Jul 30, 2009 at 07:22:24PM +0200, Marek Vasut wrote:
> Hi!
> 
> please consider applying the following patch. I tested it on Palm Tungsten|C 
> (ADCSYNC connected, both disabled and enabled through module parameter) and a 
> friend of mine tested it on Toradex Colibri (ADCSYNC not connected, disabled).
> 
> Thanks
> 
> From 65cb92df1aba511fbc44d62fa25d5cf38a687952 Mon Sep 17 00:00:00 2001
> From: Marek Vasut <marek.vasut@gmail.com>
> Date: Thu, 30 Jul 2009 19:03:10 +0200
> Subject: [PATCH] Enable ADC Filter on UCB1400
> 
> This patch enables ADC filtering on UCB1400 codec by default. The
> benefit from this change is mostly on some Colibri boards where the
> ADCSYNC pin of the UCB1400 codec isn't connected causing the touchscreen
> to jitter very badly. This change has no visible effect on boards where
> the ADCSYNC pin is connected.
> 

I wonder if it would not be safer to only enable filtering if platform
requests it (via platform data)?

-- 
Dmitry
