From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Subject: Re: NULL pointer dereference when writing fuzzed data to /dev/uhid
Date: Mon, 14 Jan 2019 17:23:13 +0300
Message-ID: <CAE5jQCd+HBh3hCkQW4SR4QOHAGRS3wEuZfT4q1N6V8g9rrpBuA@mail.gmail.com>
References: <CAE5jQCch70ZSmGZeA6RQxjXhL=LjgShdj_VZAGmqUzVRPSQBZw@mail.gmail.com>
 <CAO-hwJK29V7gT3WQXLvsM5qaQgRLsgm2HAnR81vtkrrQAsCuEg@mail.gmail.com> <20190113230946.GA18710@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190113230946.GA18710@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Roderick Colenbrander <thunderbird2k@gmail.com>
List-Id: linux-input@vger.kernel.org

> fuzzed data is hard to discriminate from valid data.

Just in case it can be helpful... If it is about manually "parsing"
descriptors to understand what is wrong by hands, then maybe Kaitai
Struct parser generator can help. I understand it is probably not
suited well for in-kernel binary parsing, but given a text-form
description of a format, it can visualize parsed binary data as a
hierarchical structure.

Best regards
Anatoly

=D0=BF=D0=BD, 14 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 02:09, Pavel Mache=
k <pavel@ucw.cz>:

>
> Hi!
>
> I just want to note that while these may not be high-priority, they
> are still security holes to be fixed.
>
> > > When writing the attached file to /dev/uhid, a NULL dereference occur=
s
> > > in kernel. As I understand, the problem is not UHID-specific, but is
> > > related to HID subsystem.
> >
> > Thanks for the report.
> > I wanted to tell you that I started investigating the other private
> > report you sent us, but couldn't find the time to properly come with a
> > fix as the fuzzed data is hard to discriminate from valid data.
> >
> > A couple of notes though:
> > - writing to uhid needs to be done by root. Any distribution that
> > doesn't enforce that is doomed to have several security issues
>
> We want to protect kernel from root, too.
>
> > - we could somehow reproduce those fuzzed data on a USB or Bluetooth
> > connection, but that would require physical access to the device, so
> > you are doomed also
>
> Not neccessarily. Imagine a kiosk where PC is protected but keyboard
> uses USB connection. If our USB stack is buggy, you are doomed... but
> you should not be ;-).
>                                                                         P=
avel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
