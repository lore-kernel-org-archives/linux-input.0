From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 3/4] driver core: add dev_print_hex_dump() logging
 function.
Date: Wed, 27 Mar 2019 11:37:57 +0900
Message-ID: <20190327023757.GB20766@kroah.com>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-4-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327014807.7472-4-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Mar 26, 2019 at 06:48:06PM -0700, Ronald Tschalär wrote:
> This is the dev_xxx() analog to print_hex_dump(), using dev_printk()
> instead of straight printk() to match other dev_xxx() logging functions.
> ---
>  drivers/base/core.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/device.h | 15 +++++++++++++++
>  2 files changed, 58 insertions(+)

No signed-off-by?

Anyway, no, please do not do this.  Please do not dump large hex values
like this to the kernel log, it does not help anyone.

You can do this while debugging, sure, but not for "real" kernel code.

Worst case, just create a debugfs file for your device that you can read
the binary data from if you really need it.  For any "normal" operation,
this is not something that you should ever need.

thanks,

greg k-h
