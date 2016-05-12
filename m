From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input - ntrig_spi: add new driver for the Surface 3
Date: Thu, 12 May 2016 21:55:34 +0200
Message-ID: <1463082934.18447.0.camel@hadess.net>
References: <1463065674-14775-1-git-send-email-benjamin.tissoires@redhat.com>
	 <20160512191613.GB25805@dtor-ws>
	 <20160512195122.GX23234@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52644 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbcELTzk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 May 2016 15:55:40 -0400
In-Reply-To: <20160512195122.GX23234@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2016-05-12 at 21:51 +0200, Benjamin Tissoires wrote:
> Which leads to an other question: do you think we should call it
> surface_ts_spi.c instead of ntrig_spi? I am not sure this will work
> with any other Ntrig/SPI device...

N-Trig got bought by Microsoft, so it's unlikely that this might be
used in anything but another Microsoft product. You can change the name
of the driver at that point ;)
