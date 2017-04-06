From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: wacom: generic: sync pad events only for actual
 packets
Date: Thu, 6 Apr 2017 20:34:36 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1704061453570.28004@cbobk.fhfr.pm>
References: <1491334267-6442-1-git-send-email-ping.cheng@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49203 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753481AbdDFSei (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 6 Apr 2017 14:34:38 -0400
In-Reply-To: <1491334267-6442-1-git-send-email-ping.cheng@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, Ping Cheng <ping.cheng@wacom.com>

On Tue, 4 Apr 2017, Ping Cheng wrote:

> Commits d793ff8 and 4082da8 introduced two pad usages which do not
> actually send pad input events. To make sure we do not post empty
> pad packets, pad_input_event_flag is introduced. Turn on the flag
> for real pad input events so we can synchronize them properly.
> 
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>

Applied to for-4.12/wacom.

-- 
Jiri Kosina
SUSE Labs

