From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH v2] drivers/hid: Check result of debugfs_create_dir() and
 debugfs_create_file()
Date: Thu, 20 Aug 2015 23:38:47 +0600
Message-ID: <20150820173847.GA1821@localhost>
References: <1439922909-18452-1-git-send-email-kuleshovmail@gmail.com>
 <alpine.LNX.2.00.1508192240080.25821@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:34817 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbbHTRjS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 13:39:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1508192240080.25821@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Jiri,

On 08-19-15, Jiri Kosina wrote:
> On Wed, 19 Aug 2015, Alexander Kuleshov wrote:
> 
> >  
> > -	hid_debug_init();
> > +	if (hid_debug)
> > +		hid_debug_init();
> 
> How is this change related to the rest of the patch?
> 
> It's wrong anyway, because hid_debug is independent of the debugfs HID 
> debugging facility. Please see for example the printk() a few lines above 
> in this very function, which is emited in case hid_debug is enabled.
>

hmm, I thought that these things are related. I've remove all hid_debug check
and sent v3 of the patch.
