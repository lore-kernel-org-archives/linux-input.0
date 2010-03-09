From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH 2/3] HID: suppress the second input for the Apple Magic Mouse.
Date: Tue, 09 Mar 2010 08:06:59 -0500
Message-ID: <87bpex1w5o.fsf@troilus.org>
References: <1268083784.9018.20.camel@localhost.localdomain>
	<87eiju2v1u.fsf@troilus.org> <4B963892.9020103@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54906 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751823Ab0CINHE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 08:07:04 -0500
Received: by qw-out-1920.google.com with SMTP id 5so1882936qwc.38
        for <linux-input@vger.kernel.org>; Tue, 09 Mar 2010 05:07:02 -0800 (PST)
In-Reply-To: <4B963892.9020103@free.fr> (Rantanplan's message of "Tue, 09 Mar
	2010 13:01:22 +0100")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rantanplan <rantanplanlechien@free.fr>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>

Rantanplan <rantanplanlechien@free.fr> writes:

[snip]
> Then I also saw that contrary to the driver I saw before (hid-stantum
> and hid-ntrig) the hid-magicmouse uses raw event instead of higher
> level events. I thought it was not very clear (at least for me as I do
> not speak very well bit fields) and I started to write a work-around.

That was mostly a code compactness issue: It was not clear to me how to
generate an appropriate set of field descriptors for the multi-touch
records, but it looked like it would not be easy.  It is still not clear
to me -- from hid-ntrig, hid-stantum, hid-core and your patch -- how a
variable-length report from the device gets translated to multiple
events for the touch fields.  (The key words there are "to me": I am
probably overlooking something.)

The other notable part of using raw events is that the middle-button
emulation requires watching button state in both the standard mouse
report and the multi-touch report.  Matching button-down and -up events
may be sent in different report types.

> The last point that was worrying me was the line (after the call of
> hid_register_report):
> 'report->size = 6;'
> The driver registered a new report, tells it has an arbitrary size (or
> maybe not?) whereas it has no field initialized.

Six bytes is the minimum length of the touch report -- although now that
I look at it, report->size was meant to count bits.  (I am not sure why
the mouse sometimes decides to send a report with zero touches rather
than the standard mouse report, but it does.)

> So I wrote first a big patch to avoid all the 'problems' listed above.
> I did not send it immediately and I was a little bit overload at work.
> However, when I saw that the driver had been included in the next
> branch of the kernel, I took time to work on the patch again. But, I
> only tried to tackle the problem of the second input device.
>
> To sum up, the advantages of my patch are, I think, the following
> (though I do not want to seem to be competing with Micheal):
> - It's documenting the data the magic mouse sends as the mouse does
> not send the descriptor.
> - It will allow another patch to avoid the use of the raw events
> instead of high level events (don't know if it is really a benefit)
>
> As Micheal said there are huge pitfalls:
> - It heavy regards to its aim
> - I insert fields into the descriptor that I use them later with a
> slightly change in the meaning (some keywords are not well choose and
> the whole meaning is split between the registering of the fields and
> the mapping)
> - coding style (not really a problem though)
> - raw events have the benefits of giving the number of touches into
> the data size, something we don't have with high level events only.
>
>
> Maybe a solution would just be to add a comment documenting the bit
> fields in the data? (as now, most of the problems had been solved by
> the last patch of Michael)

To what end?  User space should see the same data from either approach.
In the kernel, the decoding of the multi-touch reports is in five lines
near the top of magicmouse_emit_touch() and five to seven lines in
magicmouse_raw_event()'s case TOUCH_REPORT_ID.  There are ten known
fields (X, Y, buttons, and six touch fields) in the data, so it seems
hard to do better than ten (sane) lines.  Using some other description
may be easier to find, but I'm not sure it will be much clearer.

Michael
