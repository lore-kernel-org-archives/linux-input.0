From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: NULL pointer dereference when writing fuzzed data to /dev/uhid
Date: Mon, 14 Jan 2019 15:55:28 +0100
Message-ID: <CAO-hwJKxRBdctUf59TJLW0G81gKXLiEoueheUxgtPO4x_=YieQ@mail.gmail.com>
References: <CAE5jQCch70ZSmGZeA6RQxjXhL=LjgShdj_VZAGmqUzVRPSQBZw@mail.gmail.com>
 <CAO-hwJK29V7gT3WQXLvsM5qaQgRLsgm2HAnR81vtkrrQAsCuEg@mail.gmail.com>
 <20190113230946.GA18710@amd> <CAE5jQCd+HBh3hCkQW4SR4QOHAGRS3wEuZfT4q1N6V8g9rrpBuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE5jQCd+HBh3hCkQW4SR4QOHAGRS3wEuZfT4q1N6V8g9rrpBuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Roderick Colenbrander <thunderbird2k@gmail.com>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 14, 2019 at 3:23 PM Anatoly Trosinenko
<anatoly.trosinenko@gmail.com> wrote:
>
> > fuzzed data is hard to discriminate from valid data.
>
> Just in case it can be helpful... If it is about manually "parsing"
> descriptors to understand what is wrong by hands, then maybe Kaitai
> Struct parser generator can help. I understand it is probably not
> suited well for in-kernel binary parsing, but given a text-form
> description of a format, it can visualize parsed binary data as a
> hierarchical structure.

Well, the data and parsing is pretty straightforward (see
http://who-t.blogspot.com/2018/12/understanding-hid-report-descriptors.html
if you want to have an entertaining understanding, instead of reading
the specs). The problem is the fuzzed data looks like a correct one,
but there is garbage in the middle.

And we can not simply rely on some global CRC that would prevent
fuzzing because there is none. And the report descriptor is in the
device, so we can't upgrade all of them.

So in the end, sending a fuzz HID report descriptor is like sending a
language grammar that doesn't mean anything. The parser says, "well,
yes, why not", but sometime the rest of the drivers expect a little
bit more, and this is where it gets hard to see.

Cheers,
Benjamin

>
> Best regards
> Anatoly
>
> пн, 14 янв. 2019 г. в 02:09, Pavel Machek <pavel@ucw.cz>:
>
> >
> > Hi!
> >
> > I just want to note that while these may not be high-priority, they
> > are still security holes to be fixed.
> >
> > > > When writing the attached file to /dev/uhid, a NULL dereference occurs
> > > > in kernel. As I understand, the problem is not UHID-specific, but is
> > > > related to HID subsystem.
> > >
> > > Thanks for the report.
> > > I wanted to tell you that I started investigating the other private
> > > report you sent us, but couldn't find the time to properly come with a
> > > fix as the fuzzed data is hard to discriminate from valid data.
> > >
> > > A couple of notes though:
> > > - writing to uhid needs to be done by root. Any distribution that
> > > doesn't enforce that is doomed to have several security issues
> >
> > We want to protect kernel from root, too.
> >
> > > - we could somehow reproduce those fuzzed data on a USB or Bluetooth
> > > connection, but that would require physical access to the device, so
> > > you are doomed also
> >
> > Not neccessarily. Imagine a kiosk where PC is protected but keyboard
> > uses USB connection. If our USB stack is buggy, you are doomed... but
> > you should not be ;-).
> >                                                                         Pavel
> > --
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
