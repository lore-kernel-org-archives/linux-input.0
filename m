From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: introduce medfield keypad driver
Date: Fri, 9 Jul 2010 09:56:24 -0700
Message-ID: <20100709165624.GA20120@core.coreip.homeip.net>
References: <20100708164127.22458.31279.stgit@localhost.localdomain>
 <20100709162113.GA19827@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:55085 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021Ab0GIQ4e (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jul 2010 12:56:34 -0400
Received: by pxi14 with SMTP id 14so914473pxi.19
        for <linux-input@vger.kernel.org>; Fri, 09 Jul 2010 09:56:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100709162113.GA19827@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Fri, Jul 09, 2010 at 09:21:13AM -0700, Dmitry Torokhov wrote:
> On Thu, Jul 08, 2010 at 05:41:33PM +0100, Alan Cox wrote:
> 
> > +	return i2c_add_driver(&mfld_keypad_i2c_driver);
> 
> i2c_register_driver() is more common.
> 

Ignore me here, I am mistaken.

-- 
Dmitry
