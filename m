From: simon@mungewell.org
Subject: Re: Bug HID Dial - jstest and evtest see different number of clicks
Date: Mon, 21 Jan 2013 23:48:01 -0500
Message-ID: <04d6d378f8654bc2923cd22e11fd6569.squirrel@www.mungewell.org>
References: <dd635eb75d3c9621e698d5458b16811a.squirrel@www.mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:57757 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab3AVEsD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jan 2013 23:48:03 -0500
In-Reply-To: <dd635eb75d3c9621e698d5458b16811a.squirrel@www.mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

With a little more digging on this I think the issue is down to the
default calibration values.

Using 'jscal -c' I am able to recalibrate so that the system reports 4
different values (for the 4 position dial), however the spacing is not
linear as there is no way to set the mid position - which would need to be
1.5

Also using 'jscal -s 8,0,0,0,0,0...' I can turn off the calibration
altogether and see the raw values from the device.

Question: should a calibration really be applied to a dial?? evtest
displays without a fuzz and flat listed.

Simon

> Hi,
> I'm modifying the HID descriptor for a gaming wheel to support the dials
> on it and I'm seeing that jstest does not report/register the highest
> value location, whereas evtest does.
>
> For example the last dial is 4 position (values 0 to 3) and reported as
> the 'ABS_GAS' control.
> --
>                     /*   ---- Dial patch starts here ----   */
> 0x05, 0x01,         /*          Usage Page (Desktop),       */
> 0x09, 0x37,         /*          Usage (Dial),               */
> 0x75, 0x04,         /*          Report Size (4),            */
> 0x95, 0x02,         /*          Report Count (2),           */
> 0x15, 0x00,         /*          Logical Minimum (0),        */
> 0x25, 0x0b,         /*          Logical Maximum (b),        */
> 0x81, 0x02,         /*          Input (Variable),           */
> 0x09, 0x37,         /*          Usage (Dial),               */
> 0x75, 0x04,         /*          Report Size (4),            */
> 0x95, 0x01,         /*          Report Count (1),           */
> 0x25, 0x03,         /*          Logical Maximum (3),        */
> 0x81, 0x02,         /*          Input (Variable),           */
>                     /*    ---- Dial patch ends here ----    */
> --
>
> Jstest only reports 3 positions and 'misses' the last click
> --
> simon@simon-virtual-machine:~/linux-git$ jstest --event /dev/input/js0
> Driver version is 2.1.0.
> Joystick (SteelSeries SRWheel) has 8 axes (X, Y, Z, Rudder, Wheel, Gas,
> Hat0X, Hat0Y)
> and 17 buttons (BtnX, BtnY, BtnZ, BtnTL, BtnTR, BtnTL2, BtnTR2, BtnSelect,
> BtnStart, BtnMode, BtnThumbL, BtnThumbR, ?, ?, ?, ?, (null)).
> Testing ... (interrupt to exit)
> Event: type 129, time 5915608, number 0, value 0
> Event: type 129, time 5915608, number 1, value 0
> Event: type 129, time 5915608, number 2, value 0
> Event: type 129, time 5915608, number 3, value 0
> Event: type 129, time 5915608, number 4, value 0
> Event: type 129, time 5915608, number 5, value 0
> Event: type 129, time 5915608, number 6, value 0
> Event: type 129, time 5915608, number 7, value 0
> Event: type 129, time 5915608, number 8, value 0
> Event: type 129, time 5915608, number 9, value 0
> Event: type 129, time 5915608, number 10, value 0
> Event: type 129, time 5915608, number 11, value 0
> Event: type 129, time 5915608, number 12, value 0
> Event: type 129, time 5915608, number 13, value 0
> Event: type 129, time 5915608, number 14, value 0
> Event: type 129, time 5915608, number 15, value 0
> Event: type 129, time 5915608, number 16, value 0
> Event: type 130, time 5915608, number 0, value 0
> Event: type 130, time 5915608, number 1, value -32767
> Event: type 130, time 5915608, number 2, value -32767
> Event: type 130, time 5915608, number 3, value -32767
> Event: type 130, time 5915608, number 4, value -32767
> Event: type 130, time 5915608, number 5, value -32767
> Event: type 130, time 5915608, number 6, value 0
> Event: type 130, time 5915608, number 7, value 0
> Event: type 2, time 5922404, number 5, value 0
> Event: type 2, time 5925804, number 5, value 32767
> Event: type 2, time 5938004, number 5, value 0
> Event: type 2, time 5940096, number 5, value -32767
> ^C
> --
>
> Whereas evtest (simultaneously) sees all 4 positions
> --
> simon@simon-virtual-machine:~$ evtest /dev/input/event4
> Input driver version is 1.0.1
> Input device ID: bus 0x3 vendor 0x1038 product 0x1410 version 0x111
> Input device name: "SteelSeries SRWheel"
> Supported events:
>   Event type 0 (EV_SYN)
>   Event type 1 (EV_KEY)
>     Event code 304 (BTN_A)
>     Event code 305 (BTN_B)
>     Event code 306 (BTN_C)
>     Event code 307 (BTN_X)
>     Event code 308 (BTN_Y)
>     Event code 309 (BTN_Z)
>     Event code 310 (BTN_TL)
>     Event code 311 (BTN_TR)
>     Event code 312 (BTN_TL2)
>     Event code 313 (BTN_TR2)
>     Event code 314 (BTN_SELECT)
>     Event code 315 (BTN_START)
>     Event code 316 (BTN_MODE)
>     Event code 317 (BTN_THUMBL)
>     Event code 318 (BTN_THUMBR)
>     Event code 319 (?)
>     Event code 704 (BTN_TRIGGER_HAPPY1)
>   Event type 3 (EV_ABS)
>     Event code 0 (ABS_X)
>       Value   1800
>       Min    -1800
>       Max     1800
>       Fuzz      14
>       Flat     225
>     Event code 1 (ABS_Y)
>       Value      0
>       Min        0
>       Max     1023
>       Fuzz       3
>       Flat      63
>     Event code 2 (ABS_Z)
>       Value      0
>       Min        0
>       Max     1023
>       Fuzz       3
>       Flat      63
>     Event code 7 (ABS_RUDDER)
>       Value      0
>       Min        0
>       Max       11
>     Event code 8 (ABS_WHEEL)
>       Value      0
>       Min        0
>       Max       11
>     Event code 9 (ABS_GAS)
>       Value      0
>       Min        0
>       Max        3
>     Event code 16 (ABS_HAT0X)
>       Value      0
>       Min       -1
>       Max        1
>     Event code 17 (ABS_HAT0Y)
>       Value      0
>       Min       -1
>       Max        1
>   Event type 4 (EV_MSC)
>     Event code 4 (MSC_SCAN)
> Properties:
> Testing ... (interrupt to exit)
> Event: time 1358662071.788346, type 3 (EV_ABS), code 9 (ABS_GAS), value 1
> Event: time 1358662071.788346, -------------- SYN_REPORT ------------
> Event: time 1358662075.188293, type 3 (EV_ABS), code 9 (ABS_GAS), value 2
> Event: time 1358662075.188293, -------------- SYN_REPORT ------------
> Event: time 1358662079.725606, type 3 (EV_ABS), code 9 (ABS_GAS), value 3
> Event: time 1358662079.725606, -------------- SYN_REPORT ------------
> Event: time 1358662084.757001, type 3 (EV_ABS), code 9 (ABS_GAS), value 2
> Event: time 1358662084.757001, -------------- SYN_REPORT ------------
> Event: time 1358662087.388547, type 3 (EV_ABS), code 9 (ABS_GAS), value 1
> Event: time 1358662087.388547, -------------- SYN_REPORT ------------
> Event: time 1358662089.477327, type 3 (EV_ABS), code 9 (ABS_GAS), value 0
> Event: time 1358662089.477327, -------------- SYN_REPORT ------------
> ^C
> --
>
> Can anyone else confirm this is a bug, or am I messing up some where?
> Simon.
>


