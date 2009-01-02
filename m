From: Alessio Sangalli <alesan@manoweb.com>
Subject: Equivalent of /dev/input/mice for keyboards
Date: Fri, 02 Jan 2009 15:29:53 -0800
Message-ID: <495EA371.8050304@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:60442 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbZABX36 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Jan 2009 18:29:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi, I have developed a PS/2 driver for a new ARM-based hardware.

I have used the serio subsystem and I can test with input-event or
similar programs that the keyboard and mouse I have connected work well.

Now, this platform, being an embedded ARM board, does not have a
"console" that can be attached to the keyboard. I only connect with
serial port or telnet. And here I am getting confused: I can read one
device at a time by opening /dev/input/event*.

I would like to write my userspace application so that it gets all the
input from the various keyboards (can be up to two PS/2 keyboards + USB
ones) and process it. The struct input_event is very convenient but what
I am doing now is to open all the event* devices and select() them. This
wouldn't probably work if I connect/disconnect a device on the fly. It
would be much easier if I had a device similar to input/mice that
automatically does the muxing for me...

Thank you
Alessio


