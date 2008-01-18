From: Ben Dooks <ben@fluff.org>
Subject: Re: [PATCH] Core driver for WM97xx touchscreens
Date: Fri, 18 Jan 2008 21:57:15 +0000
Message-ID: <20080118215715.GB27399@fluff.org.uk>
References: <20080118162627.GA28974@rakim.wolfsonmicro.main> <1200673631-366-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20080118120148.ZZRA012@mailhub.coreip.homeip.net> <fmqq50$te0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932483AbYARV50@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fmqq50$te0$1@ger.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 18, 2008 at 06:11:45PM +0000, Dmitry Baryshkov wrote:
> Hi,
> 
> Dmitry Torokhov wrote:
> 
> > I will need some more time to review and understand the need for the new
> > bus in the driver.
> 
> Most likely this can be converted to platform_bus. Maybe this can also get
> help from soon-to-be posted MFD (multi function devices) helpers.

Is there any current discussion of these in public? I'm interested
mainly due to my involvement in the SM501 core and FB driver. Can
I also request to be Cc'd when these are posted?

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
