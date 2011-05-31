From: "Eric Andersson" <eric.andersson@unixphere.com>
Subject: Re: [PATCH] input: add driver for Bosch Sensortec's BMA150
 accelerometer
Date: Tue, 31 May 2011 22:00:30 +0200
Message-ID: <20110531200031.01097304A02D@bmail00.one.com>
References: <1306857314-655-1-git-send-email-eric.andersson@unixphere.com>
 <20110531172320.0fcadfef@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webmail-out2.one.com ([91.198.169.17]:14141 "EHLO
	webmail-out2.b-one.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484Ab1EaUHr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 May 2011 16:07:47 -0400
Content-Disposition: inline
In-Reply-To: <20110531172320.0fcadfef@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zhengguang.guo@bosch-sensortec.com, stefan.nilsson@unixphere.com, Albert Zhang <xu.zhang@bosch-sensortec.com>

On May 31, 2011 18:23 "Alan Cox" <alan@lxorguk.ukuu.org.uk> wrote:
> See the driver I posted some time ago. It's in rather better state than
> this one and as it's been through most of the review process and also
> handles the BMA023 and SMB380 so I think would be a better place to start
> from. I'll report that driver in a moment.
I wasn't aware of that patch! Thanks for pointing it out! Regarding BMA023 and
SMB380, these are also supported by this driver, which should probably have been
stated in the Kconfig file.

> Some of the first immediately obvious questions though - in particular
> the lack of clear locking ...
Thanks for reviewing!

Dimitry, I guess it's up to you to decide which version of the driver you prefer
before we go through another round in the review process.

Best regards,
 Eric

http://www.unixphere.com

