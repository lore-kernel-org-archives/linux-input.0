From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: LID switch and /dev/input/event*
Date: Sat, 23 Aug 2008 23:43:55 +0200
Message-ID: <48B0849B.7070800@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

I am using Linux 2.6.27-rc4 on Clevo D410J laptop and the I can
query the LID switch state like this:

# cat /proc/acpi/button/lid/LID/state
state:      open
# cat /proc/acpi/button/lid/LID/state
state:      closed

If I check the event4, I get no events when the LID switch is pushed:

# evtest /dev/input/event4
Input driver version is 1.0.0
Input device ID: bus 0x19 vendor 0x0 product 0x5 version 0x0
Input device name: "Lid Switch"
Supported events:
  Event type 0 (Sync)
  Event type 5 (?)
    Event code 0 (?)
Testing ... (interrupt to exit)

The events are only reported if I suspend to RAM with "s2ram -f -p -s".=
 I did
the following steps:

1. Execute "s2ram -f -p -s". Now the system suspends to RAM.
2. Push the LID switch and hold it down.
3. Wake the system with the POWER button.
4. After the system is up, release the LID switch to see the screen.
5. "evtest" reports the following line:

Event: time 1219526119.163805, type 5 (?), code 0 (?), value 1

6. Execute "s2ram -f -p -s" again.
7. Wake the system with the POWER button.
8. "evtest" reports the following line:

Event: time 1219526913.208803, type 5 (?), code 0 (?), value 0

	M=E1rton N=E9meth

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
