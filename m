From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Add support for eGalax TouchKit USB touchscreen
	used on HP tx1305us
Date: Mon, 30 Jun 2008 11:23:35 -0400
Message-ID: <20080630112020.ZZRA012@mailhub.coreip.homeip.net>
References: <200806281719.16837.daniel.ritz-ml@swissonline.ch> <200806281757.48201.daniel.ritz-ml@swissonline.ch> <48668070.3040902@lisphacker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:56465 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbYF3PXj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2008 11:23:39 -0400
Received: by an-out-0708.google.com with SMTP id d40so307538and.103
        for <linux-input@vger.kernel.org>; Mon, 30 Jun 2008 08:23:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48668070.3040902@lisphacker.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alastair Bridgewater <nyef_sbcl@lisphacker.com>
Cc: Daniel Ritz <daniel.ritz-ml@swissonline.ch>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Alastair,

On Sat, Jun 28, 2008 at 02:18:24PM -0400, Alastair Bridgewater wrote:
>       bInterfaceClass         3 Human Interface Devices
>       bInterfaceSubClass      1 Boot Interface Subclass
>       bInterfaceProtocol      2 Mouse

I think we can try to make usbtouchscreen ignore eGalaxes with
interface class set to HID?

-- 
Dmitry
