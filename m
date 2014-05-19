From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 4/8] input: misc: Add driver for AXP20x Power Enable
 Key
Date: Sun, 18 May 2014 22:57:45 -0700
Message-ID: <20140519055745.GL29386@core.coreip.homeip.net>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-5-git-send-email-carlo@caione.org>
 <20140503010604.GE4090@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140503010604.GE4090@lukather>
Sender: linux-doc-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Carlo Caione <carlo@caione.org>, linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org, boris.brezillon@free-electrons.com
List-Id: linux-input@vger.kernel.org

On Fri, May 02, 2014 at 06:06:04PM -0700, Maxime Ripard wrote:
> On Thu, May 01, 2014 at 02:29:30PM +0200, Carlo Caione wrote:
> > This patch add support for the Power Enable Key found on MFD AXP202 and
> > AXP209. Besides the basic support for the button, the driver adds two
> > entries in sysfs to configure the time delay for power on/off.
> > 
> > Signed-off-by: Carlo Caione <carlo@caione.org>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

How are we merging it? MFD tree?

Thanks.

-- 
Dmitry
