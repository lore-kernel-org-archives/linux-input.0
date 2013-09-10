From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 4/7] HID: steelseries: validate output report details
Date: Tue, 10 Sep 2013 13:45:20 +0200
Message-ID: <CAN+gG=HkWMWUgF1_G-Rj+QGDQwM1JONEKjCB2LpcWVMbJwzFAg@mail.gmail.com>
References: <1378312645-27736-1-git-send-email-keescook@chromium.org>
	<1378312645-27736-5-git-send-email-keescook@chromium.org>
	<CAN+gG=H6Pib-kzWKPH_Hj_vcw7q_agHZ7_Qi-pEde9tbTB4EkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:64614 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab3IJLpW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Sep 2013 07:45:22 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so5980782lab.2
        for <linux-input@vger.kernel.org>; Tue, 10 Sep 2013 04:45:21 -0700 (PDT)
In-Reply-To: <CAN+gG=H6Pib-kzWKPH_Hj_vcw7q_agHZ7_Qi-pEde9tbTB4EkA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>

On Mon, Sep 9, 2013 at 3:02 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> On Wed, Sep 4, 2013 at 6:37 PM, Kees Cook <keescook@chromium.org> wrote:
>> A HID device could send a malicious output report that would cause the
>> steelseries HID driver to write beyond the output report allocation
>> during initialization, causing a heap overflow:
>>
>> [  167.981534] usb 1-1: New USB device found, idVendor=1038, idProduct=1410
>> ...
>> [  182.050547] BUG kmalloc-256 (Tainted: G        W   ): Redzone overwritten
>>
>> CVE-2013-2891
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Cc: stable@kernel.org
>> ---
>>  drivers/hid/hid-steelseries.c |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
>> index d164911..29f328f 100644
>> --- a/drivers/hid/hid-steelseries.c
>> +++ b/drivers/hid/hid-steelseries.c
>> @@ -249,6 +249,11 @@ static int steelseries_srws1_probe(struct hid_device *hdev,
>>                 goto err_free;
>>         }
>>
>> +       if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 16)) {
>> +               ret = -ENODEV;
>> +               goto err_free;
>
> There is a problem here in case of a failure:
> hid_parse() allocates a lot of memory and sets the flag
> HID_STAT_PARSED, but we are leaving the probe() without clearing all
> this stuff.
> In hid_parse(), when a failure is detected, we call
> hid_close_report(), so we also should close the report in the same way
> here (but hid_close_report() is a static function).
>

Sorry, my bad. hid_close_report() is called upon ->probe() failure. So
this is perfectly good.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin
