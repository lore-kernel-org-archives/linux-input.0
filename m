From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v3 2/2] input: add driver support for MAX8997-haptic
Date: Fri, 16 Mar 2012 18:48:02 +0100
Message-ID: <20120316174802.GI20524@sortiz-mobl>
References: <4F5DB459.9090701@samsung.com>
 <20120314084652.GC3964@core.coreip.homeip.net>
 <4F60AF8E.7050900@samsung.com>
 <20120314154828.GA24964@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120314154828.GA24964@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Wed, Mar 14, 2012 at 08:48:28AM -0700, Dmitry Torokhov wrote:
> On Wed, Mar 14, 2012 at 11:47:42PM +0900, Chanwoo Choi wrote:
> > Hi Dmitry,
> > 
> > > This is not proper locking between playing effect and suspend. Now that
> > > you are using workqueue you need to synchronize access with it, not with
> > > play_effect method.
> > > 
> > > Does the following patch work for you?
> > > 
> > 
> > Your patch is worked on TRATS board based on EXYNOS4210 but, you should
> > apply following patch because 'chip->enabled' is used on
> > max8997_haptic_configure() function to enable/disable haptic motor.
> 
> OK, excellent. I'll pick up this fix and apply the driver for 3.4 queue,
> thanks!
Your patch depends on the MFD changes Choi sent along the input driver. I
think it would make more sense for me to take it. What do you think ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
