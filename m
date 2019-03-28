From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 3/4] driver core: add dev_print_hex_dump() logging
 function.
Date: Thu, 28 Mar 2019 08:30:36 -0400
Message-ID: <20190328083036.7398db1b@gandalf.local.home>
References: <20190327014807.7472-1-ronald@innovation.ch>
        <20190327014807.7472-4-ronald@innovation.ch>
        <20190327023757.GB20766@kroah.com>
        <20190328002817.GF24753@innovation.ch>
        <20190328052917.GB18668@kroah.com>
        <20190328102755.GA26446@innovation.ch>
        <20190328112952.GA2232@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328112952.GA2232@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Life is hard, and then you die" <ronald@innovation.ch>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 28 Mar 2019 12:29:52 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> >   3. In at least two places we log different types of packets in the
> >      same lines of code (protected by a "if (log_mask & PKT_TYPE)") -
> >      dynamic-debug would only allow enabling or disabling logging of
> >      all packets. This could be worked around by creating a separate
> >      (but essentially duplicate) logging function for each packet type
> >      and some lookup table to call the appropriate one. Not very
> >      pretty IMO, though.  
> 
> True, but you can use tracepoints as well, that would probably be much
> easier when you are logging data streams.  You can also use an ebpf
> program with the tracepoints to log just what you need/want to when you
> want to as well.

And tracepoints have filters where you don't even need ebpf to do such
filtering.

See Documentation/trace/events.rst Section 5: Event Filtering

-- Steve
