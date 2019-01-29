From: Vladis Dronov <vdronov@redhat.com>
Subject: Re: [PATCH v2] HID: debug: fix the ring buffer implementation
Date: Tue, 29 Jan 2019 05:59:54 -0500 (EST)
Message-ID: <1016483826.67536575.1548759594722.JavaMail.zimbra@redhat.com>
References: <20190126170722.8035-1-vdronov@redhat.com> <CAO-hwJJGux_5bQJmXgLrcj+v=n3n8hvqXfqPEu60aghYNJSfzw@mail.gmail.com> <20190128111818.GA22143@redhat.com> <CAO-hwJK_WoimsUMR19GR_qEUCk0ZMaKGham3DSJ5SDqtc8oCzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJK_WoimsUMR19GR_qEUCk0ZMaKGham3DSJ5SDqtc8oCzw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "3.8+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

> > I still think that
> >
> >                     __set_current_state(TASK_RUNNING);
> >
> > will look a bit better, but this is really minor.
> 
> Would you mind sending a v3 with this change? I'll apply it ASAP.

Done, please, see inbox.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security | Senior Software Engineer
