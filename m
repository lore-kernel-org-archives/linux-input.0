From: Alessandro Rubini <rubini@unipv.it>
Subject: Re: [PATCH v2] psmouse: mitigate failing-mouse symptoms
Date: Sun, 30 Sep 2012 20:02:40 +0200
Message-ID: <20120930180240.GA31164@mail.gnudd.com>
References: <20120930174353.GA29129@elie.Belkin>
  <4D2A3008.3000609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120930174353.GA29129@elie.Belkin>
Sender: linux-kernel-owner@vger.kernel.org
To: jrnieder@gmail.com
Cc: gjthill@gmail.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 607242@bugs.debian.org
List-Id: linux-input@vger.kernel.org

> I think this would be less controversial if the run-time default were
> to disable the feature.

Yes, that's the common sensible path to new little-tested features.
As you say, it may become enabled by default over time.

Then, I think it would be good to have a specific sub-structure for
this stuff. It would allow this:

  +       psmouse->err_log_base = 0;
  +       psmouse->interval_base = 0;
  +       psmouse->hotio_log_base = 0;
  +       psmouse->err_log_counter = 0;
  +       psmouse->interval_pkts = 0;
  +       psmouse->hotio_log_counter = 0;

to be replaced with a memset. I also think it would make it clearer
what these are:

  +       unsigned long interval_base;
  +       unsigned long interval_pkts;
  +       unsigned long hotio_log_base;
  +       unsigned long hotio_log_counter;
  +       unsigned long err_log_base;
  +       unsigned long err_log_counter;

to the casual reader.

This is only a suggestion, though.

thanks
/alessandro
