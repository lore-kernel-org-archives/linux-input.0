From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Recent change to hid-core.c
Date: Mon, 16 Dec 2013 14:24:11 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1312161418110.12882@pobox.suse.cz>
References: <52AD3D74.90905@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55726 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753703Ab3LPNYP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Dec 2013 08:24:15 -0500
In-Reply-To: <52AD3D74.90905@pobox.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: linux-input@vger.kernel.org

On Sun, 15 Dec 2013, Mark Lord wrote:

> The recent update 08ec2dcc3527a20c619aca2fb36f800908256bac
>  "Merge branches 'for-3.11/multitouch', 'for-3.11/sony' and 'for-3.11/upstream' into for-linus"
> included an unexpected change to the return code handing for ->raw_event() calls.
> 
> A HID driver's raw_event() method previously could return these values:
>    0 --> keep processing.
>    1 --> no further processing required.
>    <0 --> error.
> 
> Now, "1" and "0" are both treated as "keep processing",
> so a lower level HID driver has to return a negative error code
> to achieve the "no further processing required" state.
> 
> Was this intentional?  Doesn't that have side-effects for some drivers?

Hi Mark,

this was intentional -- please see commit b1a1442a23 and discussion here: 
https://lkml.org/lkml/2013/3/21/591

If you have any other concerns, please let me know.

-- 
Jiri Kosina
SUSE Labs
