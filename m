From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [v3.11][Regression] HID: hyperv: convert alloc+memcpy to memdup
Date: Thu, 19 Dec 2013 12:22:30 +0100
Message-ID: <CANq1E4R3LSx7pYncZ1dWf-BYY5gvC15=AjhFvurFqp0jaTUqYg@mail.gmail.com>
References: <5237430B.5040009@canonical.com> <20130916203824.GP25896@mwanda>
 <52376ED9.5080208@canonical.com> <20130916210503.GQ25896@mwanda>
 <5237A5D5.8010006@canonical.com>
 <alpine.LNX.2.00.1309241129370.18703@pobox.suse.cz>
 <52432152.3030100@canonical.com>
 <alpine.LNX.2.00.1309271250130.18703@pobox.suse.cz>
 <52459942.3020600@canonical.com>
 <alpine.LNX.2.00.1312161401100.12882@pobox.suse.cz>
 <CANq1E4QriATWbfruwj7oVnEBHvtLe_s2yhSSU5COXFjomt5R_A@mail.gmail.com>
 <alpine.LNX.2.00.1312191058100.28730@pobox.suse.cz>
 <CANq1E4RuteNfo23DQ5SvGXpsrpTmotLoJ6Wv1L8hAbE1ict6aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <CANq1E4RuteNfo23DQ5SvGXpsrpTmotLoJ6Wv1L8hAbE1ict6aA@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Joseph Salisbury <joseph.salisbury@canonical.com>, Haiyang Zhang <haiyangz@microsoft.com>, LKML <linux-kernel@vger.kernel.org>, open@osuosl.org, Dan Carpenter <dan.carpenter@oracle.com>, HID CORE LAYER <linux-input@vger.kernel.org>, "driverdev-devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, thomas@m3y3r.de
List-Id: linux-input@vger.kernel.org

Hi

On Thu, Dec 19, 2013 at 11:08 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Thu, Dec 19, 2013 at 10:59 AM, Jiri Kosina <jkosina@suse.cz> wrote:
>> On Thu, 19 Dec 2013, David Herrmann wrote:
>>
>>> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>>> > index 253fe23..81eacd3 100644
>>> > --- a/drivers/hid/hid-core.c
>>> > +++ b/drivers/hid/hid-core.c
>>> > @@ -1334,7 +1334,7 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
>>> >                 csize--;
>>> >         }
>>> >
>>> > -       rsize = ((report->size - 1) >> 3) + 1;
>>> > +       rsize = ((report->size - 1) >> 3) + 1 + (report->id > 0) + 7;
>>>
>>> Isn't "report->id" already covered by "if (report_enum->numbered)"
>>> above? The test for "id > 0" won't work here as in this case
>>> "report_enum->numbered" must already be set to true by the hid-desc
>>> parser, doesn't it?
>>
>> Right, that one is not correct here, thanks.
>>
>>> Where exactly did you get the +7 from?
>>
>> Please see commit (the one I am not really proud of) 27ce405039bfe6d3.
>
> Eh, I remember.. Ok, but the magic-mouse is BT right? So this commit
> really breaks BT drivers:
>
> commit b1a1442a23776756b254b69786848a94d92445ba
> Author: Jiri Kosina <jkosina@suse.cz>
> Date:   Mon Jun 3 11:27:48 2013 +0200
>
>     HID: core: fix reporting of raw events
>
> Problem is, if the raw_event() callback returned 0 earlier, we just
> skipped raw input reports. However, we now always call the
> hid_report_raw_event() helper. Which is normally fine, but the helper
> expects the input buffer to be of size HID_MAX_REPORT_SIZE, which is
> *not* true for HIDP. So the memset() writes over some random memory.
>
> I don't know exactly how to fix it. HID_MAX_BUFFER_SIZE is too big to
> be allocated on the stack, but we're in atomic-context here so a
> kzalloc(rsize, GFP_ATOMIC) seems overkill. So I guess we'd have to
> look into HIDP to make the skb big enough, but I'm not sure how we can
> achieve that.
>
> So off the top of my head, the best idea is to add "char
> inbuf[HID_MAX_BUFFER_SIZE];" to the hidp_session object in HIDP and
> copy every input-report into the buffer before passing to
> hid_input_report().

As this thread doesn't really contain any oops message nor the exact
driver name (except mentioning hyperv and magicmouse), I fixed a
related bug for HIDP:
  http://thread.gmane.org/gmane.linux.bluez.kernel/41969

A similar patch is *really* required for hid-hyperv.c as it also does
not provide a properly sized buffer to hid_input_report().

David
