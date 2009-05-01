From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: remove driver_data direct access of struct
	device
Date: Fri, 1 May 2009 06:30:03 -0700
Message-ID: <20090501133003.GA20000@dtor-d630.eng.vmware.com>
References: <20090430221730.GA18512@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:5301 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762398AbZEANaJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 May 2009 09:30:09 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1871191rvb.1
        for <linux-input@vger.kernel.org>; Fri, 01 May 2009 06:30:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090430221730.GA18512@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-input@vger.kernel.org, Greg KH <greg@kroah.com>

On Thu, Apr 30, 2009 at 03:17:30PM -0700, Greg Kroah-Hartman wrote:
> From: Greg Kroah-Hartman <gregkh@suse.de>
> 
> In the near future, the driver core is going to not allow direct access
> to the driver_data pointer in struct device.  Instead, the functions
> dev_get_drvdata() and dev_set_drvdata() should be used.  These functions
> have been around since the beginning, so are backwards compatible with
> all older kernel versions.
> 

Applied to my 'next' branch, thanks Greg.

-- 
Dmitry
