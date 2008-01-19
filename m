From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] Core driver for WM97xx touchscreens
Date: Sat, 19 Jan 2008 19:53:00 +0000 (UTC)
Message-ID: <fmtker$mv1$1@ger.gmane.org>
References: <20080118162627.GA28974@rakim.wolfsonmicro.main>
	<1200673631-366-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20080118120148.ZZRA012@mailhub.coreip.homeip.net>
	<fmqq50$te0$1@ger.gmane.org> <20080118215715.GB27399@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755199AbYASTxY@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Ben Dooks wrote:

> On Fri, Jan 18, 2008 at 06:11:45PM +0000, Dmitry Baryshkov wrote:
>> Hi,
>> 
>> Dmitry Torokhov wrote:
>> 
>> > I will need some more time to review and understand the need for the
>> > new bus in the driver.
>> 
>> Most likely this can be converted to platform_bus. Maybe this can also
>> get help from soon-to-be posted MFD (multi function devices) helpers.
> 
> Is there any current discussion of these in public? I'm interested
> mainly due to my involvement in the SM501 core and FB driver. Can I also
> request to be Cc'd when these are posted?


You can find the current work at
git://git.mnementh.co.uk/linux-2.6-im.git#tmio_dev_try3. Look for "Core MFD support" changeset.
For CC concact Ian <spyro@f2s.com>.

> 
> --
> Ben (ben@fluff.org, http://www.fluff.org/)
> 
>   'a smiley only costs 4 bytes'





-- 
With best wishes
Dmitry


