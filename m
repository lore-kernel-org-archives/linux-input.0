From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: rmi: Print the firmware id of the touchpad
Date: Tue, 17 Feb 2015 13:26:19 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502171326080.2279@pobox.suse.cz>
References: <1423600615-615-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423600615-615-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Tue, 10 Feb 2015, Andrew Duggan wrote:

> Knowing the firmware id is extremely useful when debugging issues related to
> the touchpad. It can be used to determine the hardware, firmware version,
> and configuation of the touchpad. This patch queries the firmware id and
> prints it as the touchpad is starting so that it will show up in the dmesg
> output included in bug reports.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Applied to for-3.21/rmi.

-- 
Jiri Kosina
SUSE Labs
