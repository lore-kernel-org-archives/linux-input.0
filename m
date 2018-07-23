From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 05/11] touchscreen: elants: Use octal permissions
Date: Mon, 23 Jul 2018 11:30:40 -0700
Message-ID: <5ac390c1cdf14656624dcc1f2816ab4d694d0d4f.camel@perches.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
         <20180723131954.30739-4-harshitjain6751@gmail.com>
         <20180723133200.GA1167@kroah.com> <20180723171831.GC100814@dtor-ws>
         <e257bc89eb082e9fdc342d6f794c15a2805c98a9.camel@perches.com>
         <20180723182412.GA2964@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723182412.GA2964@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dev-harsh1998 <harshitjain6751@gmail.com>, trivial@kernel.org, Simon Budig <simon.budig@kernelconcepts.de>, Andi Shyti <andi@etezian.org>, Luca Ceresoli <luca@lucaceresoli.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2018-07-23 at 11:24 -0700, Guenter Roeck wrote:
> There are much more urgent issues to fix there (such as, for example,
> converting the "offending" drivers to the latest API, which would
> magically cause most of the offenders to disappear).

Perhaps posting a list of desired hwmon changes could help.

Documentation/hwmon/submitting-patches does not seem to specify
what the "latest API" is nor describe what changes would be
required in older drivers.
