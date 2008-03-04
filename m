From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: WM97xx touchscreen drivers
Date: Tue, 4 Mar 2008 18:27:33 +0300
Message-ID: <bc64b4640803040727q39b8aa76j45f3355ec7f6363c@mail.gmail.com>
References: <20080229165029.GB11451@rakim.wolfsonmicro.main>
	 <20080304140251.GA24649@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:8816 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761134AbYCDP1p (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Mar 2008 10:27:45 -0500
Received: by wr-out-0506.google.com with SMTP id 50so1260725wra.13
        for <linux-input@vger.kernel.org>; Tue, 04 Mar 2008 07:27:44 -0800 (PST)
In-Reply-To: <20080304140251.GA24649@rakim.wolfsonmicro.main>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hans-Christian Egtvedt <hcegtvedt@atmel.com>

Hi,

2008/3/4, Mark Brown <broonie@opensource.wolfsonmicro.com>:
> This patch series adds support for the touchscreen controllers found in
>  WM97xx devices.  This revision of the series adds support for
>  configuration of the interrupt source used for pen down detection in
>  accelerated touch drivers.
>
>  These changes are also available in the git repository at:
>
>
>   git://opensource.wolfsonmicro.com/linux-2.6-touch upstream
>
>  Mark Brown (6):
>       Core driver for WM97xx touchscreens
>       Add chip driver for WM9705 touchscreen
>       Add chip driver for WM9712 touchscreen
>       Add chip driver for WM9713 touchscreen
>       Driver for WM97xx touchscreens in streaming mode on Mainstone
>       Build system and MAINTAINERS entry for WM97xx touchscreen drivers

The 6th patch seems to be lost somehow. And I don't see it in the
recent -mm tree.

-- 
With best wishes
Dmitry
