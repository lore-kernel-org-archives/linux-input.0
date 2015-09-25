From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v6 4/9] Input: goodix - write configuration data to
 device
Date: Fri, 25 Sep 2015 16:40:40 +0200
Message-ID: <1443192040.17020.26.camel@hadess.net>
References: <1442327483-19407-1-git-send-email-irina.tirdea@intel.com>
	 <1442327483-19407-5-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:43019 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbbIYOrZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Sep 2015 10:47:25 -0400
In-Reply-To: <1442327483-19407-5-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Tue, 2015-09-15 at 17:31 +0300, Irina Tirdea wrote:
> Goodix devices can be configured by writing custom data to the device
> at
> init. The configuration data is read with request_firmware from
> "goodix_<id>_cfg.bin", where <id> is the product id read from the
> device
> (e.g.: goodix_911_cfg.bin for Goodix GT911, goodix_9271_cfg.bin for
> GT9271).
> 
> The configuration information has a specific format described in the
> Goodix
> datasheet. It includes X/Y resolution, maximum supported touch
> points,
> interrupt flags, various sesitivity factors and settings for advanced

sensitivity.
