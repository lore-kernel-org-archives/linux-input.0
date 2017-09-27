From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] HID: usbhid: fix out-of-bounds bug
Date: Wed, 27 Sep 2017 10:29:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1709271013300.1390-100000@iolanthe.rowland.org>
References: <CAAZ5spCffHnU_EtnhKpP5cDqsEKaGMatpaqAJqorvph+vZm1Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAZ5spCffHnU_EtnhKpP5cDqsEKaGMatpaqAJqorvph+vZm1Sw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michel Hermier <michel.hermier@gmail.com>
Cc: Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Jiri Kosina <jikos@kernel.org>, USB list <linux-usb@vger.kernel.org>, Jaejoong Kim <climbbb.kim@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, 27 Sep 2017, Michel Hermier wrote:

> Le 27 sept. 2017 07:42, "Alan Stern" <stern@rowland.harvard.edu> a écrit :

> > -       for (n = 0; n < hdesc->bNumDescriptors; n++)
> > +       num_descriptors = min_t(int, hdesc->bNumDescriptors,
> > +                               (hdesc->bLength - 6) / 3);
> > +       for (n = 0; n < num_descriptors; n++)
> >                 if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT)
> >                         rsize = le16_to_cpu(hdesc->desc[n].
> wDescriptorLength);
> 
> Yes, this is a lot better.
> 
> 
> Is it possible to explicit the magic number 6 and 3 in the code. Currently,
> it looks like it comes from no where.

Yes, it is possible.  The 6 is equal to

	offsetof(struct hid_descriptor, desc)

and the 3 is equal to

	sizeof(struct hid_class_descriptor)

(at least, I think it is -- the structure is marked as packed so its 
size should be 3).

In this case I found the numbers to be more readable, but other people 
may have different opinions.

> I'm also wondering if this change will not affect some devices in the wild,
> by rejecting hid descriptors with num descriptors == 0 ?

It's possible, but I doubt it.  If such devices do exist, they should
never have worked in the first place.  Certainly they would generate
warnings or errors during enumeration because of their invalid
descriptors.

Alan Stern
