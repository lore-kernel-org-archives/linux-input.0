From: Nuno Santos <nsantos@displax.com>
Subject: Question regarding multitouch input on Linux kernel
Date: Mon, 25 Feb 2013 15:00:32 +0000
Message-ID: <512B7C90.4010704@displax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx02.edigma.com ([195.22.18.196]:33413 "EHLO mx02.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757958Ab3BYPHI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Feb 2013 10:07:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx02.edigma.com (Postfix) with ESMTP id 139792E8F02
	for <linux-input@vger.kernel.org>; Mon, 25 Feb 2013 15:00:34 +0000 (WET)
Received: from mx02.edigma.com ([127.0.0.1])
	by localhost (mx02.edigma.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IrQNAoH3Vrr7 for <linux-input@vger.kernel.org>;
	Mon, 25 Feb 2013 15:00:33 +0000 (WET)
Received: from [192.168.3.103] (bl17-89-18.dsl.telepac.pt [188.82.89.18])
	by mx02.edigma.com (Postfix) with ESMTPSA id 6D2E02E8D7A
	for <linux-input@vger.kernel.org>; Mon, 25 Feb 2013 15:00:33 +0000 (WET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I have been experiencing an issue with a Linux driver for multitouch 
input that i'm responsible for maintaining.

The issue is basically the following:

- I load the driver and the mouse works just fine
- I touch the screen and the first touch input is delivered to the system
- On that very same moment I can't use mouse left button down to click 
on folders on nautilus. I can only selected them using drag select. I 
also can't get a folder to get selected with a single touch input.
- The user experience with the mouse gets inconsistent.
- Unloading the module doesn't return the good experience
- Restarting X fixes the problem until I report a touch input again with 
this driver
- If I only use common pointer input, the issue doesn't occur.

My questions resides in if the problem is due to bad touch reporting, or 
due to a bug in X/nautilus.

I have been analyzing a lot of examples under kernel tree for multitouch 
input under Linux an it seems I'm doing what is necessary.

I'm using Ubuntu 12.04 but this happened with Ubuntu 11.XX already

This what I do in order to declare device capabilities:

input_set_abs_params(input_dev, ABS_X, 0, 6300, 0, 0);
input_set_abs_params(input_dev, ABS_Y, 0, 6300, 0, 0);

input_mt_init_slots(input_dev, DPX_TOUCH_MAX_COUNT);
input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 6300, 0, 0);
input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 6300, 0, 0);

This is what I do in order to report touches:

for (currentTouch=0;currentTouch<DPX_TOUCH_MAX_COUNT && 
touchCount<priv->context->State.Acquisition.TouchPoints;++currentTouch)
     {
         Touch = priv->context->State.Touches + currentTouch;

         x = Touch->CalibratedPoint.Position.X;
         y = Touch->CalibratedPoint.Position.Y;

         input_mt_slot(usbtouch->input, currentTouch);

         // touch down
         if(Touch->CurrentState==DPX_TOUCH_STATE_ACTIVE && 
Touch->ReportedState==DPX_TOUCH_STATE_INACTIVE)
         {
             Touch->ReportedState = DPX_TOUCH_STATE_ACTIVE;

             input_mt_report_slot_state(usbtouch->input, MT_TOOL_FINGER, 1);

             input_report_abs(usbtouch->input, ABS_MT_POSITION_X, x);
             input_report_abs(usbtouch->input, ABS_MT_POSITION_Y, y);

             touchCount++;
         }
         // touch move
         else if (Touch->CurrentState==DPX_TOUCH_STATE_ACTIVE && 
Touch->ReportedState==DPX_TOUCH_STATE_ACTIVE)
         {
             Touch->ReportedState = DPX_TOUCH_STATE_ACTIVE;

             input_mt_report_slot_state(usbtouch->input, MT_TOOL_FINGER, 1);

             input_report_abs(usbtouch->input, ABS_MT_POSITION_X, x);
             input_report_abs(usbtouch->input, ABS_MT_POSITION_Y, y);

             touchCount++;
         }
         // touch up
         else
         {
             Touch->ReportedState = DPX_TOUCH_STATE_INACTIVE;

             input_mt_report_slot_state(usbtouch->input, MT_TOOL_FINGER, 0);

             input_report_abs(usbtouch->input, ABS_MT_POSITION_X, x);
             input_report_abs(usbtouch->input, ABS_MT_POSITION_Y, y);

             touchCount++;
         }
     }

     if (touchCount>0)
     {
         input_mt_report_pointer_emulation(usbtouch->input, true);
         input_sync(usbtouch->input);
     }


Thanks for your attention,

With my best regards,

Nuno Santos

