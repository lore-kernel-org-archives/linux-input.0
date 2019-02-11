From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH] Input: matrix_keypad - use flush_delayed_work()
Date: Mon, 11 Feb 2019 07:42:27 -0500
Message-ID: <CAGngYiXZ-vgX4MTJENRaPPoj12gBNFffjOef2F8NeOy0RT8hTw@mail.gmail.com>
References: <20190207224650.GA49861@dtor-ws> <CAGngYiXytDjjAVh_gAaqJa0qLZAM-cTko92s6=PjS4tjZMvfHg@mail.gmail.com>
 <20190211082902.GA95126@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211082902.GA95126@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Feb 11, 2019 at 3:29 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> It will not schedule new work because we check keypad->stopped flag
> in ISR.
>

Yes, you are correct. Sorry for the confusion.

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
