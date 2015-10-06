From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: Input: joydev - validate axis/button maps before clobbering
 current ones
Date: Tue, 6 Oct 2015 21:51:55 +0300
Message-ID: <20151006185155.GA8997@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:29051 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbbJFSwH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Oct 2015 14:52:07 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: steve@sk2.org
Cc: linux-input@vger.kernel.org

Hello Stephen Kitt,

The patch 999b874f4aa3: "Input: joydev - validate axis/button maps
before clobbering current ones" from Aug 25, 2009, leads to the
following static checker warning:

	drivers/input/joydev.c:466 joydev_handle_JSIOCSAXMAP()
	error: 'abspam' dereferencing possible ERR_PTR()

drivers/input/joydev.c
   437  static int joydev_handle_JSIOCSAXMAP(struct joydev *joydev,
   438                                       void __user *argp, size_t len)
   439  {
   440          __u8 *abspam;
   441          int i;
   442          int retval = 0;
   443  
   444          len = min(len, sizeof(joydev->abspam));
   445  
   446          /* Validate the map. */
   447          abspam = memdup_user(argp, len);
   448          if (IS_ERR(abspam)) {
   449                  retval = PTR_ERR(abspam);
   450                  goto out;

out labels are error prone.  It's safer to return directly.

https://plus.google.com/106378716002406849458/posts/dnanfhQ4mHQ

joydev_handle_JSIOCSBTNMAP() has the same issue.

   451          }
   452  
   453          for (i = 0; i < joydev->nabs; i++) {
   454                  if (abspam[i] > ABS_MAX) {
   455                          retval = -EINVAL;
   456                          goto out;
   457                  }
   458          }
   459  
   460          memcpy(joydev->abspam, abspam, len);
   461  
   462          for (i = 0; i < joydev->nabs; i++)
   463                  joydev->absmap[joydev->abspam[i]] = i;
   464  
   465   out:
   466          kfree(abspam);
   467          return retval;
   468  }

regards,
dan carpenter
