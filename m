From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: HID: intel_ish-hid: various cleanups
Date: Fri, 26 May 2017 13:57:22 -0700
Message-ID: <1495832242.79527.1.camel@linux.intel.com>
References: <20170518202144.3482304-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170518202144.3482304-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2017-05-18 at 22:21 +0200, Arnd Bergmann wrote:
> I ran into a warning message during randconfig testing and spent way
> too much time figuring out how to best address it. One thing led to
> another and I ended up with a 5 patch series.
> 
> Unforunately I screwed up the first version of the series and
> had to replace the first patch, but the second version should
> be much better.
> 
> Please have a look at the first patch separately, it might fix an
> important bug and need backporting to stable kernels, or it might
> only address a harmless warning.
This is just addressing some warning.

> 
> For the rest of the patches, please merge for 4.13 unless you
> see something wrong.

I will ack individual patches as this patch is not 0/5 patch series.

Thanks,
Srinivas
