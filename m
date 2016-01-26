From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: New FocalTech FT6236 touchscreen driver is a duplicate with the
 existing edt-ft5x06.c driver
Date: Tue, 26 Jan 2016 10:16:25 +0100
Message-ID: <56A73969.5000100@redhat.com>
References: <5675B852.5060308@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44092 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756215AbcAZJQc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jan 2016 04:16:32 -0500
In-Reply-To: <5675B852.5060308@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Sean Cross <xobs@kosagi.com>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.or>
Cc: Bertrik Sikken <bertrik@sikken.nl>

Hi,

On 19-12-15 21:04, Hans de Goede wrote:
> Hi All,
>
> While looking into getting a focaltech touchscreen on a tablet working I noticed
> that we've 2 overlapping drivers, the ft6236.c and the edt-ft5x06.c driver both
> support the exact same i2c touchscreen protocol. In the latter the code for the
> "M09" variant offers identical functionality to the ft6236.c code.
>
> Since the edt-ft5x06.c code seems more complete wrt advanced features and has
> been around much longer, I would like to suggest to add the ft6236.c compatible
> and i2c-ids to the edt-ft5x06.c driver and to drop the duplicate ft6236.c driver.
>
> I've tested both drivers on a Chuwi_V7_CW0825 tablet with a ft5302fe4 touchscreen
> controller (not 100% sure on the model I may be mixing up touchscreen models here,
> but it definitely is a focaltech controller), and both drivers work identically.

Ping ? We really need to fix this and the sooner the better, so that we do not
get more and more devices depending on the new duplicate ft6236.c driver.

Dmitry, since non of the ft6236.c maintainers has responded / has tested there devices
with edt-ft5x06.c, shall I just go ahead and send a patch to add the i2c-id +
compatibles from ft6236.c to edt-ft5x06.c and remove ft6236.c ?

Regards,

Hans
