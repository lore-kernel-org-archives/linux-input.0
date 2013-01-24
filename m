From: simon@mungewell.org
Subject: How do I increase the response speed of /sys/class/leds
Date: Wed, 23 Jan 2013 23:48:31 -0500
Message-ID: <7b0f77cf522d0e8c74207279784dda04.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20130123234831_39104"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:33453 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab3AXEsd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2013 23:48:33 -0500
Received: from localhost ([127.0.0.1] helo=mungewell.org)
	by host171.canaca.com with esmtpa (Exim 4.69)
	(envelope-from <simon@mungewell.org>)
	id 1TyEjn-0007Zn-6U
	for linux-input@vger.kernel.org; Wed, 23 Jan 2013 23:48:31 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

------=_20130123234831_39104
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

I'm looking at using the LEDs on a gaming wheel via the /sys/class/leds
interface, and I am seeing that the response time is slow when I want to
set/clear all the LEDs simultaneously.

I've attached example C code which which slowly draws the bar, and then
flashes everything on/off. I can clearly see the 'progression' when
flashing.

Q. If there a method to minimise file access across LEDs and/or
synchronise the flashing?


If I run the same code on a G27 wheel (5 leds via /sys/class/leds) the
response timeh is much better.

Q. Is there a way to increase the polling/writing speed to a HID device?


Thanks,
Simon.
------=_20130123234831_39104
Content-Type: text/x-csrc; name="led_test.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="led_test.c"

#include <sys/time.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int fd[15] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};

int scramble[] = {12, 2, 14, 6, 10, 7, 9, 1, 3, 15, 4, 5, 11, 8, 13};

void flash(int led, int enable)
{
	// want to do the equivalant of:
	// echo 1 > /sys/class/leds/SRWS1\:\:69005002125011007452\:\:RPM3/brightness

	char d = enable ? '1' : '0';

	if (fd[led] == 0) {
		char name[255];

		printf("Opening led %d\n", led);
		sprintf(name, "/sys/class/leds/SRWS1::69005002125011007452::RPM%d/brightness", led);
  		fd[led] = open(name, O_WRONLY);
	}

	write (fd[led], &d, 1);
}

int main()
{
	struct timeval start;
	int i;

	while (1) {
		gettimeofday(&start, NULL);

		if (start.tv_sec % 20 > 15) {
			// flash all leds quickly
			int on = (start.tv_usec / 200000) % 2;

			for(i=1; i<= 15; i++)
#if 1
				flash(i, on);
#else
				flash(scramble[i], on);
#endif

			usleep(100000);
		} else {
			// turn led on
			switch(start.tv_sec % 20) {
			case 15:
				flash(15, 1);
				break;
			case 14:
				flash(14, 1);
				break;
			case 13:
				flash(13, 1);
				break;
			case 12:
				flash(12, 1);
				break;
			case 11:
				flash(11, 1);
				break;
			case 10:
				flash(10, 1);
				break;
			case  9:
				flash(9, 1);
				break;
			case  8:
				flash(8, 1);
				break;
			case  7:
				flash(7, 1);
				break;
			case  6:
				flash(6, 1);
				break;
			case  5:
				flash(5, 1);
				break;
			case  4:
				flash(4, 1);
				break;
			case  3:
				flash(3, 1);
				break;
			case  2:
				flash(2, 1);
				break;
			case  1:
				flash(1, 1);
				break;
			default:
				// turn all led off
				flash(1, 0);
				flash(2, 0);
				flash(3, 0);
				flash(4, 0);
				flash(5, 0);
				flash(6, 0);
				flash(7, 0);
				flash(8, 0);
				flash(9, 0);
				flash(10, 0);
				flash(11, 0);
				flash(12, 0);
				flash(13, 0);
				flash(14, 0);
				flash(15, 0);
				break;
			}

			usleep(500000);
		}

    }

    return 0;
}


------=_20130123234831_39104--


