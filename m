From: Kees Cook <keescook@chromium.org>
Subject: Re: HID: hid-logitech - missing HID_OUTPUT_REPORT 0
Date: Thu, 17 Apr 2014 10:50:25 -0700
Message-ID: <CAGXu5jKVCme=a8EVg1BOrB+5enpjT5aABy3QB=div-t230+NSA@mail.gmail.com>
References: <6452400bfacafd7e1f0d0f7a98b06248.squirrel@mungewell.org>
	<CAGXu5jKTcV9m70tgsxrBhUXWp5eXdXRJkCdYJDhpdOtB16b=6w@mail.gmail.com>
	<796aa99e55f8812aa6422d35610d4ed3.squirrel@mungewell.org>
	<CAGXu5jL4H2ukqQDV4syME148bbD3wcSqM0NscvOujnMYtW5w1g@mail.gmail.com>
	<20140417173723.GC10689@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:44770 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbaDQRu0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Apr 2014 13:50:26 -0400
Received: by mail-ob0-f179.google.com with SMTP id va2so822071obc.10
        for <linux-input@vger.kernel.org>; Thu, 17 Apr 2014 10:50:25 -0700 (PDT)
In-Reply-To: <20140417173723.GC10689@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Simon Wood <simon@mungewell.org>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Elias Vanderstuyft <elias.vds@gmail.com>

On Thu, Apr 17, 2014 at 10:37 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> On Apr 17 2014 or thereabouts, Kees Cook wrote:
>> On Thu, Apr 17, 2014 at 9:35 AM,  <simon@mungewell.org> wrote:
>> >
>> >> I don't know the lg driver very well, but it looks like it's expecting
>> >> a single report ID (0), but the device is showing two report IDs: 1
>> >> and 2. So, from the perspective of the driver, this is correct: it
>> >> wouldn't know how to deal with things since it is only expecting
>> >> Report ID 0. It seems like the driver needs to be updated for this
>> >> different device.
>> >
>> > Hi,
>> > The 'hid-lgff.c' driver supports lots of devices (see end of 'hid-lg.c'),
>> > and presumably these devices offer up a wide/varied range of HID
>> > descriptors.
>> >
>> > Does the recently introduced(/changed) check need to have prior knowledge
>> > of which 'Report ID's are actually used? If so, it possible that the
>> > change has broken a number of devices...
>> >
>> > I am trying to get the end user to test with an older kernel to see
>> > whether his device was always 'broken'.
>>
>> Ah-ha, actually, when taking a closer look at this, I see that lgff
>> isn't using ID "0", it's actually using "the first report in the
>> list", without using an ID at all. This appears to be true for all the
>> lg*ff devices, actually. Instead of validating ID 0, it needs to
>> validate "the first report".
>>
>> Documentation for hid_validate_values says:
>>  * @id: which report ID to examine (0 for first)
>>
>> Benjamin, does that mean "first report in the list", or is that a hint
>
> yep
>
>> that IDs are 0-indexed?
>
> nope :)
>
> page 46 of the HID 1.11 spec (http://www.usb.org/developers/devclass_docs/HID1_11.pdf)
> says: "Report ID zero is reserved and should not be used."

Ah! Perfect, yes. And I see we're doing that validation:

        case HID_GLOBAL_ITEM_TAG_REPORT_ID:
                parser->global.report_id = item_udata(item);
                if (parser->global.report_id == 0 ||
                    parser->global.report_id >= HID_MAX_IDS) {
                        hid_err(parser->device, "report_id %u is invalid\n",
                                parser->global.report_id);
                        return -1;
                }
                return 0;


>> What do you think is the best way to handle
>> this? Seems like passing something for "id" that means "whatever is
>> first in list" would be safest? I don't think overloading the meaning
>> of "0" is good, in case a driver really is using a 0 index but no
>> report with that ID exists in the list.
>
> "Overloading" 0 here is fine because reportID==0 can not exist according
> to the spec. Actually, a HID device is not forced to use report IDs at
> all if it sends only one type of reports.
> So in the various transport layers, 0 is handled as a special case
> anyway, and that means that there is no report ID. And when there is no
> report ID, there should be only one which is the first in the list :)
>
> Still, hid-lg should not use this trick to find the first report, but
> this driver has quite a lot of history, so I will not try to fix it.
>
> Anyway, it looks like hid_validate_values has to be fixed to handle HID
> devices without a report ID (which would fix hid-lg too).
>
>> Or if we do change the
>> meaning, make sure drivers always use the report returned by
>> hid_validate_values instead of re-finding it later.
>
> As explained above, it shouldn't matter. And it's more likely a bug in
> hid_validate_values that I should have spot when reviewing it :/

How does this look? (Likely whitespace damaged -- I can resend
correctly if it's what you had in mind.)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9e8064205bc7..5205ebb76cd2 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -840,6 +840,15 @@ struct hid_report *hid_validate_values(struct hid_device *h
         * drivers go to access report values.
         */
        report = hid->report_enum[type].report_id_hash[id];
+       if (!report && id == 0) {
+               /*
+                * Requesting id 0 means we should fall back to the first
+                * report in the list.
+                */
+               report = list_entry(
+                               hid->report_enum[type].report_list.next,
+                               struct hid_report, list);
+       }
        if (!report) {
                hid_err(hid, "missing %s %u\n", hid_report_names[type], id);
                return NULL;

Alternatively, should hid_register_report add a default to the hash
instead, so no change to hid_validate_values is needed?

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9e8064205bc7..5d07124457ba 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -80,6 +80,8 @@ struct hid_report *hid_register_report(struct hid_device *devi
        report->size = 0;
        report->device = device;
        report_enum->report_id_hash[id] = report;
+       if (!report_enum->report_id_hash[0])
+               report_enum->report_id_hash[0] = report;

        list_add_tail(&report->list, &report_enum->report_list);



-Kees

-- 
Kees Cook
Chrome OS Security
