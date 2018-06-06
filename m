From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 00/12] cros_ec: Match licenses and switch to SPDX
 identifier.
Date: Wed, 06 Jun 2018 08:42:19 -0700
Message-ID: <517d33d8219f22126ec8caaf41072c14b5ebf407.camel@perches.com>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606150900.8342-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Luck <tony.luck@intel.com>, Alessandro Zummo <a.zummo@towertech.it>, Paolo Cretaro <paolocretaro@gmail.com>, linux-iio@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-i2c@vger.kernel.org, Olof Johansson <olof@lixom.net>, linux-rtc@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>, Chanwoo Choi <cw00.choi@samsung.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Colin
List-Id: linux-input@vger.kernel.org

On Wed, 2018-06-06 at 17:08 +0200, Enric Balletbo i Serra wrote:
> Dear all,
> 
> This patchset is just to adopt the SPDX license identifier for all
> ChromeOS Embedded Controller related drivers.

This bit is fine,

>  The patches touches
> different subsystems but every patch can be picked from their respective
> maintainer independently.
> 
> This third version takes the license note as the valid license (I did
> the contrary in the second version) so apart from add the SPDX tags it
> also introduces new patches to match the license.

But why change any MODULE_LICENSE text?

There are uses of MODULE_LICENSE("GPL") where
the SPDX license identifier is some GPL variant

For instance:
$ git grep -P --name-only
'MODULE_LICENSE\s*\("GPL"\s*\)\s*;'| \
  xargs grep "SPDX-License-
Identifier:" | \
  cut -f3- -d: | \
  sed -r 's@\s*\*/\s*$@@' | \
  sort |
uniq -c | sort -rn
    551  GPL-2.0+
    281  GPL-2.0
     13  GPL-1.0+
    
  9  GPL-2.0-only
      2  GPL-2.0 OR MIT
      1  (GPL-2.0 OR MPL-1.1)
   
   1  (GPL-2.0+ OR BSD-3-Clause)
      1  (GPL-2.0 OR BSD-3-Clause)

And if you were to do this, please do it tree-wide,
and ideally via a script
