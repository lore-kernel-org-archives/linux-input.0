From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [git pull] Input updates for 3.20-rc0
Date: Wed, 11 Feb 2015 00:37:22 +0100
Message-ID: <1423611442.8772.14.camel@hadess.net>
References: <20150210232326.GD26472@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41541 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbbBJXi4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Feb 2015 18:38:56 -0500
In-Reply-To: <20150210232326.GD26472@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hey Dmitry,

On Tue, 2015-02-10 at 15:23 -0800, Dmitry Torokhov wrote:
> Hi Linus,
> 
> Please pull from:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> or
> 	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus
> 
> to receive first round of updates for the input subsystem. You will get
> a few new drivers (power button handler for AXP20x PMIC, tps65218 power
> button driver, sun4i keys driver, regulator haptic driver, NI Ettus
> Research USRP E3x0 button, Alwinner A10/A20 PS/2 controller), updates to
> Synaptics and ALPS touchpad drivers (with more to come later), brand
> new Focaltech PS/2 support, update to Cypress driver to handle Gen5 (in
> addition to Gen3) devices, and number of other fixups to various drivers
> as well as input core.

Could you look at:
http://thread.gmane.org/gmane.linux.kernel.input/41095
to get merged in rc1?

Cheers

