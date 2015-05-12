From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: core: remove phidgets from ignore list
Date: Tue, 12 May 2015 15:39:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505121539200.8186@pobox.suse.cz>
References: <1431077398-3530-1-git-send-email-sean@mess.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44524 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932663AbbELNjd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 May 2015 09:39:33 -0400
In-Reply-To: <1431077398-3530-1-git-send-email-sean@mess.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: linux-input@vger.kernel.org

On Fri, 8 May 2015, Sean Young wrote:

> Once there were kernel drivers for some of the phidgets devices, and for
> those kernel drivers to work the hid system needed exceptions. Now the
> kernel drivers are long gone in favour of the user-space drivers.

Applied to for-4.2/upstream. Thanks,

-- 
Jiri Kosina
SUSE Labs
