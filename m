From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] evstate: new utility for querying evdev key/switch/event state
Date: Mon, 11 Jul 2011 14:14:09 +0100
Message-ID: <CAGq3pz5hJrpcSdwnJwGRGtC3Ap=vDzm3r0PSbYdK=33S4t2HBg@mail.gmail.com>
References: <20110709132046.90A119D401C@zog.reactivated.net>
	<20110711121836.GJ5214@nb.net.home>
	<CAGq3pz4smg1pJisnEpnFKKAcNMFyBjDVSSWrLA79O8JK+=AFQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGq3pz4smg1pJisnEpnFKKAcNMFyBjDVSSWrLA79O8JK+=AFQQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: util-linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pgf-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

+CC linux-input

On 11 July 2011 14:12, Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org> wrote:
> On 11 July 2011 13:18, Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:>
>>> http://article.gmane.org/gmane.linux.drivers.platform.x86.devel/1089
>>
>> Wow, so you have already implemented a patch that exports the state
>> in *human readable format* by sysfs. This patch was NACKed.
>>
>> Now it's expected that everyone in userspace will use ioctl() (with
>> root permissions?) and translate any crazy bit array to something
>> human readable. Right? Really?
>
> Dmitry, what are your thoughts on this?
>
> To clarify, there are 4 different switches that we need to read the state of.
>
> 1. XO-1.5 lid switch, exposed via ACPI via normal acpi-button driver
> 2. XO-1.5 ebook switch, exposed via drivers/platform/x86/xo15-ebook.c
> 3. XO-1 lid switch, exposed via arch/x86/platform/olpc/olpc-xo1-sci.c
> (linux-next)
> 4. XO-1 ebook switch, exposed via
> arch/x86/platform/olpc/olpc-xo1-sci.c (linux-next)
>
> We'd like to do this from shell code, as root.

add 2 more to that list as well in the near future: we are currently
writing drivers for the lid and ebook switches on the ARM-based
XO-1.75 laptop currently in prototype stages.

Daniel
--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
