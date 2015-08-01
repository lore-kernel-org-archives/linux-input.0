From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 05/15] drivers: input: Drop unlikely before
 IS_ERR(_OR_NULL)
Date: Sat, 1 Aug 2015 16:52:51 +0530
Message-ID: <20150801112251.GK899@linux>
References: <cover.1438331416.git.viresh.kumar@linaro.org>
 <72b53f2cabc15cf3d019041a0ed605ca7c24d19b.1438331416.git.viresh.kumar@linaro.org>
 <20150731165841.GD5613@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150731165841.GD5613@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: akpm@linux-foundation.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Masaki Ota <masaki.ota@jp.alps.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
List-Id: linux-input@vger.kernel.org

On 31-07-15, 09:58, Dmitry Torokhov wrote:
> On Fri, Jul 31, 2015 at 02:08:25PM +0530, Viresh Kumar wrote:
> > IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
> > is no need to do that again from its callers. Drop it.
> 
> I'd rather keep it as it documents the expected behavior and double
> unlikely should work just fine.

TBH, I don't really agree that it is there for documentation. The only purpose
of such compiler flags is to try make code more efficient.

Anyway, I got to this series as someone asked me to fix this for one of my
patches which used unlikely(IS_ERR_OR_NULL()). And so I thought about fixing all
sites that are doing double unlikely (that shouldn't hurt for sure).

I will leave it to you.

-- 
viresh
