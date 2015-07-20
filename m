From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH RFC V1 3/3] devicetree: da9062: Add device tree bindings
 for DA9062 RTC
Date: Mon, 20 Jul 2015 23:07:17 +0200
Message-ID: <20150720210717.GN15539@piout.net>
References: <cover.1436427954.git.stwiss.opensource@diasemi.com>
 <b47f52abd6a574e5f95760a07a59f445031baefc.1436427954.git.stwiss.opensource@diasemi.com>
 <20150717234737.GJ3487@piout.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B253DAD@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35999 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752431AbbGTVHW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 17:07:22 -0400
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B253DAD@SW-EX-MBX02.diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, David Dajun Chen <david.chen@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>

Hi,

On 20/07/2015 at 17:08:00 +0000, Opensource [Steve Twiss] wrote :
> If I miss out the compatible line for the RTC in the DTSI for DA9062, or is I alter it
> so it does not match the string specified in the DA9063 RTC driver, the DA9063 RTC
> driver will not be probed for the DA9062 compatibility.
> The RTC compatible = "dlg,da9062-rtc"  is essential in this case.
> 

You are right. Disregard my comment.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
