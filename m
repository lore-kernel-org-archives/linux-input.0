From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Rename keypad and ts platform driver for w90p910
Date: Mon, 17 Aug 2009 01:17:40 -0700
Message-ID: <20090817084848.6720F526EA5@mailhub.coreip.homeip.net>
References: <4A88D499.30302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:6339 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757330AbZHQIRo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Aug 2009 04:17:44 -0400
Received: by rv-out-0506.google.com with SMTP id f6so745224rvb.1
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2009 01:17:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A88D499.30302@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input@vger.kernel.org

On Mon, Aug 17, 2009 at 11:55:05AM +0800, Wan ZongShun wrote:
> Dear Dmitry,
> 
> Due to I modified the corresponding platform device name, 
> so I make the patch to rename keypad and ts platform driver
> for w90p910 platform.
> 

Do we really need to go through renaming the drivers just because the
company changed it's name?

-- 
Dmitry
