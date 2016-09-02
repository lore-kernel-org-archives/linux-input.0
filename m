From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: RFC: Backport HID-logitech to 3.10?
Date: Fri, 2 Sep 2016 11:32:06 +0200
Message-ID: <CAN+gG=FjjBFxNAKiXPu9xJQsZNOg1pOmo1_-MsvTQV4J11e6vw@mail.gmail.com>
References: <8d56b91cd89e3da158940e53db67b993.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8d56b91cd89e3da158940e53db67b993.squirrel@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Simon,

On Thu, Sep 1, 2016 at 2:56 AM, Simon Wood <simon@mungewell.org> wrote:
> Hi all,
> I received a question regarding back-porting the support for the G29
> racing wheel to 3.10 (Android in particular), and after some collaborative
> work we determined that changes between 3.10 and 4.7 are actually pretty
> minimal and self contained.
>
> After copying the HEAD 'hid-lg.[ch]' and 'hid-lg4ff.[ch]' from 4.7, there
> is a minimal patch (example attached) required to get the build working.

Don't you need hid-logitech-hidpp too?

>
>
> My question to the list would be how this would/could be implemented, and
> how the process works as 3.10 moves through the mainline patches to reach
> current HEAD.

Not sure I understand exactly what you want from us here.

The stable rules are detailed in
Documentation/stable_kernel_rules.txt. And unfortunately, I don't
think adding these patches will be acceptable for upstream 3.10.
The rule of thumb is that if a distribution wants to backport changes,
they can have their own rules but the official stable tree is only for
fixing issues, not adding new device support, unless it's *very* small
("- New device IDs and quirks are also accepted.")

So if you need to backport the changes to the 3.10 tree, see the rules
of the distribution you are working on. Some prefer backporting full
commits only (to keep closer to upstream), others will accept some #if
LINUX_VERSION. In those case, I'd personally rather have a small
header that makes the glue between old code and new one to keep the
code closer to upstream.

Cheers,
Benjamin

>
> Any hints that anyone has would be appreciated.
> Simon.
