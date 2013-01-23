From: simon@mungewell.org
Subject: BUG: Joydev - Broken line compensation does not work for small range
 inputs
Date: Wed, 23 Jan 2013 00:21:58 -0500
Message-ID: <b778032fe6aef2b537b734c6a248c219.squirrel@www.mungewell.org>
References: <dd635eb75d3c9621e698d5458b16811a.squirrel@www.mungewell.org>
    <04d6d378f8654bc2923cd22e11fd6569.squirrel@www.mungewell.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20130123002158_84541"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:35752 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab3AWFWA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2013 00:22:00 -0500
In-Reply-To: <04d6d378f8654bc2923cd22e11fd6569.squirrel@www.mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

------=_20130123002158_84541
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> With a little more digging on this I think the issue is down to the
> default calibration values.

I have further confirmation that this is due to the calibration used when
the dial is presented via the joystick interface. The values in the event
interface are correct.

See 'joydev_correct()' from 'driver/input/joydev.c'

The problem is that the 'broken line' calibration can not properly
represent/process a value with a small range - I guess this does not
matter when there is a large input range.

In my system I have a dial (RZ) with 4 positions (0..3):
      expect to see -32768, -10922, +10922, +32768
      actually see -32768, 0, 32768, 65536 (limited to 32768)

Anyone got suggestions?
Simon

--
More info:

jscal -s 8,
        1,0, 0,0,298261,298261,                 // Wheel = -1800..1800
        1,0, 511,511,1050628,1050628,           // Throttle = 0..1023
        1,0, 511,511,1050628,1050628,           // Brake = 0..1023
        1,0, 5,5,107374182,107374182,           // RX = 0..12
        1,0, 5,5,107374182,107374182,           // RY = 0..12
        1,0, 1,1,536870912,536870912,           // RZ = 0..3
        1,0, 0,0,536870912,536870912,           // Hat = -1..1
        1,0, 0,0,536870912,536870912            // Hat = -1..1
                /dev/input/js0


from driver/input/joydev.c
--
        case JS_CORR_BROKEN:
                value = value > corr->coef[0] ? (value < corr->coef[1] ? 0 :
                        ((corr->coef[3] * (value - corr->coef[1])) >> 14)) :
                        ((corr->coef[2] * (value - corr->coef[0])) >> 14);
                break;
--
        case JS_CORR_BROKEN:
                if (value > corr->coef[0]) {
                        if (value < corr->coef[1]) {
                                value = 0
                        } else {
                                value = ((corr->coef[3] * (value -
corr->coef[1])) >> 14)
                        }
                } else {
                        value = ((corr->coef[2] * (value - corr->coef[0]))
>> 14)
                }
                break;
--

        RZ = 0,1,2,3 :
                expect to see -32768, -10922, +10922, +32768
                actually see -32768, 0, 32768, 65536 (limited to 32768)

------=_20130123002158_84541
Content-Type: text/x-csrc; name="test.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="test.c"

#include <stdlib.h>
#include <stdio.h>

int coef[] = { 1,1,536870912,536870912};

int compute(int value)
{
#if 1
	value = value > coef[0] ? (value < coef[1] ? 0 :
		((coef[3] * (value - coef[1])) >> 14)) :
		((coef[2] * (value - coef[0])) >> 14);

#else
	if (value > coef[0]) {
		if (value < coef[1]) {
			value = 0;
		} else {
			value = ((coef[3] * (value - coef[1])) >> 14);
		}
	} else {
		value = ((coef[2] * (value - coef[0])) >> 14);
	}
#endif
	return value;

}

main()
{
	printf("value = %d\n", compute(0));
	printf("value = %d\n", compute(1));
	printf("value = %d\n", compute(2));
	printf("value = %d\n", compute(3));
}
------=_20130123002158_84541--


