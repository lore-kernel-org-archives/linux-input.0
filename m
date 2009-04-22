From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/4] fix some improper uses of dev_set_name
Date: Tue, 21 Apr 2009 22:45:31 -0700
Message-ID: <20090422054531.GD9009@kroah.com>
References: <1240273036-5995-1-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:37193 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752533AbZDVGIw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Apr 2009 02:08:52 -0400
Content-Disposition: inline
In-Reply-To: <1240273036-5995-1-git-send-email-cascardo@holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, gregkh@suse.de, kay.sievers@vrfy.org

On Mon, Apr 20, 2009 at 09:17:12PM -0300, Thadeu Lima de Souza Cascardo wrote:
> dev_set_name expects a format string. Many of its uses, however, blindly
> call it with a string variable that comes from some external, perhaps
> unreliable source. Some of those uses are safe, like those in the third
> patch in the series and most of those not fixed by any of them. Some few
> remaining uses may require some more attention to decide if a patch is
> really required. Perhaps converting all of them for safeness is a good
> compromise.
> 
> Thadeu Lima de Souza Cascardo (4):
>   driver core: use string format when name is another device's name
>   driver core: use string format when name is given to an exported
>     function

These two patches were a bit more than just the "driver core".  Care to
split them up into the subsystem-proper sections and send them to the
different subsystem maintainers?

I don't see anything here that can come from a user supplied string, do
you?  So it's a pretty low priority.

thanks,

greg k-h
