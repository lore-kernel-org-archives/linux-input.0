From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Merging hid-huion into hid-uclogic
Date: Tue, 27 Jan 2015 11:10:06 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1501271109200.10817@pobox.suse.cz>
References: <54C4EE18.4030005@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44252 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755101AbbA0KKI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 05:10:08 -0500
In-Reply-To: <54C4EE18.4030005@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Sun, 25 Jan 2015, Nikolai Kondrashov wrote:

> I'd like to have your opinion if it will be fine to merge hid-huion.c into
> hid-uclogic.c, keeping tablet support intact, of course.

huion driver module doesn't take any module parameters, so that should be 
fine (renaming modules that accept parameters is more tricky due to 
potential userspace configuration breakage).

-- 
Jiri Kosina
SUSE Labs
