From: Carlo Caione <carlo@caione.org>
Subject: Re: [linux-sunxi] Re: [PATCH v4 6/9] regulator: AXP20x: Add support
 for regulators subsystem
Date: Fri, 11 Apr 2014 14:29:30 +0200
Message-ID: <CAOQ7t2Y8tN6i7MtT_QkrxZsLzJi-53MmUcC9c1GJscreniStXw@mail.gmail.com>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
	<1397209093-10077-7-git-send-email-carlo@caione.org>
	<20140411122345.GD28800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from srv-hp10.netsons.net ([94.141.22.71]:60869 "EHLO
	srv-hp10.netsons.net" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754413AbaDKM3v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Apr 2014 08:29:51 -0400
In-Reply-To: <20140411122345.GD28800@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, maxime.ripard@free-electrons.com, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org, boris.brezillon@free-electrons.com, linux-sunxi@googlegroups.com

On Fri, Apr 11, 2014 at 2:23 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Apr 11, 2014 at 11:38:10AM +0200, Carlo Caione wrote:
>> AXP202 and AXP209 come with two synchronous step-down DC-DCs and five
>> LDOs. This patch introduces basic support for those regulators.
>
> Applied, thanks, but I had to resolve some trivial add/add conflicts
> with the Broadcom regulator driver Makefile and Kconfig additions -
> please remember to submit patches against current code.

Sorry, I'll do next time.

Thank you,

-- 
Carlo Caione
