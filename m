From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: goodix: Check the 'buffer status' bit before
 reading data
Date: Wed, 6 May 2015 16:54:09 -0700
Message-ID: <20150506235409.GE5580@dtor-ws>
References: <1430484036-17541-1-git-send-email-paul@crapouillou.net>
 <1430489635.3945.3.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34127 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbEFXyO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 May 2015 19:54:14 -0400
Content-Disposition: inline
In-Reply-To: <1430489635.3945.3.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Paul Cercueil <paul@crapouillou.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 01, 2015 at 04:13:55PM +0200, Bastien Nocera wrote:
> On Fri, 2015-05-01 at 14:40 +0200, Paul Cercueil wrote:
> > The MSB of the first byte read via I2C at the coordinates address
> > indicates whether the data is valid or ready (called "buffer status" 
> > in
> > the datasheets) when an interrupt is raised. Previously, this bit was
> > ignored, which resulted in a lot of incorrect detections of "finger
> > removed" events.
> > 
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>

Applied, thank you.

-- 
Dmitry
