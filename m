From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: Input: gamecon - use parallel port device model
Date: Fri, 2 Oct 2015 01:05:32 +0300
Message-ID: <20151001220532.GA493@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:26327 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbbJAWFj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Oct 2015 18:05:39 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sudipm.mukherjee@gmail.com
Cc: linux-input@vger.kernel.org

Hello Sudip Mukherjee,

The patch a517e87c3dfc: "Input: gamecon - use parallel port device
model" from Sep 29, 2015, leads to the following static checker
warning:

	drivers/input/joystick/gamecon.c:988 gc_attach()
	error: buffer overflow 'gc_base' 3 <= 5

drivers/input/joystick/gamecon.c
   972  
   973          for (i = 0; i < n_pads && i < GC_MAX_DEVICES; i++) {
                                              ^^^^^^^^^^^^^^
Should this be GC_MAX_PORTS?

   974                  if (!pads[i])
   975                          continue;
   976  
   977                  if (gc_setup_pad(gc, i, pads[i]))
   978                          goto err_unreg_devs;
   979  
   980                  count++;
   981          }
   982  
   983          if (count == 0) {
   984                  pr_err("No valid devices specified\n");
   985                  goto err_free_gc;
   986          }
   987  
   988          gc_base[i] = gc;
                ^^^^^^^^^^
It's saying this is out of bounds.

Even if we change GC_MAX_DEVICES to GC_MAX_PORTS it will still complain
because we are relying on n_pads to be less than GC_MAX_DEVICES.  I
guess we could change the other condition to be:

	if (count == 0 || i == GC_MAX_PORTS)
		goto err_free_gc;

   989          return;
   990  

regards,
dan carpenter
