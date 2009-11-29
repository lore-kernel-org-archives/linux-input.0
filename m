From: Greg KH <greg@kroah.com>
Subject: Re: [IR-RFC PATCH v4 2/6] Core IR module
Date: Sun, 29 Nov 2009 09:14:37 -0800
Message-ID: <20091129171437.GA4993@kroah.com>
References: <20091127013217.7671.32355.stgit@terra> <20091127013423.7671.36546.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:53076 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416AbZK2RR0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2009 12:17:26 -0500
Content-Disposition: inline
In-Reply-To: <20091127013423.7671.36546.stgit@terra>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Nov 26, 2009 at 08:34:23PM -0500, Jon Smirl wrote:
> Changes to core input subsystem to allow send and receive of IR messages. Encode and decode state machines are provided for common IR porotocols such as Sony, JVC, NEC, Philips, etc.
> 
> Received IR messages generate event in the input queue.
> IR messages are sent using an input IOCTL.

As you are creating new sysfs files here, please document them in
Documentation/ABI/

thanks,

greg k-h
