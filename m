From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: [PATCH] USB: input: powermate: fix oops with malicious USB descriptors
Date: Mon, 14 Mar 2016 12:46:26 -0400
Message-ID: <CA+5PVA5XPO8sQHi07kDSLR-EfocV7Kpqvu3aa1Qvy9Sq7Of=Dw@mail.gmail.com>
References: <1457964773-29512-1-git-send-email-jwboyer@fedoraproject.org>
	<20160314161548.GA2585@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20160314161548.GA2585@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>
List-Id: linux-input@vger.kernel.org

On Mon, Mar 14, 2016 at 12:15 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Mar 14, 2016 at 10:12:53AM -0400, Josh Boyer wrote:
>> The powermate driver expects at least one valid USB endpoint in its
>> probe function.  If given malicious descriptors that specify 0 for
>> the number of endpoints, it will crash.  Validate the number of
>> endpoints on the interface before using them.
>>
>> The full report for this issue can be found here:
>> http://seclists.org/bugtraq/2016/Mar/85
>>
>> Reported-by: Ralf Spenneberg <ralf@spenneberg.net>
>> Cc: stable <stable@vger.kernel.org>
>> Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
>> ---
>>  drivers/input/misc/powermate.c | 3 +++
>>  1 file changed, 3 insertions(+)
>
> I'll queue these up after 4.6-rc1 is out as the merge window is closed
> right now, but we might want to think about a better way to handle this
> type of thing in the USB core.  A way to keep from having to add checks
> like this for every single driver, when the driver shouldn't even really
> have their probe function called unless their expected endpoints are
> going to be there.

I thought this discussion came up a while ago, when something very
similar was fixed in the whiteheat driver (commit cbb4be652d374).  I
can't find the thread at the moment, but I thought someone said this
had to be per-driver for some reason.  I'm more than happy to have a
core subsystem fix if it's possible.

> I'll think about that over the next few weeks...

I have something around 8 drivers with issues like this.  I think
Oliver (now CC'd) is working from the same set of bugs.  Should we
hold off on submitting individual fixes until later, or should we go
ahead and submit them?

josh
