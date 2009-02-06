From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] input: let's remove the now deprecated corgi_ts.c
Date: Fri, 6 Feb 2009 09:56:28 +0800
Message-ID: <f17812d70902051756t464eb58au187c2f03d9780142@mail.gmail.com>
References: <f17812d70902050226g1780ca58m4d271b55ba3d3166@mail.gmail.com>
	 <1233840784.5350.8.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:52334 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbZBFB43 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Feb 2009 20:56:29 -0500
Received: by rv-out-0506.google.com with SMTP id g9so107362rvb.5
        for <linux-input@vger.kernel.org>; Thu, 05 Feb 2009 17:56:28 -0800 (PST)
In-Reply-To: <1233840784.5350.8.camel@dax.rpnet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-input@vger.kernel.org

On Thu, Feb 5, 2009 at 9:33 PM, Richard Purdie <rpurdie@rpsys.net> wrote:
>
> On Thu, 2009-02-05 at 18:26 +0800, Eric Miao wrote:
>> Let's move to the generic SPI based ADS7846 touchscreen driver.
>>
>> Signed-off-by: Eric Miao <eric.miao@marvell.com>
>> ---
>>
>> Richard, any concern on this move?
>
> Does the SPI based ADS7846 touchscreen driver have the facility to sync
> the touchscreen readings with the video blanking period to reduce
> interference now? That was the main feature that needed porting over.
>

Yeah, I was once heard of this yet don't know the exact reason for
doing so. And I'm afraid this is missing from the SPI-based ADS7846
driver. Richard, do you have any more info on this, so that I can
have trials later on this?
