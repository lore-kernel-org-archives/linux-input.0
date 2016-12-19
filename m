From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: usbhid: fix more Mayflash adapters
 (HID_QUIRK_MULTI_INPUT)
Date: Mon, 19 Dec 2016 11:38:27 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1612191137270.19203@cbobk.fhfr.pm>
References: <20161213002305.GA30732@dtor-ws> <alpine.LSU.2.20.1612191119280.19203@cbobk.fhfr.pm> <CAGNp=Nxi7-_dKar3SOUUvGksxQvuy0AfzqtM8Szpq9P7deEwZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGNp=Nxi7-_dKar3SOUUvGksxQvuy0AfzqtM8Szpq9P7deEwZw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Hasler <mahasler@gmail.com>, Robert de Rooy <robert.de.rooy@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Rodland <andrew@cleverdomain.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 19 Dec 2016, Marcel Hasler wrote:

> What maybe still should be added, is the "Mayflash Dolphin-bar" (PID
> 0x1803, see the Bugzilla entry mentioned above).

On Mon, 19 Dec 2016, Robert de Rooy wrote:

> Thanks for this,
> 
> Any chance we can also get the same quirk added for the Mayflash Dolphinbar?
> It has four different operating modes, when set to "mode 3", it emulates 4
> PC USB joysticks and has the same problem and needs the
> HID_QUIRK_MULTI_INPUT.
> 
> When set to mode 3, the USB id is: 0079:1803
> 
> I tested it locally by booting with usbhid.quirks=0x79:0x1803:0x40
> 
> Regarding the other modes, mode 1 and 2 already work as it just emulates a
> USB keyboard/mouse. mode 4 is special, and supposedly now works with the
> latest versions of the Dolphin emulator for Linux.

Could either of you please submit a proper patch on top of b255400, so 
that I could queue it?

Thanks,

-- 
Jiri Kosina
SUSE Labs
