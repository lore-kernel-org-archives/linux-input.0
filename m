From: Daniel Mack <daniel@caiaq.de>
Subject: Re: rotary encoder
Date: Wed, 2 Jun 2010 15:20:31 +0200
Message-ID: <20100602132031.GB2695@buzzloop.caiaq.de>
References: <7A46ED6446BE4CF7AAC51205F1B5A88B@tech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:40017 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932439Ab0FBNUj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jun 2010 09:20:39 -0400
Content-Disposition: inline
In-Reply-To: <7A46ED6446BE4CF7AAC51205F1B5A88B@tech>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitriy Vasil'ev <tech@digiton.ru>
Cc: linux-input@vger.kernel.org

(Cc'ing the linux-input mailing list)

On Wed, Jun 02, 2010 at 05:12:49PM +0400, Dmitriy Vasil'ev wrote:
> I have founded your rotary encoder driver at the Linux kernel.
> I am sorry, but I do not understand how I can use it.
> 
> How I can read data from encoder in a user space programm?
> Do I can have input like keyboard?
> For example, I would like have key-left and key-left-alt emulation keyboard-keys while rotate counterclockwise,
> key-right and key-right-alt keyboard-keys while rotate clockwise,
> shift and enter keys emulation while pressing.
> How I can do it?

You have to register this driver as platform device in your board
support code. See arch/arm/mach-pxa/raumfeld.c for an example of how to
do that. What hardware are you working on?

Daniel
