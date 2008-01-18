From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] Core driver for WM97xx touchscreens
Date: Fri, 18 Jan 2008 18:11:45 +0000 (UTC)
Message-ID: <fmqq50$te0$1@ger.gmane.org>
References: <20080118162627.GA28974@rakim.wolfsonmicro.main>
	<1200673631-366-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20080118120148.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764114AbYARSM1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

Dmitry Torokhov wrote:

> I will need some more time to review and understand the need for the new
> bus in the driver.

Most likely this can be converted to platform_bus. Maybe this can also get
help from soon-to-be posted MFD (multi function devices) helpers.

-- 
With best wishes
Dmitry


