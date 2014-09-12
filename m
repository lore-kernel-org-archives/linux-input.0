From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: rmi: check sanity of the incoming report
Date: Fri, 12 Sep 2014 22:58:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1409122257500.5523@pobox.suse.cz>
References: <1410397358-15308-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410397358-15308-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Wed, 10 Sep 2014, Andrew Duggan wrote:

> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> In the Dell XPS 13 9333, it appears that sometimes the bus get confused
> and corrupts the incoming data. It fills the input report with the
> sentinel value "ff". Synaptics told us that such behavior does not comes
> from the touchpad itself, so we filter out such reports here.
> 
> Unfortunately, we can not simply discard the incoming data because they
> may contain useful information. Most of the time, the misbehavior is
> quite near the end of the report, so we can still use the valid part of
> it.
> 
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=1123584
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
