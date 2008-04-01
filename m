From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: WM97xx touchscreen drivers
Date: Tue, 1 Apr 2008 14:34:02 -0700
Message-ID: <20080401143402.6e433a3b.akpm@linux-foundation.org>
References: <20080401102825.GA30868@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37802 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753976AbYDAVgR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Apr 2008 17:36:17 -0400
In-Reply-To: <20080401102825.GA30868@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: dtor@mail.ru, jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, hcegtvedt@atmel.com, liam.girdwood@wolfsonmicro.com, gg@opensource.wolfsonmicro.com, dbaryshkov@gmail.com, giometti@enneenne.com, rmk@arm.linux.org.uk, mkl@pengutronix.de, linux01@architechnical.net, spyro@f2s.com, vince@kyllikki.org, zap@homelink.ru

On Tue, 1 Apr 2008 11:28:25 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> This patch series adds support for the touchscreen controllers found in
> WM97xx devices.  This revision of the series fixes some races when
> closing an active device and fixes a shadowed variable.
> 
> This patch series is also available in the git repository at:
> 
>   git://opensource.wolfsonmicro.com/linux-2.6-touch upstream

I added that git tree to the -mm lineup.
