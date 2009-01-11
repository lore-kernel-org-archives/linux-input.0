From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 12/17] input: uvc: the button on the camera is
	KEY_CAMERA
Date: Sat, 10 Jan 2009 23:49:00 -0800
Message-ID: <20090110234816.ZZRA012@mailhub.coreip.homeip.net>
References: <200901092019.n09KJoV2017259@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:32946 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbZAKHtj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Jan 2009 02:49:39 -0500
Received: by an-out-0708.google.com with SMTP id d40so3323517and.1
        for <linux-input@vger.kernel.org>; Sat, 10 Jan 2009 23:49:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200901092019.n09KJoV2017259@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, hadess@hadess.net

On Fri, Jan 09, 2009 at 12:19:50PM -0800, akpm@linux-foundation.org wrote:
> From: Bastien Nocera <hadess@hadess.net>
> 
> Not BTN_0.  Also call input_sync() on the device once the button has been
> pressed.
> 

Applied, thank you Bastien.

-- 
Dmitry
