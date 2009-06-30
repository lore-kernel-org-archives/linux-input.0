From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] gpio_mouse: use standard driver registration method
Date: Mon, 29 Jun 2009 19:31:56 -0700
Message-ID: <20090630023156.GB10652@dtor-d630.eng.vmware.com>
References: <1245832299-23608-1-git-send-email-saeed@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:55006 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709AbZF3Cb5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2009 22:31:57 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1390435rvb.1
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2009 19:32:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1245832299-23608-1-git-send-email-saeed@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: linux-input@vger.kernel.org, saeed.bishara@gmail.com

Hi Saeed,

On Wed, Jun 24, 2009 at 11:31:39AM +0300, Saeed Bishara wrote:
> This patch is needed when the gpio's became available only at late
> stages, for example, when using i2c gpio expander.
> 

When changing from platform_driver_probe() to platform_driver_register()
you also need to convert markings on the driver's probe() method from
__init to __devinit.

Applied.

-- 
Dmitry
