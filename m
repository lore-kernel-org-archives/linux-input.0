From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] input: pcf8574_keypad: use after
 input_unregister_device()
Date: Thu, 11 Nov 2010 01:04:23 -0800
Message-ID: <20101111090423.GH24415@core.coreip.homeip.net>
References: <20101111062429.GA3610@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51897 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab0KKJEb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Nov 2010 04:04:31 -0500
Content-Disposition: inline
In-Reply-To: <20101111062429.GA3610@bicker>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Mike Frysinger <vapier@gentoo.org>, Richard Purdie <rpurdie@linux.intel.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thu, Nov 11, 2010 at 10:28:30AM +0300, Dan Carpenter wrote:
> input_unregister_device() is tricky because it frees the argument.  So
> in the original code the call to input_set_drvdata(idev, NULL) is a use
> after free bug.  The other problem is the input_set_drvdata() makes the 
> input_free_device() into a no-op.
> 
> The prefered style in input/ is to make input_register_device() the
> last function in the probe which can fail.  That way we don't need to
> call input_unregister_device().
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Applied, thanks Dan.

-- 
Dmitry
