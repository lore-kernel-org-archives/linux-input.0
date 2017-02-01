From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] mfd: cros-ec: Update cros_ec_commands.h for buttons
 and switches
Date: Wed, 1 Feb 2017 09:52:44 -0800
Message-ID: <20170201175244.GG40045@dtor-ws>
References: <20170120101415.26028-1-enric.balletbo@collabora.com>
 <20170123121319.GK16020@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170123121319.GK16020@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Douglas Anderson <dianders@chromium.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 23, 2017 at 12:13:19PM +0000, Lee Jones wrote:
> On Fri, 20 Jan 2017, Enric Balletbo i Serra wrote:
> 
> > From: Douglas Anderson <dianders@chromium.org>
> > 
> > Add the defines for the new buttons and switches connected to the CrosEC.
> > 
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >  include/linux/mfd/cros_ec_commands.h | 73 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 71 insertions(+), 2 deletions(-)
> 
> Applied, thanks.

Then please take "[PATCH 2/2] input: cros_ec_keyb: Add non-matrix
buttons and switches" as well as it depends on this one.

Thanks.

-- 
Dmitry
