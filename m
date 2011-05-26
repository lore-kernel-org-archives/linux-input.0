From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3] input: Add support for Kionix KXTJ9 accelerometer
Date: Thu, 26 May 2011 14:56:22 +0100
Message-ID: <1306418184.2010.241.camel@novo.hadess.net>
References: <1306273877-28503-1-git-send-email-chudson@kionix.com>
	 <4DDCC9E5.7050205@cam.ac.uk>
	 <BANLkTi=PwXb7PJTd8B_Y8x9G0WwDYgmk8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54601 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757810Ab1EZN4a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2011 09:56:30 -0400
In-Reply-To: <BANLkTi=PwXb7PJTd8B_Y8x9G0WwDYgmk8w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Hudson <chris.hudson.comp.eng@gmail.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Chris Hudson <chudson@kionix.com>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Wed, 2011-05-25 at 14:55 -0400, Christopher Hudson wrote:
> On Wed, May 25, 2011 at 5:20 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> Hi Jonathan,
> 
> > So after all this, I'd leave it as it currently is!  Sorry for the wild
> > goose chase.
> 
> I think I lost you somewhere in there, but I'm glad it turned out that
> I was doing it right!
> 
> > Subject to responses to RFC on delay control, I'm happy with this driver.
> > Good work and I look forward to lots more drivers in the future.
> 
> Thanks!  Don't worry, we have plenty more accelerometers to merge
> drivers for eventually!

I'm testing the pegatron accelerometer patches (I have the hardware),
and wanted to add support for automatic rotation in GNOME as well.

Do any of your devices offer coarse events when the rotation of the
device changes? Do you send kevents through udev when the rotation
changes? Is there a good way to detect accelerometers themselves from
user-space?

Cheers

