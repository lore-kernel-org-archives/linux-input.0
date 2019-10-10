From: Sam Bazley <sambazley@fastmail.com>
Subject: Re: [PATCH 0/3] Logitech G920 fixes
Date: Thu, 10 Oct 2019 23:38:33 +0100
Message-ID: <20191010223833.axroklxlo2lkdzo6@SamLinux>
References: <20191007051240.4410-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191007051240.4410-1-andrew.smirnov@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Austin Palmer <austinp@valvesoftware.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Oct 06, 2019 at 10:12:37PM -0700, Andrey Smirnov wrote:
> Everyone:
> 
> This series contains patches to fix a couple of regressions in G920
> wheel support by hid-logitech-hidpp driver. Without the patches the
> wheel remains stuck in autocentering mode ("resisting" any attempt to
> trun) as well as missing support for any FF action.
> 
> Thanks,
> Andrey Smirnov
> 
> Andrey Smirnov (3):
>   HID: logitech-hidpp: use devres to manage FF private data
>   HID: logitech-hidpp: split g920_get_config()
>   HID: logitech-hidpp: add G920 device validation quirk
> 
>  drivers/hid/hid-logitech-hidpp.c | 193 +++++++++++++++++++------------
>  1 file changed, 120 insertions(+), 73 deletions(-)
> 
> -- 
> 2.21.0
> 

All seems to work now. Thanks again Andrey!

Tested-by: Sam Bazley <sambazley@fastmail.com>
