From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] [v2] HID: add support for Apple Magic Keyboards
Date: Tue, 28 Aug 2018 13:53:08 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1808281352550.25787@cbobk.fhfr.pm>
References: <20180827200215.172838-1-seobrien@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180827200215.172838-1-seobrien@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean O'Brien <seobrien@chromium.org>
Cc: Dmitry Torokhov <dtor@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 27 Aug 2018, Sean O'Brien wrote:

> USB device
> 	Vendor 05ac (Apple)
> 	Device 026c (Magic Keyboard with Numeric Keypad)
> 
> Bluetooth devices
> 	Vendor 004c (Apple)
> 	Device 0267 (Magic Keyboard)
> 	Device 026c (Magic Keyboard with Numeric Keypad)
> 
> Support already exists for the Magic Keyboard over USB connection.
> Add support for the Magic Keyboard over Bluetooth connection, and for
> the Magic Keyboard with Numeric Keypad over Bluetooth and USB
> connection.
> 
> Signed-off-by: Sean O'Brien <seobrien@chromium.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
