From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Testing ti_am335x_adc continuous mode (WAS: Re: [PATCH 2/2]
Date: Mon, 7 Oct 2013 13:53:17 +0200
Message-ID: <20131007115317.GA6135@linutronix.de>
References: <1379503383-17086-1-git-send-email-zubair.lutfullah@gmail.com>
 <1379503383-17086-3-git-send-email-zubair.lutfullah@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1379503383-17086-3-git-send-email-zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Zubair,

I have here am335x-evm board. The output of voltage4 (via `cat
/sys/bus/iio/devices/iio\:device0/in_voltage4_raw=C2=B4) returns values=
 in
the range 570=E2=80=A6580. I tested the continuous sampling mdoe by exe=
cuting
the following commands:

|echo 1 > /sys/bus/iio/devices/iio\:device0/scan_elements/in_voltage4_e=
n
|echo 25 > /sys/bus/iio/devices/iio\:device0/buffer/length
|echo 1 > /sys/bus/iio/devices/iio\:device0/buffer/enable
|sleep 1
|echo 0 > /sys/bus/iio/devices/iio\:device0/buffer/enable
|cat /dev/iio\:device0 > iio
|hexdump -C iio

and the output is:
|00000000  37 02 92 02 1f 07 0a 06  20 06 31 06 2f 07 2a 07
|00000010  2b 07 2d 07 2c 07 28 07  2c 07 2b 07 2b 07 0c 06
|00000020  21 06 32 06 2e 07 2c 07  2a 07 2a 07 2c 07 2b 07
|00000030  29 07 27 07 28 07 29 07  2a 07 0d 06 21 06 35 06

The first entry is in the range that I would expect. The second is
slitghly higher. The third and following entries are out of range. Have
you observed something like that? Is my testing close to what you have
done or did I make an mistake here?

Sebastian
