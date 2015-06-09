From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 3/8] input: goodix: export id and version read from
 device
Date: Tue, 09 Jun 2015 17:36:03 +0200
Message-ID: <1433864163.5707.6.camel@hadess.net>
References: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
	 <1433774273-23103-4-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58714 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbbFIPgH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 11:36:07 -0400
In-Reply-To: <1433774273-23103-4-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Octavian Purdila <octavian.purdila@intel.com>

On Mon, 2015-06-08 at 17:37 +0300, Irina Tirdea wrote:
> Goodix touchscreens export through their registers a Product ID
> and Firmware Version. The Product ID is an ASCII encoding of the
> product name (e.g.: "911").
> 
> Export to sysfs (through the input subsystem) the product id and
> firmware version read from the device rather than using constant
> values.
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>

Acked-by: Bastien Nocera <hadess@hadess.net>
