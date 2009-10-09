From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH] Input: support the specified input device number
Date: Fri, 9 Oct 2009 09:29:51 -0700
Message-ID: <20091009162951.GD1092@core.coreip.homeip.net>
References: <4ACD4A4B.3080200@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:19685 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933874AbZJIQbv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2009 12:31:51 -0400
Received: by fg-out-1718.google.com with SMTP id 22so2256737fge.1
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2009 09:30:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4ACD4A4B.3080200@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com

Hi Joonyoung,

On Thu, Oct 08, 2009 at 11:11:23AM +0900, Joonyoung Shim wrote:
> Currently, the input device number is decided by order of driver probe.
> But we need the specified input device number regardless of order of
> driver probe because the platform or the middleware tends to access
> using fixed device node of the input devices.
> 
> This patch supports to use the specified input device number when the
> input device is registered. If the input device number bigger than zero
> is registered before by other input device, returns error.
> 

No, I don't think this is a good solution. You can have persistent
device nodes without hadrcoding it into the driver. See how UDEV creates
'by-id' and 'by-path' links.

-- 
Dmitry
