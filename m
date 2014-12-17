From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: bail out if wtp_connect fails
Date: Wed, 17 Dec 2014 09:09:36 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1412170908351.1680@pobox.suse.cz>
References: <1418767562-4136-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418767562-4136-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Peter Wu <peter@lekensteyn.nl>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 16 Dec 2014, Benjamin Tissoires wrote:

> If wtp_connect() fails, that means most of the time that the device has
> been disconnected. Subsequent attempts to contact the device will fail
> too, so it's simpler to bail out earlier.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I have applied this one to for-3.20/logitech. I am postponing 2/2, 
expecting v2 with an updated comment.

Thanks,

-- 
Jiri Kosina
SUSE Labs
