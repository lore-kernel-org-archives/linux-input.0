From: Vladis Dronov <vdronov@redhat.com>
Subject: Re: [PATCH 0/3] HID: debug: fix the ring buffer implementation
Date: Mon, 29 Oct 2018 16:51:29 -0400 (EDT)
Message-ID: <65007864.26733351.1540846289100.JavaMail.zimbra@redhat.com>
References: <20181003171936.11271-1-vdronov@redhat.com> <nycvar.YFH.7.76.1810261724510.23511@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1810261724510.23511@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello, Jiri,

Thank you for the reply and your opinion. It appeared that my own implementation
of a ring buffer was kind of "inventing a wheel", as "kfifo" is already is the
kernel and it may work as a ring buffer quite well. I would like to rewrite my
patchset and use kfifo instead in a new one. Please, ignore this my patchset and
I'll try to submit v2 soon.

This also will answer to "how was it tested" concern, as I believe, kfifo was
quite tested.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer

----- Original Message -----
> From: "Jiri Kosina" <jikos@kernel.org>
> To: "Vladis Dronov" <vdronov@redhat.com>
> Cc: "Benjamin Tissoires" <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
> Sent: Friday, October 26, 2018 5:25:21 PM
> Subject: Re: [PATCH 0/3] HID: debug: fix the ring buffer implementation
> 
> On Wed, 3 Oct 2018, Vladis Dronov wrote:
> 
> > This patchset is fixing some aspects of the ring buffer implementation in
> > drivers/hid/hid-debug.c. This implementation has certain problem points:
> > 
> > - it may stuck in an infinite loop
> > - it may return corrupted data
> > - a reader and a writer are not protected by spinlocks, which can lead to
> >   the corrupted data
> > 
> > The suggested patchset is a new ring buffer implementation which overwrites
> > the oldest data in case of an overflow. One can verify the suggested ring
> > buffer implementation by fuzzing it with modified kernel and fuzzer-reader
> > at: https://gist.github.com/nefigtut/33d56e3870b67493cc867344aed2a062
> 
> Vladis,
> 
> thanks for cleaning it up. I actually like your rewrite quite a lot.
> 
> Quick question -- how well was it tested in which scenarios?
> 
> --
> Jiri Kosina
> SUSE Labs
