From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Check whether if the hidraw is null pointer before
 release.
Date: Mon, 1 Feb 2016 11:12:42 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1602011110450.22727@cbobk.fhfr.pm>
References: <1454318785-11289-1-git-send-email-shenpengru@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43758 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102AbcBAKMp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Feb 2016 05:12:45 -0500
In-Reply-To: <1454318785-11289-1-git-send-email-shenpengru@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: shenpengru@gmail.com
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, shenpengru <shenpengru@xiaomi.com>

On Mon, 1 Feb 2016, shenpengru@gmail.com wrote:

> From: shenpengru <shenpengru@xiaomi.com>

Changelog needs to go here.

Namely -- what bug is being fixed, what effects does it cause and how is 
it possible to trigger it (under which circumstances can we end up with 
null pointer there).

Thanks,

-- 
Jiri Kosina
SUSE Labs

