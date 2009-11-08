From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] UCB1400: Allow passing IRQ through platfrom_data
Date: Sun, 8 Nov 2009 20:22:35 +0100
Message-ID: <200911082022.36082.marek.vasut@gmail.com>
References: <200911080310.04121.marek.vasut@gmail.com> <20091108054005.GA6542@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:40732 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961AbZKHTYH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Nov 2009 14:24:07 -0500
Received: by bwz27 with SMTP id 27so2790269bwz.21
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2009 11:24:11 -0800 (PST)
In-Reply-To: <20091108054005.GA6542@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dne Ne 8. listopadu 2009 06:40:05 Dmitry Torokhov napsal(a):
> Hi Marek,
> 
> On Sun, Nov 08, 2009 at 03:10:03AM +0100, Marek Vasut wrote:
> > From b8d3ab594008dd2714d4dedf12348d05c08a48fd Mon Sep 17 00:00:00 2001
> > From: Marek Vasut <marek.vasut@gmail.com>
> > Date: Sun, 8 Nov 2009 02:51:55 +0100
> > Subject: [PATCH] UCB1400: Allow passing IRQ through platfrom_data
> >
> > This patch allows UCB1400 to get IRQ GPIO from platform data. In case
> > platform_data are not supplied or the IRQ set in the platform_data is
> > lower than zero, fall back to the old IRQ detection algorithm.
> 
> Makes sense, will apply.
> 

Thanks :)

Cheers!
