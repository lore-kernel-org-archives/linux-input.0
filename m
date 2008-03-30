From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC: 2.6 patch] drivers/hid/: make 2 functions static
Date: Mon, 31 Mar 2008 01:41:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0803310141200.5541@jikos.suse.cz>
References: <20080330232221.GQ28445@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:57742 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752111AbYC3Xls (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Mar 2008 19:41:48 -0400
In-Reply-To: <20080330232221.GQ28445@cs181133002.pp.htv.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-input@vger.kernel.org

On Mon, 31 Mar 2008, Adrian Bunk wrote:

> This patch makes the following needlessly global functions static:
> - hid-core.c:hid_input_field()
> - usbhid/hid-quirks.c:usbhid_modify_dquirk()

Applied, thanks Adrian.

-- 
Jiri Kosina
SUSE Labs
