From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch] HID: roccat: potential out of bounds in
 pyra_sysfs_write_settings()
Date: Fri, 9 Jan 2015 14:42:06 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1501091441480.15299@pobox.suse.cz>
References: <20150109123231.GA25224@mwanda>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35546 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757192AbbAINmI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Jan 2015 08:42:08 -0500
In-Reply-To: <20150109123231.GA25224@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Fri, 9 Jan 2015, Dan Carpenter wrote:

> This is a static checker fix.  We write some binary settings to the
> sysfs file.  One of the settings is the "->startup_profile".  There
> isn't any checking to make sure it fits into the
> pyra->profile_settings[] array in the profile_activated() function.
> 
> I added a check to pyra_sysfs_write_settings() in both places because
> I wasn't positive that the other callers were correct.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to hid.git#for-3.19/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
