From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] appletouch: Improved finger detection
Date: Thu, 7 May 2009 19:59:40 -0700
Message-ID: <20090508025839.GC30616@dtor-d630.eng.vmware.com>
References: <3AC3E247-D85C-4D8A-A73B-34677C32C2D5@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:50802 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759767AbZEHC7s (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2009 22:59:48 -0400
Received: by rv-out-0506.google.com with SMTP id f9so910671rvb.1
        for <linux-input@vger.kernel.org>; Thu, 07 May 2009 19:59:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3AC3E247-D85C-4D8A-A73B-34677C32C2D5@freedesktop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Huddleston <jeremyhu@freedesktop.org>
Cc: linux-input@vger.kernel.org

HI Jeremy,

On Tue, May 05, 2009 at 12:10:34PM -0700, Jeremy Huddleston wrote:
> The appletouch driver is prone to reporting multiple fingers when only  
> one is
> pressing.  The appletouch driver queries an array of pressure sensors  
> and
> counts local maxima in pressure to determine the number of fingers.  It 
> just
> does this on the raw values, so a data stream like:
>
> 0 100 250 300 299 300 250 100 0
>
> actually registers as 2 fingers.
>
> This patch updates the logic to ignore small dips in pressure that are  
> less
> than the threshold.
>

Does it still detect 2 fingers as 2 fingers when they are held together?

-- 
Dmitry
