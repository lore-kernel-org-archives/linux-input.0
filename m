From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] hid: microsoft: Add rumble support for Xbox One S controller
Date: Mon, 13 Aug 2018 07:37:48 -0700
Message-ID: <CAHQ1cqEMJFCD8GU9o194EUPfUV9TTswW-jE2MPhoEzrg3cshYQ@mail.gmail.com>
References: <20180810001714.14659-1-andrew.smirnov@gmail.com> <ad932296a864b13134c5af6efe7754e5e588314e.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ad932296a864b13134c5af6efe7754e5e588314e.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: hadess@hadess.net
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, Juha Kuikka <juha.kuikka@gmail.com>
List-Id: linux-input@vger.kernel.org

On Fri, Aug 10, 2018 at 4:38 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Thu, 2018-08-09 at 17:17 -0700, Andrey Smirnov wrote:
> > Add HID quirk driver for Xbox One S controller over bluetooth.
> >
> > This driver only adds support for rumble. Standard controller
> > functionality is exposed by default HID driver.
>
> Did you manage to make the joypad work without hacks in the Bluetooth
> stack[1]?

I was not aware this hack actually existed, but now that I see it I
think it explains why doing

echo 1 > /sys/module/bluetooth/parameters/disable_ertm

was necessary to make the controller connect over Bluetooth on my
machine. It looks like disabling ERTM just happens to have the same
effect as the hack that you mention. I'd like/plan to look into
finding a proper solution to replace that hack, but that'd probably be
a separate patch.

Thanks,
Andrey Smirnov
