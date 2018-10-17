From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
Date: Tue, 16 Oct 2018 17:09:55 -0700
Message-ID: <20181017000955.GG230131@dtor-ws>
References: <000000000000e5f76c057664e73d@google.com>
 <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com>
 <CACT4Y+YOb6M=xuPG64PAvd=0bcteicGtwQO60CevN_V67SJ=MQ@mail.gmail.com>
 <010001660c1fafb2-6d0dc7e1-d898-4589-874c-1be1af94e22d-000000@email.amazonses.com>
 <CACT4Y+ayX8vzd2JPrLeFhf3K_Quf4x6SDtmtkNJuwNLyOh67tQ@mail.gmail.com>
 <010001660c4a8bbe-91200766-00df-48bd-bc60-a03da2ccdb7d-000000@email.amazonses.com>
 <20180924184158.GA156847@dtor-ws>
 <20180927143537.GB19006@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180927143537.GB19006@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Christopher Lameter <cl@linux.com>, Dmitry Vyukov <dvyukov@google.com>, syzbot+87829a10073277282ad1@syzkaller.appspotmail.com, Pekka Enberg <penberg@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Linux-MM <linux-mm@kvack.org>
List-Id: linux-input@vger.kernel.org

On Thu, Sep 27, 2018 at 07:35:37AM -0700, Matthew Wilcox wrote:
> On Mon, Sep 24, 2018 at 11:41:58AM -0700, Dmitry Torokhov wrote:
> > > How large is the allocation? AFACIT nRequests larger than KMALLOC_MAX_SIZE
> > > are larger than the maximum allowed by the page allocator. Thus the warning
> > > and the NULL return.
> > 
> > The size in this particular case is being derived from a value passed
> > from userspace. Input core does not care about any limits on size of
> > memory kmalloc() can support and is perfectly happy with getting NULL
> > and telling userspace to go away with their silly requests by returning
> > -ENOMEM.
> > 
> > For the record: I definitely do not want to pre-sanitize size neither in
> > uinput nor in input core.
> 
> Probably should be using kvzalloc then.

No. No sane input device can track so many contacts so we need to use
kvzalloc(). Failing to allocate memory is proper response here.

Thanks.

-- 
Dmitry
