From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: Input: gamecon - use parallel port device model
Date: Fri, 2 Oct 2015 11:09:20 +0530
Message-ID: <20151002053920.GD3544@sudip-pc>
References: <20151001220532.GA493@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34295 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbbJBFj0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2015 01:39:26 -0400
Received: by padhy16 with SMTP id hy16so97118847pad.1
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2015 22:39:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151001220532.GA493@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org

On Fri, Oct 02, 2015 at 01:05:32AM +0300, Dan Carpenter wrote:
> Hello Sudip Mukherjee,
> 
> The patch a517e87c3dfc: "Input: gamecon - use parallel port device
> model" from Sep 29, 2015, leads to the following static checker
> warning:
> 
> 	drivers/input/joystick/gamecon.c:988 gc_attach()
> 	error: buffer overflow 'gc_base' 3 <= 5
> 
> drivers/input/joystick/gamecon.c
>    972  
>    973          for (i = 0; i < n_pads && i < GC_MAX_DEVICES; i++) {
>                                               ^^^^^^^^^^^^^^
Thanks Dan. This would have been an ugly mess. I checked my othher
patches and looks like they will also have the same mistake. I will send
the patch to fix this rightaway.

Thanks again.

regards
sudip
