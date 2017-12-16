From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input - leds: fix input_led_disconnect path
Date: Fri, 15 Dec 2017 16:48:46 -0800
Message-ID: <20171216004846.3blocf4u45adwalh@dtor-ws>
References: <20171214132522.20346-1-benjamin.tissoires@redhat.com>
 <20171214132522.20346-3-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171214132522.20346-3-benjamin.tissoires@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

On Thu, Dec 14, 2017 at 02:25:22PM +0100, Benjamin Tissoires wrote:
> Before unregistering the led classes, we have to be sure there is no
> more events in the input pipeline.
> Closing the input node before removing the led classes flushes the
> pipeline and this prevents segfaults.

I do not think this actually the issue. input_leds_event() is an empty
stub, it does not really do anything with events it receives form input
core, and it does not reference the led structures. The way input leds
work is that input driver owns the hardware led and is responsible for
communicating with it. The LED subsystem is a secondary interface,
requests coming from /sys/class/led/... are being forwarded to the input
core and then to the input hardware driver by the way of:

input_leds_brightness_set() ->
	input_inject_event() ->
		input_handle_event()->
			disposition & INPUT_PASS_TO_DEVICE
				dev->event() (in atkbd or hid-input)
					actual control of LED

I do not see how stopping event flow from input core to input-leds would
help here.

Thanks.

-- 
Dmitry
