From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: zforce - enable irq only if we are ready to
 process it
Date: Mon, 20 Jul 2015 09:54:43 -0700
Message-ID: <20150720165443.GA30252@dtor-ws>
References: <1436791779-21798-1-git-send-email-dirk.behme@de.bosch.com>
 <1436791779-21798-2-git-send-email-dirk.behme@de.bosch.com>
 <20150713170735.GC5039@dtor-ws>
 <55A4AEEF.4020300@de.bosch.com>
 <20150717215847.GD39282@dtor-ws>
 <55AC84D9.2080809@de.bosch.com>
 <20150720063523.GD13092@dtor-ws>
 <55AC9C57.4070400@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33647 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbbGTQys (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 12:54:48 -0400
Received: by pdbnt7 with SMTP id nt7so33432724pdb.0
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2015 09:54:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55AC9C57.4070400@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "external.Oleksij.Rempel" <external.Oleksij.Rempel@de.bosch.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-input@vger.kernel.org

On Mon, Jul 20, 2015 at 08:59:35AM +0200, external.Oleksij.Rempel wrote:
> On 20.07.2015 08:35, Dmitry Torokhov wrote:
> >On Mon, Jul 20, 2015 at 07:19:21AM +0200, external.Oleksij.Rempel wrote:
> >>Hi Dmitry,
> >>
> >>
> >>On 17.07.2015 23:58, Dmitry Torokhov wrote:
> >>>Hi Oleksij,
> >>>
> >>>On Tue, Jul 14, 2015 at 08:40:47AM +0200, external.Oleksij.Rempel wrote:
> >>>>Hi Dmitry,
> >>>>
> >>>>On 13.07.2015 19:07, Dmitry Torokhov wrote:
> >>>>>On Mon, Jul 13, 2015 at 02:49:38PM +0200, Dirk Behme wrote:
> >>>>>>From: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
> >>>>>>
> >>>>>>If zforce is not ready to process the interrupt, the touchscreen will
> >>>>>>be lost forever. Make sure we enable the interrupt only if processing
> >>>>>>is ready.
> >>>>>>
> >>>>>>Signed-off-by: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
> >>>>>>Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> >>>>>>---
> >>>>>>  drivers/input/touchscreen/zforce_ts.c | 7 ++++++-
> >>>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>>diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
> >>>>>>index 19dc297..a1889e5 100644
> >>>>>>--- a/drivers/input/touchscreen/zforce_ts.c
> >>>>>>+++ b/drivers/input/touchscreen/zforce_ts.c
> >>>>>>@@ -22,6 +22,7 @@
> >>>>>>  #include <linux/slab.h>
> >>>>>>  #include <linux/input.h>
> >>>>>>  #include <linux/interrupt.h>
> >>>>>>+#include <linux/irq.h>
> >>>>>>  #include <linux/i2c.h>
> >>>>>>  #include <linux/delay.h>
> >>>>>>  #include <linux/gpio/consumer.h>
> >>>>>>@@ -741,6 +742,7 @@ static int zforce_probe(struct i2c_client *client,
> >>>>>>  	struct zforce_ts *ts;
> >>>>>>  	struct input_dev *input_dev;
> >>>>>>  	int ret;
> >>>>>>+	unsigned int irq;
> >>>>>>  	if (!pdata) {
> >>>>>>  		pdata = zforce_parse_dt(&client->dev);
> >>>>>>@@ -835,6 +837,7 @@ static int zforce_probe(struct i2c_client *client,
> >>>>>>  	init_completion(&ts->command_done);
> >>>>>>+	irq = client->irq;
> >>>>>>  	/*
> >>>>>>  	 * The zforce pulls the interrupt low when it has data ready.
> >>>>>>  	 * After it is triggered the isr thread runs until all the available
> >>>>>>@@ -842,7 +845,8 @@ static int zforce_probe(struct i2c_client *client,
> >>>>>>  	 * Therefore we can trigger the interrupt anytime it is low and do
> >>>>>>  	 * not need to limit it to the interrupt edge.
> >>>>>>  	 */
> >>>>>>-	ret = devm_request_threaded_irq(&client->dev, client->irq,
> >>>>>>+	irq_set_status_flags(irq, IRQ_NOAUTOEN);
> >>>>>Instead of playing with the flags should we simply request irq after we
> >>>>>release the reset pin?
> >>>>Because we should be able to process the interrupt. If i put
> >>>>request_irq after reset, some times the interrupt can be missed.
> >>>OK, I see that enabling after reset is racy. But I am still confused why
> >>>having IRQ enabled while reste pin is asserted results in lost
> >>>touchscreen. Can you walk me through the sequence of events?
> >>>
> >>>Thanks.
> >>Mostly it will fail if zforce attached over SerDes
> >>(Serializer/Deserializer). If we register IRQ after release of reset
> >>pin, SerDes will get irq just before it has irq handler. In this
> >>case irq will be lost, which means, not BOOT event will be passed to
> >>the zforce.
> >Yes, I agreed that requesting interrupt after releasing reset pin is not
> >a good idea. But what is the issue with the original code that requests
> >interrupt first (and enables it) and then releases the reset pin?
> 
> If i remember it correctly SerDes will catch spurious interrupt from
> the line and trigger it before client data was set. This means,
> interrupt handler will need extra sanity checks.

Client data is only referenced in suspend/resume routines though and
they are not called until registration is completed.

Thanks.

-- 
Dmitry
