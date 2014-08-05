From: Michael Welling <mwelling@emacinc.com>
Subject: TSC2004 driver
Date: Tue, 5 Aug 2014 12:06:40 -0500
Message-ID: <20140805170640.GA8830@sysresccd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, hvaibhav@ti.com
List-Id: linux-input@vger.kernel.org

The TSC2004 driver has yet to appear in the mainline kernel. We have
been using the driver referenced here as provided by TI:

https://www.mail-archive.com/linux-omap@vger.kernel.org/msg22018.html

Are there any plans of supporting this device in the mainline kernel?

Mysteriously a device tree entry was found in the following file:
arch/arm/boot/dts/omap4-var-som-om44.dtsi

This is obviously pointing to an out of tree driver that is not easily
obtained.

Suggestions?
