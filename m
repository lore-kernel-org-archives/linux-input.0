From: maitysanchayan@gmail.com
Subject: Re: touchscreen: edt-ft5x06: Prevent DMA driver from mapping an area
 on stack
Date: Mon, 14 Dec 2015 13:23:39 +0530
Message-ID: <20151214075339.GA28733@Sanchayan-Arch.toradex.int>
References: <e0311a5e79a315814e8678c9ef4a32563c01d1e0.1449913392.git.maitysanchayan@gmail.com>
 <20151212171355.GA7362@katana>
 <20151213044237.GA22780@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35545 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbbLNH6V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Dec 2015 02:58:21 -0500
Content-Disposition: inline
In-Reply-To: <20151213044237.GA22780@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, maxime.ripard@free-electrons.com, stefan@agner.ch

Hello,

On 15-12-12 20:42:37, Dmitry Torokhov wrote:
> On Sat, Dec 12, 2015 at 06:13:55PM +0100, Wolfram Sang wrote:
> > 
> > > Frankly speaking I do not know where the fix should actually be. I2C IMX
> > > driver somehow taking care of this or the users of I2C, touchscreen drivers
> > > in this case. In my opinion, the fix should be with the touchscreen driver
> > > however I did like to have feedback or hear opinions on what is the accepted
> > > solution to this.
> > 
> > There is no accepted solution to this yet :( DMA is/was still too rare for
> > a serious discussion about this. There is also [1] and probably more...
> > 
> > [1]  http://patchwork.ozlabs.org/patch/220137/
> 
> I believe vast majority of i2c client drivers do not expect that the
> transfer buffer they supply in i2c messages are supposed to be DMAable
> (unlike USB and SPI buses that had that requirement from the beginning).
> 
> I won't be applying this patch unless we decide that I2C changes the
> rules.

Understood. Thanks for the clarifications Dmitry and Wolfram.

- Sanchayan.
