From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/5] HID: intel_ish-hid: fix potential uninitialized
 data usage
Date: Wed, 24 May 2017 10:29:26 +0200
Message-ID: <CAK8P3a3h7P+DdNt3P4EUWE4S8knHuBeVm6N+6svi563ppaHZgw@mail.gmail.com>
References: <20170518202144.3482304-1-arnd@arndb.de> <20170518202144.3482304-2-arnd@arndb.de>
 <1495578269.14443.4.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495578269.14443.4.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, May 24, 2017 at 12:24 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Thu, 2017-05-18 at 22:21 +0200, Arnd Bergmann wrote:
>> gcc points out an uninialized pointer dereference that could happen
>> if we ever get to recv_ishtp_cl_msg_dma() or recv_ishtp_cl_msg()
>> with an empty &dev->read_list:
> In that case complete_rb should be NULL and it should not go to
>
> if (complete_rb) {
>
> shouldn't enter and cl is not dereferenced.
>
> So not sure why is this warning.

Correct. Unfortunately gcc cannot track this for complex functions, as
figuring this out is a not a solvable problem in general. I think in this
particular case, it gives up either because of the multiple 'goto' and
'continue' statements inside of the loop that get in the way of a full
analysis, or the 'spin_unlock_irqrestore' makes it forget the state.
I've seen both in the past.

However, just like gcc gets confused easily, a human reader trying
to understand the function will have the same issue, so my workaround
also helps there.

        Arnd
