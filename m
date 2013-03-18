From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/7] HID: multitouch: support of hybrid finger/pen
 devices
Date: Mon, 18 Mar 2013 23:14:36 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1303182313080.9529@pobox.suse.cz>
References: <1361984127-912-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361984127-912-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 27 Feb 2013, Benjamin Tissoires wrote:

> So the solution consists in relying inconditionaly to the quirk MULTI_INPUT for
> hid-multitouch. Before registering the input device in hid-input, we can test if
> it has been populated, and if not, then we simply don't register it. In order to
> prevent a regression for drivers that do not fill the input device, we need to
> add an other quirk.

Hi everybody,

I am in progress of reviewing this patchset, and so far don't have any 
major obejctions; I expect to have the review finished this week, so 3.10 
is definitely a realistic target.

Just to set my own expectations correctly -- Henrik, are you going to 
review this patchset as well, or there is no need for me to wait for your 
feedback?

Thanks,

-- 
Jiri Kosina
SUSE Labs
