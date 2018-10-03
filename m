From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] [v4] HID: add support for Apple Magic Trackpad 2
Date: Wed, 3 Oct 2018 10:59:12 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810031059000.14430@cbobk.fhfr.pm>
References: <20181002225337.7349-1-seobrien@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002225337.7349-1-seobrien@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean O'Brien <seobrien@chromium.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Marek Wyborski <marek.wyborski@emwesoft.com>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, Claudio Mettler <claudio@ponyfleisch.ch>
List-Id: linux-input@vger.kernel.org

On Tue, 2 Oct 2018, Sean O'Brien wrote:

> USB device
>         Vendor 05ac (Apple)
>         Device 0265 (Magic Trackpad 2)
> Bluetooth device
>         Vendor 004c (Apple)
>         Device 0265 (Magic Trackpad 2)
> 
> Add support for Apple Magic Trackpad 2 over USB and bluetooth, putting
> the device in multi-touch mode.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
