From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/2] HID: intel-ish-hid: add printf attribute to
 print_log()
Date: Mon, 2 Jan 2017 13:17:04 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701021316460.28985@cbobk.fhfr.pm>
References: <20161222100910.6179-1-nicolas.iooss_linux@m4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42017 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751353AbdABMRI (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 2 Jan 2017 07:17:08 -0500
In-Reply-To: <20161222100910.6179-1-nicolas.iooss_linux@m4x.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 22 Dec 2016, Nicolas Iooss wrote:

> Structure ishtp_device contains a logging function, print_log(), which
> formats some of its parameters using vsnprintf(). Add a __printf
> attribute to this function field (and to ish_event_tracer()) in order to
> detect at compile time issues related to the printf-like formatting.
> 
> While at it, make format parameter a const pointer as print_log() is not
> supposed to modify it.

Both patches applied to for-4.11/intel-ish. Thanks,

-- 
Jiri Kosina
SUSE Labs

