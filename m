From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v11 4/8] Input: goodix - add power management support
Date: Mon, 23 Nov 2015 17:33:05 +0100
Message-ID: <1448296385.3600.2.camel@hadess.net>
References: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
	 <1447936001-21420-5-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34481 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907AbbKWQdW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2015 11:33:22 -0500
In-Reply-To: <1447936001-21420-5-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Thu, 2015-11-19 at 14:26 +0200, Irina Tirdea wrote:
> Implement suspend/resume for goodix driver.
> 
> The suspend and resume process uses the gpio pins.
> If the device ACPI/DT information does not declare gpio pins,
> suspend/resume will not be available for these devices.
> 
> This is based on Goodix datasheets for GT911 and GT9271
> and on Goodix driver gt9xx.c for Android (publicly available
> in Android kernel trees for various devices).
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>

Not functional on the WinBook TW100, but doesn't break anything

Tested-by: Bastien Nocera <hadess@hadess.net>
