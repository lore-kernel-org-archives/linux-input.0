From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gtco - bounds check collection indent level
Date: Sat, 13 Jul 2019 01:02:54 -0700
Message-ID: <20190713080254.GB243807@dtor-ws>
References: <20190711222232.77701-1-granthernandez@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190711222232.77701-1-granthernandez@google.com>
Sender: stable-owner@vger.kernel.org
To: Grant Hernandez <granthernandez@google.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jul 11, 2019 at 03:22:32PM -0700, Grant Hernandez wrote:
> The GTCO tablet input driver configures itself from an HID report sent
> via USB during the initial enumeration process. Some debugging messages
> are generated during the parsing. A debugging message indentation
> counter is not bounds checked, leading to the ability for a specially
> crafted HID report to cause '-' and null bytes be written past the end
> of the indentation array. As long as the kernel has CONFIG_DYNAMIC_DEBUG
> enabled, this code will not be optimized out.  This was discovered
> during code review after a previous syzkaller bug was found in this
> driver.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Grant Hernandez <granthernandez@google.com>

I wish we could convert gtco to be proper HID driver, so we woudl not
have to deal with custom HID parsing, but in the meantime this is
needed.

Applied, thank you.

-- 
Dmitry
