From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Add quirk for Primax PIXART OEM mice
Date: Tue, 20 Nov 2018 13:08:53 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1811201308440.21108@cbobk.fhfr.pm>
References: <20181120062508.4567-1-sparschauer@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181120062508.4567-1-sparschauer@suse.de>
Sender: stable-owner@vger.kernel.org
To: Sebastian Parschauer <sparschauer@suse.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 20 Nov 2018, Sebastian Parschauer wrote:

> The PixArt OEM mice are known for disconnecting every minute in
> runlevel 1 or 3 if they are not always polled. So add quirk
> ALWAYS_POLL for two Primax mice as well.
> 
> 0x4e22 is the Dell MS111-P and 0x4d0f is the unbranded HP Portia
> mouse HP 697738-001. Both were built until approx. 2014.
> Those were the standard mice from those vendors and are still
> around - even as new old stock.
> 
> Reference: https://github.com/sriemer/fix-linux-mouse/issues/11
> 
> Signed-off-by: Sebastian Parschauer <sparschauer@suse.de>
> CC: stable@vger.kernel.org

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
