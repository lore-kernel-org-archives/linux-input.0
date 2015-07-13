From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2] usbtouchscreen: adds support for inverting X or Y
 axis (or both)
Date: Mon, 13 Jul 2015 12:28:16 +0200
Message-ID: <1436783296.20249.37.camel@hadess.net>
References: <1433720284-23342-1-git-send-email-rzr@gna.org>
	 <1436782503-9749-1-git-send-email-rzr@gna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35485 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbbGMK3G (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 06:29:06 -0400
In-Reply-To: <1436782503-9749-1-git-send-email-rzr@gna.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philippe Coval <rzr@gna.org>, poeschel@lemonage.de, dmitry.torokhov@gmail.com
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Philippe Coval <philippe.coval@open.eurogiciel.org>

On Mon, 2015-07-13 at 12:15 +0200, Philippe Coval wrote:
> Invert Y is needed (together with swap XY) for some touchscreens :
> - LeadingTouch screens (at least for some of them)
> - CarTft 8in4 (USB ID=0eef:0001)

Wouldn't it be useful to force those settings for touchscreen devices
which you can detect? That would make it work out-of-the-box on those
devices.
