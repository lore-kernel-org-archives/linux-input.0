From: Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] iio: adc: Move mxs-lradc out of staging
Date: Tue, 9 Feb 2016 09:52:05 -0800
Message-ID: <20160209175205.GD40460@dtor-ws>
References: <1454797403-21576-1-git-send-email-ksenija.stanojevic@gmail.com>
 <56B8DF81.3000901@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33211 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbcBIRwJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Feb 2016 12:52:09 -0500
Content-Disposition: inline
In-Reply-To: <56B8DF81.3000901@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Feb 08, 2016 at 06:33:37PM +0000, Jonathan Cameron wrote:
> On 06/02/16 22:23, Ksenija Stanojevic wrote:
> > Move mxs-lradc driver from drivers/staging/iio/adc to drivers/iio/adc.
> > 
> > Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> Given the input elements in here, cc'ing linux-input and Dmitry.

Input parts look reasonable to me, but please set INPUT_PROP_DIRECT to
indicate that it is a touchscreen on the device to help userspace
classify it. Can be a separate patch though.

Thanks.

-- 
Dmitry
