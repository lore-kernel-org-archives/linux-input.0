From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC 12/12] HID: wiimote: Add sysfs support to wiimote driver
Date: Thu, 16 Jun 2011 20:35:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1106162035360.22872@pobox.suse.cz>
References: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com> <1308095157-4699-13-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:35976 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687Ab1FPSgB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jun 2011 14:36:01 -0400
In-Reply-To: <1308095157-4699-13-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, padovan@profusion.mobi

On Wed, 15 Jun 2011, David Herrmann wrote:

> Add sysfs files for each led of the wiimote. Writing 1 to the file
> enables the led and 0 disables the led.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>

As sysfs is part of kernel ABI, please document it in Documentation/ABI.

Thanks,

-- 
Jiri Kosina
SUSE Labs
