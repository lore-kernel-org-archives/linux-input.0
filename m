From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] add sur40 driver for Samsung SUR40 (aka MS Surface
 2.0/Pixelsense)
Date: Tue, 22 Oct 2013 08:46:11 -0700
Message-ID: <20131022154611.GA13473@core.coreip.homeip.net>
References: <1382287751-21515-1-git-send-email-floe@butterbrot.org>
 <20131021162006.GB4575@core.coreip.homeip.net>
 <5266164C.3060509@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:42230 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab3JVPqP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Oct 2013 11:46:15 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so10608254pdj.2
        for <linux-input@vger.kernel.org>; Tue, 22 Oct 2013 08:46:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5266164C.3060509@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, rydberg@euromail.se, dh.herrmann@gmail.com

On Tue, Oct 22, 2013 at 08:08:12AM +0200, Florian Echtler wrote:
> Hello Dmitry,
> 
> thanks for your quick feedback, a few questions below:
> 
> On 21.10.2013 18:20, Dmitry Torokhov wrote:
> > On Sun, Oct 20, 2013 at 06:49:11PM +0200, Florian Echtler wrote:
> >> +/* read 512 bytes from endpoint 0x86 -> get header + blobs */
> >> +struct sur40_header {
> >> +
> >> +	uint16_t type;       /* always 0x0001 */
> >> +	uint16_t count;      /* count of blobs (if 0: continue prev. packet) */
> >> +
> >> +	uint32_t packet_id;
> >> +
> >> +	uint32_t timestamp;  /* milliseconds (inc. by 16 or 17 each frame) */
> >> +	uint32_t unknown;    /* "epoch?" always 02/03 00 00 00 */
> > 
> > Proper internal kernel types are u8, u16, u32. For user-facing APIs
> > __u8, __u16, and __u32 should be used. Also, since this is data coming
> > directly off the wire, you should be using __le16, __le32, etc, and then
> > do __leXX_to_cpu() conversion before using it in calculations.
> OK, I'll switch to u32 throughout (also for the float, I'll explain in a
> commment). However, I haven't found a single other touchscreen driver
> which uses __le32, even though they all probably process raw wire data -
> can you suggest an example?

Not necessarily le32, but:

[dtor@dtor-d630 work]$ grep -ri to_cpu drivers/input/touchscreen/
drivers/input/touchscreen/atmel_mxt_ts.c:
le16_to_cpus(&object->start_address);
drivers/input/touchscreen/atmel_mxt_ts.c:       le16_to_cpus(range.x);
drivers/input/touchscreen/atmel_mxt_ts.c:       le16_to_cpus(range.y);
drivers/input/touchscreen/cyttsp_core.c: input_report_abs(input, ABS_MT_POSITION_X, be16_to_cpu(tch->x));
drivers/input/touchscreen/cyttsp_core.c: input_report_abs(input, ABS_MT_POSITION_Y, be16_to_cpu(tch->y));
drivers/input/touchscreen/ads7846.c:            status = be16_to_cpu(req->sample);
drivers/input/touchscreen/ads7846.c:            status = be16_to_cpu(*((u16 *)&req->sample[1]));
drivers/input/touchscreen/ads7846.c:            return be16_to_cpup((__be16 *)&(((char*)t->rx_buf)[1])) >> 3;
drivers/input/touchscreen/ads7846.c:            return be16_to_cpup((__be16 *)t->rx_buf) >> 3;
drivers/input/touchscreen/usbtouchscreen.c:     unsigned int data_len = be16_to_cpu(packet->data_len);
drivers/input/touchscreen/usbtouchscreen.c:     unsigned int x_len = be16_to_cpu(packet->x_len);
drivers/input/touchscreen/usbtouchscreen.c:     unsigned int y_len = be16_to_cpu(packet->y_len);
drivers/input/touchscreen/usbtouchscreen.c: le16_to_cpu(udev->descriptor.idVendor),
drivers/input/touchscreen/usbtouchscreen.c: le16_to_cpu(udev->descriptor.idProduct));
drivers/input/touchscreen/wacom_i2c.c:  x = le16_to_cpup((__le16 *)&data[4]);
drivers/input/touchscreen/wacom_i2c.c:  y = le16_to_cpup((__le16 *)&data[6]);
drivers/input/touchscreen/wacom_i2c.c:  pressure = le16_to_cpup((__le16 *)&data[8]);

> 
> >> +/* debug helper macro */
> >> +#define get_dev(x) (&(x->usbdev->dev))
> > Just stick that dev in sur40_state and then use sur40->dev throughout.
> OK.
> 
> >> +	struct sur40_header *header = &(sur40->bulk_in_buffer->header);
> > No need to have parenthesis around & operator.
> >> +	struct sur40_blob *inblob = &(sur40->bulk_in_buffer->blobs[0]);
> > Same here.
> Intention seems clearer to me with parentheses, but if this doesn't
> conform to coding style, I'll fix it.
> 
> >> +	if (!sur40->bulk_in_buffer) {
> >> +		dev_err(&interface->dev, "Unable to allocate input buffer.");
> >> +		sur40_delete(sur40);
> > Would prefer standard kernel error unwinding style (gotos to proper
> > unwinding point).
> Something like this example from ucb1400_ts?
> 
> 	error = input_register_device(ucb->ts_idev);
> 	if (error)
> 		goto err_free_irq;
> 
> 	return 0;
> 
> err_free_irq:
> 	free_irq(ucb->irq, ucb);
> err_free_devs:
> 	input_free_device(ucb->ts_idev);
> err:
> 	return error;
> 

Yes, please.

-- 
Dmitry
