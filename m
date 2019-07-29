From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: applespi - register touchpad device
 synchronously in probe
Date: Mon, 29 Jul 2019 15:22:03 +0200
Message-ID: <20190729132203.GB1201@penguin>
References: <20190721070523.24695-1-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190721070523.24695-1-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mao Wenan <maowenan@huawei.com>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Ronald,

On Sun, Jul 21, 2019 at 12:05:23AM -0700, Ronald Tschalär wrote:
> This allows errors during registration to properly fail the probe
> function.
> 
> Doing this requires waiting for a response from the device inside the
> probe function. While this generally takes about 15ms, in case of errors
> it could be arbitrarily long, and hence a 3 second timeout is used.
> 
> This also adds 3 second timeouts to the drain functions to avoid the
> potential for suspend or remove hanging forever.

Question: is it possible to read command response synchronously as well?
I.e. I was wondering if we could add 2 (or 1?) more read xfers for the
actual result that is coming after the status response, and then we
could use spi_sync() to send the command and read the whole thing.

Thanks.

-- 
Dmitry
