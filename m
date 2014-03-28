From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC PATCH] HID: Stop hiding options with !EXPERT
Date: Fri, 28 Mar 2014 15:13:39 -0700 (PDT)
Message-ID: <alpine.LNX.2.00.1403281511120.16202@pobox.suse.cz>
References: <20140321094636.66fc62f2@endymion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42912 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbaC1WNl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Mar 2014 18:13:41 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 161BCAC91
	for <linux-input@vger.kernel.org>; Fri, 28 Mar 2014 22:13:40 +0000 (UTC)
In-Reply-To: <20140321094636.66fc62f2@endymion.delvare>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-input@vger.kernel.org

On Fri, 21 Mar 2014, Jean Delvare wrote:

> Many HID driver options are hidden unless EXPERT is set. While I
> understand the idea of simplifying the kernel configuration for most
> users, in practice I believe it adds more confusion than it helps.

Hi Jean,

actually this question has been raised by several people in the past 
already. Copy/pasting the latest reply I have sent on this topic

===
mostly this is because we don't want to bother users with asking for every
single quirky device/vendor, as there are unfortunately a lot of them.
Usually compiling everything in doesn't waste runtime footprint (the
modules don't get loaded unless needed), and they don't cost too much disk
space either.
And if you really want to disable them, CONFIG_EMBEDDED allows you to do
that.

Please see last paragraph on

	https://lkml.org/lkml/2008/10/14/266

===

i.e. it was explicitly requested by Linus.

That's the history.

Now, admittedly, it was quite some time ago, and HID world has matured a 
lot since then, so the 'quirks' turned out into proper drivers. So maybe 
there indeed might be a good time to try it again.

-- 
Jiri Kosina
SUSE Labs
