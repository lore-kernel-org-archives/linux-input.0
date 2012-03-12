From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] HID: hid-lg4ff add support for G27 LEDs
Date: Mon, 12 Mar 2012 18:07:38 +0000
Message-ID: <20120312180738.GD14020@sirena.org.uk>
References: <1331565459-1892-1-git-send-email-simon@mungewell.org>
 <alpine.LNX.2.00.1203121645050.18356@pobox.suse.cz>
 <be2be8d04b58ce75fcba9798fcb4e4fa.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:38502 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080Ab2CLSHo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Mar 2012 14:07:44 -0400
Content-Disposition: inline
In-Reply-To: <be2be8d04b58ce75fcba9798fcb4e4fa.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Bauer <michael@m-bauer.org>, Michal Maly <madcatxster@gmail.com>

On Mon, Mar 12, 2012 at 02:04:14PM -0400, simon@mungewell.org wrote:

> At the moment you'd just drive the LEDs simply, ie:
> $ echo 31 > /sys/bus/hid/devices/.../leds

Shouldn't this be using the LED subsystem the kernel already has?
