From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v4] HID: sb0540: add support for Creative SB0540 IR
 receivers
Date: Mon, 01 Jul 2019 12:20:27 +0200
Message-ID: <add17925a930d995ef5e395c0b716e7b7638acba.camel@hadess.net>
References: <20190701100819.6032-1-hadess@hadess.net>
         <CAO-hwJJaj6f216_H=UFO0CEp+ZHRWwvhTO9FCPqdeimEwE6p0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJJaj6f216_H=UFO0CEp+ZHRWwvhTO9FCPqdeimEwE6p0Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Bastien Nocera <bnocera@redhat.com>
List-Id: linux-input@vger.kernel.org

On Mon, 2019-07-01 at 12:15 +0200, Benjamin Tissoires wrote:
> 
<snip>
> I forgot to mention that sparse was complaining about:
> 
> scripts/Makefile.build:283: target 'drivers/hid/hid-creative-
> sb0540.c'
> doesn't match the target pattern
> 
> And it turns out your line should read `hid-creative-sb0540.o` not
> `hid-creative-sb0540.c`

It does show that I didn't fancy making my office warmer with a full
kernel compile, right?

v5 sent with the fix, thanks.
