From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH v3] Input: keyboard - add device tree bindings for simple
 key matrixes
Date: Tue, 3 Jan 2012 08:48:15 -0800
Message-ID: <CAOesGMj+jDsGBaQ8rtA=7BDNSk2e1DkTSzQrr9meF02gnOwRag@mail.gmail.com>
References: <1325184146-3527-1-git-send-email-olof@lixom.net>
	<1325484557-27695-1-git-send-email-olof@lixom.net>
	<CAPnjgZ1ngJrqB5FgOZDmc-H9KBE0-W75rqTHEPX4D+q0FjYumg@mail.gmail.com>
	<20120103154317.GA27061@quad.lixom.net>
	<CAPnjgZ3xN8+Ve28bcg1OQ4mv5rWvA-9ijP57UsuMQ5D1d=7Xxw@mail.gmail.com>
	<20120103162929.GY2914@n2100.arm.linux.org.uk>
	<20120103164431.GA31647@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120103164431.GA31647-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, U-Boot Mailing List <u-boot-0aAXYlwwYIKGBzrmiIFOJg@public.gmane.org>, riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 3, 2012 at 8:44 AM, Dmitry Torokhov
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Jan 03, 2012 at 04:29:30PM +0000, Russell King - ARM Linux wr=
ote:
>> On Tue, Jan 03, 2012 at 08:22:21AM -0800, Simon Glass wrote:
>> > Can the Linux key codes fit in 8 bits?
>>
>> That depends on your point of view.
>>
>> If you hack on X, then the answer is yes and you ignore the squeels =
of
>> your users when certain key presses get misinterpreted. =A0(The Psio=
n LX
>> platform, otherwise known as the Netbook Pro, suffered with this pro=
blem.)
>>
>> If you are a kernel hacker, the answer is no, because key codes curr=
ently
>> go all the way to 0x300.
>
> For bootloader environment 0-255 range is probably sufficient though,
> the upper keys are somewhat recent additions to the maps...

To keep things in common it would be convenient to not cap the key
code at 8 bits for everybody though, since we're looking at reaching
agreement on a common solution between firmware and linux. And no
matter what the size of the word is there will be need for a
translation table.


-Olof
