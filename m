From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: fix input mode switching on some Elan
 panels
Date: Wed, 2 Dec 2015 15:03:54 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512021501350.32500@pobox.suse.cz>
References: <1448970098-23572-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448970098-23572-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 1 Dec 2015, Benjamin Tissoires wrote:

[ ... snip ... ]
> Not so sure if this is 4.4 material. On the one hand we have a regression
> since 4.4-rc0 for this particular panel.
> On the other hand, there is still the chance that doing so will break a
> different panel. In the list of devices I have been reported, there is only one
> other elan touchpad (0x300b) that will be affected, but judging by the report
> descriptor, I think it will be in the same situation than this one (broken by
> 4.4).
> 
> All the other devices I know of have only one feature for the input mode and are
> thus not affected by this change.

Thanks for detailed assessment. After considering the alternatives, I've 
now applied it to for-4.5/multitouch. If it later proves itself to be 
regression-free, we might well backport it to -stable.

Ok?

Thanks,

-- 
Jiri Kosina
SUSE Labs
