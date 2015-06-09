From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 4/8] input: goodix: reset device at init
Date: Tue, 09 Jun 2015 17:53:02 +0200
Message-ID: <1433865182.5707.7.camel@hadess.net>
References: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
	 <1433774273-23103-5-git-send-email-irina.tirdea@intel.com>
	 <1433864084.5707.4.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44127 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbbFIPxl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 11:53:41 -0400
In-Reply-To: <1433864084.5707.4.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Octavian Purdila <octavian.purdila@intel.com>

On Tue, 2015-06-09 at 17:34 +0200, Bastien Nocera wrote:
> On Mon, 2015-06-08 at 17:37 +0300, Irina Tirdea wrote:
> > After power on, it is recommended that the driver resets the 
> > device.
> > The reset procedure timing is described in the datasheet and is 
> > used
> > at device init (before writing device configuration) and
> > for power management. It is a sequence of setting the interrupt
> > and reset pins high/low at specific timing intervals. This 
> > procedure
> > also includes setting the slave address to the one specified in the
> > ACPI/device tree.
> 
> This breaks the touchscreen on my Onda v975w:
> [  239.732858] Goodix-TS i2c-GDIX1001:00: ID 9271, version: 1020
> [  239.732977] Goodix-TS i2c-GDIX1001:00: Failed to get reset GPIO: 
> -16
> [  239.736071] Goodix-TS: probe of i2c-GDIX1001:00 failed with error 
> -16
> 
> This is the DSDT for that device:
> https://bugzilla.kernel.org/attachment.cgi?id=149331

(Note that this means that I haven't been able to test any following
patches in that series than 4/8).
