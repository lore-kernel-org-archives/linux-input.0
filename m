From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH] input: remove at32psif
Date: Thu, 18 Jan 2018 20:48:24 +0100
Message-ID: <20180118194824.GA1276@Red>
References: <20180118185811.12856-1-clabbe.montjoie@gmail.com>
 <20180118192017.k3gqrbqcwp53cc7z@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34192 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754170AbeARTs2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 18 Jan 2018 14:48:28 -0500
Content-Disposition: inline
In-Reply-To: <20180118192017.k3gqrbqcwp53cc7z@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: egtvedt@samfundet.no, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 18, 2018 at 11:20:17AM -0800, Dmitry Torokhov wrote:
> On Thu, Jan 18, 2018 at 07:58:11PM +0100, Corentin Labbe wrote:
> > Since AVR32 arch is gone, at32psif driver is useless.
> > This patch remove it.
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> 
> Applied, thank you.
> 
> What about:
> 
> config TOUCHSCREEN_WM97XX_ATMEL
> 	tristate "WM97xx Atmel accelerated touch"
> 	depends on TOUCHSCREEN_WM97XX && AVR32 
> 
> ?
> 

It was my second target BUT the code content reference to AT91 (wm97xx continuous touch driver for Atmel AT91 and AVR32) so perhaps it could be keeped.

But someone need to test it.

Regards
