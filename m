From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: fix hidraw_exit section mismatch
Date: Fri, 17 Oct 2008 18:09:59 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0810171809390.28536@jikos.suse.cz>
References: <1224259488-11467-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:35468 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755065AbYJQQKB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Oct 2008 12:10:01 -0400
In-Reply-To: <1224259488-11467-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 17 Oct 2008, Jiri Slaby wrote:

> hidraw_exit() marked as __exit is called from __init function
> from HID core. Remove the section placement from that function.

Thanks, applied.

-- 
Jiri Kosina
SUSE Labs
