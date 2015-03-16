From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: wacom: ask for a in-prox report when it was
 missed
Date: Mon, 16 Mar 2015 15:50:17 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503161549020.25438@pobox.suse.cz>
References: <1425595014-23048-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425595014-23048-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 5 Mar 2015, Benjamin Tissoires wrote:

> If noone listens to the input device when a tool comes in proximity,
> the tablet does not send the in-prox event when a client becomes available.
> That means that no events will be sent until the tool is taken out of
> proximity.
> 
> In this situation, ask for the report WACOM_REPORT_INTUOSREAD which will
> read the corresponding feature and generate an in-prox event.
> To make some generation of hardware working, we need to unset the
> quirk NO_GET set by hid-core because the interfaces are seen as "boot
> mouse".
> 
> We don't schedule this read in a worker while we are in an IO interrupt.
> We know that usbhid will do it asynchronously. If this is triggered by
> uhid, then this is obviously a client side bug :)
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Ping, Jason, I'd like to get your Ack on this before pushing this through 
if possible.

Thanks.

-- 
Jiri Kosina
SUSE Labs
