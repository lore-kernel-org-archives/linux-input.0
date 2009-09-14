From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] Generic suspend/resume for input devices
Date: Tue, 15 Sep 2009 00:11:46 +0200
Message-ID: <200909150011.46690.rjw@sisk.pl>
References: <20090911054210.27150.93405.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55604 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755116AbZINWKo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2009 18:10:44 -0400
In-Reply-To: <20090911054210.27150.93405.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Friday 11 September 2009, Dmitry Torokhov wrote:
> Hi,

Hi,

Sorry for the delayed response.

> The following patches implement generic suspend and resume for
> input devices. As part of the suspend sequence input core will
> turn off leds and bell (if they were active) and upon resume the
> state of the leds, sound effects and repeat rate/delay will be
> restored without requiring and special handling in individual
> drivers.
> 
> The change required some additional locking in i8042/libps2 and
> while I don't particularly like it the positive thing is that
> the change should allow switching serio to the asynchronous
> suspend and resume, i8042 should be able to handle it now.

FWIW, the patches look good to me, thanks for taking care of this!

Best,
Rafael
