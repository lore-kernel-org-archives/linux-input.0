From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Wacom: switch Dell canvas into highres mode
Date: Fri, 10 Nov 2017 09:40:52 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711100940010.32604@cbobk.fhfr.pm>
References: <20171103172947.15156-1-benjamin.tissoires@redhat.com> <DE35351F-500C-41C5-90E2-18BC2B48A803@gmail.com> <20171106080503.GB9728@mail.corp.redhat.com> <nycvar.YFH.7.76.1711091242000.32604@cbobk.fhfr.pm>
 <CANRwn3ShBkgwdzUT9Gvky7aUz0J++AKWDDDN9wgeuAQOR3sa2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43233 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbdKJIkz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Nov 2017 03:40:55 -0500
In-Reply-To: <CANRwn3ShBkgwdzUT9Gvky7aUz0J++AKWDDDN9wgeuAQOR3sa2g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Linux Input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, 9 Nov 2017, Jason Gerecke wrote:

> I spent some time checking for similar devices and didn't anything
> with a descriptor quite like it. That said, there's a good chance that
> we'll see something similar in the future...
> 
> I'm still not entirely happy with the one-off approach, but I'll but
> my stamp of approval on it. We can work out a more generic way to
> detect and configure these dual-resolution devices going forward :)
> 
> Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied to for-4.15/wacom, thanks for checking.

-- 
Jiri Kosina
SUSE Labs

